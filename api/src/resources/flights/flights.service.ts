import { prisma } from 'src/db';

import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { GetAirlineDTO } from './dto/get-airline.dto';
import { GetFlightsDTO } from './dto/get-flights.dto';

@Injectable()
export class FlightsService {
  constructor(private configService: ConfigService) {}

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
}
