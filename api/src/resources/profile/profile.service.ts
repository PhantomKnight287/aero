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
    const regs = new Set<string>();
    const modelCodes = new Set<string>();
    const candidateTypeNames = new Set<string>();

    flights.forEach((flight) => {
      const aircraft = flight.aircraft as any;
      if (aircraft?.reg) regs.add(aircraft.reg);
      if (aircraft?.registration) regs.add(aircraft.registration);
      if (aircraft?.modelCode) modelCodes.add(aircraft.modelCode);
      if (aircraft?.typeName) candidateTypeNames.add(aircraft.typeName);
      const fa = (flight as any).flightAwareData as any;
      if (fa?.aircraftType) modelCodes.add(fa.aircraftType);
    });

    const registrations = regs.size
      ? await prisma.aircraftRegistration.findMany({
          where: { reg: { in: Array.from(regs) } },
          include: { Aircraft: true },
        })
      : [];
    const regToTypeName = new Map<string, string>();
    registrations.forEach((r) => {
      if (r.reg && r.Aircraft?.typeName)
        regToTypeName.set(r.reg, r.Aircraft.typeName);
    });

    const aircraftRows =
      modelCodes.size || candidateTypeNames.size
        ? await prisma.aircraft.findMany({
            where: {
              OR: [
                modelCodes.size
                  ? { modelCode: { in: Array.from(modelCodes) } }
                  : undefined,
                candidateTypeNames.size
                  ? { typeName: { in: Array.from(candidateTypeNames) } }
                  : undefined,
              ].filter(Boolean) as any,
            },
            select: { modelCode: true, typeName: true },
          })
        : [];
    const modelCodeToTypeName = new Map<string, string>();
    aircraftRows.forEach((a) => {
      if (a.modelCode && a.typeName)
        modelCodeToTypeName.set(a.modelCode, a.typeName);
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

      if (typeName)
        aircraftCounts.set(typeName, (aircraftCounts.get(typeName) || 0) + 1);
    });

    const mostFlownAircraft = Array.from(aircraftCounts.entries()).sort(
      (a, b) => b[1] - a[1],
    )[0] || ['', 0];

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

    return {
      mostFlownAircraft: {
        aircraftName: mostFlownAircraft[0],
        flightCount: mostFlownAircraft[1],
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
