import { NotFoundException } from '@nestjs/common';
import { prisma } from 'src/db';
import { toAircraftLeg } from './aircraft-history.util';
import { FlightService } from './flight.service';

jest.mock('src/db', () => ({
  prisma: {
    flight: { findFirst: jest.fn(), findMany: jest.fn() },
  },
}));

const db = prisma as unknown as {
  flight: { findFirst: jest.Mock; findMany: jest.Mock };
};

const faLeg = {
  fa_flight_id: 'UAE381-1731456000-schedule-0123',
  ident: 'UAE381',
  ident_iata: 'EK381',
  ident_icao: 'UAE381',
  status: 'En Route / On Time',
  origin: {
    code_iata: 'HKG',
    code_icao: 'VHHH',
    city: 'Hong Kong',
    timezone: 'Asia/Hong_Kong',
  },
  destination: {
    code_iata: 'DXB',
    code_icao: 'OMDB',
    city: 'Dubai',
    timezone: 'Asia/Dubai',
  },
  scheduled_out: '2026-11-15T01:00:00Z',
  actual_out: '2026-11-15T01:10:00Z',
  scheduled_in: '2026-11-15T05:40:00Z',
  estimated_in: '2026-11-15T06:15:00Z',
  arrival_delay: 2100,
  progress_percent: 60,
  cancelled: false,
};

describe('toAircraftLeg', () => {
  it('maps a FlightAware flight', () => {
    expect(toAircraftLeg(faLeg)).toEqual({
      faFlightId: 'UAE381-1731456000-schedule-0123',
      ident: 'UAE381',
      identIata: 'EK381',
      identIcao: 'UAE381',
      status: 'En Route / On Time',
      originIata: 'HKG',
      originIcao: 'VHHH',
      originCity: 'Hong Kong',
      originTimezone: 'Asia/Hong_Kong',
      destinationIata: 'DXB',
      destinationIcao: 'OMDB',
      destinationCity: 'Dubai',
      destinationTimezone: 'Asia/Dubai',
      scheduledOut: '2026-11-15T01:00:00Z',
      estimatedOut: undefined,
      actualOut: '2026-11-15T01:10:00Z',
      scheduledIn: '2026-11-15T05:40:00Z',
      estimatedIn: '2026-11-15T06:15:00Z',
      actualIn: undefined,
      arrivalDelay: 2100,
      progressPercent: 60,
      cancelled: false,
    });
  });
});

describe('FlightService.getAircraftHistory', () => {
  let service: FlightService;
  let getFaFlightById: jest.SpyInstance;

  beforeEach(() => {
    jest.clearAllMocks();
    service = new FlightService(
      { get: () => undefined } as any,
      {} as any,
      { getOrNil: () => null } as any,
    );
    getFaFlightById = jest
      .spyOn(service as any, 'getFaFlightById')
      .mockResolvedValue(faLeg);
  });

  it('404s for a flight the user does not own', async () => {
    db.flight.findFirst.mockResolvedValue(null);
    await expect(
      service.getAircraftHistory('f1', 'u1'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(db.flight.findFirst).toHaveBeenCalledWith(
      expect.objectContaining({ where: { id: 'f1', userId: 'u1' } }),
    );
  });

  it('returns empty history when there is no FlightAware data', async () => {
    db.flight.findFirst.mockResolvedValue({
      id: 'f1',
      aircraft: {},
      flightAwareData: null,
    });
    await expect(service.getAircraftHistory('f1', 'u1')).resolves.toEqual({
      registration: null,
      inbound: null,
      ownFlights: [],
    });
    expect(getFaFlightById).not.toHaveBeenCalled();
  });

  it('returns inbound leg and own flights on the same tail', async () => {
    db.flight.findFirst.mockResolvedValue({
      id: 'f1',
      aircraft: {},
      flightAwareData: {
        registration: 'A6-EOF',
        inboundFaFlightId: faLeg.fa_flight_id,
      },
    });
    db.flight.findMany.mockResolvedValue([
      {
        id: 'f0',
        flightNo: 'EK2',
        callSign: 'UAE2',
        airline: { name: 'Emirates', iata: 'EK', icao: 'UAE' },
        departure: { airport: { iata: 'DXB', name: 'Dubai Intl' } },
        arrival: { airport: { iata: 'LHR', name: 'Heathrow' } },
        date: new Date('2025-01-14T00:00:00Z'),
      },
    ]);

    const result = await service.getAircraftHistory('f1', 'u1');

    expect(getFaFlightById).toHaveBeenCalledWith(faLeg.fa_flight_id);
    expect(result.registration).toBe('A6-EOF');
    expect(result.inbound?.identIata).toBe('EK381');
    expect(db.flight.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          userId: 'u1',
          id: { not: 'f1' },
          flightAwareData: { registration: 'A6-EOF' },
        },
        orderBy: { date: 'desc' },
      }),
    );
    expect(result.ownFlights).toEqual([
      {
        id: 'f0',
        flightNo: 'EK2',
        callSign: 'UAE2',
        airline: { name: 'Emirates', iata: 'EK', icao: 'UAE', image: undefined },
        departureAirportCode: 'DXB',
        departureAirportName: 'Dubai Intl',
        arrivalAirportCode: 'LHR',
        arrivalAirportName: 'Heathrow',
        date: '2025-01-14T00:00:00.000Z',
      },
    ]);
  });

  it('still returns own flights when the inbound lookup fails', async () => {
    db.flight.findFirst.mockResolvedValue({
      id: 'f1',
      aircraft: {},
      flightAwareData: { registration: 'A6-EOF', inboundFaFlightId: 'x' },
    });
    db.flight.findMany.mockResolvedValue([]);
    getFaFlightById.mockRejectedValue(new Error('429'));
    await expect(service.getAircraftHistory('f1', 'u1')).resolves.toEqual({
      registration: 'A6-EOF',
      inbound: null,
      ownFlights: [],
    });
  });
});

describe('FlightService.getAircraftRecent', () => {
  let service: FlightService;
  let fa: { searchFlightsByIdent: jest.Mock };

  const leg = (n: number) => ({
    ...faLeg,
    fa_flight_id: `leg-${n}`,
    scheduled_out: new Date(Date.UTC(2026, 10, n)).toISOString(),
  });

  beforeEach(() => {
    jest.clearAllMocks();
    fa = { searchFlightsByIdent: jest.fn() };
    service = new FlightService(
      { get: () => undefined } as any,
      fa as any,
      { getOrNil: () => null } as any,
    );
    db.flight.findFirst.mockResolvedValue({
      id: 'f1',
      aircraft: {},
      flightAwareData: { registration: 'A6-EPO' },
    });
  });

  it('404s for a flight the user does not own', async () => {
    db.flight.findFirst.mockResolvedValue(null);
    await expect(service.getAircraftRecent('f1', 'u1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });

  it('asks FlightAware by registration without the dash, cached 1h', async () => {
    fa.searchFlightsByIdent.mockResolvedValue({ flights: [leg(1)] });
    const legs = await service.getAircraftRecent('f1', 'u1');
    expect(fa.searchFlightsByIdent).toHaveBeenCalledWith(
      'A6EPO',
      'registration',
      3600,
    );
    expect(legs.map((l) => l.faFlightId)).toEqual(['leg-1']);
  });

  it('returns the 10 newest legs, newest first', async () => {
    fa.searchFlightsByIdent.mockResolvedValue({
      flights: Array.from({ length: 12 }, (_, i) => leg(i + 1)),
    });
    const legs = await service.getAircraftRecent('f1', 'u1');
    expect(legs).toHaveLength(10);
    expect(legs[0].faFlightId).toBe('leg-12');
    expect(legs[9].faFlightId).toBe('leg-3');
  });

  it('returns [] when FlightAware fails or there is no registration', async () => {
    fa.searchFlightsByIdent.mockRejectedValue(new Error('429'));
    await expect(service.getAircraftRecent('f1', 'u1')).resolves.toEqual([]);
    db.flight.findFirst.mockResolvedValue({
      id: 'f1',
      aircraft: {},
      flightAwareData: null,
    });
    await expect(service.getAircraftRecent('f1', 'u1')).resolves.toEqual([]);
  });
});
