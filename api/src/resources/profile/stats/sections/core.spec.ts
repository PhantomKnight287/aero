import { makeStatsFlight as mk } from '../fixtures';
import { delaySummary, flightsPer, passport, records } from './core';

const ap = (key: string, isoCountry?: string) => ({ key, icao: key, name: key, city: key, isoCountry });

describe('core stats', () => {
  it('empty input', () => {
    expect(passport([])).toEqual({
      totalFlights: 0, totalDistanceKm: 0, blockMinutes: 0, airMinutes: 0, airBasedOn: 0,
      taxiMinutes: 0, taxiBasedOn: 0, totalAirports: 0, totalAirlines: 0, totalCountries: 0,
      domestic: 0, international: 0, longHaul: 0,
    });
    const p = flightsPer([]);
    expect(p.year).toEqual([]);
    expect(p.month).toEqual(new Array(12).fill(0));
    expect(p.weekday).toEqual(new Array(7).fill(0));
    expect(records([])).toEqual({ shortestDistance: null, longestDistance: null, shortestDuration: null, longestDuration: null });
    expect(delaySummary([])).toEqual({ basedOn: 0, arrivedCount: 0, delayedCount: 0, minutesLost: 0, avgDelayMinutes: 0 });
  });

  it('counts unique by one key', () => {
    const del = ap('VIDP', 'IN'), dxb = ap('OMDB', 'AE');
    const p = passport([
      mk({ airline: { key: 'UAE', name: 'Emirates', iata: 'EK', icao: 'UAE' }, dep: del, arr: dxb }),
      mk({ airline: { key: 'UAE', name: 'Emirates', icao: 'UAE' }, dep: dxb, arr: del }),
    ]);
    expect(p.totalAirlines).toBe(1);
    expect(p.totalAirports).toBe(2);
    expect(p.totalCountries).toBe(2);
  });

  it('domestic vs international vs long haul', () => {
    const p = passport([
      mk({ dep: ap('VIDP', 'IN'), arr: ap('VABB', 'IN'), blockMinutes: 130 }),
      mk({ dep: ap('VIDP', 'IN'), arr: ap('EGLL', 'GB'), blockMinutes: 540 }),
      mk({ dep: ap('VIDP', 'IN'), arr: ap('XXXX'), blockMinutes: 100 }),
    ]);
    expect([p.domestic, p.international, p.longHaul]).toEqual([1, 1, 1]);
  });

  it('air and taxi basedOn', () => {
    const p = passport([
      mk({ airMinutes: 100, taxiOutMin: 10, taxiInMin: 5 }),
      mk({ airMinutes: 50, taxiOutMin: 20, taxiInMin: 5 }),
      mk(),
    ]);
    expect(p.airBasedOn).toBe(2);
    expect(p.airMinutes).toBe(150);
    expect(p.taxiBasedOn).toBe(2);
    expect(p.taxiMinutes).toBe(40);
  });

  it('flightsPer buckets', () => {
    const p = flightsPer([
      mk({ local: { year: 2025, month: 6, weekday: 0 } }),
      mk({ local: { year: 2024, month: 1, weekday: 3 } }),
      mk({ local: { year: 2025, month: 6, weekday: 3 } }),
    ]);
    expect(p.year).toEqual([{ year: 2024, count: 1 }, { year: 2025, count: 2 }]);
    expect(p.month[5]).toBe(2);
    expect(p.month[0]).toBe(1);
    expect(p.weekday[3]).toBe(2);
  });

  it('records pick extremes', () => {
    const r = records([mk({ distanceKm: 228, blockMinutes: 50 }), mk({ distanceKm: 15594, blockMinutes: 900 })]);
    expect(r.shortestDistance!.value).toBe(228);
    expect(r.longestDistance!.value).toBe(15594);
    expect(r.shortestDuration!.value).toBe(50);
    expect(r.longestDuration!.value).toBe(900);
  });

  it('delay summary', () => {
    const d = delaySummary([
      ...[-10, 5, 20, 90].map((m) => mk({ hasFa: true, arrivalDelayMin: m })),
      mk(),
    ]);
    expect(d).toEqual({ basedOn: 4, arrivedCount: 4, delayedCount: 2, minutesLost: 110, avgDelayMinutes: 55 });
  });

  it('boundaries', () => {
    expect(passport([mk({ blockMinutes: 360 })]).longHaul).toBe(0);
    expect(passport([mk({ blockMinutes: 361 })]).longHaul).toBe(1);
    expect(delaySummary([mk({ arrivalDelayMin: 15 })])).toMatchObject({ basedOn: 1, delayedCount: 0, minutesLost: 0 });
    const r = records([mk({ distanceKm: 0 }), mk({ distanceKm: 500 })]);
    expect(r.shortestDistance!.value).toBe(500);
    const p = passport([mk({ taxiOutMin: 10 }), mk({ taxiOutMin: 5, taxiInMin: 4 }), mk()]);
    expect(p.taxiMinutes).toBe(19);
    expect(p.taxiBasedOn).toBe(2);
  });
});
