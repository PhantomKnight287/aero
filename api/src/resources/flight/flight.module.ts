import { Module } from '@nestjs/common';
import { FlightService } from './flight.service';
import { FlightController } from './flight.controller';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';
import { RedisService } from 'src/services/redis/redis.service';

@Module({
  controllers: [FlightController],
  providers: [FlightService, FlightAwareService, RedisService],
})
export class FlightModule {}
