import { FlightService } from './flight.service';
import { makeFlightRow } from '../profile/stats/fixtures';

jest.mock('src/db', () => ({
  prisma: {
    flight: { findMany: jest.fn() },
    airport: { findMany: jest.fn().mockResolvedValue([]) },
  },
}));
import { prisma } from 'src/db';
const findMany = (prisma as any).flight.findMany as jest.Mock;

const base = makeFlightRow();
/** DEL -> DXB by default; `back` flips it. */
const row = (id: string, date: string, back = false) =>
  makeFlightRow({
    id,
    date: new Date(date),
    ...(back ? { departure: base.arrival, arrival: base.departure } : {}),
  });

describe('FlightService.getRouteHistory', () => {
  const service = new FlightService({ get: () => undefined } as any, {} as any, { getOrNil: () => null } as any);

  it('direction', async () => {
    findMany.mockResolvedValue([
      row('a', '2025-01-01T10:00:00Z'), row('b', '2025-02-01T10:00:00Z'), row('c', '2025-03-01T10:00:00Z', true),
    ]);
    expect((await service.getRouteHistory('u1', 'VIDP', 'OMDB')).flightCount).toBe(2);
    expect((await service.getRouteHistory('u1', 'OMDB', 'VIDP')).flightCount).toBe(1);
  });

  it('iata or icao', async () => {
    findMany.mockResolvedValue([row('a', '2025-01-01T10:00:00Z'), row('b', '2025-02-01T10:00:00Z')]);
    expect((await service.getRouteHistory('u1', 'DEL', 'DXB')).flightCount).toBe(2);
  });

  it('exclude', async () => {
    findMany.mockResolvedValue([row('a', '2025-01-01T10:00:00Z'), row('b', '2025-02-01T10:00:00Z')]);
    const r = await service.getRouteHistory('u1', 'DEL', 'DXB', 'b');
    expect(r.flightCount).toBe(1);
    expect(r.recent.map((f) => f.id)).toEqual(['a']);
  });

  it('recent newest first, max 3; sums over all', async () => {
    findMany.mockResolvedValue(
      ['01', '02', '03', '04', '05'].map((m, i) => row(`f${i}`, `2025-${m}-01T10:00:00Z`)),
    );
    const r = await service.getRouteHistory('u1', 'VIDP', 'OMDB');
    expect(r.recent.map((f) => f.id)).toEqual(['f4', 'f3', 'f2']);
    expect(r.flightCount).toBe(5);
    expect(r.distanceKm).toBeGreaterThan(0);
    const one = (await service.getRouteHistory('u1', 'VIDP', 'OMDB', 'f0'));
    expect(r.distanceKm).toBeCloseTo(one.distanceKm * 5 / 4, 5);
    expect(r.blockMinutes).toBe(one.blockMinutes * 5 / 4);
  });

  it('empty', async () => {
    findMany.mockResolvedValue([row('a', '2025-01-01T10:00:00Z')]);
    expect(await service.getRouteHistory('u1', 'KLAX', 'KJFK')).toEqual({
      flightCount: 0, distanceKm: 0, blockMinutes: 0, recent: [],
    });
  });
});
