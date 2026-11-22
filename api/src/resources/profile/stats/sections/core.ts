import { StatsFlight } from '../stats-flight';
import { StatsRecord } from './record';

export type { StatsRecord } from './record';

const sum = (xs: number[]) => xs.reduce((a, b) => a + b, 0);
const defined = <T>(x: T | undefined): x is T => x !== undefined;

export function passport(fs: StatsFlight[]) {
  const air = fs.map((f) => f.airMinutes).filter(defined);
  const taxi = fs
    .filter((f) => f.taxiOutMin !== undefined || f.taxiInMin !== undefined)
    .map((f) => (f.taxiOutMin ?? 0) + (f.taxiInMin ?? 0));
  const countries = new Set<string>();
  let domestic = 0, international = 0;
  for (const f of fs) {
    const d = f.dep.isoCountry, a = f.arr.isoCountry;
    if (d) countries.add(d);
    if (a) countries.add(a);
    if (d && a) d === a ? domestic++ : international++;
  }
  return {
    totalFlights: fs.length,
    totalDistanceKm: sum(fs.map((f) => f.distanceKm)),
    blockMinutes: sum(fs.map((f) => f.blockMinutes)),
    airMinutes: sum(air),
    airBasedOn: air.length,
    taxiMinutes: sum(taxi),
    taxiBasedOn: taxi.length,
    totalAirports: new Set(fs.flatMap((f) => [f.dep.key, f.arr.key]).filter(Boolean)).size,
    totalAirlines: new Set(fs.map((f) => f.airline.key).filter(Boolean)).size,
    totalCountries: countries.size,
    domestic,
    international,
    longHaul: fs.filter((f) => f.blockMinutes > 360).length,
  };
}

export function flightsPer(fs: StatsFlight[]) {
  const month = new Array<number>(12).fill(0);
  const weekday = new Array<number>(7).fill(0);
  const years = new Map<number, number>();
  for (const f of fs) {
    month[f.local.month - 1]++;
    weekday[f.local.weekday]++;
    years.set(f.local.year, (years.get(f.local.year) ?? 0) + 1);
  }
  const year = [...years].map(([y, count]) => ({ year: y, count })).sort((a, b) => a.year - b.year);
  return { year, month, weekday };
}

export function records(fs: StatsFlight[]) {
  const pick = (get: (f: StatsFlight) => number, max: boolean): StatsRecord | null => {
    let best: StatsRecord | null = null;
    for (const f of fs) {
      const value = get(f);
      if (value <= 0) continue; // unknown distance/duration is not a record
      if (!best || (max ? value > best.value : value < best.value)) best = { flight: f, value };
    }
    return best;
  };
  return {
    shortestDistance: pick((f) => f.distanceKm, false),
    longestDistance: pick((f) => f.distanceKm, true),
    shortestDuration: pick((f) => f.blockMinutes, false),
    longestDuration: pick((f) => f.blockMinutes, true),
  };
}

export function delaySummary(fs: StatsFlight[]) {
  const delays = fs.map((f) => f.arrivalDelayMin).filter(defined);
  const late = delays.filter((d) => d > 15);
  const minutesLost = sum(late);
  return {
    basedOn: delays.length,
    arrivedCount: delays.length,
    delayedCount: late.length,
    minutesLost,
    avgDelayMinutes: late.length ? minutesLost / late.length : 0,
  };
}
