import { prisma } from 'src/db';

import { Injectable } from '@nestjs/common';

import {
  FlightSummaryEntity,
  ProfileStatsResponseEntity,
} from './entities/profile-stats.entity';
import { loadCountedFlights } from './stats/load';
import { continents, countries, topAirlines, topAirports, topRoutes, mapData } from './stats/sections/places';
import { delaySummary, flightsPer, passport, records } from './stats/sections/core';
import { extremes, runways, taxiByAirport } from './stats/sections/ops';
import { toAirline, toAirport, toRecord } from './stats/summary';

@Injectable()
export class ProfileService {
  async getProfileStats(
    userId: string,
    year?: number,
  ): Promise<ProfileStatsResponseEntity> {
    const counted = await loadCountedFlights(userId, new Date());
    const availableYears = [...new Set(counted.map((x) => x.f.local.year))].sort(
      (a, b) => b - a,
    );
    const picked = year == null ? counted : counted.filter((x) => x.f.local.year === year);
    const fs = picked.map((x) => x.f);
    // aircraft block below works on the same filtered rows
    const flights = picked.map((x) => x.row);

    // Calculate most flown aircraft using DB typeName
    const aircraftCounts = new Map<string, number>();
    const aircraftTypeToFlights = new Map<string, typeof flights>();
    const regs = new Set<string>();
    const modelCodes = new Set<string>();
    const candidateTypeNames = new Set<string>();
    const tailNumbers = new Map<string, number>(); // Track tail number counts
    const tailNumberToAircraft = new Map<
      string,
      { typeName: string; age?: number; image?: string }
    >();

    flights.forEach((flight) => {
      const aircraft = flight.aircraft as any;
      const fa = (flight as any).flightAwareData as any;

      // Track tail numbers
      const tailNumber =
        aircraft?.reg || aircraft?.registration || fa?.registration || '';
      if (tailNumber) {
        tailNumbers.set(tailNumber, (tailNumbers.get(tailNumber) || 0) + 1);
      }

      if (aircraft?.reg) regs.add(aircraft.reg);
      if (aircraft?.registration) regs.add(aircraft.registration);
      if (aircraft?.modelCode) modelCodes.add(aircraft.modelCode);
      if (aircraft?.typeName) candidateTypeNames.add(aircraft.typeName);
      if (fa?.aircraftType) modelCodes.add(fa.aircraftType);
    });

    const registrations = regs.size
      ? await prisma.aircraftRegistration.findMany({
          where: { reg: { in: Array.from(regs) } },
          include: { Aircraft: true },
        })
      : [];
    const regToTypeName = new Map<string, string>();
    const regToAircraftId = new Map<string, string>();
    registrations.forEach((r) => {
      if (r.reg && r.Aircraft?.typeName) {
        regToTypeName.set(r.reg, r.Aircraft.typeName);
        if (r.Aircraft.id) regToAircraftId.set(r.reg, r.Aircraft.id);
      }
    });

    // Fetch all aircraft data for images and ages
    const allAircraftIds = Array.from(regToAircraftId.values());
    const aircraftRows =
      modelCodes.size || candidateTypeNames.size || allAircraftIds.length > 0
        ? await prisma.aircraft.findMany({
            where: {
              OR: [
                modelCodes.size
                  ? { modelCode: { in: Array.from(modelCodes) } }
                  : undefined,
                candidateTypeNames.size
                  ? { typeName: { in: Array.from(candidateTypeNames) } }
                  : undefined,
                allAircraftIds.length > 0
                  ? { id: { in: allAircraftIds } }
                  : undefined,
              ].filter(Boolean) as any,
            },
            select: {
              id: true,
              modelCode: true,
              typeName: true,
              image: true,
              age: true,
              reg: true,
              createdAt: true,
            },
          })
        : [];

    const modelCodeToTypeName = new Map<string, string>();
    const typeNameToImage = new Map<string, string>();
    const regToAge = new Map<string, number>();
    const regToImage = new Map<string, string>();

    const now = new Date();

    aircraftRows.forEach((a) => {
      if (a.modelCode && a.typeName) {
        modelCodeToTypeName.set(a.modelCode, a.typeName);
        if (a.image) typeNameToImage.set(a.typeName, a.image);
      }
      if (a.typeName && a.image) {
        typeNameToImage.set(a.typeName, a.image);
      }
      if (a.reg && a.age !== null) {
        // Calculate age offset based on when the record was created
        const ageAtCreation = Number(a.age);
        const yearsSinceCreation =
          (now.getTime() - a.createdAt.getTime()) / (1000 * 60 * 60 * 24 * 365.25);
        const adjustedAge = ageAtCreation + yearsSinceCreation;
        regToAge.set(a.reg, adjustedAge);
      }
      if (a.reg && a.image) {
        regToImage.set(a.reg, a.image);
      }
    });

    flights.forEach((flight) => {
      const aircraft = flight.aircraft as any;
      const fa = (flight as any).flightAwareData as any;
      let typeName = '';
      if (aircraft?.typeName) typeName = aircraft.typeName;
      else if (aircraft?.reg && regToTypeName.get(aircraft.reg))
        typeName = regToTypeName.get(aircraft.reg)!;
      else if (
        aircraft?.registration &&
        regToTypeName.get(aircraft.registration)
      )
        typeName = regToTypeName.get(aircraft.registration)!;
      else if (
        aircraft?.modelCode &&
        modelCodeToTypeName.get(aircraft.modelCode)
      )
        typeName = modelCodeToTypeName.get(aircraft.modelCode)!;
      else if (fa?.aircraftType && modelCodeToTypeName.get(fa.aircraftType))
        typeName = modelCodeToTypeName.get(fa.aircraftType)!;

      if (typeName) {
        aircraftCounts.set(typeName, (aircraftCounts.get(typeName) || 0) + 1);
        if (!aircraftTypeToFlights.has(typeName)) {
          aircraftTypeToFlights.set(typeName, []);
        }
        aircraftTypeToFlights.get(typeName)!.push(flight);
      }

      // Track tail number to aircraft info (for all flights, not just those with typeName)
      const tailNumber =
        aircraft?.reg || aircraft?.registration || fa?.registration || '';
      if (tailNumber && !tailNumberToAircraft.has(tailNumber)) {
        // Get typeName for this tail number if we don't have it from above
        let aircraftTypeName = typeName;
        if (!aircraftTypeName && regToTypeName.has(tailNumber)) {
          aircraftTypeName = regToTypeName.get(tailNumber)!;
        }
        tailNumberToAircraft.set(tailNumber, {
          typeName: aircraftTypeName || '',
          age: regToAge.get(tailNumber),
          image: regToImage.get(tailNumber),
        });
      }
    });

    // Collect unique aircraft ages for median calculation
    const uniqueAircraftAges: number[] = [];
    tailNumberToAircraft.forEach((info) => {
      if (info.age !== undefined && info.age > 0) {
        uniqueAircraftAges.push(info.age);
      }
    });

    const mostFlownAircraft = Array.from(aircraftCounts.entries()).sort(
      (a, b) => b[1] - a[1],
    )[0] || ['', 0];

    // Find most common tail number
    const mostCommonTailNumber = Array.from(tailNumbers.entries()).sort(
      (a, b) => b[1] - a[1],
    )[0] || ['', 0];

    // Calculate median age (using unique aircraft ages)
    let medianAge: number | undefined;
    if (uniqueAircraftAges.length > 0) {
      const sortedAges = [...uniqueAircraftAges].sort((a, b) => a - b);
      const mid = Math.floor(sortedAges.length / 2);
      const calculatedMedian =
        sortedAges.length % 2 === 0
          ? (sortedAges[mid - 1] + sortedAges[mid]) / 2
          : sortedAges[mid];
      medianAge = Math.round(calculatedMedian * 10) / 10; // Round to 1 decimal place
    }

    // Find youngest and oldest aircraft with images
    let youngestAircraft: {
      aircraftName: string;
      tailNumber: string;
      age?: number;
      image?: string;
    } | undefined;
    let oldestAircraft: {
      aircraftName: string;
      tailNumber: string;
      age?: number;
      image?: string;
    } | undefined;

    const aircraftWithAgeAndImage = Array.from(tailNumberToAircraft.entries())
      .map(([tailNumber, info]) => ({
        tailNumber,
        typeName: info.typeName,
        age: info.age,
        image: info.image,
      }))
      .filter((a) => a.age !== undefined && a.age > 0 && a.image);

    if (aircraftWithAgeAndImage.length > 0) {
      const sortedByAge = [...aircraftWithAgeAndImage].sort(
        (a, b) => (a.age || 0) - (b.age || 0),
      );
      youngestAircraft = {
        aircraftName: sortedByAge[0].typeName,
        tailNumber: sortedByAge[0].tailNumber,
        age: sortedByAge[0].age,
        image: sortedByAge[0].image,
      };
      oldestAircraft = {
        aircraftName: sortedByAge[sortedByAge.length - 1].typeName,
        tailNumber: sortedByAge[sortedByAge.length - 1].tailNumber,
        age: sortedByAge[sortedByAge.length - 1].age,
        image: sortedByAge[sortedByAge.length - 1].image,
      };
    }

    // Bulk fetch airlines to enrich images and compute stats
    const airlineIatas = new Set<string>();
    const airlineIcaos = new Set<string>();
    flights.forEach((flight) => {
      const airline = flight.airline as any;
      if (airline?.iata) airlineIatas.add(airline.iata);
      if (airline?.icao) airlineIcaos.add(airline.icao);
    });
    const airlinesFromDb =
      airlineIatas.size || airlineIcaos.size
        ? await prisma.airline.findMany({
            where: {
              OR: [
                airlineIatas.size
                  ? { iata: { in: Array.from(airlineIatas) } }
                  : undefined,
                airlineIcaos.size
                  ? { icao: { in: Array.from(airlineIcaos) } }
                  : undefined,
              ].filter(Boolean) as any,
            },
            select: { iata: true, icao: true, image: true, name: true },
          })
        : [];
    const airlineByIata = new Map<string, { image?: string; name: string }>();
    const airlineByIcao = new Map<string, { image?: string; name: string }>();
    airlinesFromDb.forEach((a) => {
      if (a.iata)
        airlineByIata.set(a.iata, {
          image: a.image || undefined,
          name: a.name,
        });
      if (a.icao)
        airlineByIcao.set(a.icao, {
          image: a.image || undefined,
          name: a.name,
        });
    });

    // Transform to lightweight flight summary (no heavy payloads)
    const transformFlight = (
      flight: (typeof flights)[0],
    ): FlightSummaryEntity => {
      const departure = flight.departure as any;
      const arrival = flight.arrival as any;
      const airline = flight.airline as any;

      return {
        id: flight.id,
        flightNo: flight.flightNo,
        callSign: flight.callSign,
        airline: {
          name:
            (airline?.iata && airlineByIata.get(airline.iata)?.name) ||
            (airline?.icao && airlineByIcao.get(airline.icao)?.name) ||
            airline?.name ||
            '',
          iata: airline?.iata || '',
          icao: airline?.icao,
          image:
            (airline?.iata && airlineByIata.get(airline.iata)?.image) ||
            (airline?.icao && airlineByIcao.get(airline.icao)?.image) ||
            airline?.image ||
            undefined,
        },
        departureAirportCode:
          departure?.airport?.iata || departure?.airport?.icao || '',
        departureAirportName:
          departure?.airport?.name || departure?.airport?.shortName || '',
        arrivalAirportCode:
          arrival?.airport?.iata || arrival?.airport?.icao || '',
        arrivalAirportName:
          arrival?.airport?.name || arrival?.airport?.shortName || '',
        date: flight.date.toISOString(),
      };
    };

    // Get flights for most flown aircraft
    const mostFlownFlights =
      mostFlownAircraft[0] && aircraftTypeToFlights.has(mostFlownAircraft[0])
        ? aircraftTypeToFlights.get(mostFlownAircraft[0])!.map(transformFlight)
        : [];

    return {
      mostFlownAircraft: {
        aircraftName: mostFlownAircraft[0],
        flightCount: mostFlownAircraft[1],
      },
      aircraftStats: {
        mostFlownAircraftName: mostFlownAircraft[0],
        mostFlownAircraftFlightCount: mostFlownAircraft[1],
        mostFlownAircraftImage: mostFlownAircraft[0]
          ? typeNameToImage.get(mostFlownAircraft[0])
          : undefined,
        mostFlownAircraftFlights: mostFlownFlights,
        mostCommonTailNumber: mostCommonTailNumber[0],
        mostCommonTailNumberCount: mostCommonTailNumber[1],
        medianAge: medianAge,
        youngestAircraft: youngestAircraft,
        oldestAircraft: oldestAircraft,
      },
      availableYears,
      year: year ?? null,
      passport: passport(fs),
      flightsPer: flightsPer(fs),
      records: Object.fromEntries(
        Object.entries(records(fs)).map(([k, v]) => [k, toRecord(v)]),
      ) as any,
      topAirports: topAirports(fs).map((r) => ({ ...r, airport: toAirport(r.airport) })),
      topAirlines: topAirlines(fs).map((r) => ({ ...r, airline: toAirline(r.airline) })),
      topRoutes: topRoutes(fs).map((r) => ({ ...r, from: toAirport(r.from), to: toAirport(r.to) })),
      countries: countries(fs),
      continents: continents(fs),
      delays: delaySummary(fs),
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
      extremes: Object.fromEntries(
        Object.entries(extremes(fs)).map(([k, v]) => [k, v && toAirport(v)]),
      ) as any,
      map: mapData(fs),
    };
  }
}
