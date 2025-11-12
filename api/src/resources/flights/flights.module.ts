import { Module } from '@nestjs/common';
import { FlightsService } from './flights.service';
import { FlightsController } from './flights.controller';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';
import { RedisService } from 'src/services/redis/redis.service';

@Module({
  controllers: [FlightsController],
  providers: [FlightsService, FlightAwareService, RedisService],
})
export class FlightsModule {}
