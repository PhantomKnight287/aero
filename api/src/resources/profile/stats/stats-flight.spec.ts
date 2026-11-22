import { makeAirport, makeFlightRow } from './fixtures';
import { AirportIndex, isCounted, normalizeFlight } from './stats-flight';

const none: AirportIndex = new Map();
const side = (o: any) => ({ airport: { icao: 'VIDP', iata: 'DEL', timeZone: 'Asia/Kolkata' }, ...o });
const t = (s: string) => new Date(s);

describe('normalizeFlight', () => {
  it('block time prefers FA gate times', () => {
    const f = normalizeFlight(
      makeFlightRow({ flightAwareData: { actualOut: t('2025-06-01T10:00:00Z'), actualIn: t('2025-06-01T12:30:00Z') } }),
      none,
    );
    expect(f.blockMinutes).toBe(150);
  });

  it('block time falls back to stored JSON then distance', () => {
    const a = normalizeFlight(
      makeFlightRow({
        departure: side({ actualTime: { utc: '2025-06-01 10:00Z' } }),
        arrival: side({ scheduledTime: { utc: '2025-06-01 11:00Z' } }),
      }),
      none,
    );
    expect(a.blockMinutes).toBe(60);
    const b = normalizeFlight(
      makeFlightRow({
        departure: side({}),
        arrival: side({}),
        greatCircleDistance: { km: 800 },
      }),
      none,
    );
    expect(b.blockMinutes).toBe(60);
  });

  it('taxi needs both actual ends', () => {
    const f = normalizeFlight(
      makeFlightRow({ flightAwareData: { actualOut: t('2025-06-01T10:00:00Z'), actualOff: t('2025-06-01T10:18:00Z') } }),
      none,
    );
    expect(f.taxiOutMin).toBe(18);
    expect(f.taxiInMin).toBeUndefined();
  });

  it('arrival delay from seconds else times', () => {
    expect(normalizeFlight(makeFlightRow({ flightAwareData: { arrivalDelay: 1800 } }), none).arrivalDelayMin).toBe(30);
    const f = normalizeFlight(
      makeFlightRow({
        flightAwareData: { arrivalDelay: null, scheduledIn: t('2025-06-01T12:00:00Z'), actualIn: t('2025-06-01T12:20:00Z') },
      }),
      none,
    );
    expect(f.arrivalDelayMin).toBe(20);
  });

  it('airport metadata from index', () => {
    const idx: AirportIndex = new Map([['C:VIDP', makeAirport({ gpsCode: 'VIDP', isoCountry: 'IN', continent: 'AS' })]]);
    const f = normalizeFlight(makeFlightRow(), idx);
    expect(f.dep.isoCountry).toBe('IN');
    expect(f.dep.key).toBe('VIDP');
  });

  it('unknown airport', () => {
    const zero = { airport: { icao: 'VIDP', iata: 'DEL', location: { lat: 0, lon: 0 } } };
    const f = normalizeFlight(makeFlightRow({ departure: zero }), none);
    expect(f.dep.isoCountry).toBeUndefined();
    expect(f.dep.lat).toBeUndefined();
    expect(f.dep.key).toBe('VIDP');
  });

  it('unknown airport falls back to stored location', () => {
    const f = normalizeFlight(makeFlightRow(), none);
    expect(f.dep.lat).toBeCloseTo(28.5665);
    expect(f.dep.lon).toBeCloseTo(77.1031);
  });

  it('taxi-in, departure delay, negative taxi', () => {
    const f = normalizeFlight(
      makeFlightRow({
        flightAwareData: {
          actualOn: t('2025-06-01T12:00:00Z'), actualIn: t('2025-06-01T12:07:00Z'),
          actualOut: t('2025-06-01T10:10:00Z'), actualOff: t('2025-06-01T10:00:00Z'),
          departureDelay: 600,
        },
      }),
      none,
    );
    expect(f.taxiInMin).toBe(7);
    expect(f.taxiOutMin).toBeUndefined();
    expect(f.departureDelayMin).toBe(10);
    const g = normalizeFlight(
      makeFlightRow({ flightAwareData: { scheduledOut: t('2025-06-01T10:00:00Z'), actualOut: t('2025-06-01T10:25:00Z') } }),
      none,
    );
    expect(g.departureDelayMin).toBe(25);
  });

  it('distance falls back to haversine', () => {
    const idx: AirportIndex = new Map([
      ['C:VIDP', makeAirport()],
      ['C:OMDB', makeAirport({ ident: 'OMDB', gpsCode: 'OMDB', iataCode: 'DXB', lat: 25.2532, long: 55.3657 })],
    ]);
    const f = normalizeFlight(makeFlightRow(), idx);
    expect(Math.abs(f.distanceKm - 2190)).toBeLessThan(10);
  });

  it('local new year', () => {
    const f = normalizeFlight(makeFlightRow({ date: t('2025-12-31T19:00:00Z') }), none);
    expect(f.local).toEqual({ year: 2026, month: 1, weekday: 4 });
  });
});

describe('isCounted', () => {
  const now = t('2025-06-01T00:00:00Z');
  const f = (o: any) => normalizeFlight(makeFlightRow({ date: t('2025-05-01T00:00:00Z'), ...o }), none);
  it('rules', () => {
    expect(isCounted(f({ flightAwareData: { cancelled: true } }), now)).toBe(false);
    expect(isCounted(f({ date: t('2025-06-02T00:00:00Z') }), now)).toBe(false);
    expect(isCounted(f({ flightAwareData: { diverted: true } }), now)).toBe(true);
  });
});
