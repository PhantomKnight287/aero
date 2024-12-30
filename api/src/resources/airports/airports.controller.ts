import { Controller, Get, Query } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiOperation,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';

import { AirportsService } from './airports.service';
import { AirportEntity } from './entities/airport.entity';

@Controller('airports')
@ApiTags('Airports')
@ApiBearerAuth()
export class AirportsController {
  constructor(private readonly airportsService: AirportsService) {}

  @Get()
  @ApiOperation({
    description:
      'Get all airports. We do not recommend using this route without any search query. This route has over 20k records',
    summary: 'Get all airports',
  })
  @ApiOkResponse({
    type: [AirportEntity],
  })
  @ApiQuery({
    name: 'search',
    required: false,
    type: String,
    example: 'VIDP',
    description:
      'Search query for airport. Can be iata, ident(icao), name or a part of any these. Searching is case insensitive',
  })
  getAirports(@Query('search') search?: string) {
    return this.airportsService.getAirports({ search });
  }
}
