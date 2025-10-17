import { prisma } from 'src/db';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';

import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { GetAirlineDTO } from './dto/get-airline.dto';
import { GetFlightsBoundsDTO } from './dto/get-flights-bounds.dto';
import { GetFlightsDTO } from './dto/get-flights.dto';

@Injectable()
export class FlightsService {
  constructor(
    private configService: ConfigService,
    private flightAwareService: FlightAwareService,
  ) {}

  async getAirline(body: GetAirlineDTO) {
    const airline = await prisma.airline.findFirst({
      where: {
        OR: [
          {
            iata: {
              equals: body.search.substring(0, 2),
              mode: 'insensitive',
            },
            icao: {
              equals: body.search.substring(0, 3),
              mode: 'insensitive',
            },
          },
        ],
      },
    });
    if (!airline)
      throw new HttpException('No airline found', HttpStatus.NOT_FOUND);
    return airline;
  }

  async getFlightsBetweenTwoAirports(query: GetFlightsDTO) {
    const { from, to, date } = query;
    const apiKey = this.configService.get<string>('AVIATION_STACK_API_KEY');

    if (!apiKey) {
      throw new HttpException(
        'Internal Server Error',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }

    const _date = new Date(date);
    const dayEndDate = new Date(_date);
    dayEndDate.setDate(_date.getDate() + 1);

    // First check in database
    try {
      const existingFlights = await prisma.flights.findMany({
        where: {
          AND: [
            {
              arrival: {
                path: ['iataCode'],
                string_contains: to,
              },
              departure: {
                path: ['iataCode'],
                string_contains: from,
              },
            },
            // Uncomment below for production
            // {
            //   date: {
            //     gte: _date,
            //     lt: dayEndDate,
            //   },
            // },
          ],
        },
        orderBy: {
          createdAt: 'desc',
        },
      });
      if (existingFlights.length > 0) {
        return {
          success: true,
          date,
          route: { from, to },
          flightCount: existingFlights.length,
          flights: existingFlights,
        };
      }
    } catch (error) {
      console.error('Database query error:', error);
    }

    try {
      const apiUrl = new URL('https://api.aviationstack.com/v1/timetable');
      apiUrl.searchParams.append('access_key', apiKey);
      apiUrl.searchParams.append('iataCode', from);
      apiUrl.searchParams.append('type', 'departure');

      const response = await fetch(apiUrl);

      if (!response.ok) {
        console.log(await response.text());
        throw new Error(`API request failed with status ${response.status}`);
      }

      const flights = await response.json();

      await Promise.all(
        flights.data.map((flight) =>
          prisma.flights.create({
            data: {
              date: _date,
              airline: flight.airline,
              arrival: flight.arrival,
              codeshared: flight.codeshared,
              flight: flight.flight,
              departure: flight.departure,
              type: flight.type,
              status: flight.status,
            },
          }),
        ),
      );

      const routeFlights = flights.data.filter(
        (flight) =>
          flight.departure?.iataCode === from &&
          flight.arrival?.iataCode === to,
      );

      return {
        success: true,
        date,
        route: { from, to },
        flightCount: routeFlights.length,
        flights: routeFlights,
      };
    } catch (error) {
      console.error('Error fetching flights:', error);
      throw new HttpException(
        'Failed to fetch flight data',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async getFlightsInBounds(query: GetFlightsBoundsDTO) {
    const { minLat, maxLat, minLng, maxLng } = query;

    try {
      // Validate bounds
      if (minLat >= maxLat) {
        throw new HttpException(
          'Minimum latitude must be less than maximum latitude',
          HttpStatus.BAD_REQUEST,
        );
      }

      if (minLng >= maxLng) {
        throw new HttpException(
          'Minimum longitude must be less than maximum longitude',
          HttpStatus.BAD_REQUEST,
        );
      }

      // Check if bounds are too large (prevent world-wide queries)
      const latSpan = maxLat - minLat;
      const lngSpan = maxLng - minLng;
      const maxAllowedSpan = 30; // degrees

      if (latSpan > maxAllowedSpan || lngSpan > maxAllowedSpan) {
        throw new HttpException(
          `Bounds too large. Maximum allowed span is ${maxAllowedSpan} degrees. Current span: lat=${latSpan.toFixed(2)}, lng=${lngSpan.toFixed(2)}`,
          HttpStatus.BAD_REQUEST,
        );
      }

      // Get flights from FlightAware
      const flightAwareData = await this.flightAwareService.getFlightsInBounds(
        minLat,
        maxLat,
        minLng,
        maxLng,
      );

      // Filter and transform the data to a more user-friendly format
      const flights = flightAwareData.flights
        .filter((flight) => {
          // Only include flights with position data and that are airborne
          return (
            flight.last_position &&
            flight.last_position.latitude &&
            flight.last_position.longitude &&
            flight.status !== 'Cancelled' &&
            flight.status !== 'Landed'
          );
        })
        .map((flight) => ({
          ident_icao: flight.ident_icao || flight.ident,
          ident_iata: flight.ident_iata,
          callsign: flight.ident,

          // Position and movement data
          latitude: flight.last_position?.latitude,
          longitude: flight.last_position?.longitude,
          altitude: flight.last_position?.altitude,
          velocity: flight.last_position?.groundspeed,
          heading: flight.last_position?.heading,
          verticalRate:
            flight.last_position?.altitude_change === 'C'
              ? 1
              : flight.last_position?.altitude_change === 'D'
                ? -1
                : 0,
          lastContact:
            flight.last_position?.timestamp || new Date().toISOString(),
          isOnGround:
            flight.status === 'Landed' || flight.status === 'On Ground',

          // Aircraft details
          aircraftType: flight.aircraft_type,
          aircraftTypeFaa: flight.aircraft_type_faa,
          aircraftFamily: flight.aircraft_family,
          manufacturer: flight.manufacturer,
          model: flight.model,
          engineType: flight.engine_type,
          engineCount: flight.engine_count,
          wakeTurbulenceCategory: flight.wake_turbulence_category,

          // Flight plan and registration
          aircraftId: flight.flight_plan?.aircraft_id,
          aircraftRegistration: flight.flight_plan?.owner || 'Unknown',
          ownerIcao: flight.flight_plan?.owner_icao,
          ownerIata: flight.flight_plan?.owner_iata,
          ownerName: flight.flight_plan?.owner_name,

          // Operator information
          operator: flight.operator?.name || flight.operator?.callsign,
          operatorIcao: flight.operator?.icao,
          operatorIata: flight.operator?.iata,
          operatorCountry: flight.operator?.country,

          // Route information
          origin: {
            code: flight.origin?.code,
            codeIcao: flight.origin?.code_icao,
            codeIata: flight.origin?.code_iata,
            name: flight.origin?.name,
            city: flight.origin?.city,
            timezone: flight.origin?.timezone,
          },
          destination: {
            code: flight.destination?.code,
            codeIcao: flight.destination?.code_icao,
            codeIata: flight.destination?.code_iata,
            name: flight.destination?.name,
            city: flight.destination?.city,
            timezone: flight.destination?.timezone,
          },

          // Flight status and timing
          status: flight.status,
          progressPercent: flight.progress_percent,
          routeDistance: flight.route_distance,
          filedAirspeedKts: flight.filed_airspeed_kts,
          filedAltitude: flight.filed_altitude,

          // Schedule information
          scheduledOff: flight.scheduled_off,
          scheduledOn: flight.scheduled_on,
          estimatedOff: flight.estimated_off,
          estimatedOn: flight.estimated_on,
          actualOff: flight.actual_off,
          actualOn: flight.actual_on,

          // Delays
          departureDelay: flight.departure_delay,
          arrivalDelay: flight.arrival_delay,

          // Airport details
          gateOrigin: flight.gate_origin,
          gateDestination: flight.gate_destination,
          terminalOrigin: flight.terminal_origin,
          terminalDestination: flight.terminal_destination,

          // Additional metadata
          route: flight.route,
          type: flight.type,
        }));

      return {
        success: true,
        timestamp: new Date().toISOString(),
        bounds: {
          minLat,
          maxLat,
          minLng,
          maxLng,
        },
        totalAircraft: flightAwareData.flights.length,
        airborneAircraft: flights.length,
        flights,
      };
    } catch (error) {
      console.error('Error fetching flights in bounds:', error);
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch flight data for the specified region',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
