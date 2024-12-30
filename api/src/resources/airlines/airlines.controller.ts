import { Controller, Get, Query } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiOperation,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';

import { AirlinesService } from './airlines.service';
import { AirlineEntity } from './entities/airline.entity';

@Controller('airlines')
@ApiTags('Airlines')
@ApiBearerAuth()
export class AirlinesController {
  constructor(private readonly airlinesService: AirlinesService) {}

  @Get()
  @ApiOperation({
    description:
      'Get airlines.  Has over 800 records, only has commerical airlines.',
    summary: 'Get airlines',
  })
  @ApiOkResponse({
    type: [AirlineEntity],
  })
  @ApiQuery({
    name: 'search',
    description:
      'The full(or a part of) name, ident or icao. Case Insensitive.',
    required: false,
  })
  getAirlines(@Query('search') search?: string) {
    return this.airlinesService.getAirlines({ search });
  }
}
