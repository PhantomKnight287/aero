import { Airport } from '@prisma/client';
import { FlightRow, StatsFlight } from './stats-flight';

export function makeAirport(o: Partial<Record<keyof Airport, unknown>> = {}): Airport {
  return {
    id: 'a1',
    ident: 'VIDP',
    type: 'large_airport',
    elevation: 777,
    continent: 'AS',
    isoCountry: 'IN',
    isoRegion: 'IN-DL',
    municipality: 'New Delhi',
    gpsCode: 'VIDP',
    iataCode: 'DEL',
    name: 'Indira Gandhi International Airport',
    lat: 28.5665,
    long: 77.1031,
    createdAt: new Date(0),
    updatedAt: new Date(0),
    ...o,
  } as unknown as Airport;
}

const side = (icao: string, iata: string, name: string, city: string, tz: string, lat: number, lon: number) => ({
  airport: { icao, iata, name, municipalityName: city, timeZone: tz, countryCode: icao.slice(0, 2), location: { lat, lon } },
  scheduledTime: { utc: '2025-06-01 10:00Z', local: '2025-06-01 15:30+05:30' },
});

/** Defaults: DEL -> DXB on 2025-06-01, no FlightAware data. */
export function makeFlightRow(o: Record<string, unknown> = {}): FlightRow {
  return {
    id: 'f1',
    flightNo: 'EK511',
    aircraft: {},
    airline: { name: 'Emirates', iata: 'EK', icao: 'UAE', image: null },
    departure: side('VIDP', 'DEL', 'Indira Gandhi International', 'New Delhi', 'Asia/Kolkata', 28.5665, 77.1031),
    arrival: side('OMDB', 'DXB', 'Dubai International', 'Dubai', 'Asia/Dubai', 25.2532, 55.3657),
    cargo: false,
    date: new Date('2025-06-01T10:00:00Z'),
    callSign: 'UAE511',
    createdAt: new Date(0),
    updatedAt: new Date(0),
    allFlightPositionsFetched: false,
    userId: 'u1',
    greatCircleDistance: null,
    flightAwareData: null,
    ...o,
  } as unknown as FlightRow;
}

const dxbAirport = { key: 'OMDB', icao: 'OMDB', iata: 'DXB', name: 'Dubai International', city: 'Dubai', isoCountry: 'AE', continent: 'AS', lat: 25.2532, lon: 55.3657 };

export function makeStatsFlight(o: Partial<StatsFlight> = {}): StatsFlight {
  return {
    id: 'f1',
    flightNo: 'EK511',
    airline: { key: 'UAE', name: 'Emirates', iata: 'EK', icao: 'UAE' },
    dep: { key: 'VIDP', icao: 'VIDP', iata: 'DEL', name: 'Indira Gandhi International', city: 'New Delhi', isoCountry: 'IN', continent: 'AS', lat: 28.5665, lon: 77.1031 },
    arr: dxbAirport,
    date: new Date('2025-06-01T10:00:00Z'),
    local: { year: 2025, month: 6, weekday: 0 },
    distanceKm: 2190,
    blockMinutes: 200,
    hasFa: false,
    cancelled: false,
    diverted: false,
    ...o,
  };
}
