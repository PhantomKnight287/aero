# Aircraft history — design (draft)

Covers idea 1 (inbound aircraft + previous flights on this tail) and 7 (aircraft biography).

## Intent
Know the airframe, not just the flight: where your plane is coming from right now (predicts your delay), when you've been on this exact tail before, and its life story.

## Goals
1. **Inbound aircraft card** on flight detail: the previous leg of this airframe via `FlightAwareData.inboundFaFlightId` — ident, origin → destination, status, ETA / actual arrival, delay. Line like "Your aircraft lands at BOM 35 min late".
2. **"You've flown this tail" list**: user's own flights where `FlightAwareData.registration` matches (indexed). Shows date, flight no, route. Tap opens that flight.
3. **Recent flights of this tail (public)**: FlightAware flights for the registration (`searchFlightsByIdent(registration)` already exists), last ~10 legs.
4. **Biography additions** to the existing aircraft section / Registration History card (`flight_info.dart:1057`):
   - Age on the day you flew (`firstFlightDate` or `deliveryDate` vs flight date).
   - Country of registration from hex ICAO 24-bit address block (static allocation table) + flag.
   - Reg prefix → country flag (VT- India, A6- UAE, N USA…) as fallback when hex missing.

## Non-goals
- Live position of inbound aircraft on map (maybe later).
- Fleet siblings.

## Approaches
- **New endpoint `GET /v1/flight/:flightId/aircraft-history` returning `{ inbound, ownFlights, recentFlights }` (picked).** One call, server caches FA responses in Redis (pattern exists: "Get a faFlight via Redis cache").
- Three separate endpoints — rejected: three round trips for one card stack.
- Fetch inbound inside existing `GET /v1/flight` — rejected: slows the main flight load and spends FA quota on every view.

## Constraints
- FlightAware has a rate limiter (`checkRateLimit`) and costs per call. Cache inbound for ~5 min while active, recentFlights for ~1 h.
- 47/108 flights have a registration; card hides when missing.

## Data
- Hex → country table: static TS map in `api/src/common/` (ICAO Annex 10 allocation ranges). Pure function + unit test.
- Reg prefix → country: static map, same file.

## Open (ask when we reach this)
- Is the public recent-flights list (costs FA calls) worth it, or only inbound + own flights?
- Should inbound card auto-refresh like the main flight (refresh countdown exists)?

## Left to builder
Card layout (reuse existing card/chip patterns), cache TTLs within the ranges above.
