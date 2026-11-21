import { prisma } from 'src/db';
import { FlightsService } from './flights.service';

jest.mock('src/db', () => ({
  prisma: {
    flight: { findMany: jest.fn().mockResolvedValue([]) },
    airport: { findMany: jest.fn().mockResolvedValue([]) },
    airline: { findMany: jest.fn().mockResolvedValue([]) },
  },
}));

describe('FlightsService.getTrackedFlights', () => {
  it("includes the user's bookings so the app can warn before deleting", async () => {
    const service = new FlightsService({} as any, {} as any);
    await service.getTrackedFlights('u1');
    const args = (prisma.flight.findMany as jest.Mock).mock.calls[0][0];
    expect(args.include.bookings).toEqual({ where: { userId: 'u1' } });
  });
});
