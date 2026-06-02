import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';

import { GetAirportsBoundsDTO } from './dto/get-airports-bounds.dto';
import { AirportsService } from './airports.service';
import { AirportDetailsEntity } from './entities/airport-details.entity';
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

  @Get('bounds')
  @ApiOperation({
    summary: 'Get airports within geographic bounds',
    description:
      'Returns airports whose coordinates fall inside the given bounding box. ' +
      'Restricted to non-closed airports with an IATA code, prioritized by size ' +
      'and capped at 200 results. Intended for plotting airports on a map as the ' +
      'user pans at a sufficient zoom level.',
  })
  @ApiOkResponse({ type: [AirportEntity] })
  getAirportsInBounds(@Query() query: GetAirportsBoundsDTO) {
    return this.airportsService.getAirportsInBounds(query);
  }

  @Get(':ident/details')
  @ApiOperation({
    summary: 'Get detailed live information for an airport',
    description:
      'Aggregates current delays plus the latest METAR observation and TAF ' +
      'forecast (raw + decoded) for the given airport identifier (ICAO/IATA). ' +
      'Each source is best-effort; missing data is returned as null.',
  })
  @ApiParam({
    name: 'ident',
    example: 'VIDP',
    description: 'Airport identifier (ICAO preferred, IATA accepted)',
  })
  @ApiOkResponse({ type: AirportDetailsEntity })
  getAirportDetails(@Param('ident') ident: string) {
    return this.airportsService.getAirportDetails(ident);
  }
}
