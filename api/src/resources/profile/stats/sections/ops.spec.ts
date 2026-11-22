import { makeStatsFlight as mk } from '../fixtures';
import { extremes, runways, taxiByAirport } from './ops';

const ap = (key: string, o: object = {}) => ({ key, icao: key, name: key, city: key, ...o });

describe('runways', () => {
  it('splits off and on', () => {
    const r = runways([
      mk({ runwayOff: '29R' }),
      mk({ id: 'f2', runwayOff: '29R' }),
      mk({ id: 'f3', dep: ap('OMDB'), arr: mk().dep, runwayOn: '29R' }),
      mk({ id: 'f4' }),
    ]);
    expect(r.basedOn).toBe(3);
    expect(r.items).toHaveLength(1);
    expect(r.items[0]).toMatchObject({ runway: '29R', departures: 2, arrivals: 1 });
    expect(r.items[0].airport.key).toBe('VIDP');
  });
});

describe('taxiByAirport', () => {
  it('averages per airport', () => {
    const t = taxiByAirport([
      mk({ taxiOutMin: 20 }),
      mk({ id: 'f2', taxiOutMin: 30, taxiInMin: 45 }),
      mk({ id: 'f3' }),
    ]);
    expect(t.basedOn).toBe(2);
    const del = t.items.find((i) => i.airport.key === 'VIDP')!;
    expect(del).toMatchObject({ avgTaxiOutMin: 25, taxiOutCount: 2, avgTaxiInMin: null, taxiInCount: 0 });
    const dxb = t.items.find((i) => i.airport.key === 'OMDB')!;
    expect(dxb).toMatchObject({ avgTaxiOutMin: null, avgTaxiInMin: 45, taxiInCount: 1 });
    expect(t.longest!.value).toBe(45);
  });
  it('null longest when none', () => expect(taxiByAirport([mk()]).longest).toBeNull());
});

describe('extremes', () => {
  it('finds extremes, ignoring airports without coordinates', () => {
    const fs = [
      mk({ dep: ap('A', { lat: 64.1, lon: -157.9, elevationFt: 100 }), arr: ap('B', { lat: -33.9, lon: 151.2, elevationFt: 9000 }) }),
      mk({ dep: ap('C', { lat: 1.3, lon: 103.9 }), arr: ap('D', { elevationFt: 99999 }) }),
    ];
    const e = extremes(fs);
    expect(e.north!.lat).toBe(64.1);
    expect(e.south!.lat).toBe(-33.9);
    expect(e.east!.lon).toBe(151.2);
    expect(e.west!.lon).toBe(-157.9);
    expect(e.highest!.key).toBe('B');
  });
  it('empty -> nulls', () =>
    expect(extremes([])).toEqual({ north: null, south: null, east: null, west: null, highest: null }));
});
