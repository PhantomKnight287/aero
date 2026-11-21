import { FlightSummaryEntity } from 'src/resources/profile/entities/profile-stats.entity';
import { AircraftLegEntity } from './entities/aircraft-history.entity';

/**
 * Cache TTL for an inbound (previous-leg) FlightAware flight: short while it
 * can still change (ETA, delay), long once it has landed or was cancelled.
 */
export function inboundCacheTtl(faFlight: any): number {
  const settled =
    !!faFlight?.actual_on || !!faFlight?.actual_in || !!faFlight?.cancelled;
  return settled ? 3600 : 120;
}

const opt = (v: any) => (v === null || v === undefined ? undefined : v);

/** Map a raw FlightAware flight to the leg shape the app shows. */
export function toAircraftLeg(fa: any): AircraftLegEntity {
  return {
    faFlightId: fa.fa_flight_id,
    ident: fa.ident,
    identIata: opt(fa.ident_iata),
    identIcao: opt(fa.ident_icao),
    status: fa.status ?? '',
    originIata: opt(fa.origin?.code_iata),
    originIcao: opt(fa.origin?.code_icao),
    originCity: opt(fa.origin?.city),
    originTimezone: opt(fa.origin?.timezone),
    destinationIata: opt(fa.destination?.code_iata),
    destinationIcao: opt(fa.destination?.code_icao),
    destinationCity: opt(fa.destination?.city),
    destinationTimezone: opt(fa.destination?.timezone),
    scheduledOut: opt(fa.scheduled_out),
    estimatedOut: opt(fa.estimated_out),
    actualOut: opt(fa.actual_out),
    scheduledIn: opt(fa.scheduled_in),
    estimatedIn: opt(fa.estimated_in),
    actualIn: opt(fa.actual_in),
    arrivalDelay: opt(fa.arrival_delay),
    progressPercent: opt(fa.progress_percent),
    cancelled: !!fa.cancelled,
  };
}

/** Lightweight summary of a stored flight (same shape as profile stats). */
export function toFlightSummary(flight: any): FlightSummaryEntity {
  const dep = flight.departure as any;
  const arr = flight.arrival as any;
  const airline = flight.airline as any;
  return {
    id: flight.id,
    flightNo: flight.flightNo,
    callSign: flight.callSign,
    airline: {
      name: airline?.name ?? '',
      iata: airline?.iata ?? '',
      icao: airline?.icao,
      image: airline?.image ?? undefined,
    },
    departureAirportCode: dep?.airport?.iata || dep?.airport?.icao || '',
    departureAirportName: dep?.airport?.name || dep?.airport?.shortName || '',
    arrivalAirportCode: arr?.airport?.iata || arr?.airport?.icao || '',
    arrivalAirportName: arr?.airport?.name || arr?.airport?.shortName || '',
    date: flight.date.toISOString(),
  };
}
