import { prisma } from 'src/db';
import { ProfileService } from './profile.service';
import { makeFlightRow } from './stats/fixtures';

jest.mock('src/db', () => ({
  prisma: {
    flight: { findMany: jest.fn() },
    airport: { findMany: jest.fn() },
    airline: { findMany: jest.fn() },
    aircraft: { findMany: jest.fn() },
    aircraftRegistration: { findMany: jest.fn() },
  },
}));

const db = prisma as unknown as Record<string, { findMany: jest.Mock }>;
const at = (id: string, iso: string, extra: Record<string, unknown> = {}) =>
  makeFlightRow({ id, date: new Date(iso), ...extra });

describe('ProfileService.getProfileStats', () => {
  const service = new ProfileService();
  beforeEach(() => {
    jest.clearAllMocks();
    for (const k of ['airport', 'airline', 'aircraft', 'aircraftRegistration']) db[k].findMany.mockResolvedValue([]);
  });

  it('filters by year and lists all years', async () => {
    db.flight.findMany.mockResolvedValue([
      at('a', '2024-03-01T10:00:00Z'),
      at('b', '2025-03-01T10:00:00Z'),
      at('c', '2025-04-01T10:00:00Z'),
      at('d', '2099-01-01T10:00:00Z'),
    ]);
    const all = await service.getProfileStats('u1');
    expect(all.availableYears).toEqual([2025, 2024]);
    expect(all.year).toBeNull();
    expect(all.passport.totalFlights).toBe(3);
    const y = await service.getProfileStats('u1', 2024);
    expect(y.year).toBe(2024);
    expect(y.passport.totalFlights).toBe(1);
    expect(y.topAirports[0].airport).not.toHaveProperty('key');
  });

  it('excludes cancelled flights', async () => {
    db.flight.findMany.mockResolvedValue([
      at('a', '2024-03-01T10:00:00Z'),
      at('b', '2024-03-02T10:00:00Z', { flightAwareData: { cancelled: true } }),
    ]);
    expect((await service.getProfileStats('u1')).passport.totalFlights).toBe(1);
  });

  it('counts past cancelled flights per year in the delay buckets', async () => {
    const cx = { flightAwareData: { cancelled: true } };
    db.flight.findMany.mockResolvedValue([
      at('a', '2024-03-01T10:00:00Z'),
      at('b', '2025-03-02T10:00:00Z', cx),
      at('c', '2099-03-02T10:00:00Z', cx),
    ]);
    expect((await service.getProfileStats('u1', 2025)).delays.buckets.cancelled).toBe(1);
    expect((await service.getProfileStats('u1', 2024)).delays.buckets.cancelled).toBe(0);
    expect((await service.getProfileStats('u1')).delays.buckets.cancelled).toBe(1);
    expect((await service.getProfileStats('u1', 2099)).delays.buckets.cancelled).toBe(0);
  });

  it('handles an empty log', async () => {
    db.flight.findMany.mockResolvedValue([]);
    const r = await service.getProfileStats('u1');
    expect(r.availableYears).toEqual([]);
    expect(r.passport.totalFlights).toBe(0);
    expect(r.mostFlownAircraft.flightCount).toBe(0);
  });
});
