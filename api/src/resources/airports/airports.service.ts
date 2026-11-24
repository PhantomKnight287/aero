import { prisma } from 'src/db';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';

import { Injectable } from '@nestjs/common';
import { createId } from '@paralleldrive/cuid2';

import { GetAirportsBoundsDTO } from './dto/get-airports-bounds.dto';
import {
  AirportDetailsEntity,
  DecodedWeatherEntity,
} from './entities/airport-details.entity';

// @squawk/weather is ESM-only ("type": "module"); the API compiles to CommonJS.
// A plain require()/static import fails at runtime, and TS would downlevel a
// dynamic import() to require(), so we hide it behind a Function to keep a real
// dynamic import. Loaded (and cached) once.
const importEsm = new Function('s', 'return import(s)') as (
  s: string,
) => Promise<any>;
let weatherModule: Promise<any> | null = null;
const getWeather = () =>
  (weatherModule ??= importEsm('@squawk/weather'));

/** Custom ranking so larger airports come first when we cap the result set. */
const AIRPORT_TYPE_RANK: Record<string, number> = {
  large_airport: 0,
  medium_airport: 1,
  small_airport: 2,
  seaplane_base: 3,
  heliport: 4,
  balloonport: 5,
};

@Injectable()
export class AirportsService {
  constructor(private readonly flightAware: FlightAwareService) {}

  async getAirports({ search }: { search: string }) {
    const res = await prisma.airport.findMany({
      omit: { createdAt: true, updatedAt: true },
      where: {
        type: { not: 'closed' },
        iataCode: { not: null },
        ...(search
          ? {
              OR: [
                {
                  name: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
                {
                  ident: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
                {
                  iataCode: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
                {
                  municipality: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
              ],
            }
          : undefined),
      },
    });
    return res;
  }

  /**
   * Airports whose coordinates fall inside the given bounding box. Restricted to
   * non-closed airports with an IATA code, prioritized by size and capped so a
   * wide view can never flood the client.
   */
  async getAirportsInBounds({
    minLat,
    maxLat,
    minLng,
    maxLng,
  }: GetAirportsBoundsDTO) {
    const res = await prisma.airport.findMany({
      omit: { createdAt: true, updatedAt: true },
      where: {
        type: { not: 'closed' },
        iataCode: { not: null },
        lat: { gte: minLat, lte: maxLat },
        long: { gte: minLng, lte: maxLng },
      },
      // Over-fetch a little, then rank by size and slice to the cap so we keep
      // the most relevant (largest) airports when the box is dense.
      take: 600,
    });

    return res
      .sort(
        (a, b) =>
          (AIRPORT_TYPE_RANK[a.type] ?? 99) - (AIRPORT_TYPE_RANK[b.type] ?? 99),
      )
      .slice(0, 200);
  }

  /**
   * Aggregate live detail for a single airport: current delays plus the latest
   * METAR observation and TAF forecast, each decoded into a structured form.
   * Every source is best-effort — a failure in one never fails the request.
   */
  async getAirportDetails(ident: string): Promise<AirportDetailsEntity> {
    const [airportResult, delaysResult, forecastResult, observationResult] =
      await Promise.allSettled([
        // Callers opening from a flight only know the ICAO/IATA code; the
        // table is the source of truth for country, region and elevation.
        prisma.airport.findFirst({
          omit: { createdAt: true, updatedAt: true },
          where: { OR: [{ ident }, { gpsCode: ident }, { iataCode: ident }] },
        }),
        this.flightAware.getAirportDelays(ident),
        this.flightAware.getAirportWeatherForecast(ident),
        this.flightAware.getAirportLatestObservation(ident),
      ]);

    const airportRow =
      airportResult.status === 'fulfilled' ? airportResult.value : null;
    const delays =
      delaysResult.status === 'fulfilled' ? delaysResult.value : null;
    const forecast =
      forecastResult.status === 'fulfilled' ? forecastResult.value : null;
    const observation =
      observationResult.status === 'fulfilled' ? observationResult.value : null;

    const metarRaw = this.extractRaw(observation, [
      'raw_data',
      'raw_text',
      'raw',
    ]);
    const tafRaw = this.extractRaw(forecast, [
      'raw_forecast',
      'raw_data',
      'raw_text',
      'raw',
    ]);

    return {
      ident,
      airport: airportRow && {
        ...airportRow,
        // Decimals serialise as strings everywhere else; match AirportEntity.
        elevation: airportRow.elevation?.toString(),
        lat: airportRow.lat.toString(),
        long: airportRow.long.toString(),
      },
      delays,
      metar: await this.decode(metarRaw, 'metar'),
      taf: await this.decode(tafRaw, 'taf'),
    };
  }

  /**
   * Pull the first present raw string from a loosely-typed payload. FlightAware
   * returns METAR as a single string but TAF as `raw_forecast` (an array of
   * lines), so string arrays are joined back into one string.
   */
  private extractRaw(source: any, candidateKeys: string[]): string | null {
    if (!source || typeof source !== 'object') return null;
    for (const key of candidateKeys) {
      const value = source[key];
      if (typeof value === 'string' && value.trim().length > 0) {
        return value;
      }
      if (
        Array.isArray(value) &&
        value.length > 0 &&
        value.every((v) => typeof v === 'string')
      ) {
        const joined = value.join(' ').trim();
        if (joined.length > 0) return joined;
      }
    }
    return null;
  }

  /** Decode a raw METAR/TAF string, returning raw + structured (or raw-only on failure). */
  private async decode(
    raw: string | null,
    kind: 'metar' | 'taf',
  ): Promise<DecodedWeatherEntity | null> {
    if (!raw) return null;
    try {
      const { parseMetar, parseTaf, deriveFlightCategory } = await getWeather();
      let decoded: any;
      if (kind === 'metar') {
        decoded = parseMetar(raw);
        // Flight category isn't part of the parsed METAR; derive it so the
        // client can show VFR/MVFR/IFR/LIFR. deriveFlightCategory expects
        // visibility in statute miles.
        try {
          const visM = decoded?.visibility?.visibilityM;
          const visSm =
            typeof visM === 'number' ? visM / 1609.344 : undefined;
          const category = deriveFlightCategory(
            visSm,
            decoded?.visibility?.isLessThan ?? false,
            decoded?.sky ?? { layers: [] },
            decoded?.isCavok ?? false,
          );
          if (category) decoded.flightCategory = category;
        } catch {
          // best-effort; leave flightCategory unset on failure
        }
      } else {
        // parseTaf requires a leading "TAF" identifier, which FlightAware's
        // raw_forecast lines omit.
        const tafInput = /^\s*TAF\b/i.test(raw) ? raw : `TAF ${raw}`;
        decoded = parseTaf(tafInput);
      }
      return { raw, decoded };
    } catch (error) {
      console.warn(`Airports: failed to decode ${kind} "${raw}":`, error);
      return { raw, decoded: null };
    }
  }

  async createAirport(body: any) {
    return await prisma.airport.create({
      data: { ...body, id: `airport_${createId()}` },
    });
  }
}
