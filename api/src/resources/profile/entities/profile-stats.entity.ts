import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

class MostFlownAircraftEntity {
  @ApiProperty()
  aircraftName: string;

  @ApiProperty()
  flightCount: number;
}

class PassportEntity {
  @ApiProperty({ description: 'Total number of flights taken' })
  totalFlights: number;

  @ApiProperty({ description: 'Total distance in kilometers' })
  totalDistanceKm: number;

  @ApiProperty({ description: 'Total flight duration in minutes (including delays)' })
  totalDurationMinutes: number;

  @ApiProperty({ description: 'Number of unique airports' })
  totalAirports: number;

  @ApiProperty({ description: 'Number of unique airlines' })
  totalAirlines: number;
}

class FlightSummaryAirlineEntity {
  @ApiProperty()
  name: string;

  @ApiPropertyOptional()
  iata?: string;

  @ApiPropertyOptional()
  icao?: string;

  @ApiPropertyOptional()
  image?: string;
}

export class FlightSummaryEntity {
  @ApiProperty()
  id: string;

  @ApiProperty()
  flightNo: string;

  @ApiProperty()
  callSign: string;

  @ApiProperty({ type: FlightSummaryAirlineEntity })
  airline: FlightSummaryAirlineEntity;

  @ApiProperty({ description: 'Departure airport code (IATA or ICAO)' })
  departureAirportCode: string;

  @ApiProperty({ description: 'Departure airport name' })
  departureAirportName: string;

  @ApiProperty({ description: 'Arrival airport code (IATA or ICAO)' })
  arrivalAirportCode: string;

  @ApiProperty({ description: 'Arrival airport name' })
  arrivalAirportName: string;

  @ApiProperty({ description: 'Flight date (ISO string)' })
  date: string;
}

class FlightDistanceEntity {
  @ApiProperty({ type: FlightSummaryEntity })
  flight: FlightSummaryEntity;

  @ApiProperty({ description: 'Distance in kilometers' })
  distanceKm: number;
}

class FlightDurationEntity {
  @ApiProperty({ type: FlightSummaryEntity })
  flight: FlightSummaryEntity;

  @ApiProperty({ description: 'Duration in minutes' })
  durationMinutes: number;
}

class AirlineStatsEntity {
  @ApiProperty()
  airlineName: string;

  @ApiProperty()
  airlineIata: string;

  @ApiPropertyOptional()
  airlineIcao?: string;

  @ApiPropertyOptional({ description: 'Airline image URL from DB, when available' })
  image?: string;

  @ApiProperty()
  flightCount: number;
}

class AirportStatsEntity {
  @ApiProperty()
  airportCode: string;

  @ApiProperty()
  airportName: string;

  @ApiProperty({ description: 'Number of flights departing from this airport' })
  departureCount: number;
}

class TopRouteEntity {
  @ApiProperty()
  origin: string;

  @ApiProperty()
  destination: string;

  @ApiProperty()
  flightCount: number;
}

export class ProfileStatsResponseEntity {
  @ApiProperty({ type: MostFlownAircraftEntity })
  mostFlownAircraft: MostFlownAircraftEntity;

  @ApiProperty({ type: PassportEntity })
  passport: PassportEntity;

  @ApiProperty({ type: FlightDistanceEntity })
  shortestDistanceFlight: FlightDistanceEntity;

  @ApiProperty({ type: FlightDistanceEntity })
  longestDistanceFlight: FlightDistanceEntity;

  @ApiProperty({ type: FlightDurationEntity })
  shortestDurationFlight: FlightDurationEntity;

  @ApiProperty({ type: FlightDurationEntity })
  longestDurationFlight: FlightDurationEntity;

  @ApiProperty({ type: [AirlineStatsEntity] })
  airlines: AirlineStatsEntity[];

  @ApiProperty({ type: [AirportStatsEntity] })
  airports: AirportStatsEntity[];

  @ApiProperty({ type: [TopRouteEntity] })
  topRoutes: TopRouteEntity[];
}

