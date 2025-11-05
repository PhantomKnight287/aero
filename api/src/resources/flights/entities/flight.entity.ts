import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { FlightStatus, FlightType } from '@prisma/client';
import { FlightResponseEntity } from 'src/resources/flight/entities/flight.entity';

class AirlineInfo {
  @ApiProperty()
  name: string;

  @ApiProperty()
  iataCode: string;

  @ApiProperty({ required: false })
  icaoCode?: string;
}

class AirportInfo {
  @ApiPropertyOptional()
  actualRunway?: string;

  @ApiPropertyOptional()
  actualTime?: string;

  @ApiPropertyOptional()
  baggage?: string;

  @ApiPropertyOptional({ description: 'in mins' })
  delay?: string;

  @ApiPropertyOptional()
  estimatedRunway?: string;

  @ApiPropertyOptional()
  estimatedTime?: string;

  @ApiPropertyOptional()
  gate?: string;

  @ApiPropertyOptional()
  iataCode?: string;

  @ApiPropertyOptional()
  icaoCode?: string;

  @ApiPropertyOptional()
  scheduledTime?: string;

  @ApiPropertyOptional()
  terminal?: string;
}

class AircraftFlightEntity {
  @ApiProperty()
  iataNumber: string;

  @ApiProperty()
  icaoNumber: string;

  @ApiProperty()
  number: string;
}

export class FlightEntity {
  @ApiProperty()
  airline: AirlineInfo;

  @ApiProperty()
  flight: AircraftFlightEntity;

  @ApiProperty()
  departure: AirportInfo;

  @ApiProperty()
  arrival: AirportInfo;

  @ApiProperty({ enumName: 'FlightStatus', enum: FlightStatus })
  status: FlightStatus;

  @ApiProperty({ enumName: 'FlighType', enum: FlightType })
  type: FlightType;

  @ApiPropertyOptional()
  codeshared: {};
}

export class FlightsRouteEntity {
  @ApiProperty()
  from: string;

  @ApiProperty()
  to: string;
}

export class FlightsResponseEntity {
  @ApiProperty()
  success: boolean;

  @ApiProperty()
  date: string;

  @ApiProperty()
  route: FlightsRouteEntity;

  @ApiProperty()
  flightCount: number;

  @ApiProperty({ type: [FlightEntity] })
  flights: FlightEntity[];
}

export class TrackedFlightsResponseEntity {
  @ApiProperty()
  success: boolean;

  @ApiProperty()
  total: number;

  @ApiProperty({ type: [FlightResponseEntity] })
  flights: FlightResponseEntity[];
}
