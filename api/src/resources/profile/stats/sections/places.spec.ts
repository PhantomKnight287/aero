import { makeStatsFlight } from '../fixtures';
import { continentBucket } from '../regions';
import { continents, countries, mapData, topAirlines, topAirports, topRoutes } from './places';

const ap = (key: string, o: object = {}) => ({ key, icao: key, iata: key.slice(1), name: key, city: key, isoCountry: 'IN', continent: 'AS', lat: 1, lon: 2, ...o });
const DEL = ap('VIDP', { iata: 'DEL' });
const DXB = ap('OMDB', { iata: 'DXB', isoCountry: 'AE' });
const LHR = ap('EGLL', { iata: 'LHR', isoCountry: 'GB', continent: 'EU', lat: 51, lon: 0 });
const f = (dep: any, arr: any, o: object = {}) => makeStatsFlight({ dep, arr, distanceKm: 100, ...o });

describe('places', () => {
  it('top airports count dep and arr', () => {
    const r = topAirports([f(DEL, DXB), f(DXB, DEL)]);
    const dxb = r.find((x) => x.airport.key === 'OMDB')!;
    expect(dxb).toMatchObject({ departures: 1, arrivals: 1, flightCount: 2, distanceKm: 200 });
  });

  it('top airports and routes skip empty-key airports', () => {
    const blank = ap('');
    expect(topAirports([f(DEL, blank)]).map((x) => x.airport.key)).toEqual(['VIDP']);
    expect(topRoutes([f(DEL, blank)])).toEqual([]);
  });

  it('top airlines', () => {
    const r = topAirlines([f(DEL, DXB), f(DXB, DEL)]);
    expect(r).toHaveLength(1);
    expect(r[0]).toMatchObject({ flightCount: 2, distanceKm: 200 });
  });

  it('routes are directional', () => {
    const r = topRoutes([f(DEL, LHR), f(DEL, LHR), f(LHR, DEL)]);
    expect(r.map((x) => x.flightCount)).toEqual([2, 1]);
  });

  it('countries skip unknown', () => {
    const r = countries([f(DEL, ap('XXXX', { isoCountry: undefined }))]);
    expect(r).toEqual([{ isoCountry: 'IN', name: 'India', flightCount: 1 }]);
  });

  it('country flightCount counts flights once', () => {
    const BOM = ap('VABB', { iata: 'BOM' });
    const r = countries([f(DEL, BOM), f(DEL, DXB)]);
    expect(r).toEqual([
      { isoCountry: 'IN', name: 'India', flightCount: 2 },
      { isoCountry: 'AE', name: 'United Arab Emirates', flightCount: 1 },
    ]);
  });

  it('continents single domestic asia flight', () => {
    const BOM = ap('VABB', { iata: 'BOM' });
    expect(continents([f(DEL, BOM)])[0]).toEqual({ bucket: 'asia', countryCount: 1, flightShare: 1 });
  });

  it('continent buckets', () => {
    expect(continentBucket('AE', 'AS')).toBe('middle_east');
    expect(continentBucket('MX', 'NA')).toBe('central_america');
    expect(continentBucket('JM', 'NA')).toBe('caribbean');
    expect(continentBucket('US', 'NA')).toBe('north_america');
    expect(continentBucket('IN', 'AS')).toBe('asia');
    expect(continentBucket('ZZ', 'AN')).toBeNull();
    expect(continentBucket(undefined, undefined)).toBeNull();
  });

  it('continents returns 9 buckets in order', () => {
    const r = continents([f(DEL, DXB), f(DEL, LHR)]);
    expect(r.map((x) => x.bucket)).toEqual(['asia', 'europe', 'north_america', 'middle_east', 'oceania', 'africa', 'central_america', 'caribbean', 'south_america']);
    expect(r[0]).toEqual({ bucket: 'asia', countryCount: 1, flightShare: 1 });
    expect(r[1]).toEqual({ bucket: 'europe', countryCount: 1, flightShare: 0.5 });
    expect(r[3]).toEqual({ bucket: 'middle_east', countryCount: 1, flightShare: 0.5 });
    expect(continents([]).every((x) => x.flightShare === 0)).toBe(true);
  });

  it('map routes undirected, skip no-coords', () => {
    const r = mapData([f(DEL, LHR), f(LHR, DEL), f(DEL, ap('NOCO', { lat: undefined, lon: undefined }))]);
    expect(r.routes).toHaveLength(1);
    expect(r.routes[0].count).toBe(2);
    expect(r.airports.map((a) => a.icao).sort()).toEqual(['EGLL', 'VIDP']);
  });
});
