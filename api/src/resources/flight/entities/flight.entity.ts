import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FlightAwareDataEntity {
  @ApiProperty()
  id: string;

  @ApiProperty({ description: 'Flight identifier' })
  ident: string;

  @ApiPropertyOptional()
  identIcao?: string;

  @ApiPropertyOptional()
  identIata?: string;

  @ApiPropertyOptional()
  actualRunwayOff?: string;

  @ApiPropertyOptional()
  actualRunwayOn?: string;

  @ApiPropertyOptional()
  operator?: string;

  @ApiPropertyOptional()
  operatorIcao?: string;

  @ApiPropertyOptional()
  operatorIata?: string;

  @ApiPropertyOptional()
  flightNumber?: string;

  @ApiPropertyOptional()
  registration?: string;

  @ApiPropertyOptional()
  atcIdent?: string;

  @ApiPropertyOptional()
  inboundFaFlightId?: string;

  @ApiPropertyOptional({ type: [String] })
  codesharesIata?: string[];

  @ApiPropertyOptional({
    description: 'Departure delay in seconds (negative = early)',
  })
  departureDelay?: number;

  @ApiPropertyOptional({
    description: 'Arrival delay in seconds (negative = early)',
  })
  arrivalDelay?: number;

  @ApiPropertyOptional({ description: 'Estimated time en route in seconds' })
  filedEte?: number;

  @ApiPropertyOptional({ description: 'Percent completion (0-100)' })
  progressPercent?: number;

  @ApiProperty({ description: 'Flight status description' })
  status: string;

  @ApiPropertyOptional()
  aircraftType?: string;

  @ApiPropertyOptional({
    description: 'Planned flight distance in statute miles',
  })
  routeDistance?: number;

  @ApiPropertyOptional({ description: 'Filed IFR airspeed in knots' })
  filedAirspeed?: number;

  @ApiPropertyOptional({ description: 'Filed IFR altitude in 100s of feet' })
  filedAltitude?: number;

  @ApiPropertyOptional()
  route?: string;

  @ApiPropertyOptional()
  baggageClaim?: string;

  @ApiPropertyOptional({ description: 'Business class seats' })
  seatsCabinBusiness?: number;

  @ApiPropertyOptional({ description: 'Coach class seats' })
  seatsCabinCoach?: number;

  @ApiPropertyOptional({ description: 'First class seats' })
  seatsCabinFirst?: number;

  @ApiPropertyOptional()
  gateOrigin?: string;

  @ApiPropertyOptional()
  gateDestination?: string;

  @ApiPropertyOptional()
  terminalOrigin?: string;

  @ApiPropertyOptional()
  terminalDestination?: string;

  @ApiPropertyOptional()
  scheduledOut?: Date;

  @ApiPropertyOptional()
  estimatedOut?: Date;

  @ApiPropertyOptional()
  actualOut?: Date;

  @ApiPropertyOptional()
  scheduledOff?: Date;

  @ApiPropertyOptional()
  estimatedOff?: Date;

  @ApiPropertyOptional()
  actualOff?: Date;

  @ApiPropertyOptional()
  scheduledOn?: Date;

  @ApiPropertyOptional()
  estimatedOn?: Date;

  @ApiPropertyOptional()
  actualOn?: Date;

  @ApiPropertyOptional()
  scheduledIn?: Date;

  @ApiPropertyOptional()
  estimatedIn?: Date;

  @ApiPropertyOptional()
  actualIn?: Date;

  @ApiProperty({ description: 'Foresight predictions available' })
  foresightPredictionsAvailable: boolean;

  @ApiProperty()
  blocked: boolean;

  @ApiProperty()
  diverted: boolean;

  @ApiProperty()
  cancelled: boolean;

  @ApiProperty()
  positionOnly: boolean;

  @ApiPropertyOptional()
  originCode?: string;

  @ApiPropertyOptional()
  originCodeIcao?: string;

  @ApiPropertyOptional()
  originCodeIata?: string;

  @ApiPropertyOptional()
  originCodeLid?: string;

  @ApiPropertyOptional()
  originTimezone?: string;

  @ApiPropertyOptional()
  originName?: string;

  @ApiPropertyOptional()
  originCity?: string;

  @ApiPropertyOptional()
  destinationCode?: string;

  @ApiPropertyOptional()
  destinationCodeIcao?: string;

  @ApiPropertyOptional()
  destinationCodeIata?: string;

  @ApiPropertyOptional()
  destinationCodeLid?: string;

  @ApiPropertyOptional()
  destinationTimezone?: string;

  @ApiPropertyOptional()
  destinationName?: string;

  @ApiPropertyOptional()
  destinationCity?: string;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
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

  @ApiPropertyOptional({ type: Object })
  payload?: object;
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

  @ApiPropertyOptional()
  baggageBelt?: string;
}
class StringifiedGreatCircleDistanceEntity {
  @ApiPropertyOptional()
  meter: string;

  @ApiPropertyOptional()
  km: string;

  @ApiPropertyOptional()
  mile: string;

  @ApiPropertyOptional()
  nm: string;

  @ApiPropertyOptional()
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

  @ApiPropertyOptional()
  flightAwareData?: FlightAwareDataEntity;
}
