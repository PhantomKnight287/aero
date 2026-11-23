import { Airport, Flight, FlightAwareData, GreatCircleDistance } from '@prisma/client';
import type { AirportIndex } from './airport-index';

export type { AirportIndex };

export type FlightRow = Flight & {
  greatCircleDistance: GreatCircleDistance | null;
  flightAwareData: FlightAwareData | null;
};

export interface StatsAirport {
  key: string; iata?: string; icao?: string; name: string; city: string;
  isoCountry?: string; continent?: string; lat?: number; lon?: number; elevationFt?: number;
}
export interface StatsAirline { key: string; name: string; iata?: string; icao?: string; image?: string }
export interface StatsFlight {
  id: string; flightNo: string; identIata?: string; identIcao?: string; faFlightId?: string;
  airline: StatsAirline; dep: StatsAirport; arr: StatsAirport; date: Date;
  local: { year: number; month: number; day: number; weekday: number };
  distanceKm: number; blockMinutes: number; airMinutes?: number;
  taxiOutMin?: number; taxiInMin?: number; arrivalDelayMin?: number; departureDelayMin?: number;
  hasFa: boolean; cancelled: boolean; diverted: boolean; runwayOff?: string; runwayOn?: string;
  reg?: string; typeCode?: string; typeName?: string;
}

const num = (v: unknown) => (v == null ? undefined : Number(v));
const str = (v: unknown) => (typeof v === 'string' && v ? v : undefined);
const mins = (a?: Date | null, b?: Date | null) =>
  a && b ? Math.round((b.getTime() - a.getTime()) / 60000) : undefined;
const nonNeg = (n?: number) => (n != null && n >= 0 ? n : undefined);
const utc = (t: any) => (t?.utc ? new Date(String(t.utc).replace(' ', 'T')) : undefined);
const jsonTime = (side: any) => {
  for (const k of ['actualTime', 'revisedTime', 'scheduledTime']) {
    const d = utc(side?.[k]);
    if (d && !isNaN(d.getTime())) return d;
  }
};

// stored JSON uses 0,0 when its DB lookup failed, so treat that as unknown
function coords(row: Airport | undefined, loc: any) {
  if (row) return { lat: num(row.lat), lon: num(row.long) };
  const lat = num(loc?.lat), lon = num(loc?.lon);
  if (lat == null || lon == null || (lat === 0 && lon === 0)) return {};
  return { lat, lon };
}

function airportOf(side: any, idx: AirportIndex): StatsAirport {
  const ap = side?.airport ?? {};
  const icao = str(ap.icao), iata = str(ap.iata);
  const row: Airport | undefined =
    (icao && idx.get(`C:${icao}`)) || (iata && idx.get(`I:${iata}`)) || undefined;
  const raw = (icao ?? iata ?? '').trim();
  const junk = /[\s.]/.test(raw) || raw.length > 4; // e.g. 'L 23.89 43.44' stored for unknown strips
  return {
    key: junk ? '' : raw,
    iata, icao,
    name: ap.name || row?.name || '',
    city: ap.municipalityName || row?.municipality || '',
    isoCountry: row?.isoCountry,
    continent: row?.continent,
    ...(junk ? {} : coords(row, ap.location)),
    elevationFt: num(row?.elevation),
  };
}

function haversineKm(a: StatsAirport, b: StatsAirport) {
  if (a.lat == null || a.lon == null || b.lat == null || b.lon == null) return 0;
  const r = (d: number) => (d * Math.PI) / 180;
  const h =
    Math.sin(r(b.lat - a.lat) / 2) ** 2 +
    Math.cos(r(a.lat)) * Math.cos(r(b.lat)) * Math.sin(r(b.lon - a.lon) / 2) ** 2;
  return 2 * 6371 * Math.asin(Math.sqrt(h));
}

const WEEKDAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
function localParts(date: Date, timeZone: string) {
  const fmt = (tz: string) =>
    new Intl.DateTimeFormat('en-US', { timeZone: tz, year: 'numeric', month: 'numeric', day: 'numeric', weekday: 'short' })
      .formatToParts(date);
  let parts;
  try { parts = fmt(timeZone); } catch { parts = fmt('UTC'); }
  const get = (t: string) => parts.find((p) => p.type === t)!.value;
  return { year: +get('year'), month: +get('month'), day: +get('day'), weekday: WEEKDAYS.indexOf(get('weekday')) };
}

export function normalizeFlight(row: FlightRow, airports: AirportIndex): StatsFlight {
  const fa = row.flightAwareData;
  const dep = airportOf(row.departure, airports);
  const arr = airportOf(row.arrival, airports);
  const al: any = row.airline ?? {};
  const ac: any = row.aircraft ?? {};
  const distanceKm = num(row.greatCircleDistance?.km) ?? haversineKm(dep, arr);

  let blockMinutes = mins(fa?.actualOut, fa?.actualIn);
  if (blockMinutes == null || blockMinutes <= 0)
    blockMinutes = mins(jsonTime(row.departure), jsonTime(row.arrival));
  if (blockMinutes == null || blockMinutes <= 0)
    blockMinutes = Math.round((distanceKm / 800) * 60);

  const delay = (secs: number | null | undefined, sched?: Date | null, act?: Date | null) =>
    secs != null ? Math.round(secs / 60) : mins(sched, act);

  return {
    id: row.id,
    flightNo: row.flightNo,
    identIata: fa?.identIata ?? undefined,
    identIcao: fa?.identIcao ?? undefined,
    faFlightId: fa?.faFlightId,
    airline: {
      key: al.icao || al.iata || al.name || '',
      name: al.name || '', iata: str(al.iata), icao: str(al.icao), image: str(al.image),
    },
    dep, arr,
    date: row.date,
    local: localParts(row.date, str((row.departure as any)?.airport?.timeZone) ?? 'UTC'),
    distanceKm,
    blockMinutes,
    airMinutes: mins(fa?.actualOff, fa?.actualOn),
    taxiOutMin: nonNeg(mins(fa?.actualOut, fa?.actualOff)),
    taxiInMin: nonNeg(mins(fa?.actualOn, fa?.actualIn)),
    arrivalDelayMin: delay(fa?.arrivalDelay, fa?.scheduledIn, fa?.actualIn),
    departureDelayMin: delay(fa?.departureDelay, fa?.scheduledOut, fa?.actualOut),
    hasFa: !!fa,
    cancelled: !!fa?.cancelled,
    diverted: !!fa?.diverted,
    runwayOff: fa?.actualRunwayOff ?? undefined,
    runwayOn: fa?.actualRunwayOn ?? undefined,
    reg: str(ac.reg) ?? str(ac.registration) ?? str(fa?.registration),
    // FlightAware's ICAO designator; stored/registry model codes are manufacturer models.
    typeCode: str(fa?.aircraftType),
    typeName: str(ac.typeName),
  };
}

export function isCounted(f: StatsFlight, now: Date): boolean {
  return !f.cancelled && f.date <= now;
}
