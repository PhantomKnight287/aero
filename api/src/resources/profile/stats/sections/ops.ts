import { StatsAirport, StatsFlight } from '../stats-flight';
import { StatsRecord } from './record';

export function runways(fs: StatsFlight[]) {
  const m = new Map<string, { airport: StatsAirport; runway: string; departures: number; arrivals: number }>();
  const bump = (airport: StatsAirport, runway: string, k: 'departures' | 'arrivals') => {
    const id = `${airport.key}|${runway}`;
    const e = m.get(id) ?? { airport, runway, departures: 0, arrivals: 0 };
    e[k]++;
    m.set(id, e);
  };
  let basedOn = 0;
  for (const f of fs) {
    if (!f.runwayOff && !f.runwayOn) continue;
    basedOn++;
    if (f.runwayOff && f.dep.key) bump(f.dep, f.runwayOff, 'departures');
    if (f.runwayOn && f.arr.key) bump(f.arr, f.runwayOn, 'arrivals');
  }
  const items = [...m.values()].sort(
    (a, b) => b.departures + b.arrivals - (a.departures + a.arrivals),
  );
  return { basedOn, items };
}

export function taxiByAirport(fs: StatsFlight[]) {
  type Acc = { airport: StatsAirport; out: number[]; in: number[] };
  const m = new Map<string, Acc>();
  const acc = (a: StatsAirport) => {
    const e = m.get(a.key) ?? { airport: a, out: [], in: [] };
    m.set(a.key, e);
    return e;
  };
  const avg = (v: number[]) => (v.length ? Math.round(v.reduce((s, x) => s + x, 0) / v.length) : null);
  let basedOn = 0;
  let longest: StatsRecord | null = null;
  for (const f of fs) {
    if (f.taxiOutMin == null && f.taxiInMin == null) continue;
    basedOn++;
    if (f.taxiOutMin != null && f.dep.key) acc(f.dep).out.push(f.taxiOutMin);
    if (f.taxiInMin != null && f.arr.key) acc(f.arr).in.push(f.taxiInMin);
    const value = Math.max(f.taxiOutMin ?? -Infinity, f.taxiInMin ?? -Infinity);
    if (!longest || value > longest.value) longest = { flight: f, value };
  }
  const items = [...m.values()]
    .map((e) => ({
      airport: e.airport,
      avgTaxiOutMin: avg(e.out), taxiOutCount: e.out.length,
      avgTaxiInMin: avg(e.in), taxiInCount: e.in.length,
    }))
    .sort((a, b) => b.taxiOutCount + b.taxiInCount - (a.taxiOutCount + a.taxiInCount));
  return { basedOn, items, longest };
}

export function extremes(fs: StatsFlight[]) {
  const m = new Map<string, StatsAirport>();
  for (const f of fs) for (const a of [f.dep, f.arr]) if (a.key && !m.has(a.key)) m.set(a.key, a);
  const all = [...m.values()];
  const geo = all.filter((a) => a.lat != null && a.lon != null);
  const pick = (list: StatsAirport[], v: (a: StatsAirport) => number) =>
    list.reduce<StatsAirport | null>((best, a) => (!best || v(a) > v(best) ? a : best), null);
  return {
    north: pick(geo, (a) => a.lat!),
    south: pick(geo, (a) => -a.lat!),
    east: pick(geo, (a) => a.lon!),
    west: pick(geo, (a) => -a.lon!),
    highest: pick(geo.filter((a) => a.elevationFt != null), (a) => a.elevationFt!),
  };
}
