import { Module } from '@nestjs/common';
import { FlightService } from './flight.service';
import { FlightController } from './flight.controller';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';

@Module({
  controllers: [FlightController],
  providers: [FlightService, FlightAwareService],
})
export class FlightModule {}
