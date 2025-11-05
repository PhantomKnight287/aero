import { GenericErrorEntity } from 'src/common/entites/generic-error.entity';

import {
  BadRequestException,
  Controller,
  Get,
  InternalServerErrorException,
  Query,
  UnauthorizedException,
} from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiInternalServerErrorResponse,
  ApiOperation,
  ApiQuery,
  ApiResponse,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';

import { GetFlightTrackDTO } from './dto/get-flight-track.dto';
import { GetFlightDTO } from './dto/get-flight.dto';
import { FlightTrackResponseEntity } from './entities/flight-track.entity';
import { FlightResponseEntity } from './entities/flight.entity';
import { FlightService } from './flight.service';

@Controller('flight')
@ApiTags('Flight')
@ApiBearerAuth('JWT-auth')
export class FlightController {
  constructor(private readonly flightService: FlightService) {}

  @Get('track')
  @ApiOperation({
    summary: 'Get flight track/path',
    description:
      'Get the flight path with all position data points for a specific flight',
  })
  @ApiQuery({
    name: 'iata',
    required: true,
    type: String,
    description: 'IATA flight number',
    example: 'UA123',
  })
  @ApiQuery({
    name: 'icao',
    required: true,
    type: String,
    description: 'ICAO flight number',
    example: 'UAL123',
  })
  @ApiQuery({
    name: 'date',
    required: false,
    type: String,
    description:
      'Flight date (ISO format). Defaults to current date if not provided',
    example: '2024-03-20',
  })
  @ApiResponse({
    status: 200,
    description: 'Flight track data retrieved successfully',
    type: FlightTrackResponseEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiBadRequestResponse({
    description: 'Invalid request parameters or flight not found',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  @ApiQuery({
    type: String,
    name: 'timezone',
    description: 'The timezone from which the request is being made.',
    required: true,
  })
  async getFlightTrack(@Query() query: GetFlightTrackDTO) {
    return await this.flightService.getFlightTrack(query);
  }

  @Get()
  @ApiOperation({
    summary: 'Get flight details',
    description:
      'Get detailed information about a specific flight including real-time tracking data',
  })
  @ApiQuery({
    name: 'iata',
    required: true,
    type: String,
    description: 'IATA flight number',
    example: 'UA123',
  })
  @ApiQuery({
    name: 'icao',
    required: true,
    type: String,
    description: 'ICAO flight number',
    example: 'UAL123',
  })
  @ApiQuery({
    name: 'date',
    required: false,
    type: String,
    description:
      'Flight date (ISO format). Defaults to current date if not provided',
    example: '2024-03-20',
  })
  @ApiResponse({
    status: 200,
    description: 'Flight details retrieved successfully',
    type: FlightResponseEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiBadRequestResponse({
    description: 'Invalid request parameters',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  @ApiQuery({
    type: String,
    name: 'timezone',
    description: 'The timezone from which the request is being made.',
    required: true,
  })
  async getFlight(@Query() query: GetFlightDTO) {
    return await this.flightService.getFlight(query);
  }
}
