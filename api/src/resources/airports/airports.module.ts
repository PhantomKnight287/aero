import { Module } from '@nestjs/common';
import { AirportsService } from './airports.service';
import { AirportsController } from './airports.controller';

@Module({
  controllers: [AirportsController],
  providers: [AirportsService],
})
export class AirportsModule {}
