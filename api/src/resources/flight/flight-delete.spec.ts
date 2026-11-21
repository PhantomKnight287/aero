import { NotFoundException } from '@nestjs/common';
import { prisma } from 'src/db';
import { FlightService } from './flight.service';

jest.mock('src/db', () => ({
  prisma: {
    flight: { findFirst: jest.fn(), delete: jest.fn() },
    flightPositions: { deleteMany: jest.fn() },
    $transaction: jest.fn((ops) => Promise.all(ops)),
  },
}));

const db = prisma as unknown as {
  flight: { findFirst: jest.Mock; delete: jest.Mock };
  flightPositions: { deleteMany: jest.Mock };
  $transaction: jest.Mock;
};

describe('FlightService.deleteFlight', () => {
  let service: FlightService;

  beforeEach(() => {
    jest.clearAllMocks();
    service = new FlightService(
      { get: () => undefined } as any,
      {} as any,
      { getOrNil: () => null } as any,
    );
  });

  it('throws NotFound and deletes nothing when flight not owned', async () => {
    db.flight.findFirst.mockResolvedValue(null);
    await expect(service.deleteFlight('f1', 'u1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(db.flight.findFirst).toHaveBeenCalledWith({
      where: { id: 'f1', userId: 'u1' },
    });
    expect(db.flight.delete).not.toHaveBeenCalled();
    expect(db.flightPositions.deleteMany).not.toHaveBeenCalled();
  });

  it('deletes positions then flight in one transaction', async () => {
    db.flight.findFirst.mockResolvedValue({ id: 'f1' });
    await expect(service.deleteFlight('f1', 'u1')).resolves.toEqual({
      message: 'Flight deleted successfully',
    });
    expect(db.flightPositions.deleteMany).toHaveBeenCalledWith({
      where: { flightId: 'f1' },
    });
    expect(db.flight.delete).toHaveBeenCalledWith({ where: { id: 'f1' } });
    expect(db.$transaction).toHaveBeenCalledTimes(1);
  });
});
