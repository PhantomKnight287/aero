import { prisma } from 'src/db';

import { Injectable } from '@nestjs/common';

import { ProfileStatsResponseEntity } from './entities/profile-stats.entity';
import { FlightSummaryEntity } from './entities/profile-stats.entity';

@Injectable()
export class ProfileService {
  async getProfileStats(userId: string): Promise<ProfileStatsResponseEntity> {
    const flights = await prisma.flight.findMany({
      include: {
        greatCircleDistance: true,
        flightAwareData: true,
      },
      where: { userId },
    });

    if (flights.length === 0) {
      return this.getEmptyStats();
    }

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

    // Calculate passport stats
    const uniqueAirports = new Set<string>();
    const uniqueAirlines = new Set<string>();
    let totalDistanceKm = 0;
    let totalDurationMinutes = 0;

    flights.forEach((flight) => {
      const departure = flight.departure as any;
      const arrival = flight.arrival as any;
      const airline = flight.airline as any;

      // Track airports
      if (departure?.airport?.iata) {
        uniqueAirports.add(departure.airport.iata);
      }
      if (departure?.airport?.icao) {
        uniqueAirports.add(departure.airport.icao);
      }
      if (arrival?.airport?.iata) {
        uniqueAirports.add(arrival.airport.iata);
      }
      if (arrival?.airport?.icao) {
        uniqueAirports.add(arrival.airport.icao);
      }

      // Track airlines
      if (airline?.iata) {
        uniqueAirlines.add(airline.iata);
      }
      if (airline?.icao) {
        uniqueAirlines.add(airline.icao);
      }

      // Sum distance
      if (flight.greatCircleDistance?.km) {
        const km = Number(flight.greatCircleDistance.km);
        if (!isNaN(km)) {
          totalDistanceKm += km;
        }
      }

      // Calculate duration (including delays)
      if (flight.flightAwareData) {
        const faData = flight.flightAwareData;
        let durationMinutes = 0;

        // Use filed ETE if available (in seconds)
        if (faData.filedEte) {
          durationMinutes = faData.filedEte / 60;
        } else {
          // Calculate from actual times if available
          const departureTime =
            faData.actualOff ||
            faData.actualOut ||
            faData.scheduledOff ||
            faData.scheduledOut;
          const arrivalTime =
            faData.actualOn ||
            faData.actualIn ||
            faData.scheduledOn ||
            faData.scheduledIn;

          if (departureTime && arrivalTime) {
            durationMinutes =
              (arrivalTime.getTime() - departureTime.getTime()) / (1000 * 60);
          }
        }

        // Add delays if available (delays are in seconds)
        if (faData.departureDelay) {
          durationMinutes += faData.departureDelay / 60;
        }
        if (faData.arrivalDelay) {
          durationMinutes += faData.arrivalDelay / 60;
        }

        if (durationMinutes > 0) {
          totalDurationMinutes += durationMinutes;
        }
      }
    });

    // Find shortest and longest distance flights
    const flightsWithDistance = flights
      .map((flight) => ({
        flight,
        distanceKm: flight.greatCircleDistance?.km
          ? Number(flight.greatCircleDistance.km)
          : null,
      }))
      .filter((f) => f.distanceKm !== null && !isNaN(f.distanceKm));

    const shortestDistanceFlight =
      flightsWithDistance.length > 0
        ? flightsWithDistance.reduce((prev, curr) =>
            curr.distanceKm! < prev.distanceKm! ? curr : prev,
          )
        : null;

    const longestDistanceFlight =
      flightsWithDistance.length > 0
        ? flightsWithDistance.reduce((prev, curr) =>
            curr.distanceKm! > prev.distanceKm! ? curr : prev,
          )
        : null;

    // Find shortest and longest duration flights
    const flightsWithDuration = flights
      .map((flight) => {
        if (!flight.flightAwareData) return null;

        const faData = flight.flightAwareData;
        let durationMinutes = 0;

        if (faData.filedEte) {
          durationMinutes = faData.filedEte / 60;
        } else {
          const departureTime =
            faData.actualOff ||
            faData.actualOut ||
            faData.scheduledOff ||
            faData.scheduledOut;
          const arrivalTime =
            faData.actualOn ||
            faData.actualIn ||
            faData.scheduledOn ||
            faData.scheduledIn;

          if (departureTime && arrivalTime) {
            durationMinutes =
              (arrivalTime.getTime() - departureTime.getTime()) / (1000 * 60);
          }
        }

        if (faData.departureDelay) {
          durationMinutes += faData.departureDelay / 60;
        }
        if (faData.arrivalDelay) {
          durationMinutes += faData.arrivalDelay / 60;
        }

        return durationMinutes > 0 ? { flight, durationMinutes } : null;
      })
      .filter(
        (f): f is { flight: (typeof flights)[0]; durationMinutes: number } =>
          f !== null,
      );

    const shortestDurationFlight =
      flightsWithDuration.length > 0
        ? flightsWithDuration.reduce((prev, curr) =>
            curr.durationMinutes < prev.durationMinutes ? curr : prev,
          )
        : null;

    const longestDurationFlight =
      flightsWithDuration.length > 0
        ? flightsWithDuration.reduce((prev, curr) =>
            curr.durationMinutes > prev.durationMinutes ? curr : prev,
          )
        : null;

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

    // Calculate airline stats
    const airlineCounts = new Map<
      string,
      { name: string; iata: string; icao?: string; count: number }
    >();

    flights.forEach((flight) => {
      const airline = flight.airline as any;
      const key = airline?.iata || airline?.icao || '';
      const dbMatch =
        (airline?.iata && airlineByIata.get(airline.iata)) ||
        (airline?.icao && airlineByIcao.get(airline.icao)) ||
        undefined;
      const existing = airlineCounts.get(key) || {
        name: dbMatch?.name || airline?.name || '',
        iata: airline?.iata || '',
        icao: airline?.icao,
        count: 0,
      };
      existing.count++;
      airlineCounts.set(key, existing);
    });

    const airlines = Array.from(airlineCounts.values())
      .map((airline) => ({
        airlineName: airline.name,
        airlineIata: airline.iata,
        airlineIcao: airline.icao,
        image:
          (airline.iata && airlineByIata.get(airline.iata)?.image) ||
          (airline.icao && airlineByIcao.get(airline.icao)?.image) ||
          undefined,
        flightCount: airline.count,
      }))
      .sort((a, b) => b.flightCount - a.flightCount);

    // Calculate airport stats (departures)
    const airportDepartureCounts = new Map<
      string,
      { code: string; name: string; count: number }
    >();

    flights.forEach((flight) => {
      const departure = flight.departure as any;
      const airportCode = departure?.airport?.iata || departure?.airport?.icao;
      const airportName =
        departure?.airport?.name || departure?.airport?.shortName || '';

      if (airportCode) {
        const existing = airportDepartureCounts.get(airportCode) || {
          code: airportCode,
          name: airportName,
          count: 0,
        };
        existing.count++;
        airportDepartureCounts.set(airportCode, existing);
      }
    });

    const airports = Array.from(airportDepartureCounts.values())
      .map((airport) => ({
        airportCode: airport.code,
        airportName: airport.name,
        departureCount: airport.count,
      }))
      .sort((a, b) => b.departureCount - a.departureCount);

    // Calculate top routes
    const routeCounts = new Map<string, number>();

    flights.forEach((flight) => {
      const departure = flight.departure as any;
      const arrival = flight.arrival as any;
      const origin = departure?.airport?.iata || departure?.airport?.icao;
      const destination = arrival?.airport?.iata || arrival?.airport?.icao;

      if (origin && destination) {
        const routeKey = `${origin}-${destination}`;
        routeCounts.set(routeKey, (routeCounts.get(routeKey) || 0) + 1);
      }
    });

    const topRoutes = Array.from(routeCounts.entries())
      .map(([route, count]) => {
        const [origin, destination] = route.split('-');
        return { origin, destination, flightCount: count };
      })
      .sort((a, b) => b.flightCount - a.flightCount)
      .slice(0, 10); // Top 10 routes

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
      passport: {
        totalFlights: flights.length,
        totalDistanceKm: Math.round(totalDistanceKm * 100) / 100,
        totalDurationMinutes: Math.round(totalDurationMinutes),
        totalAirports: uniqueAirports.size,
        totalAirlines: uniqueAirlines.size,
      },
      shortestDistanceFlight: shortestDistanceFlight
        ? {
            flight: transformFlight(shortestDistanceFlight.flight),
            distanceKm:
              Math.round(shortestDistanceFlight.distanceKm! * 100) / 100,
          }
        : {
            flight: transformFlight(flights[0]),
            distanceKm: 0,
          },
      longestDistanceFlight: longestDistanceFlight
        ? {
            flight: transformFlight(longestDistanceFlight.flight),
            distanceKm:
              Math.round(longestDistanceFlight.distanceKm! * 100) / 100,
          }
        : {
            flight: transformFlight(flights[0]),
            distanceKm: 0,
          },
      shortestDurationFlight: shortestDurationFlight
        ? {
            flight: transformFlight(shortestDurationFlight.flight),
            durationMinutes: Math.round(shortestDurationFlight.durationMinutes),
          }
        : {
            flight: transformFlight(flights[0]),
            durationMinutes: 0,
          },
      longestDurationFlight: longestDurationFlight
        ? {
            flight: transformFlight(longestDurationFlight.flight),
            durationMinutes: Math.round(longestDurationFlight.durationMinutes),
          }
        : {
            flight: transformFlight(flights[0]),
            durationMinutes: 0,
          },
      airlines,
      airports,
      topRoutes,
    };
  }

  private getEmptyStats(): ProfileStatsResponseEntity {
    return {
      mostFlownAircraft: {
        aircraftName: '',
        flightCount: 0,
      },
      aircraftStats: {
        mostFlownAircraftName: '',
        mostFlownAircraftFlightCount: 0,
        mostFlownAircraftFlights: [],
        mostCommonTailNumber: '',
        mostCommonTailNumberCount: 0,
      },
      passport: {
        totalFlights: 0,
        totalDistanceKm: 0,
        totalDurationMinutes: 0,
        totalAirports: 0,
        totalAirlines: 0,
      },
      shortestDistanceFlight: {
        flight: {} as unknown as FlightSummaryEntity,
        distanceKm: 0,
      },
      longestDistanceFlight: {
        flight: {} as unknown as FlightSummaryEntity,
        distanceKm: 0,
      },
      shortestDurationFlight: {
        flight: {} as unknown as FlightSummaryEntity,
        durationMinutes: 0,
      },
      longestDurationFlight: {
        flight: {} as unknown as FlightSummaryEntity,
        durationMinutes: 0,
      },
      airlines: [],
      airports: [],
      topRoutes: [],
    };
  }
}
