import { DateTime, IANAZone } from 'luxon';
import { prisma } from 'src/db';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';
import { RedisService } from 'src/services/redis/redis.service';

import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createId } from '@paralleldrive/cuid2';
import { CreateFlightBookingDTO } from './dto/create-flight-booking.dto';
import { GetFlightSearchDTO } from './dto/get-flight-search.dto';
import { GetFlightTrackDTO } from './dto/get-flight-track.dto';
import { GetFlightDTO } from './dto/get-flight.dto';
import type { UpdateFlightBookingDTO } from './dto/update-flight-booking.dto';
import {
  AircraftEntity,
  FlightCandidateEntity,
  FlightSearchResponseEntity,
} from './entities/flight.entity';

const TIMEZONE_ABBREV_TO_IANA: Record<string, string> = {
  UTC: 'UTC',
  GMT: 'Etc/UTC',
  BST: 'Europe/London',
  CET: 'Europe/Berlin',
  CEST: 'Europe/Berlin',
  EET: 'Europe/Athens',
  EEST: 'Europe/Athens',
  IST: 'Asia/Kolkata',
  PKT: 'Asia/Karachi',
  MSK: 'Europe/Moscow',
  AST: 'America/Halifax',
  ADT: 'America/Halifax',
  EST: 'America/New_York',
  EDT: 'America/New_York',
  CST: 'America/Chicago',
  CDT: 'America/Chicago',
  MST: 'America/Denver',
  MDT: 'America/Denver',
  PST: 'America/Los_Angeles',
  PDT: 'America/Los_Angeles',
  AKST: 'America/Anchorage',
  AKDT: 'America/Anchorage',
  HST: 'Pacific/Honolulu',
  JST: 'Asia/Tokyo',
  KST: 'Asia/Seoul',
  AEST: 'Australia/Sydney',
  AEDT: 'Australia/Sydney',
  ACST: 'Australia/Adelaide',
  ACDT: 'Australia/Adelaide',
  AWST: 'Australia/Perth',
};

const ALT_CHANGE_FROM_CODE: Record<string, 'Climb' | 'Descend' | 'None'> = {
  C: 'Climb',
  D: 'Descend',
  '-': 'None',
};
const ALT_CHANGE_TO_CODE: Record<string, 'C' | 'D' | '-'> = {
  Climb: 'C',
  Descend: 'D',
  None: '-',
};

type UpdateType =
  | 'Projected'
  | 'Oceanic'
  | 'Radar'
  | 'ADSB'
  | 'Multilateration'
  | 'Datalink'
  | 'Surface_And_Near_Surface'
  | 'Spaced_Based'
  | 'Virtual_Event';

const UPDATE_TYPE_FROM_CODE: Record<string, UpdateType> = {
  P: 'Projected',
  O: 'Oceanic',
  Z: 'Radar',
  A: 'ADSB',
  M: 'Multilateration',
  D: 'Datalink',
  X: 'Surface_And_Near_Surface',
  S: 'Spaced_Based',
  V: 'Virtual_Event',
};
type AirportConditions = {
  delays: any | null;
  forecast: any | null;
  observation: any | null;
};

const EMPTY_CONDITIONS: AirportConditions = {
  delays: null,
  forecast: null,
  observation: null,
};

const UPDATE_TYPE_TO_CODE: Record<UpdateType, string> = {
  Projected: 'P',
  Oceanic: 'O',
  Radar: 'Z',
  ADSB: 'A',
  Multilateration: 'M',
  Datalink: 'D',
  Surface_And_Near_Surface: 'X',
  Spaced_Based: 'S',
  Virtual_Event: 'V',
};

function resolveIanaZone(tz: string): string {
  if (tz && tz.includes('/') && IANAZone.isValidZone(tz)) return tz;
  const mapped = tz ? TIMEZONE_ABBREV_TO_IANA[tz.toUpperCase()] : null;
  if (mapped && IANAZone.isValidZone(mapped)) return mapped;
  return 'UTC';
}

function parseDateInTimezone(
  dateString: string,
  timezone: string,
): { startOfDayUtc: Date; endOfDayUtc: Date } {
  if (dateString.split('-').length !== 3) {
    throw new BadRequestException('Invalid date format. Expected YYYY-MM-DD');
  }
  const zone = resolveIanaZone(timezone);
  const start = DateTime.fromISO(dateString, { zone }).startOf('day').toUTC();
  const end = start.plus({ days: 1 });
  return { startOfDayUtc: start.toJSDate(), endOfDayUtc: end.toJSDate() };
}

function normalizeAircraftFromDb(aircraft: any): AircraftEntity {
  return {
    modeS: aircraft.hexIcao,
    age: aircraft.age?.toString(),
    image: aircraft.image,
    attribution: aircraft.attribution,
    isFreighter: aircraft.isFreighter,
    model: aircraft.typeName,
    registration: aircraft.reg,
    aircraft_id: aircraft.aircraft_id,
    deliveryDate: aircraft.deliveryDate?.toISOString(),
    firstFlightDate: aircraft.firstFlightDate?.toISOString(),
    payload: aircraft.payload as any,
    registrations: (aircraft.registrations ?? []).map((r: any) => ({
      id: r.id,
      reg: r.reg,
      active: r.active,
      hexIcao: r.hexIcao ?? undefined,
      airlineName: r.airlineName ?? undefined,
      registrationDate: r.registrationDate?.toISOString(),
    })),
  } satisfies AircraftEntity;
}

function normalizeAircraftFromStored(
  stored: any | undefined,
): AircraftEntity | undefined {
  if (!stored) return undefined;
  return {
    modeS: stored.modeS ?? stored.hexIcao,
    age: (stored.ageYears ?? stored.age)?.toString(),
    image: stored.image?.url ?? stored.image,
    attribution:
      stored.attribution ?? stored.image?.htmlAttributions?.join(' '),
    isFreighter: stored.isFreighter ?? false,
    model: stored.typeName ?? stored.modelCode ?? stored.model,
    registration: stored.reg ?? stored.registration ?? stored.registrataion,
    aircraft_id: stored.aircraft_id ?? stored.id?.toString(),
    payload: stored.payload,
    deliveryDate: stored.deliveryDate,
    firstFlightDate: stored.firstFlightDate,
  } as AircraftEntity;
}

async function lookupAirline(iata?: string, icao?: string) {
  if (!iata && !icao) return null;
  return prisma.airline.findFirst({
    where: {
      OR: [
        iata ? { iata } : undefined,
        icao ? { icao } : undefined,
      ].filter(Boolean) as any,
    },
  });
}

function mergeAirline(stored: any, db: any) {
  if (!db) return stored;
  return { name: db.name, iata: db.iata, icao: db.icao, image: db.image };
}

async function lookupAirport(iata?: string, icao?: string) {
  if (!iata && !icao) return null;
  return prisma.airport.findFirst({
    where: {
      OR: [
        iata ? { iataCode: iata } : undefined,
        icao ? { OR: [{ gpsCode: icao }, { ident: icao }] } : undefined,
      ].filter(Boolean) as any,
    },
  });
}

function buildFlightAwareDataPayload(faFlight: any, flightId: string) {
  const d = (v: any) => (v ? new Date(v) : null);
  return {
    ident: faFlight.ident,
    identIcao: faFlight.ident_icao ?? null,
    identIata: faFlight.ident_iata ?? null,
    actualRunwayOff: faFlight.actual_runway_off ?? null,
    actualRunwayOn: faFlight.actual_runway_on ?? null,
    operator: faFlight.operator ?? null,
    operatorIcao: faFlight.operator_icao ?? null,
    operatorIata: faFlight.operator_iata ?? null,
    flightNumber: faFlight.flight_number ?? null,
    registration: faFlight.registration ?? null,
    atcIdent: faFlight.atc_ident ?? null,
    inboundFaFlightId: faFlight.inbound_fa_flight_id ?? null,
    codesharesIata: faFlight.codeshares_iata ?? [],
    codesharesIcao: faFlight.codeshares ?? [],
    departureDelay: faFlight.departure_delay ?? null,
    arrivalDelay: faFlight.arrival_delay ?? null,
    filedEte: faFlight.filed_ete ?? null,
    progressPercent: faFlight.progress_percent ?? null,
    status: faFlight.status,
    aircraftType: faFlight.aircraft_type ?? null,
    routeDistance: faFlight.route_distance ?? null,
    filedAirspeed: faFlight.filed_airspeed ?? null,
    filedAltitude: faFlight.filed_altitude ?? null,
    route: faFlight.route ?? null,
    baggageClaim: faFlight.baggage_claim ?? null,
    seatsCabinBusiness: faFlight.seats_cabin_business ?? null,
    seatsCabinCoach: faFlight.seats_cabin_coach ?? null,
    seatsCabinFirst: faFlight.seats_cabin_first ?? null,
    gateOrigin: faFlight.gate_origin ?? null,
    gateDestination: faFlight.gate_destination ?? null,
    terminalOrigin: faFlight.terminal_origin ?? null,
    terminalDestination: faFlight.terminal_destination ?? null,
    scheduledOut: d(faFlight.scheduled_out),
    estimatedOut: d(faFlight.estimated_out),
    actualOut: d(faFlight.actual_out),
    scheduledOff: d(faFlight.scheduled_off),
    estimatedOff: d(faFlight.estimated_off),
    actualOff: d(faFlight.actual_off),
    scheduledOn: d(faFlight.scheduled_on),
    estimatedOn: d(faFlight.estimated_on),
    actualOn: d(faFlight.actual_on),
    scheduledIn: d(faFlight.scheduled_in),
    estimatedIn: d(faFlight.estimated_in),
    actualIn: d(faFlight.actual_in),
    foresightPredictionsAvailable:
      faFlight.foresight_predictions_available ?? false,
    blocked: faFlight.blocked ?? false,
    diverted: faFlight.diverted ?? false,
    cancelled: faFlight.cancelled ?? false,
    positionOnly: faFlight.position_only ?? false,
    originCode: faFlight?.origin?.code ?? 'Unknown',
    originCodeIcao: faFlight?.origin?.code_icao ?? null,
    originCodeIata: faFlight?.origin?.code_iata ?? null,
    originCodeLid: faFlight?.origin?.code_lid ?? null,
    originTimezone: faFlight?.origin?.timezone ?? null,
    originName: faFlight?.origin?.name ?? null,
    originCity: faFlight?.origin?.city ?? null,
    destinationCode: faFlight?.destination?.code ?? 'Unknown',
    destinationCodeIcao: faFlight?.destination?.code_icao ?? null,
    destinationCodeIata: faFlight?.destination?.code_iata ?? null,
    destinationCodeLid: faFlight?.destination?.code_lid ?? null,
    destinationTimezone: faFlight?.destination?.timezone ?? null,
    destinationName: faFlight?.destination?.name ?? null,
    destinationCity: faFlight?.destination?.city ?? null,
    flightId,
  };
}

function buildFlightData(
  faFlight: any,
  userId: string,
  searchDate: Date,
  dbAirline: any,
  depAirport: any,
  arrAirport: any,
  departureConditions: AirportConditions,
  arrivalConditions: AirportConditions,
) {
  return {
    userId,
    flightNo: faFlight.ident.replace(/ /g, ''),
    callSign: faFlight.ident,
    aircraft: {
      registration: faFlight.registration,
      type: faFlight.aircraft_type,
    },
    airline: {
      name:
        dbAirline?.name ??
        faFlight.operator ??
        faFlight.operator_iata ??
        'Unknown',
      iata: dbAirline?.iata ?? faFlight.operator_iata,
      icao: dbAirline?.icao ?? faFlight.operator_icao,
      image: dbAirline?.image ?? null,
    },
    arrival: {
      airport: {
        icao: faFlight.destination?.code_icao ?? faFlight.destination?.code,
        iata: faFlight.destination?.code_iata,
        name: faFlight.destination?.name ?? 'Unknown',
        municipalityName: faFlight.destination?.city ?? 'Unknown',
        location: {
          lat: arrAirport ? Number(arrAirport.lat) : 0,
          lon: arrAirport ? Number(arrAirport.long) : 0,
        },
        countryCode: faFlight.destination?.code_icao?.substring(0, 2) ?? 'XX',
        timeZone: faFlight.destination?.timezone ?? 'UTC',
        shortName: faFlight?.destination?.name ?? 'Unknown',
        conditions: arrivalConditions,
      },
      scheduledTime: {
        utc: faFlight.scheduled_on ?? faFlight.scheduled_in,
        local: faFlight.scheduled_on ?? faFlight.scheduled_in,
      },
      revisedTime: faFlight.estimated_on
        ? { utc: faFlight.estimated_on, local: faFlight.estimated_on }
        : null,
      actualTime: faFlight.actual_on
        ? { utc: faFlight.actual_on, local: faFlight.actual_on }
        : null,
      terminal: faFlight.terminal_destination,
      gate: faFlight.gate_destination,
    },
    cargo: false,
    date: faFlight.scheduled_out ? new Date(faFlight.scheduled_out) : searchDate,
    departure: {
      airport: {
        shortName: faFlight?.origin?.name ?? 'Unknown',
        icao: faFlight.origin?.code_icao ?? faFlight.origin?.code,
        iata: faFlight.origin?.code_iata,
        name: faFlight.origin?.name ?? 'Unknown',
        municipalityName: faFlight.origin?.city ?? 'Unknown',
        location: {
          lat: depAirport ? Number(depAirport.lat) : 0,
          lon: depAirport ? Number(depAirport.long) : 0,
        },
        countryCode: faFlight.origin?.code_icao?.substring(0, 2) ?? 'XX',
        timeZone: faFlight.origin?.timezone ?? 'UTC',
        conditions: departureConditions,
      },
      scheduledTime: {
        utc: faFlight.scheduled_out ?? faFlight.scheduled_off,
        local: faFlight.scheduled_out ?? faFlight.scheduled_off,
      },
      revisedTime: faFlight.estimated_out
        ? { utc: faFlight.estimated_out, local: faFlight.estimated_out }
        : null,
      actualTime: faFlight.actual_out
        ? { utc: faFlight.actual_out, local: faFlight.actual_out }
        : null,
      terminal: faFlight.terminal_origin,
      gate: faFlight.gate_origin,
    },
  };
}

@Injectable()
export class FlightService {
  private redis: RedisService;

  constructor(
    private readonly configService: ConfigService,
    private readonly flightAwareService: FlightAwareService,
    private readonly redisService: RedisService,
  ) {
    this.redis = this.redisService.getOrNil();
  }

  /** Get a faFlight via Redis cache (by fa_flight_id) or FlightAware API. */
  private async getFaFlightById(faFlightId: string): Promise<any> {
    const cacheKey = `flightaware:flight:by_id:${faFlightId}`;
    if (this.redis) {
      try {
        const cached = await this.redis.get(cacheKey);
        if (cached) {
          console.log(`Retrieved flight ${faFlightId} from Redis cache (saving API call)`);
          return JSON.parse(cached);
        }
      } catch (error) {
        console.warn('Failed to read flight from Redis cache:', error);
      }
    }

    console.log(`Cache miss for ${faFlightId}, fetching from FlightAware API`);
    const response = await this.flightAwareService.searchFlightsByIdent(faFlightId);
    if (!response || !response.flights?.length) return null;
    const faFlight = response.flights[0];

    if (this.redis) {
      try {
        await this.redis.setex(cacheKey, 3600, JSON.stringify(faFlight));
        console.log(`Cached flight ${faFlightId} in Redis for future use`);
      } catch (error) {
        console.warn('Failed to cache flight in Redis:', error);
      }
    }
    return faFlight;
  }

  /** Resolve the FlightAware flight to operate on, given the request shape. */
  private async resolveFaFlight(args: {
    faFlightId?: string;
    forceUpdate?: boolean;
    existingFlight: any;
    iata?: string;
    icao?: string;
    searchDate: Date;
    nextDate: Date;
  }): Promise<any> {
    const { faFlightId, forceUpdate, existingFlight, iata, icao, searchDate, nextDate } = args;

    if (faFlightId) {
      const record = await prisma.flight.findFirst({
        where: {
          OR: [
            { flightAwareData: { faFlightId } },
            { id: faFlightId }, // widget flight_id may point to a flight, not fa_flight
            {
              flightAwareData:{
                id:faFlightId,
              }
            }
          ],
        },
        include: { flightAwareData: true },
      });
      const resolvedId = record?.flightAwareData?.faFlightId ?? faFlightId;
      console.log(`Fetching specific flight using fa_flight_id ${resolvedId}`);
      const faFlight = await this.getFaFlightById(resolvedId);
      if (!faFlight) {
        throw new BadRequestException(
          'Unable to fetch flight information with the provided flight ID.',
        );
      }
      return faFlight;
    }

    if (forceUpdate && existingFlight?.flightAwareData?.faFlightId) {
      const id = existingFlight.flightAwareData.faFlightId;
      console.log(`Force update: Using existing fa_flight_id ${id} to fetch from FlightAware`);
      const response = await this.flightAwareService.searchFlightsByIdent(id);
      if (!response || !response.flights?.length) {
        throw new BadRequestException(
          'Unable to fetch flight information. Please make sure the flight number is correct.',
        );
      }
      return response.flights[0];
    }

    const ident = icao || iata;
    if (!ident) throw new BadRequestException('Flight identifier required');
    const response = await this.flightAwareService.searchFlightsByIdent(ident);
    if (!response || !response.flights?.length) {
      throw new BadRequestException(
        'Unable to fetch flight information. Please make sure the flight number is correct.',
      );
    }
    let faFlight = response.flights[0];
    if (response.flights.length > 1) {
      const matched = response.flights.find((f) => {
        const d = f.scheduled_out
          ? new Date(f.scheduled_out)
          : f.scheduled_off
            ? new Date(f.scheduled_off)
            : null;
        return d ? d >= searchDate && d < nextDate : false;
      });
      if (matched) {
        faFlight = matched;
        console.log(`Matched FlightAware flight by date: ${faFlight.fa_flight_id}`);
      } else {
        console.log(`No date match found, using first flight: ${faFlight.fa_flight_id}`);
      }
    }
    return faFlight;
  }

  /** Extract a usable AeroAPI airport identifier (prefer ICAO, then IATA, then raw code). */
  private extractAirportId(airport: any): string | undefined {
    return airport?.code_icao ?? airport?.code_iata ?? airport?.code ?? undefined;
  }

  /** Fetch delays, forecast, and latest observation for an airport, in parallel. */
  private async getAirportConditions(airportId: string) {
    const [delays, forecast, observation] = await Promise.allSettled([
      this.flightAwareService.getAirportDelays(airportId),
      this.flightAwareService.getAirportWeatherForecast(airportId),
      this.flightAwareService.getAirportLatestObservation(airportId),
    ]);
    const val = <T>(r: PromiseSettledResult<T>): T | null =>
      r.status === 'fulfilled' ? r.value : null;
    return {
      delays: val(delays),
      forecast: val(forecast),
      observation: val(observation),
    };
  }

  /** Resolve (find or create) the aircraft record for a flight. */
  private async resolveAircraft(
    registration: string | undefined,
    faFlight: any,
    newFlight: any,
  ): Promise<AircraftEntity | undefined> {
    if (!registration) {
      return {
        ...(newFlight.aircraft as any),
        registration: faFlight.registration ?? 'Unknown',
        model: faFlight.aircraft_type ?? 'Unknown',
      };
    }

    const existing = await prisma.aircraft.findFirst({
      where: { reg: registration },
      include: { registrations: true },
    });
    if (existing) return normalizeAircraftFromDb(existing);

    const apiKey = this.configService.get<string>('RAPID_API_KEY');
    if (!apiKey) {
      return {
        ...(newFlight.aircraft as any),
        registration,
        model: faFlight.aircraft_type ?? 'Unknown',
      };
    }

    try {
      const res = await fetch(
        `https://aerodatabox.p.rapidapi.com/aircrafts/reg/${registration}?withImage=true&withRegistrations=true`,
        {
          headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': 'aerodatabox.p.rapidapi.com',
          },
        },
      );
      if (!res.ok) throw new Error('AeroDataBox request failed');
      const json = await res.json();

      const aircraft = await prisma.aircraft.create({
        data: {
          aircraft_id: String(json.id),
          payload: json,
          reg: json.reg,
          hexIcao: json.hexIcao,
          modelCode: json.modelCode,
          firstFlightDate: json.firstFlightDate
            ? new Date(json.firstFlightDate as string)
            : null,
          deliveryDate: json.deliveryDate
            ? new Date(json.deliveryDate as string)
            : null,
          typeName: json.typeName,
          isFreighter: json.isFreighter ?? false,
          age: json.ageYears,
          image: json?.image?.url,
          attribution: json?.image?.htmlAttributions
            ? `${json.image.htmlAttributions[0]} ${json.image.htmlAttributions[1] ?? ''}`
            : null,
          registrations: json.registrations
            ? {
                createMany: {
                  data: json.registrations.map((data: any) => ({
                    id: `registration_${createId()}`,
                    active: data.active ?? true,
                    reg: data.reg,
                    airlineName: data.airlineName,
                    registrationDate: data.registrationDate
                      ? new Date(data.registrationDate)
                      : null,
                    hexIcao: data.hexIcao,
                  })),
                  skipDuplicates: true,
                },
              }
            : undefined,
        },
        include: { registrations: true },
      });
      console.log(`Fetched aircraft data from AeroDataBox for ${registration}`);
      return normalizeAircraftFromDb(aircraft);
    } catch (error) {
      console.error('Error fetching from AeroDataBox:', error);

      let planespotterImage: string | null = null;
      let planespotterAttribution: string | null = null;
      try {
        const psRes = await fetch(
          `https://api.planespotters.net/pub/photos/reg/${registration}`,
        );
        if (psRes.ok) {
          const data = await psRes.json();
          if (data.photos?.length > 0) {
            planespotterImage = data.photos[0].thumbnail_large.src;
            planespotterAttribution = `Photo by ${data.photos[0].photographer}`;
          }
        }
      } catch (e) {
        console.error('Error fetching from Planespotters:', e);
      }

      const aircraft = await prisma.aircraft.create({
        data: {
          aircraft_id: `aircraft_${createId()}`,
          reg: registration,
          hexIcao: '',
          typeName: faFlight.aircraft_type ?? 'Unknown',
          modelCode: faFlight.aircraft_type ?? 'Unknown',
          isFreighter: false,
          age: 0,
          image: planespotterImage,
          attribution: planespotterAttribution,
          payload: {},
        },
      });
      return {
        modeS: aircraft.hexIcao,
        age: aircraft.age?.toString(),
        image: aircraft.image,
        attribution: aircraft.attribution,
        isFreighter: aircraft.isFreighter,
        model: aircraft.typeName,
        registration: aircraft.reg,
        aircraft_id: aircraft.aircraft_id,
        deliveryDate: aircraft.deliveryDate?.toISOString(),
        firstFlightDate: aircraft.firstFlightDate?.toISOString(),
        payload: aircraft.payload as any,
      } satisfies AircraftEntity;
    }
  }

  async getFlight(
    { iata, icao, date, timezone, forceUpdate, faFlightId }: GetFlightDTO,
    userId: string,
  ) {
    const dateToUse = date ?? new Date().toISOString().split('T')[0];
    const { startOfDayUtc: searchDate, endOfDayUtc: nextDate } =
      parseDateInTimezone(dateToUse, timezone);

    const existingFlight = await prisma.flight.findFirst({
      where: {
        OR: [
          { callSign: iata },
          { flightNo: iata },
          { callSign: icao },
          { flightNo: icao },
        ],
        date: { gte: searchDate, lt: nextDate },
      },
      orderBy: { createdAt: 'desc' },
      include: {
        greatCircleDistance: true,
        flightAwareData: true,
        bookings: { where: { userId }, orderBy: { createdAt: 'desc' } },
      },
    });

    // Cached path: return existing flight without hitting FlightAware
    if (!forceUpdate && existingFlight) {
      return this.buildExistingFlightResponse(existingFlight);
    }

    try {
      const faFlight = await this.resolveFaFlight({
        faFlightId,
        forceUpdate,
        existingFlight,
        iata,
        icao,
        searchDate,
        nextDate,
      });

      const arrivalAirportId = this.extractAirportId(faFlight.destination);
      const departureAirportId = this.extractAirportId(faFlight.origin);
      if (!arrivalAirportId) {
        throw new BadRequestException('No flight found');
      }

      // Kick off airport-conditions fetches in parallel with DB lookups below.
      const conditionsPromise = Promise.all([
        departureAirportId
          ? this.getAirportConditions(departureAirportId).catch(() => EMPTY_CONDITIONS)
          : Promise.resolve(EMPTY_CONDITIONS),
        this.getAirportConditions(arrivalAirportId).catch(() => EMPTY_CONDITIONS),
      ]);

      const greatCircleDistance = faFlight.route_distance
        ? {
            meter: Math.round(faFlight.route_distance * 1852).toString(),
            km: (faFlight.route_distance * 1.852).toFixed(0),
            mile: (faFlight.route_distance * 1.15078).toFixed(0),
            nm: faFlight.route_distance.toString(),
            feet: Math.round(faFlight.route_distance * 6076.12).toString(),
          }
        : null;

      const dbAirline = await lookupAirline(
        faFlight.operator_iata ?? undefined,
        faFlight.operator_icao ?? undefined,
      );
      const [depAirport, arrAirport] = await Promise.all([
        lookupAirport(
          faFlight.origin?.code_iata ?? undefined,
          faFlight.origin?.code_icao ?? faFlight.origin?.code ?? undefined,
        ),
        lookupAirport(
          faFlight.destination?.code_iata ?? undefined,
          faFlight.destination?.code_icao ?? faFlight.destination?.code ?? undefined,
        ),
      ]);

      const [departureConditions, arrivalConditions] = await conditionsPromise;

      const flightData = buildFlightData(
        faFlight,
        userId,
        searchDate,
        dbAirline,
        depAirport,
        arrAirport,
        departureConditions,
        arrivalConditions,
      );

      const newFlight =
        forceUpdate && existingFlight
          ? await prisma.flight.update({
              where: { id: existingFlight.id },
              data: flightData,
              include: { greatCircleDistance: true },
            })
          : await prisma.flight.create({
              data: { ...flightData, id: `flight_${createId()}` },
              include: { greatCircleDistance: true },
            });

      if (greatCircleDistance) {
        await prisma.greatCircleDistance.upsert({
          where: { flightId: newFlight.id },
          update: greatCircleDistance,
          create: { ...greatCircleDistance, flightId: newFlight.id },
        });
      }
      console.log(
        forceUpdate && existingFlight
          ? `Updated flight from FlightAware: ${faFlight.fa_flight_id}`
          : `Created flight from FlightAware: ${faFlight.fa_flight_id}`,
      );

      const faPayload = buildFlightAwareDataPayload(faFlight, newFlight.id);
      if (forceUpdate && existingFlight?.flightAwareData) {
        await prisma.flightAwareData.update({
          where: { id: existingFlight.flightAwareData.id },
          data: faPayload,
        });
      } else {
        const found = await prisma.flightAwareData.findFirst({
          where: { faFlightId: faFlight.fa_flight_id },
        });
        if (found) {
          await prisma.flightAwareData.update({
            where: { id: found.id },
            data: faPayload,
          });
        } else {
          await prisma.flightAwareData.create({
            data: { faFlightId: faFlight.fa_flight_id, ...faPayload },
          });
        }
      }

      const normalizedAircraft = await this.resolveAircraft(
        faFlight.registration,
        faFlight,
        newFlight,
      );

      const flightWithAwareData = await prisma.flight.findUnique({
        where: { id: newFlight.id },
        include: {
          greatCircleDistance: true,
          flightAwareData: { omit: { faFlightId: true } },
          bookings: { where: { userId }, orderBy: { createdAt: 'desc' } },
        },
      });

      const storedAirline = flightWithAwareData?.airline as any;
      const dbAirlineFinal = await lookupAirline(
        storedAirline?.iata,
        storedAirline?.icao,
      );
      const mergedAirline = mergeAirline(storedAirline, dbAirlineFinal);

      if (flightWithAwareData && normalizedAircraft) {
        return {
          ...flightWithAwareData,
          airline: mergedAirline,
          aircraft: normalizedAircraft,
          bookings: flightWithAwareData.bookings || [],
        };
      }
      return flightWithAwareData
        ? {
            ...flightWithAwareData,
            airline: mergedAirline,
            bookings: flightWithAwareData.bookings || [],
          }
        : { ...newFlight, bookings: [] };
    } catch (error) {
      if (
        error instanceof UnauthorizedException ||
        error instanceof BadRequestException
      ) {
        throw error;
      }
      console.error('Error fetching flight data:', error);
      throw new InternalServerErrorException('Failed to fetch flight data');
    }
  }

  /** Build the response for the cached (existing-flight, no forceUpdate) path. */
  private async buildExistingFlightResponse(existingFlight: any) {
    const stored = existingFlight.aircraft as any;
    let aircraft: any = null;
    if (stored) {
      const hex = stored.modeS ?? stored.hexIcao;
      const reg = stored.reg ?? stored.registration ?? stored.registrataion;
      if (hex) {
        aircraft = await prisma.aircraft.findFirst({
          where: { hexIcao: hex },
          include: { registrations: true },
        });
      }
      if (!aircraft && reg) {
        aircraft = await prisma.aircraft.findFirst({
          where: { reg },
          include: { registrations: true },
        });
      }
    }

    const storedAirline = existingFlight.airline as any;
    const dbAirline = await lookupAirline(
      storedAirline?.iata,
      storedAirline?.icao,
    );

    return {
      ...existingFlight,
      airline: mergeAirline(storedAirline, dbAirline),
      aircraft: aircraft
        ? normalizeAircraftFromDb(aircraft)
        : normalizeAircraftFromStored(stored),
      bookings: existingFlight.bookings || [],
    };
  }

  async searchFlights(
    { iata, icao, date, timezone }: GetFlightSearchDTO,
    userId: string,
  ): Promise<FlightSearchResponseEntity> {
    let searchDate: Date | null = null;
    let nextDate: Date | null = null;
    if (date) {
      const parsed = parseDateInTimezone(date, timezone);
      searchDate = parsed.startOfDayUtc;
      nextDate = parsed.endOfDayUtc;
    }

    try {
      const ident = icao || iata;
      if (!ident) throw new BadRequestException('Flight identifier required');

      const response = await this.flightAwareService.searchFlightsByIdent(ident);
      if (!response || !response.flights?.length) {
        return { flights: [], count: 0 };
      }

      let filtered = response.flights;
      if (searchDate && nextDate) {
        filtered = response.flights.filter((f: any) => {
          const d = f.scheduled_out
            ? new Date(f.scheduled_out)
            : f.scheduled_off
              ? new Date(f.scheduled_off)
              : null;
          return d ? d >= searchDate! && d < nextDate! : false;
        });
      }

      // Cache by fa_flight_id so getFlight can hit Redis instead of FA API
      if (this.redis) {
        try {
          for (const f of filtered) {
            await this.redis.setex(
              `flightaware:flight:by_id:${f.fa_flight_id}`,
              3600,
              JSON.stringify(f),
            );
          }
          console.log(
            `Cached ${filtered.length} flights in Redis for retrieval (key: flightaware:flight:by_id:*)`,
          );
        } catch (error) {
          console.warn('Failed to cache flights in Redis:', error);
        }
      }

      // Batch-resolve airlines from DB
      const iatas = new Set<string>();
      const icaos = new Set<string>();
      filtered.forEach((f: any) => {
        if (f.operator_iata) iatas.add(f.operator_iata);
        if (f.operator_icao) icaos.add(f.operator_icao);
      });
      const airlineByIata = new Map<string, any>();
      const airlineByIcao = new Map<string, any>();
      if (iatas.size || icaos.size) {
        const dbAirlines = await prisma.airline.findMany({
          where: {
            OR: [
              iatas.size ? { iata: { in: Array.from(iatas) } } : undefined,
              icaos.size ? { icao: { in: Array.from(icaos) } } : undefined,
            ].filter(Boolean) as any,
          },
        });
        for (const a of dbAirlines) {
          if (a.iata) airlineByIata.set(a.iata, a);
          if (a.icao) airlineByIcao.set(a.icao, a);
        }
      }

      const flights: FlightCandidateEntity[] = filtered.map((f: any) => {
        const dbAirline =
          (f.operator_iata && airlineByIata.get(f.operator_iata)) ||
          (f.operator_icao && airlineByIcao.get(f.operator_icao)) ||
          null;
        return {
          faFlightId: f.fa_flight_id,
          ident: f.ident,
          origin: {
            code: f.origin?.code ?? 'Unknown',
            codeIata: f.origin?.code_iata,
            codeIcao: f.origin?.code_icao ?? f.origin?.code,
            name: f.origin?.name,
            city: f.origin?.city,
          },
          destination: {
            code: f.destination?.code ?? 'Unknown',
            codeIata: f.destination?.code_iata,
            codeIcao: f.destination?.code_icao ?? f.destination?.code,
            name: f.destination?.name,
            city: f.destination?.city,
          },
          scheduledOut: f.scheduled_out ? new Date(f.scheduled_out) : undefined,
          scheduledOff: f.scheduled_off ? new Date(f.scheduled_off) : undefined,
          status: f.status ?? 'Unknown',
          airline: {
            name:
              dbAirline?.name ??
              f.operator ??
              f.operator_iata ??
              f.operator_icao ??
              'Unknown',
            iata: dbAirline?.iata ?? f.operator_iata,
            icao: dbAirline?.icao ?? f.operator_icao,
            image: dbAirline?.image ?? undefined,
          },
        };
      });

      return { flights, count: flights.length };
    } catch (error) {
      if (error instanceof BadRequestException) throw error;
      console.error(
        'Error searching flights from FlightAware, falling back to database:',
        error,
      );
      return this.searchFlightsDbFallback(iata, icao, userId, searchDate, nextDate);
    }
  }

  private async searchFlightsDbFallback(
    iata: string | undefined,
    icao: string | undefined,
    userId: string,
    searchDate: Date | null,
    nextDate: Date | null,
  ): Promise<FlightSearchResponseEntity> {
    const where: any = {
      OR: [
        { callSign: { equals: iata, mode: 'insensitive' } },
        { flightNo: { equals: iata, mode: 'insensitive' } },
        ...(icao
          ? [
              { callSign: { equals: icao, mode: 'insensitive' } },
              { flightNo: { equals: icao, mode: 'insensitive' } },
            ]
          : []),
      ],
      userId,
    };
    if (searchDate && nextDate) where.date = { gte: searchDate, lte: nextDate };

    const dbFlights = await prisma.flight.findMany({
      where,
      include: { flightAwareData: true },
      orderBy: { date: 'desc' },
    });
    if (dbFlights.length === 0) {
      throw new InternalServerErrorException('Failed to search flights');
    }

    const flights: FlightCandidateEntity[] = dbFlights.map((flight) => {
      const dep = flight.departure as any;
      const arr = flight.arrival as any;
      const airline = flight.airline as any;
      const fa = flight.flightAwareData;
      return {
        faFlightId: fa?.faFlightId ?? flight.id,
        ident: fa?.ident ?? flight.callSign ?? flight.flightNo,
        origin: {
          code: dep?.airport?.icao ?? dep?.airport?.iata ?? 'Unknown',
          codeIata: dep?.airport?.iata,
          codeIcao: dep?.airport?.icao,
          name: dep?.airport?.shortName ?? dep?.airport?.name,
          city: dep?.airport?.municipality,
        },
        destination: {
          code: arr?.airport?.icao ?? arr?.airport?.iata ?? 'Unknown',
          codeIata: arr?.airport?.iata,
          codeIcao: arr?.airport?.icao,
          name: arr?.airport?.shortName ?? arr?.airport?.name,
          city: arr?.airport?.municipality,
        },
        scheduledOut: fa?.scheduledOut ?? undefined,
        scheduledOff: fa?.scheduledOff ?? undefined,
        status: fa?.status ?? 'Unknown',
        airline: {
          name: airline?.name ?? 'Unknown',
          iata: airline?.iata,
          icao: airline?.icao,
          image: airline?.image ?? undefined,
        },
      };
    });
    return { flights, count: flights.length };
  }

  async getFlightTrack(
    { iata, icao, date, timezone }: GetFlightTrackDTO,
    userId: string,
  ) {
    const dateToUse = date ?? new Date().toISOString().split('T')[0];
    const { startOfDayUtc: searchDate, endOfDayUtc: nextDate } =
      parseDateInTimezone(dateToUse, timezone ?? 'UTC');

    const existingFlight = await prisma.flight.findFirst({
      where: {
        OR: [
          { callSign: { equals: iata, mode: 'insensitive' } },
          { flightNo: { equals: iata, mode: 'insensitive' } },
          { callSign: { equals: icao, mode: 'insensitive' } },
          { flightNo: { equals: icao, mode: 'insensitive' } },
        ],
        userId,
        date: { gte: searchDate, lte: nextDate },
      },
      orderBy: { createdAt: 'desc' },
      include: { flightAwareData: true },
    });
    if (!existingFlight) {
      throw new HttpException('Flight not found in database', HttpStatus.NOT_FOUND);
    }
    if (!existingFlight.flightAwareData?.faFlightId) {
      throw new HttpException(
        'FlightAware data not available for this flight',
        HttpStatus.NOT_FOUND,
      );
    }

    const faFlightId = existingFlight.flightAwareData.faFlightId;
    const cacheKey = `flight:track:${faFlightId}`;
    const cacheTTL = 30;

    const fa = existingFlight.flightAwareData;
    const landingTime = fa.actualOn ?? fa.actualIn ?? fa.estimatedOn;
    const isFlightConcluded = landingTime
      ? (Date.now() - new Date(landingTime as Date).getTime()) / 3_600_000 > 2
      : false;

    // Concluded + complete data already persisted: serve from DB
    if (isFlightConcluded && existingFlight.allFlightPositionsFetched) {
      console.log(
        `Flight ${faFlightId} has concluded and all positions are fetched. Returning database data.`,
      );
      const positions = await prisma.flightPositions.findMany({
        where: { flightId: existingFlight.id },
        orderBy: { timestamp: 'asc' },
      });
      if (positions.length > 0) {
        console.log(
          `FlightTrack: Returning ${positions.length} positions from database for concluded flight ${faFlightId}`,
        );
        let actualDistance: number | null = null;
        if (positions.length >= 2) {
          const a = positions[0];
          const b = positions[positions.length - 1];
          const R = 3440.065;
          const dLat = ((Number(b.latitude) - Number(a.latitude)) * Math.PI) / 180;
          const dLon = ((Number(b.longitude) - Number(a.longitude)) * Math.PI) / 180;
          const x =
            Math.sin(dLat / 2) ** 2 +
            Math.cos((Number(a.latitude) * Math.PI) / 180) *
              Math.cos((Number(b.latitude) * Math.PI) / 180) *
              Math.sin(dLon / 2) ** 2;
          actualDistance = R * 2 * Math.atan2(Math.sqrt(x), Math.sqrt(1 - x));
        }
        return {
          actual_distance: actualDistance,
          positions: positions.map((p) => ({
            fa_flight_id: faFlightId,
            altitude: p.altitude,
            altitude_change: ALT_CHANGE_TO_CODE[p.altitudeChange] ?? '-',
            groundspeed: p.groundSpeed,
            heading: p.heading ?? null,
            latitude: Number(p.latitude),
            longitude: Number(p.longitude),
            timestamp: p.timestamp.toISOString(),
            update_type: UPDATE_TYPE_TO_CODE[p.updatedType as UpdateType] ?? null,
          })),
        };
      }
    }

    const shouldSkipCache =
      isFlightConcluded && !existingFlight.allFlightPositionsFetched;
    if (shouldSkipCache) {
      console.log(
        `Flight ${faFlightId} has concluded but positions not fully fetched. Fetching complete track data from FlightAware.`,
      );
    }

    if (!shouldSkipCache && this.redis) {
      try {
        const cached = await this.redis.get(cacheKey);
        if (cached) {
          console.log(
            `FlightTrack: Returning cached data for ${faFlightId} from application cache`,
          );
          return JSON.parse(cached);
        }
      } catch (error) {
        console.warn('Redis cache read error in flight service:', error);
      }
    }

    console.log(
      `FlightTrack: Fetching ${isFlightConcluded ? 'complete' : 'live'} data from FlightAware for ${faFlightId}`,
    );
    const trackData = await this.flightAwareService.getFlightTrack(faFlightId);
    if (!trackData || !trackData.positions) {
      throw new InternalServerErrorException('Failed to fetch flight track data');
    }

    await prisma.$transaction(
      async (tx) => {
        for (const pos of trackData.positions) {
          const id = `${existingFlight.id}_${new Date(pos.timestamp).getTime()}_${pos.latitude}_${pos.longitude}`;
          const data = {
            altitude: pos.altitude,
            altitudeChange: ALT_CHANGE_FROM_CODE[pos.altitude_change || '-'] ?? 'None',
            groundSpeed: pos.groundspeed,
            heading: pos.heading ?? null,
            latitude: pos.latitude,
            longitude: pos.longitude,
            timestamp: new Date(pos.timestamp),
            updatedType: UPDATE_TYPE_FROM_CODE[pos.update_type || 'A'] ?? 'ADSB',
          };
          await tx.flightPositions.upsert({
            where: { id },
            update: data,
            create: { id, ...data, flightId: existingFlight.id },
          });
        }
        if (isFlightConcluded) {
          await tx.flight.update({
            where: { id: existingFlight.id },
            data: { allFlightPositionsFetched: true },
          });
          console.log(
            `FlightTrack: Marked all positions as fetched for concluded flight ${faFlightId}`,
          );
        }
      },
      { timeout: 60000 },
    );

    const responseData = {
      actual_distance: trackData.actual_distance ?? null,
      positions: trackData.positions.map((pos: any) => ({
        fa_flight_id: pos.fa_flight_id ?? null,
        altitude: pos.altitude,
        altitude_change: pos.altitude_change || '-',
        groundspeed: pos.groundspeed,
        heading: pos.heading ?? null,
        latitude: pos.latitude,
        longitude: pos.longitude,
        timestamp: pos.timestamp,
        update_type: pos.update_type ?? null,
      })),
    };

    if (!isFlightConcluded && this.redis) {
      try {
        await this.redis.setex(cacheKey, cacheTTL, JSON.stringify(responseData));
        console.log(
          `FlightTrack: Cached track data for ${faFlightId} for ${cacheTTL} seconds`,
        );
      } catch (error) {
        console.warn('Redis cache write error in flight service:', error);
      }
    }

    return responseData;
  }

  async createFlightBooking(dto: CreateFlightBookingDTO, userId: string) {
    const flight = await prisma.flight.findFirst({
      where: { id: dto.flightId, userId },
    });
    if (!flight) {
      throw new BadRequestException(
        'Flight not found or does not belong to the user',
      );
    }
    const existing = await prisma.flightBooking.findFirst({
      where: { flightId: dto.flightId, userId },
    });
    if (existing) {
      throw new BadRequestException(
        'A booking already exists for this flight. Use update endpoint to modify it.',
      );
    }
    return prisma.flightBooking.create({
      data: {
        flightId: dto.flightId,
        userId,
        bookingCode: dto.bookingCode ?? null,
        seatNumber: dto.seatNumber ?? null,
        seatType: dto.seatType ?? null,
        seatingClass: dto.seatingClass ?? null,
        reason: dto.reason ?? 'personal',
        notes: dto.notes ?? null,
      },
    });
  }

  async updateFlightBooking(
    bookingId: string,
    dto: UpdateFlightBookingDTO,
    userId: string,
  ) {
    const existing = await prisma.flightBooking.findFirst({
      where: { id: bookingId, userId },
    });
    if (!existing) {
      throw new NotFoundException(
        'Booking not found or does not belong to the user',
      );
    }
    const data: any = {};
    const nullIfEmpty = (v: string | null | undefined) => (v === '' ? null : v);
    if (dto.bookingCode !== undefined) data.bookingCode = nullIfEmpty(dto.bookingCode);
    if (dto.seatNumber !== undefined) data.seatNumber = nullIfEmpty(dto.seatNumber);
    if (dto.seatType !== undefined) data.seatType = dto.seatType;
    if (dto.seatingClass !== undefined) data.seatingClass = dto.seatingClass;
    if (dto.reason !== undefined) data.reason = dto.reason;
    if (dto.notes !== undefined) data.notes = nullIfEmpty(dto.notes);

    return prisma.flightBooking.update({ where: { id: bookingId }, data });
  }

  async getFlightBooking(bookingId: string, userId: string) {
    const booking = await prisma.flightBooking.findFirst({
      where: { id: bookingId, userId },
    });
    if (!booking) {
      throw new NotFoundException(
        'Booking not found or does not belong to the user',
      );
    }
    return booking;
  }

  async getFlightBookingsByFlightId(flightId: string, userId: string) {
    const flight = await prisma.flight.findFirst({
      where: { id: flightId, userId },
    });
    if (!flight) {
      throw new BadRequestException(
        'Flight not found or does not belong to the user',
      );
    }
    return prisma.flightBooking.findMany({
      where: { flightId, userId },
      orderBy: { createdAt: 'desc' },
    });
  }

  async deleteFlightBooking(bookingId: string, userId: string) {
    const existing = await prisma.flightBooking.findFirst({
      where: { id: bookingId, userId },
    });
    if (!existing) {
      throw new NotFoundException(
        'Booking not found or does not belong to the user',
      );
    }
    await prisma.flightBooking.delete({ where: { id: bookingId } });
    return { message: 'Booking deleted successfully' };
  }

  async deleteFlight(flightId: string, userId: string) {
    const existing = await prisma.flight.findFirst({
      where: { id: flightId, userId },
    });
    if (!existing) {
      throw new NotFoundException(
        'Flight not found or does not belong to the user',
      );
    }
    // Positions have no cascade; bookings, distance and FlightAware data do.
    await prisma.$transaction([
      prisma.flightPositions.deleteMany({ where: { flightId } }),
      prisma.flight.delete({ where: { id: flightId } }),
    ]);
    return { message: 'Flight deleted successfully' };
  }
}
