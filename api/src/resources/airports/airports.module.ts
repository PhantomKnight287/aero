import { Module } from '@nestjs/common';

import { FlightAwareService } from 'src/services/flightaware/flightaware.service';
import { RedisService } from 'src/services/redis/redis.service';

import { AirportsController } from './airports.controller';
import { AirportsService } from './airports.service';

@Module({
  controllers: [AirportsController],
  providers: [AirportsService, FlightAwareService, RedisService],
})
export class AirportsModule {}
