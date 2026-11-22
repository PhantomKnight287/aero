import { CONTINENT_BUCKETS, ContinentBucket, continentBucket } from '../regions';
import { StatsAirline, StatsAirport, StatsFlight } from '../stats-flight';

const byCountDesc = <T extends { flightCount: number }>(a: T, b: T, ka: string, kb: string) =>
  b.flightCount - a.flightCount || (ka < kb ? -1 : ka > kb ? 1 : 0);

export function topAirports(fs: StatsFlight[]) {
  const m = new Map<string, { airport: StatsAirport; departures: number; arrivals: number; flightCount: number; distanceKm: number }>();
  const row = (a: StatsAirport) => {
    let r = m.get(a.key);
    if (!r) m.set(a.key, (r = { airport: a, departures: 0, arrivals: 0, flightCount: 0, distanceKm: 0 }));
    return r;
  };
  for (const f of fs) {
    const d = row(f.dep), a = row(f.arr);
    d.departures++; a.arrivals++;
    for (const r of [d, a]) { r.flightCount++; r.distanceKm += f.distanceKm; }
  }
  return [...m.values()].sort((a, b) => byCountDesc(a, b, a.airport.key, b.airport.key));
}

export function topAirlines(fs: StatsFlight[]) {
  const m = new Map<string, { airline: StatsAirline; flightCount: number; distanceKm: number }>();
  for (const f of fs) {
    let r = m.get(f.airline.key);
    if (!r) m.set(f.airline.key, (r = { airline: f.airline, flightCount: 0, distanceKm: 0 }));
    r.flightCount++; r.distanceKm += f.distanceKm;
  }
  return [...m.values()].sort((a, b) => byCountDesc(a, b, a.airline.key, b.airline.key));
}

export function topRoutes(fs: StatsFlight[]) {
  const m = new Map<string, { from: StatsAirport; to: StatsAirport; flightCount: number; distanceKm: number }>();
  for (const f of fs) {
    const k = `${f.dep.key}>${f.arr.key}`;
    let r = m.get(k);
    if (!r) m.set(k, (r = { from: f.dep, to: f.arr, flightCount: 0, distanceKm: 0 }));
    r.flightCount++; r.distanceKm += f.distanceKm;
  }
  return [...m.entries()].sort(([ka, a], [kb, b]) => byCountDesc(a, b, ka, kb)).map(([, r]) => r);
}

const regionNames = new Intl.DisplayNames(['en'], { type: 'region' });

export function countries(fs: StatsFlight[]) {
  const m = new Map<string, number>();
  for (const f of fs)
    for (const c of new Set([f.dep.isoCountry, f.arr.isoCountry]))
      if (c) m.set(c, (m.get(c) ?? 0) + 1);
  return [...m.entries()]
    .map(([isoCountry, flightCount]) => ({ isoCountry, name: regionNames.of(isoCountry) ?? isoCountry, flightCount }))
    .sort((a, b) => byCountDesc(a, b, a.isoCountry, b.isoCountry));
}

export function continents(fs: StatsFlight[]) {
  const ctry = new Map<ContinentBucket, Set<string>>();
  const flights = new Map<ContinentBucket, number>();
  for (const f of fs) {
    const touched = new Set<ContinentBucket>();
    for (const a of [f.dep, f.arr]) {
      const b = continentBucket(a.isoCountry, a.continent);
      if (!b) continue;
      touched.add(b);
      if (a.isoCountry) ctry.set(b, (ctry.get(b) ?? new Set()).add(a.isoCountry));
    }
    for (const b of touched) flights.set(b, (flights.get(b) ?? 0) + 1);
  }
  return CONTINENT_BUCKETS.map((bucket) => ({
    bucket,
    countryCount: ctry.get(bucket)?.size ?? 0,
    flightShare: fs.length ? (flights.get(bucket) ?? 0) / fs.length : 0,
  }));
}

export function mapData(fs: StatsFlight[]) {
  const airports = new Map<string, { iata?: string; icao?: string; lat: number; lon: number }>();
  const routes = new Map<string, { fromLat: number; fromLon: number; toLat: number; toLon: number; count: number }>();
  for (const f of fs) {
    for (const a of [f.dep, f.arr])
      if (a.lat != null && a.lon != null && !airports.has(a.key))
        airports.set(a.key, { iata: a.iata, icao: a.icao, lat: a.lat, lon: a.lon });
    if (f.dep.lat == null || f.dep.lon == null || f.arr.lat == null || f.arr.lon == null) continue;
    const [x, y] = f.dep.key <= f.arr.key ? [f.dep, f.arr] : [f.arr, f.dep];
    const k = `${x.key}|${y.key}`;
    const r = routes.get(k);
    if (r) r.count++;
    else routes.set(k, { fromLat: x.lat!, fromLon: x.lon!, toLat: y.lat!, toLon: y.lon!, count: 1 });
  }
  return { airports: [...airports.values()], routes: [...routes.values()] };
}
