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
}
