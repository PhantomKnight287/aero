import { prisma } from 'src/db';

import { Injectable } from '@nestjs/common';

import { ProfileStatsResponseEntity } from './entities/profile-stats.entity';
import { loadAircraftIndex } from './stats/aircraft-index';
import { aircraftReport } from './stats/sections/aircraft';
import { loadFlights } from './stats/load';
import { isCounted } from './stats/stats-flight';
import { continents, countries, topAirlines, topAirports, topRoutes, mapData } from './stats/sections/places';
import { flightsPer, passport, records } from './stats/sections/core';
import { delayReport } from './stats/sections/delays';
import { extremes, runways, taxiByAirport } from './stats/sections/ops';
import { toAirline, toAirport, toFlightSummary, toRecord } from './stats/summary';

@Injectable()
export class ProfileService {
  async getProfileStats(
    userId: string,
    year?: number,
  ): Promise<ProfileStatsResponseEntity> {
    const now = new Date();
    const all = await loadFlights(userId);
    const counted = all.filter((x) => isCounted(x.f, now));
    const inYear = (y: number) => year == null || y === year;
    // Cancelled flights are left out of `counted`; they only fill the delay bucket.
    const cancelled = all.filter(
      (x) => x.f.cancelled && x.f.date <= now && inYear(x.f.local.year),
    ).length;
    const availableYears = [...new Set(counted.map((x) => x.f.local.year))].sort(
      (a, b) => b - a,
    );
    const picked = year == null ? counted : counted.filter((x) => x.f.local.year === year);
    const fs = picked.map((x) => x.f);
    const aircraftIdx = await loadAircraftIndex(
      fs.map((f) => f.reg).filter((r): r is string => !!r),
      now,
    );
    return {
      availableYears,
      year: year ?? null,
      passport: passport(fs),
      flightsPer: flightsPer(fs),
      records: (({ shortestDistance, longestDistance, shortestDuration, longestDuration }) => ({
        shortestDistance: toRecord(shortestDistance),
        longestDistance: toRecord(longestDistance),
        shortestDuration: toRecord(shortestDuration),
        longestDuration: toRecord(longestDuration),
      }))(records(fs)),
      topAirports: topAirports(fs).map((r) => ({ ...r, airport: toAirport(r.airport) })),
      topAirlines: topAirlines(fs).map((r) => ({ ...r, airline: toAirline(r.airline) })),
      topRoutes: topRoutes(fs).map((r) => ({ ...r, from: toAirport(r.from), to: toAirport(r.to) })),
      countries: countries(fs),
      continents: continents(fs),
      delays: (() => {
        const d = delayReport(fs, cancelled);
        return {
          ...d,
          worst: toRecord(d.worst),
          airlines: d.airlines.map((a) => ({ ...a, airline: toAirline(a.airline) })),
          airports: d.airports.map((a) => ({ ...a, airport: toAirport(a.airport) })),
          flights: d.flights.map((r) => toRecord(r)!),
        };
      })(),
      runways: (() => {
        const r = runways(fs);
        return { ...r, items: r.items.map((i) => ({ ...i, airport: toAirport(i.airport) })) };
      })(),
      taxiByAirport: (() => {
        const t = taxiByAirport(fs);
        return {
          basedOn: t.basedOn,
          items: t.items.map((i) => ({ ...i, airport: toAirport(i.airport) })),
          longest: toRecord(t.longest),
        };
      })(),
      extremes: (({ north, south, east, west, highest }) => ({
        north: north && toAirport(north),
        south: south && toAirport(south),
        east: east && toAirport(east),
        west: west && toAirport(west),
        highest: highest && toAirport(highest),
      }))(extremes(fs)),
      map: mapData(fs),
      aircraft: (() => {
        const a = aircraftReport(fs, aircraftIdx);
        const airframe = (x: (typeof a.airframes)['oldest']) =>
          x && { ...x, flight: toFlightSummary(x.flight) };
        return {
          ...a,
          types: a.types.map((t) => ({ ...t, flights: t.flights.map(toFlightSummary) })),
          airframes: {
            ...a.airframes,
            oldest: airframe(a.airframes.oldest),
            newest: airframe(a.airframes.newest),
          },
        };
      })(),
    };
  }
}
