import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { FlightBookingEntity } from './flight-booking.entity';

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

  @ApiPropertyOptional({ type: [String] })
  codesharesIcao?: string[];

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
export class AircraftRegistrationEntity {
  @ApiProperty()
  id: string;

  @ApiProperty()
  reg: string;

  @ApiProperty()
  active: boolean;

  @ApiPropertyOptional()
  hexIcao?: string;

  @ApiPropertyOptional()
  airlineName?: string;

  @ApiPropertyOptional()
  registrationDate?: string;
}

export class AircraftEntity {
  @ApiPropertyOptional()
  modeS: string;

  @ApiPropertyOptional()
  registration: string;

  @ApiPropertyOptional()
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

  @ApiPropertyOptional({ type: [AircraftRegistrationEntity] })
  registrations?: AircraftRegistrationEntity[];
}

class PartialAirlineEntity {
  @ApiProperty()
  name: string;

  @ApiPropertyOptional()
  iata?: string;

  @ApiPropertyOptional()
  icao?: string;

  @ApiPropertyOptional()
  image?: string;
}
class LocationEntity {
  @ApiProperty()
  lat: number;

  @ApiProperty()
  lon: number;
}

class AirportDelayReasonEntity {
  @ApiProperty() category: string;
  @ApiProperty({ enum: ['red', 'yellow', 'green'] }) color: 'red' | 'yellow' | 'green';
  @ApiProperty() delay_secs: number;
  @ApiProperty() reason: string;
}

export class AirportDelaysEntity {
  @ApiProperty() airport: string;
  @ApiProperty() category: string;
  @ApiProperty({ enum: ['red', 'yellow', 'green'] }) color: 'red' | 'yellow' | 'green';
  @ApiProperty() delay_secs: number;
  @ApiProperty({ type: [AirportDelayReasonEntity] }) reasons: AirportDelayReasonEntity[];
}

class WeatherForecastWindsEntity {
  @ApiProperty() symbol: string;
  @ApiProperty() direction: string;
  @ApiProperty() speed: number;
  @ApiPropertyOptional({ nullable: true }) units?: string | null;
  @ApiPropertyOptional({ nullable: true }) peak_gusts?: number | null;
}

class WeatherForecastWindshearEntity {
  @ApiProperty() symbol: string;
  @ApiProperty() height: string;
  @ApiProperty() direction: string;
  @ApiProperty() speed: string;
  @ApiPropertyOptional({ nullable: true }) units?: string | null;
}

class WeatherForecastVisibilityEntity {
  @ApiProperty() symbol: string;
  @ApiProperty() visibility: string;
  @ApiPropertyOptional({ nullable: true }) units?: string | null;
}

class WeatherForecastCloudEntity {
  @ApiProperty() symbol: string;
  @ApiPropertyOptional({
    enum: ['', 'sky_clear', 'few', 'scattered', 'broken', 'overcast'],
    nullable: true,
  })
  coverage?: '' | 'sky_clear' | 'few' | 'scattered' | 'broken' | 'overcast' | null;
  @ApiPropertyOptional({ nullable: true }) altitude?: string | null;
  @ApiPropertyOptional({ nullable: true }) special?: string | null;
}

class WeatherForecastLineEntity {
  @ApiProperty() type: string;
  @ApiProperty() start: string;
  @ApiPropertyOptional({ nullable: true }) end?: string | null;
  @ApiPropertyOptional({ nullable: true }) turbulence_layers?: string | null;
  @ApiPropertyOptional({ nullable: true }) icing_layers?: string | null;
  @ApiPropertyOptional({ nullable: true }) barometric_pressure?: number | null;
  @ApiPropertyOptional({ nullable: true }) significant_weather?: string | null;
  @ApiPropertyOptional({ type: WeatherForecastWindsEntity }) winds: WeatherForecastWindsEntity;
  @ApiPropertyOptional({ type: WeatherForecastWindshearEntity }) windshear: WeatherForecastWindshearEntity;
  @ApiPropertyOptional({ type: WeatherForecastVisibilityEntity }) visibility: WeatherForecastVisibilityEntity;
  @ApiPropertyOptional({ type: [WeatherForecastCloudEntity] }) clouds: WeatherForecastCloudEntity[];
}

class WeatherForecastDecodedEntity {
  @ApiProperty() start: string;
  @ApiProperty() end: string;
  @ApiPropertyOptional({ type: [WeatherForecastLineEntity] }) lines: WeatherForecastLineEntity[];
}

export class AirportWeatherForecastEntity {
  @ApiProperty() airport_code: string;
  @ApiProperty({ type: [String] }) raw_forecast: string[];
  @ApiProperty() time: string;
  @ApiPropertyOptional({ type: WeatherForecastDecodedEntity }) decoded_forecast: WeatherForecastDecodedEntity;
}

class WeatherObservationCloudEntity {
  @ApiPropertyOptional({ nullable: true }) altitude?: number | null;
  @ApiProperty() symbol: string;
  @ApiProperty() type: string;
}

export class AirportWeatherObservationEntity {
  @ApiProperty() airport_code: string;
  @ApiPropertyOptional({ nullable: true }) cloud_friendly?: string | null;
  @ApiPropertyOptional({ type: [WeatherObservationCloudEntity] }) clouds: WeatherObservationCloudEntity[];
  @ApiPropertyOptional({ nullable: true }) conditions?: string | null;
  @ApiPropertyOptional({ nullable: true }) pressure?: number | null;
  @ApiPropertyOptional({ enum: ['', 'mb', 'in Hg'], nullable: true })
  pressure_units?: '' | 'mb' | 'in Hg' | null;
  @ApiProperty() raw_data: string;
  @ApiPropertyOptional({ nullable: true }) temp_air?: number | null;
  @ApiPropertyOptional({ nullable: true }) temp_dewpoint?: number | null;
  @ApiPropertyOptional({ nullable: true }) temp_perceived?: number | null;
  @ApiPropertyOptional({ nullable: true }) relative_humidity?: number | null;
  @ApiProperty() time: string;
  @ApiPropertyOptional({ nullable: true }) visibility?: number | null;
  @ApiPropertyOptional({ enum: ['', 'meters', 'SM'], nullable: true })
  visibility_units?: '' | 'meters' | 'SM' | null;
  @ApiProperty() wind_direction: number;
  @ApiProperty() wind_friendly: string;
  @ApiProperty() wind_speed: number;
  @ApiProperty() wind_speed_gust: number;
  @ApiProperty({ enum: ['MPS', 'KT'] }) wind_units: 'MPS' | 'KT';
}

export class AirportConditionsEntity {
  @ApiPropertyOptional({ type: AirportDelaysEntity, nullable: true })
  delays?: AirportDelaysEntity | null;

  @ApiPropertyOptional({ type: AirportWeatherForecastEntity, nullable: true })
  forecast?: AirportWeatherForecastEntity | null;

  @ApiPropertyOptional({ type: AirportWeatherObservationEntity, nullable: true })
  observation?: AirportWeatherObservationEntity | null;
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

  @ApiPropertyOptional()
  shortName: string;

  @ApiProperty()
  countryCode: string;

  @ApiProperty()
  municipalityName: string;

  @ApiProperty()
  location: LocationEntity;

  @ApiPropertyOptional({ type: AirportConditionsEntity })
  conditions?: AirportConditionsEntity;
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

  @ApiPropertyOptional({
    description: 'Bookings associated with this flight',
    type: [FlightBookingEntity],
  })
  bookings?: FlightBookingEntity[];
}

class FlightSummaryOriginEntity {
  @ApiProperty()
  code: string;

  @ApiPropertyOptional()
  codeIata?: string;

  @ApiPropertyOptional()
  codeIcao?: string;

  @ApiPropertyOptional()
  name?: string;

  @ApiPropertyOptional()
  city?: string;
}

class FlightSummaryDestinationEntity {
  @ApiProperty()
  code: string;

  @ApiPropertyOptional()
  codeIata?: string;

  @ApiPropertyOptional()
  codeIcao?: string;

  @ApiPropertyOptional()
  name?: string;

  @ApiPropertyOptional()
  city?: string;
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

export class FlightCandidateEntity {
  @ApiProperty({
    description: 'FlightAware flight ID for fetching full details',
  })
  faFlightId: string;

  @ApiProperty({ description: 'Flight identifier (e.g., "AC113")' })
  ident: string;

  @ApiProperty()
  origin: FlightSummaryOriginEntity;

  @ApiProperty()
  destination: FlightSummaryDestinationEntity;

  @ApiPropertyOptional()
  scheduledOut?: Date;

  @ApiPropertyOptional()
  scheduledOff?: Date;

  @ApiProperty({ description: 'Flight status description' })
  status: string;

  @ApiProperty()
  airline: FlightSummaryAirlineEntity;
}

export class FlightSearchResponseEntity {
  @ApiProperty({
    description: 'Array of flight candidates',
    type: [FlightCandidateEntity],
  })
  flights: FlightCandidateEntity[];

  @ApiProperty({ description: 'Number of flights found' })
  count: number;
}
