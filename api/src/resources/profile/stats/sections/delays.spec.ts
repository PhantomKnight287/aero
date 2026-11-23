import { makeStatsFlight as mk } from '../fixtures';
import { StatsAirline, StatsAirport } from '../stats-flight';
import { delayReport } from './delays';

const al = (key: string): StatsAirline => ({ key, name: key, iata: key });
const ap = (key: string): StatsAirport => ({ key, iata: key, name: key, city: key });
const arr = (arrivalDelayMin: number, o = {}) => mk({ hasFa: true, arrivalDelayMin, ...o });

describe('delayReport', () => {
  it('empty', () => {
    expect(delayReport([], 0)).toEqual({
      basedOn: 0, arrivedCount: 0, delayedCount: 0, minutesLost: 0, avgDelayMinutes: 0, netMinutes: 0,
      buckets: { early: 0, onTime: 0, late15: 0, late30: 0, late45: 0, cancelled: 0, diverted: 0, total: 0 },
      worst: null, airlines: [], airports: [], flights: [],
    });
  });

  it('buckets', () => {
    const r = delayReport([-10, -5, 0, 15, 16, 30, 31, 45, 46, 120].map((d) => arr(d)), 2);
    expect(r.buckets).toEqual({ early: 1, onTime: 3, late15: 2, late30: 2, late45: 2, cancelled: 2, diverted: 0, total: 12 });
    expect(r.delayedCount).toBe(6);
    expect(r.basedOn).toBe(10);
    expect(r.minutesLost).toBe(288);
    expect(r.avgDelayMinutes).toBe(48);
    expect(r.netMinutes).toBe(288);
  });

  it('diverted wins', () => {
    const r = delayReport([arr(90, { diverted: true })], 0);
    expect(r.buckets.diverted).toBe(1);
    expect(r.buckets.late45).toBe(0);
    expect(r.flights).toEqual([]);
    expect(r.basedOn).toBe(0);
    expect(r.airlines).toEqual([]);
  });

  it('worst and order', () => {
    const r = delayReport([20, 200, 60].map((d) => arr(d)), 0);
    expect(r.worst?.value).toBe(200);
    expect(r.flights.map((f) => f.value)).toEqual([200, 60, 20]);
  });

  it('airlines', () => {
    const r = delayReport([
      arr(20, { airline: al('EK') }), arr(0, { airline: al('EK') }),
      arr(100, { airline: al('AI') }), arr(50, { airline: al('') }),
    ], 0);
    expect(r.airlines.map(({ airline, ...x }) => ({ k: airline.key, ...x }))).toEqual([
      { k: 'AI', late: 1, total: 1, minutesLate: 100 },
      { k: 'EK', late: 1, total: 2, minutesLate: 20 },
    ]);
  });

  it('airports', () => {
    const dep = (key: string, departureDelayMin: number) => mk({ hasFa: true, dep: ap(key), departureDelayMin });
    const r = delayReport([dep('DEL', 30), dep('DEL', 0), dep('DEL', 5), dep('DXB', 16), dep('', 40)], 0);
    expect(r.airports.map(({ airport, ...x }) => ({ k: airport.key, ...x }))).toEqual([
      { k: 'DXB', lateDepartures: 1, total: 1 },
      { k: 'DEL', lateDepartures: 1, total: 3 },
    ]);
  });
});
