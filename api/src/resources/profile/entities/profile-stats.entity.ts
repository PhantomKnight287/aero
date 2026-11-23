import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  AircraftSectionEntity, ContinentEntity, CountryEntity, DelaySummaryEntity, ExtremesEntity, FlightsPerEntity,
  MapDataEntity, PassportEntity, RecordsEntity, RunwaysEntity, TaxiByAirportEntity,
  TopAirlineEntity, TopAirportEntity, TopRouteEntity,
} from './stats-sections.entity';

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

export class ProfileStatsResponseEntity {
  @ApiProperty({ type: [Number], description: 'Years with counted flights, descending' })
  availableYears: number[];

  @ApiPropertyOptional({ nullable: true, type: Number })
  year?: number | null;

  @ApiProperty({ type: PassportEntity }) passport: PassportEntity;
  @ApiProperty({ type: FlightsPerEntity }) flightsPer: FlightsPerEntity;
  @ApiProperty({ type: RecordsEntity }) records: RecordsEntity;
  @ApiProperty({ type: [TopAirportEntity] }) topAirports: TopAirportEntity[];
  @ApiProperty({ type: [TopAirlineEntity] }) topAirlines: TopAirlineEntity[];
  @ApiProperty({ type: [TopRouteEntity] }) topRoutes: TopRouteEntity[];
  @ApiProperty({ type: [CountryEntity] }) countries: CountryEntity[];
  @ApiProperty({ type: [ContinentEntity] }) continents: ContinentEntity[];
  @ApiProperty({ type: DelaySummaryEntity }) delays: DelaySummaryEntity;
  @ApiProperty({ type: RunwaysEntity }) runways: RunwaysEntity;
  @ApiProperty({ type: TaxiByAirportEntity }) taxiByAirport: TaxiByAirportEntity;
  @ApiProperty({ type: ExtremesEntity }) extremes: ExtremesEntity;
  @ApiProperty({ type: MapDataEntity }) map: MapDataEntity;
  @ApiProperty({ type: AircraftSectionEntity }) aircraft: AircraftSectionEntity;
}

export {
  StatsAirportEntity, StatsFlightSummaryEntity, StatsRecordEntity, YearCountEntity,
} from './stats-sections.entity';
