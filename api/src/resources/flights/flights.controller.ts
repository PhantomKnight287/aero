import { GenericErrorEntity } from 'src/common/entites/generic-error.entity';

import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';

import { AirlineEntity } from '../airlines/entities/airline.entity';
import { GetAirlineDTO } from './dto/get-airline.dto';
import { GetFlightsBoundsDTO } from './dto/get-flights-bounds.dto';
import { GetFlightsDTO } from './dto/get-flights.dto';
import { FlightsResponseEntity } from './entities/flight.entity';
import { FlightsService } from './flights.service';

@Controller('flights')
@ApiBearerAuth('JWT-auth')
@ApiTags('Flights')
export class FlightsController {
  constructor(private readonly flightsService: FlightsService) {}

  @Post('airline')
  @ApiOperation({
    summary: 'Get airline',
    description:
      "Get airline with search query. This doesn't check if the number is correct",
  })
  @ApiOkResponse({
    type: AirlineEntity,
  })
  @ApiNotFoundResponse({ type: GenericErrorEntity })
  getAirline(@Body() body: GetAirlineDTO) {
    return this.flightsService.getAirline(body);
  }

  @Get()
  @ApiOperation({
    summary: 'Get flights between two airports',
    description: 'Get all flights between two airports for a specific date',
  })
  @ApiOkResponse({ type: FlightsResponseEntity })
  @ApiUnauthorizedResponse({ type: GenericErrorEntity })
  getFlights(@Query() query: GetFlightsDTO) {
    return this.flightsService.getFlightsBetweenTwoAirports(query);
  }

  @Get('bounds')
  @ApiOperation({
    summary:
      'Get flights within geographic bounds(deprecated - will return nothing)',
    description:
      'Get all aircraft currently flying within a specified geographic bounding box using FlightAware data with comprehensive aircraft details',
    deprecated: true,
  })
  @ApiOkResponse({
    description:
      'List of flights within the specified bounds with detailed aircraft information',
    schema: {
      type: 'object',
      properties: {
        success: { type: 'boolean' },
        timestamp: { type: 'string', format: 'date-time' },
        bounds: {
          type: 'object',
          properties: {
            minLat: { type: 'number' },
            maxLat: { type: 'number' },
            minLng: { type: 'number' },
            maxLng: { type: 'number' },
          },
        },
        totalAircraft: { type: 'number' },
        airborneAircraft: { type: 'number' },
        flights: {
          type: 'array',
          items: {
            type: 'object',
            properties: {
              ident_icao: { type: 'string', nullable: true },
              ident_iata: { type: 'string', nullable: true },
              callsign: { type: 'string', nullable: true },

              // Position and movement data
              latitude: { type: 'number', nullable: true },
              longitude: { type: 'number', nullable: true },
              altitude: { type: 'number', nullable: true },
              velocity: { type: 'number', nullable: true },
              heading: { type: 'number', nullable: true },
              verticalRate: { type: 'number', nullable: true },
              lastContact: { type: 'string', format: 'date-time' },
              isOnGround: { type: 'boolean' },

              // Aircraft details
              aircraftType: { type: 'string', nullable: true },
              aircraftTypeFaa: { type: 'string', nullable: true },
              aircraftFamily: { type: 'string', nullable: true },
              manufacturer: { type: 'string', nullable: true },
              model: { type: 'string', nullable: true },
              engineType: { type: 'string', nullable: true },
              engineCount: { type: 'string', nullable: true },
              wakeTurbulenceCategory: { type: 'string', nullable: true },

              // Flight plan and registration
              aircraftId: { type: 'string', nullable: true },
              aircraftRegistration: { type: 'string', nullable: true },
              ownerIcao: { type: 'string', nullable: true },
              ownerIata: { type: 'string', nullable: true },
              ownerName: { type: 'string', nullable: true },

              // Operator information
              operator: { type: 'string', nullable: true },
              operatorIcao: { type: 'string', nullable: true },
              operatorIata: { type: 'string', nullable: true },
              operatorCountry: { type: 'string', nullable: true },

              // Route information
              origin: {
                type: 'object',
                nullable: true,
                properties: {
                  code: { type: 'string', nullable: true },
                  codeIcao: { type: 'string', nullable: true },
                  codeIata: { type: 'string', nullable: true },
                  name: { type: 'string', nullable: true },
                  city: { type: 'string', nullable: true },
                  timezone: { type: 'string', nullable: true },
                },
              },
              destination: {
                type: 'object',
                nullable: true,
                properties: {
                  code: { type: 'string', nullable: true },
                  codeIcao: { type: 'string', nullable: true },
                  codeIata: { type: 'string', nullable: true },
                  name: { type: 'string', nullable: true },
                  city: { type: 'string', nullable: true },
                  timezone: { type: 'string', nullable: true },
                },
              },

              // Flight status and timing
              status: { type: 'string', nullable: true },
              progressPercent: { type: 'number', nullable: true },
              routeDistance: { type: 'number', nullable: true },
              filedAirspeedKts: { type: 'number', nullable: true },
              filedAltitude: { type: 'number', nullable: true },

              // Schedule information
              scheduledOff: { type: 'string', nullable: true },
              scheduledOn: { type: 'string', nullable: true },
              estimatedOff: { type: 'string', nullable: true },
              estimatedOn: { type: 'string', nullable: true },
              actualOff: { type: 'string', nullable: true },
              actualOn: { type: 'string', nullable: true },

              // Delays
              departureDelay: { type: 'string', nullable: true },
              arrivalDelay: { type: 'string', nullable: true },

              // Airport details
              gateOrigin: { type: 'string', nullable: true },
              gateDestination: { type: 'string', nullable: true },
              terminalOrigin: { type: 'string', nullable: true },
              terminalDestination: { type: 'string', nullable: true },

              // Additional metadata
              route: { type: 'string', nullable: true },
              type: { type: 'string', nullable: true },
            },
          },
        },
      },
    },
  })
  @ApiUnauthorizedResponse({ type: GenericErrorEntity })
  getFlightsInBounds(@Query() query: GetFlightsBoundsDTO) {
    return this.flightsService.getFlightsInBounds(query);
  }
}
