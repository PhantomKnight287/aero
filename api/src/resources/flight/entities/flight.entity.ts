import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AircraftEntity {
  @ApiPropertyOptional()
  modeS: string;

  @ApiPropertyOptional()
  registration: string;

  @ApiProperty()
  model: string;

  @ApiPropertyOptional()
  image?: string;

  @ApiPropertyOptional()
  aircraft_id?: string;

  @ApiPropertyOptional()
  age?: string;

  @ApiPropertyOptional()
  firstFlightDate?: string;

  @ApiPropertyOptional()
  deliveryDate?: string;

  @ApiPropertyOptional()
  isFreighter?: boolean;

  @ApiPropertyOptional()
  attribution?: string;
}

class PartialAirlineEntity {
  @ApiProperty()
  name: string;

  @ApiPropertyOptional()
  iata?: string;

  @ApiPropertyOptional()
  icao?: string;
}
class LocationEntity {
  @ApiProperty()
  lat: number;

  @ApiProperty()
  lon: number;
}

class RouteAirportEntity {
  @ApiProperty()
  iata: string;

  @ApiProperty()
  icao: string;

  @ApiProperty()
  name: string;

  @ApiProperty()
  timeZone: string;

  @ApiProperty()
  shortName: string;

  @ApiProperty()
  countryCode: string;

  @ApiProperty()
  municipalityName: string;

  @ApiProperty()
  location: LocationEntity;
}

class TimeEntity {
  @ApiProperty()
  utc: string;

  @ApiProperty()
  local: string;
}

class RouteInfoEntity {
  @ApiProperty()
  airport: RouteAirportEntity;

  @ApiPropertyOptional()
  terminal?: string;

  @ApiPropertyOptional()
  gate?: string;

  @ApiProperty()
  scheduledTime?: TimeEntity;

  @ApiPropertyOptional()
  revisedTime?: TimeEntity;

  @ApiPropertyOptional()
  predictedTime?: TimeEntity;
}
class StringifiedGreatCircleDistanceEntity {
  @ApiProperty()
  meter: string;

  @ApiProperty()
  km: string;

  @ApiProperty()
  mile: string;

  @ApiProperty()
  nm: string;

  @ApiProperty()
  feet: string;
}

export class FlightResponseEntity {
  @ApiProperty()
  id: string;

  @ApiProperty()
  flightNo: string;

  @ApiProperty()
  callSign: string;

  @ApiPropertyOptional()
  aircraft: AircraftEntity;

  @ApiProperty()
  airline: PartialAirlineEntity;

  @ApiProperty()
  arrival: RouteInfoEntity;

  @ApiProperty()
  departure: RouteInfoEntity;

  @ApiProperty()
  cargo: boolean;

  @ApiProperty()
  greatCircleDistance: StringifiedGreatCircleDistanceEntity;

  @ApiProperty()
  date: Date;

  @ApiPropertyOptional()
  image?: string;
}
