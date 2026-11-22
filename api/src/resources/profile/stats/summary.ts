import {
  StatsAirlineEntity, StatsAirportEntity, StatsFlightSummaryEntity, StatsRecordEntity,
} from '../entities/stats-sections.entity';
import { StatsAirline, StatsAirport, StatsFlight } from './stats-flight';

export const toAirport = (a: StatsAirport): StatsAirportEntity => ({
  iata: a.iata, icao: a.icao, name: a.name, city: a.city,
  isoCountry: a.isoCountry, lat: a.lat, lon: a.lon, elevationFt: a.elevationFt,
});

export const toAirline = (a: StatsAirline): StatsAirlineEntity => ({
  name: a.name, iata: a.iata, icao: a.icao, image: a.image,
});

export const toFlightSummary = (f: StatsFlight): StatsFlightSummaryEntity => ({
  id: f.id, flightNo: f.flightNo,
  identIata: f.identIata, identIcao: f.identIcao, faFlightId: f.faFlightId,
  airline: toAirline(f.airline),
  departure: toAirport(f.dep),
  arrival: toAirport(f.arr),
  date: f.date.toISOString(),
});

export const toRecord = (r: { flight: StatsFlight; value: number } | null): StatsRecordEntity | null =>
  r && { flight: toFlightSummary(r.flight), value: r.value };
