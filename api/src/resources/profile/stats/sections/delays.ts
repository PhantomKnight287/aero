import { StatsAirline, StatsAirport, StatsFlight } from '../stats-flight';
import { StatsRecord } from './record';

const LATE = 15;
const sum = (xs: number[]) => xs.reduce((a, b) => a + b, 0);
const byRate = <T extends { total: number }>(late: (x: T) => number, ...more: ((x: T) => number)[]) =>
  (a: T, b: T) => {
    const keys = [(x: T) => late(x) / x.total, (x: T) => x.total, ...more];
    for (const k of keys) if (k(b) !== k(a)) return k(b) - k(a);
    return 0;
  };

/** Arrival/departure delay stats. `cancelled` comes from outside: counted flights exclude them. */
export function delayReport(fs: StatsFlight[], cancelled: number) {
  const buckets = { early: 0, onTime: 0, late15: 0, late30: 0, late45: 0, cancelled, diverted: 0, total: 0 };
  const arrived: { flight: StatsFlight; value: number }[] = [];
  for (const f of fs) {
    if (f.diverted) {
      if (f.hasFa) buckets.diverted++;
      continue;
    }
    const d = f.arrivalDelayMin;
    if (d == null) continue;
    arrived.push({ flight: f, value: d });
    if (d < -5) buckets.early++;
    else if (d <= LATE) buckets.onTime++;
    else if (d <= 30) buckets.late15++;
    else if (d <= 45) buckets.late30++;
    else buckets.late45++;
  }
  buckets.total = buckets.early + buckets.onTime + buckets.late15 + buckets.late30 +
    buckets.late45 + buckets.cancelled + buckets.diverted;

  const flights: StatsRecord[] = arrived.filter((r) => r.value > LATE).sort((a, b) => b.value - a.value);
  const minutesLost = sum(flights.map((r) => r.value));

  const airlineMap = new Map<string, { airline: StatsAirline; late: number; total: number; minutesLate: number }>();
  for (const { flight: f, value } of arrived) {
    if (!f.airline.key) continue;
    const e = airlineMap.get(f.airline.key) ?? { airline: f.airline, late: 0, total: 0, minutesLate: 0 };
    e.total++;
    if (value > LATE) { e.late++; e.minutesLate += value; }
    airlineMap.set(f.airline.key, e);
  }

  const airportMap = new Map<string, { airport: StatsAirport; lateDepartures: number; total: number }>();
  for (const f of fs) {
    const d = f.departureDelayMin;
    if (d == null || !f.dep.key) continue;
    const e = airportMap.get(f.dep.key) ?? { airport: f.dep, lateDepartures: 0, total: 0 };
    e.total++;
    if (d > LATE) e.lateDepartures++;
    airportMap.set(f.dep.key, e);
  }

  return {
    basedOn: arrived.length,
    arrivedCount: arrived.length,
    delayedCount: flights.length,
    minutesLost,
    avgDelayMinutes: flights.length ? minutesLost / flights.length : 0,
    netMinutes: sum(arrived.map((r) => r.value)),
    buckets,
    worst: flights[0] ?? null,
    airlines: [...airlineMap.values()].sort(byRate((x) => x.late, (x) => x.minutesLate)),
    airports: [...airportMap.values()].sort(byRate((x) => x.lateDepartures)),
    flights,
  };
}
