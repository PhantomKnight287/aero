/**
 * Cache TTL for an inbound (previous-leg) FlightAware flight: short while it
 * can still change (ETA, delay), long once it has landed or was cancelled.
 */
export function inboundCacheTtl(faFlight: any): number {
  const settled =
    !!faFlight?.actual_on || !!faFlight?.actual_in || !!faFlight?.cancelled;
  return settled ? 3600 : 120;
}
