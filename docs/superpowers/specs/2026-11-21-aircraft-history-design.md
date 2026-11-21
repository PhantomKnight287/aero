# Aircraft history — design (approved 2026-11-21)

Covers idea 1 (inbound aircraft + previous flights on this tail) and 7 (aircraft biography).

## Intent
Know the airframe, not just the flight: where your plane is coming from right now (predicts your delay), when you've flown this exact tail before, what else it has been doing, and its life story.

## Decisions (user)
- Recent public flights of the tail: **behind a "Show recent flights" button** (FA calls only on demand).
- Approved design below, incl. `ident_type` on FA calls and the adaptive inbound cache.
- Process call (approved): extract `flight_info.dart`'s aircraft section into `aircraft_section.dart`, fully on tokens; rest of `flight_info.dart` migrates in #4/#5.

## API (Aero's own endpoints, `flight.controller.ts`; both scoped to the auth user's flight, 404 otherwise)
- `GET /v1/flight/:flightId/aircraft-history` → `{ registration, inbound, ownFlights }`
  - `inbound`: previous leg via FA `GET /flights/{inbound_fa_flight_id}?ident_type=fa_flight_id` (existing `getFaFlightById`). Cache **120 s while that leg hasn't arrived, 3600 s once landed/cancelled**. Null when no inbound id or FA has nothing.
  - `ownFlights`: user's flights whose `FlightAwareData.registration` equals this one's (indexed), excluding this flight, newest first. DB only.
- `GET /v1/flight/:flightId/aircraft-recent` → last ≤10 legs of the tail via FA `GET /flights/{registration}?ident_type=registration`, cached 1 h. Only called from the button.
- FA `/flights/{ident}` is the one FlightAware endpoint behind both; `ident_type` (designator | registration | fa_flight_id) disambiguates.

## App
- Aircraft area on the flight screen (`aircraft_section.dart`): existing photo/age/payload/registration history + new:
  - **Your aircraft** card: inbound leg route, status, arrival time (actual/estimated), delay; headline turns red when the inbound arrival is later than this flight's scheduled departure minus a 45 min turnaround.
  - Biography line: registration · flag + country (from hex via ICAO 24-bit allocation blocks; fallback registration prefix) · type; age now and age on the day you flew.
  - **You've flown this tail (n)** list.
  - **Show recent flights of <reg>** button → list of legs.
  - Tapping inbound / own / recent legs opens that flight (lookups add to the log — accepted behaviour from the delete-flight spec).
- Inbound card refreshes with the main flight. Cards hide when data is missing.
- Times and units via the units formatters; everything per `app/DESIGN.md`.

## Approaches
- **Two endpoints, history eager + recent on demand (picked)** — matches the button decision; history is cheap (cached FA call + DB).
- One endpoint with everything — rejected: would spend FA quota on every view.
- Inbound inside `GET /v1/flight` — rejected: slows the main load and couples refresh rates.

## Data notes
- Registration stored with dash (`A6-EPO`); 51 distinct regs / 55 rows. FA registration ident format to be verified on first real call (dash vs no dash).
- Hex comes through as `aircraft.modeS` (from `aircrafts.hex_icao`, 78/78 filled).

## Revision (approved 2026-11-21, after comparing with Flighty)
- Inbound card + recent list + own-flights list replaced by one **rotation timeline**: status chip + one-line summary on top; "This flight" → airport → inbound leg → airport → earlier legs (newest first, only legs before the inbound; future legs excluded); "Show earlier flights" at the end is the on-demand FA call (replaces "Show recent flights").
- Own flights become one row "You have N flights on <reg> ›" opening an `AeroSheet` ("Your history on <reg>").
- Chain rows keep max info: cities, IATA+ICAO, idents, local departure, arrival time, delay colour. API unchanged.
