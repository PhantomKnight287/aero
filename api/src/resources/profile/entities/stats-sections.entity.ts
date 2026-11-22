import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { CONTINENT_BUCKETS, ContinentBucket } from '../stats/regions';

const opt = { nullable: true } as const;

export class StatsAirportEntity {
  @ApiPropertyOptional(opt) iata?: string;
  @ApiPropertyOptional(opt) icao?: string;
  @ApiProperty() name: string;
  @ApiProperty() city: string;
  @ApiPropertyOptional(opt) isoCountry?: string;
  @ApiPropertyOptional(opt) lat?: number;
  @ApiPropertyOptional(opt) lon?: number;
  @ApiPropertyOptional(opt) elevationFt?: number;
}

export class StatsAirlineEntity {
  @ApiProperty() name: string;
  @ApiPropertyOptional(opt) iata?: string;
  @ApiPropertyOptional(opt) icao?: string;
  @ApiPropertyOptional(opt) image?: string;
}

export class StatsFlightSummaryEntity {
  @ApiProperty() id: string;
  @ApiProperty() flightNo: string;
  @ApiPropertyOptional(opt) identIata?: string;
  @ApiPropertyOptional(opt) identIcao?: string;
  @ApiPropertyOptional(opt) faFlightId?: string;
  @ApiProperty({ type: StatsAirlineEntity }) airline: StatsAirlineEntity;
  @ApiProperty({ type: StatsAirportEntity }) departure: StatsAirportEntity;
  @ApiProperty({ type: StatsAirportEntity }) arrival: StatsAirportEntity;
  @ApiProperty({ description: 'Flight date (ISO string)' }) date: string;
}

export class StatsRecordEntity {
  @ApiProperty({ type: StatsFlightSummaryEntity }) flight: StatsFlightSummaryEntity;
  @ApiProperty() value: number;
}

export class YearCountEntity {
  @ApiProperty() year: number;
  @ApiProperty() count: number;
}

export class PassportEntity {
  @ApiProperty() totalFlights: number;
  @ApiProperty() totalDistanceKm: number;
  @ApiProperty() blockMinutes: number;
  @ApiProperty() airMinutes: number;
  @ApiProperty() airBasedOn: number;
  @ApiProperty() taxiMinutes: number;
  @ApiProperty() taxiBasedOn: number;
  @ApiProperty() totalAirports: number;
  @ApiProperty() totalAirlines: number;
  @ApiProperty() totalCountries: number;
  @ApiProperty() domestic: number;
  @ApiProperty() international: number;
  @ApiProperty() longHaul: number;
}

export class FlightsPerEntity {
  @ApiProperty({ type: [YearCountEntity] }) year: YearCountEntity[];
  @ApiProperty({ type: [Number], description: 'Jan..Dec' }) month: number[];
  @ApiProperty({ type: [Number], description: 'Sun..Sat' }) weekday: number[];
}

export class RecordsEntity {
  @ApiPropertyOptional({ ...opt, type: StatsRecordEntity }) shortestDistance?: StatsRecordEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsRecordEntity }) longestDistance?: StatsRecordEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsRecordEntity }) shortestDuration?: StatsRecordEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsRecordEntity }) longestDuration?: StatsRecordEntity | null;
}

export class TopAirportEntity {
  @ApiProperty({ type: StatsAirportEntity }) airport: StatsAirportEntity;
  @ApiProperty() departures: number;
  @ApiProperty() arrivals: number;
  @ApiProperty() flightCount: number;
  @ApiProperty() distanceKm: number;
}

export class TopAirlineEntity {
  @ApiProperty({ type: StatsAirlineEntity }) airline: StatsAirlineEntity;
  @ApiProperty() flightCount: number;
  @ApiProperty() distanceKm: number;
}

export class TopRouteEntity {
  @ApiProperty({ type: StatsAirportEntity }) from: StatsAirportEntity;
  @ApiProperty({ type: StatsAirportEntity }) to: StatsAirportEntity;
  @ApiProperty() flightCount: number;
  @ApiProperty() distanceKm: number;
}

export class CountryEntity {
  @ApiProperty() isoCountry: string;
  @ApiProperty() name: string;
  @ApiProperty() flightCount: number;
}

export class ContinentEntity {
  @ApiProperty({ enum: CONTINENT_BUCKETS, enumName: 'ContinentBucket' }) bucket: ContinentBucket;
  @ApiProperty() countryCount: number;
  @ApiProperty({ description: 'Share of flights touching this continent, 0..1' }) flightShare: number;
}

export class DelaySummaryEntity {
  @ApiProperty() basedOn: number;
  @ApiProperty() arrivedCount: number;
  @ApiProperty() delayedCount: number;
  @ApiProperty() minutesLost: number;
  @ApiProperty() avgDelayMinutes: number;
}

export class RunwayUseEntity {
  @ApiProperty({ type: StatsAirportEntity }) airport: StatsAirportEntity;
  @ApiProperty() runway: string;
  @ApiProperty() departures: number;
  @ApiProperty() arrivals: number;
}

export class RunwaysEntity {
  @ApiProperty() basedOn: number;
  @ApiProperty({ type: [RunwayUseEntity] }) items: RunwayUseEntity[];
}

export class TaxiAirportEntity {
  @ApiProperty({ type: StatsAirportEntity }) airport: StatsAirportEntity;
  @ApiPropertyOptional(opt) avgTaxiOutMin?: number | null;
  @ApiProperty() taxiOutCount: number;
  @ApiPropertyOptional(opt) avgTaxiInMin?: number | null;
  @ApiProperty() taxiInCount: number;
}

export class TaxiByAirportEntity {
  @ApiProperty() basedOn: number;
  @ApiProperty({ type: [TaxiAirportEntity] }) items: TaxiAirportEntity[];
  @ApiPropertyOptional({ ...opt, type: StatsRecordEntity }) longest?: StatsRecordEntity | null;
}

export class ExtremesEntity {
  @ApiPropertyOptional({ ...opt, type: StatsAirportEntity }) north?: StatsAirportEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsAirportEntity }) south?: StatsAirportEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsAirportEntity }) east?: StatsAirportEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsAirportEntity }) west?: StatsAirportEntity | null;
  @ApiPropertyOptional({ ...opt, type: StatsAirportEntity }) highest?: StatsAirportEntity | null;
}

export class MapAirportEntity {
  @ApiPropertyOptional(opt) iata?: string;
  @ApiPropertyOptional(opt) icao?: string;
  @ApiProperty() lat: number;
  @ApiProperty() lon: number;
}

export class MapRouteEntity {
  @ApiProperty() fromLat: number;
  @ApiProperty() fromLon: number;
  @ApiProperty() toLat: number;
  @ApiProperty() toLon: number;
  @ApiProperty() count: number;
}

export class MapDataEntity {
  @ApiProperty({ type: [MapAirportEntity] }) airports: MapAirportEntity[];
  @ApiProperty({ type: [MapRouteEntity] }) routes: MapRouteEntity[];
}
