import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AircraftEntity {
  @ApiPropertyOptional()
  modeS: string;

  @ApiProperty()
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

  @ApiProperty()
  terminal?: string;

  @ApiProperty()
  gate?: string;

  @ApiProperty()
  scheduledTime?: TimeEntity;

  @ApiPropertyOptional()
  revisedTime?: TimeEntity;

  @ApiPropertyOptional()
  predictedTime?: TimeEntity;
}
export class GreatCircleDistanceEntity {
  @ApiProperty()
  meter: number;

  @ApiProperty()
  km: number;

  @ApiProperty()
  mile: number;

  @ApiProperty()
  nm: number;

  @ApiProperty()
  feet: number;
}

export class FlightResponseEntity {
  @ApiProperty()
  id: string;

  @ApiProperty()
  flight_no: string;

  @ApiProperty()
  call_sign: string;

  @ApiProperty()
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
  greatCircleDistance: GreatCircleDistanceEntity;

  @ApiProperty()
  date: Date;

  @ApiPropertyOptional()
  image?: string;
}
