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

const row = (id: string, date: string, o: Record<string, unknown> = {}) =>
  makeFlightRow({ id, date: new Date(date), ...o });

describe('FlightService.getFlightHistory', () => {
  const service = new FlightService({ get: () => undefined } as any, {} as any, { getOrNil: () => null } as any);
  const ids = (r: any) => r.items.map((i: any) => i.id);

  it('pages newest first', async () => {
    findMany.mockResolvedValue([
      row('a', '2025-01-01T10:00:00Z'), row('b', '2025-02-01T10:00:00Z'), row('c', '2025-03-01T10:00:00Z'),
      row('d', '2025-04-01T10:00:00Z'), row('e', '2025-05-01T10:00:00Z'),
    ]);
    const p1 = await service.getFlightHistory('u1', { limit: 2 });
    expect(ids(p1)).toEqual(['e', 'd']);
    const p2 = await service.getFlightHistory('u1', { limit: 2, cursor: p1.nextCursor! });
    expect(ids(p2)).toEqual(['c', 'b']);
    const p3 = await service.getFlightHistory('u1', { limit: 2, cursor: p2.nextCursor! });
    expect(ids(p3)).toEqual(['a']);
    expect(p3.nextCursor).toBeNull();
  });

  it('stable cursor on equal dates', async () => {
    findMany.mockResolvedValue(['x1', 'x3', 'x2'].map((id) => row(id, '2025-06-01T10:00:00Z')));
    const seen: string[] = [];
    let cursor: string | undefined;
    do {
      const r = await service.getFlightHistory('u1', { limit: 1, cursor });
      seen.push(...ids(r));
      cursor = r.nextCursor ?? undefined;
    } while (cursor);
    expect(seen).toEqual(['x3', 'x2', 'x1']);
  });

  it('year filter and yearCounts', async () => {
    findMany.mockResolvedValue([
      row('a', '2024-06-01T10:00:00Z'), row('b', '2025-06-01T10:00:00Z'), row('c', '2025-07-01T10:00:00Z'),
    ]);
    const r = await service.getFlightHistory('u1', { year: 2025 });
    expect(ids(r)).toEqual(['c', 'b']);
    expect(r.yearCounts).toEqual([{ year: 2025, count: 2 }, { year: 2024, count: 1 }]);
  });

  it('excludes future and cancelled; clamps limit; unknown cursor is first page', async () => {
    findMany.mockResolvedValue([
      row('ok', '2025-06-01T10:00:00Z'),
      row('future', '2999-01-01T10:00:00Z'),
      row('cx', '2025-07-01T10:00:00Z', { flightAwareData: { cancelled: true } }),
    ]);
    const r = await service.getFlightHistory('u1', { limit: 0, cursor: 'nope' });
    expect(ids(r)).toEqual(['ok']);
    expect(r.yearCounts).toEqual([{ year: 2025, count: 1 }]);
  });
});
