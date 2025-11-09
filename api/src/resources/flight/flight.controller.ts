import { GenericErrorEntity } from 'src/common/entites/generic-error.entity';
import { Auth } from 'src/decorators/auth/auth.decorator';

import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  InternalServerErrorException,
  Param,
  Post,
  Put,
  Query,
  UnauthorizedException,
} from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiInternalServerErrorResponse,
  ApiNotFoundResponse,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiResponse,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { User } from '@prisma/client';

import { GetFlightTrackDTO } from './dto/get-flight-track.dto';
import { GetFlightDTO } from './dto/get-flight.dto';
import { CreateFlightBookingDTO } from './dto/create-flight-booking.dto';
import { UpdateFlightBookingDTO } from './dto/update-flight-booking.dto';
import { FlightTrackResponseEntity } from './entities/flight-track.entity';
import { FlightResponseEntity } from './entities/flight.entity';
import { FlightBookingEntity } from './entities/flight-booking.entity';
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
  async getFlightTrack(@Query() query: GetFlightTrackDTO, @Auth() auth: User) {
    return await this.flightService.getFlightTrack(query, auth.id);
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
  @ApiQuery({
    type: Boolean,
    default: false,
    required: false,
    name: 'forceUpdate',
    description:
      'Force update the flight data(used to refresh the flight data)',
  })
  async getFlight(@Query() query: GetFlightDTO, @Auth() auth: User) {
    return await this.flightService.getFlight(query, auth.id);
  }

  @Post('booking')
  @ApiOperation({
    summary: 'Create a flight booking',
    description: 'Create a new booking for a flight with booking details',
  })
  @ApiResponse({
    status: 201,
    description: 'Flight booking created successfully',
    type: FlightBookingEntity,
  })
  @ApiBadRequestResponse({
    description: 'Invalid request parameters or flight not found',
    type: GenericErrorEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  async createFlightBooking(
    @Body() createBookingDto: CreateFlightBookingDTO,
    @Auth() auth: User,
  ) {
    return await this.flightService.createFlightBooking(
      createBookingDto,
      auth.id,
    );
  }

  @Put('booking/:bookingId')
  @ApiOperation({
    summary: 'Update a flight booking',
    description: 'Update an existing flight booking',
  })
  @ApiParam({
    name: 'bookingId',
    description: 'ID of the booking to update',
    example: 'booking_abc123',
  })
  @ApiResponse({
    status: 200,
    description: 'Flight booking updated successfully',
    type: FlightBookingEntity,
  })
  @ApiBadRequestResponse({
    description: 'Invalid request parameters',
    type: GenericErrorEntity,
  })
  @ApiNotFoundResponse({
    description: 'Booking not found',
    type: GenericErrorEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  async updateFlightBooking(
    @Param('bookingId') bookingId: string,
    @Body() updateBookingDto: UpdateFlightBookingDTO,
    @Auth() auth: User,
  ) {
    return await this.flightService.updateFlightBooking(
      bookingId,
      updateBookingDto,
      auth.id,
    );
  }

  @Get('booking/:bookingId')
  @ApiOperation({
    summary: 'Get a flight booking',
    description: 'Get details of a specific flight booking',
  })
  @ApiParam({
    name: 'bookingId',
    description: 'ID of the booking to retrieve',
    example: 'booking_abc123',
  })
  @ApiResponse({
    status: 200,
    description: 'Flight booking retrieved successfully',
    type: FlightBookingEntity,
  })
  @ApiNotFoundResponse({
    description: 'Booking not found',
    type: GenericErrorEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  async getFlightBooking(
    @Param('bookingId') bookingId: string,
    @Auth() auth: User,
  ) {
    return await this.flightService.getFlightBooking(bookingId, auth.id);
  }

  @Get('booking/flight/:flightId')
  @ApiOperation({
    summary: 'Get all bookings for a flight',
    description: 'Get all bookings associated with a specific flight',
  })
  @ApiParam({
    name: 'flightId',
    description: 'ID of the flight',
    example: 'flight_abc123',
  })
  @ApiResponse({
    status: 200,
    description: 'Flight bookings retrieved successfully',
    type: [FlightBookingEntity],
  })
  @ApiBadRequestResponse({
    description: 'Flight not found',
    type: GenericErrorEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  async getFlightBookingsByFlightId(
    @Param('flightId') flightId: string,
    @Auth() auth: User,
  ) {
    return await this.flightService.getFlightBookingsByFlightId(
      flightId,
      auth.id,
    );
  }

  @Delete('booking/:bookingId')
  @ApiOperation({
    summary: 'Delete a flight booking',
    description: 'Delete a flight booking',
  })
  @ApiParam({
    name: 'bookingId',
    description: 'ID of the booking to delete',
    example: 'booking_abc123',
  })
  @ApiResponse({
    status: 200,
    description: 'Flight booking deleted successfully',
    schema: {
      type: 'object',
      properties: {
        message: {
          type: 'string',
          example: 'Booking deleted successfully',
        },
      },
    },
  })
  @ApiNotFoundResponse({
    description: 'Booking not found',
    type: GenericErrorEntity,
  })
  @ApiUnauthorizedResponse({
    description: 'User is not authenticated',
    type: GenericErrorEntity,
  })
  @ApiInternalServerErrorResponse({
    description: 'Internal server error',
    type: GenericErrorEntity,
  })
  async deleteFlightBooking(
    @Param('bookingId') bookingId: string,
    @Auth() auth: User,
  ) {
    return await this.flightService.deleteFlightBooking(bookingId, auth.id);
  }
}
