# Flight Detail Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the flight detail sheet in Flighty's order and grouping, keeping every piece of data, on Aero's design system.

**Architecture:** The API adds `aircraftTypeName` to the flight response and a route-history endpoint. The app splits `flight_info.dart` into section widgets under `screens/home/widgets/flight_detail/`. The status/time logic lives in one pure, unit-tested file. Existing migrated widgets are reused.

**Tech Stack:** NestJS + Jest (bun), openapi-generator Dart client, Flutter.

**Spec:** `docs/superpowers/specs/2026-11-24-flight-detail-redesign-design.md`

## Global Constraints
- Every piece of data visible today stays. Airport conditions move to the existing airport sheet, reached by tapping an airport row or the weather row.
- Late means more than 15 min (`> 15`), everywhere. Big times use gate times (`actualOut`/`actualIn`, then `estimatedOut`/`estimatedIn` or the stored `revisedTime`, then scheduled).
- No FlightAware Foresight or predicted times. `predictedTime` is no longer used for display.
- Age and photo keep their slots: "No photo yet" placeholder, "Age unknown" when missing or 0.
- UI uses `app/lib/ui` tokens and components only. No `PopupMenuButton`, `SnackBar`, `ListTile`, `Gap`, `Theme.of(context)` colours, or raw sizes. Toasts come from `utils/error.dart`.
- `dart format` only files you own. Regenerate `test/design_baseline.json` once `flight_info.dart` (and `flight_route_info.dart`, if deleted) leave it.
- API tests run with `cd api && bunx jest <path>`. Regenerate the Dart client after API changes. Don't kill a server you didn't start: a second `nest start` writes `openapi.json` before it fails on the port.

## Review Focus
- A flight with no FlightAware data (old lookup): the band, route block and timetable still render from the stored times, with no crash or empty band. (Task 3 test.)
- A cancelled flight: red band "Cancelled", times struck through, no "departed … ago". (Task 3 test.)
- A diverted flight with a `destinationCodeIata` that differs from the planned arrival: the arrival side shows the actual airport with "planned PHX". (Task 3 test.)
- An overnight or timezone-crossing arrival: the arrival big time is in the arrival airport's local time, and the "arrives in" text is correct. (Task 3 test.)
- A route history that would include the open flight: the open flight is excluded and the counts drop by one. (Task 1 test.)

---

### Task 1: API — type name and route history

**Files:**
- Modify: `api/src/resources/flight/entities/flight.entity.ts` (`FlightResponseEntity.aircraftTypeName?: string`; new `RouteHistoryEntity`), `api/src/resources/flight/flight.controller.ts` (`getFlight` adds `aircraftTypeName`; new `@Get('route-history')` placed **before** `@Get()` and any `:flightId` routes), `api/src/resources/flight/flight.service.ts` (`getRouteHistory`)
- Test: `api/src/resources/flight/route-history.spec.ts` (mock `src/db` like `flight-history.spec.ts`)

**Interfaces:**
- `aircraftTypeName = TYPE_NAMES[flightAwareData.aircraftType]` (from `src/resources/profile/stats/families`), otherwise undefined.
- `RouteHistoryEntity { flightCount: number; distanceKm: number; blockMinutes: number; recent: StatsFlightSummaryEntity[] }`.
- `GET /v1/flight/route-history?dep=<code>&arr=<code>&exclude=<flightId>`:
  - `dep`/`arr` match a flight's `dep.icao`, `dep.iata` or `dep.key` (same for `arr`), in that direction only.
  - `exclude` is optional.
  - `recent` holds the 3 newest, mapped with `toFlightSummary`.
- `FlightService.getRouteHistory(userId, dep, arr, exclude?): Promise<RouteHistoryEntity>`, built from `loadCountedFlights(userId, new Date())`.

- [ ] **Step 1: Failing tests** (`route-history.spec.ts`), with fixture rows via `makeFlightRow`:
  - `direction`: VIDP→OMDB ×2 and OMDB→VIDP ×1. A query for `dep=VIDP&arr=OMDB` gives `flightCount 2`.
  - `iata or icao`: `dep=DEL&arr=DXB` gives the same 2.
  - `exclude`: excluding one id gives `flightCount 1`, and `recent` doesn't contain that id.
  - `recent newest first, max 3`: 5 flights give 3 ids, newest first. `distanceKm` and `blockMinutes` are sums over all 5.
  - `empty`: an unknown route gives `{ flightCount 0, distanceKm 0, blockMinutes 0, recent [] }`.
- [ ] **Step 2:** `cd api && bunx jest src/resources/flight/route-history.spec.ts` → FAIL.
- [ ] **Step 3:** Implement the service, entity and controller route. Add `aircraftTypeName` in `getFlight`'s return value (`{ ...flight, aircraftTypeName }`).
- [ ] **Step 4:** `cd api && bunx jest src/resources/flight/route-history.spec.ts src/resources/flight/flight-history.spec.ts src/resources/profile` → PASS.
- [ ] **Step 5:** Commit `feat(api): route history and aircraft type name`.

### Task 2: Regenerate the Dart client
- [ ] **Step 1:** Write `openapi.json` (second `nest start`, or the user's running server after a restart), then `./generate-openapi-client.sh`.
- [ ] **Step 2:** `grep -c RouteHistoryEntity api/openapi.json` ≥ 1, and `FlightResponseEntity` has `aircraftTypeName`. `ProfileApi`/`FlightApi` gains `flightControllerGetRouteHistory`.
- [ ] **Step 3:** Commit `chore(app): regenerate client for flight detail`.

### Task 3: Pure status model

**Files:**
- Create: `app/lib/screens/home/widgets/flight_detail/flight_status.dart`, `app/test/flight_status_test.dart`

**Interfaces (Produces):**
```dart
enum Punctuality { early, onTime, late, cancelled }   // late = > 15 min
enum FlightPhase { scheduled, boardingSoon, taxiingOut, inFlight, landed, arrived, cancelled, diverted }

class SideTimes {          // one per side, in that airport's tz
  final tz.TZDateTime scheduled;
  final tz.TZDateTime best;        // actual > estimated/revised > scheduled
  final bool isActual;
  final int delayMinutes;          // best - scheduled, rounded
  Punctuality get punctuality;
}

class FlightStatus {
  final FlightPhase phase;
  final SideTimes departure, arrival;
  final Punctuality overall;       // from arrival; cancelled wins
  final String? divertedToIata;    // FA destinationCodeIata when diverted and != planned
  String bandText(DateTime now);   // 'Departs in 3h 12m', 'Boarding soon', 'Taxiing', 'In flight · lands in 40m', 'Landed 12m ago', 'Arrived at gate', 'Cancelled', 'Diverted to XXX'
  String sideLine(bool departure, DateTime now); // '7m late · departed 2h 10m ago' | '3m early · arrives in 4h 13m' | 'On time · in 2h'
}

FlightStatus flightStatus(FlightResponseEntity f, DateTime now);
```
Rules:
- Phase:
  - cancelled → `cancelled`;
  - diverted → `diverted`;
  - `actualIn` set → `arrived`;
  - `actualOn` set → `landed`;
  - `actualOff` set → `inFlight`;
  - `actualOut` set → `taxiingOut`;
  - now within 40 min before scheduled out → `boardingSoon`;
  - otherwise `scheduled`.
- Without FlightAware data, use the stored `revisedTime` (or `scheduledTime`) against `now`: before departure → `scheduled` / `boardingSoon`; between departure and arrival → `inFlight`; after arrival → `arrived`.
- Durations use `formatDurationShort` from `utils/flight_timing.dart`.

- [ ] **Step 1: Failing tests** (`flight_status_test.dart`), with a fixture builder for `FlightResponseEntity` with optional FlightAware times:
  - one test per phase, checking `bandText` exactly (for example `In flight · lands in 40m`);
  - late cutoff: arrival 15 min late → `onTime`, 16 min → `late`;
  - gate time beats runway time: `actualOut` 9:42 with `actualOff` 9:52 → departure `best` 9:42, `delayMinutes` 7 against 9:35;
  - no FlightAware data, now between stored times → `inFlight`, `isActual` false;
  - cancelled → `overall` `cancelled`, `sideLine` contains no "ago";
  - diverted to `TUS` (planned PHX) → `divertedToIata` `'TUS'`, `bandText` `Diverted to TUS`;
  - tz: arrival in `America/Phoenix`, scheduled 11:40 local, `best.hour` 12 when `actualIn` is 19:06Z (MST is UTC−7).
- [ ] **Step 2:** `cd app && flutter test test/flight_status_test.dart` → FAIL.
- [ ] **Step 3:** Implement.
- [ ] **Step 4:** PASS.
- [ ] **Step 5:** Commit `feat(app): flight status model`.

### Task 4: Flight detail sections + rewrite

**Files:**
- Create under `app/lib/screens/home/widgets/flight_detail/`:
  - `header.dart` (header plus the ⋮ action sheet);
  - `status_band.dart`;
  - `route_block.dart`;
  - `good_to_know.dart`;
  - `route_history.dart`;
  - `booking_section.dart`;
  - `airline_section.dart`.
- Rewrite: `app/lib/screens/home/widgets/flight_info.dart`. Keep the class name `FlightInfoWidget` and its constructor, plus a new `onAirportTap: void Function(AirportEntity)?` and `routeHistory`/`onLoadRouteHistory` (or `FutureBuilder` on the service).
- Modify:
  - `app/lib/screens/home/widgets/aircraft_section.dart`: title = `info.aircraftTypeName ?? aircraft.model`, subtitle = the FlightAware type code; "No photo yet" placeholder; "Age unknown".
  - `app/lib/screens/home/widgets/flight_timetable.dart`: Scheduled and Actual columns.
  - `app/lib/screens/home/main.dart`: pass `onAirportTap: _showAirportDetailsSheet` (it takes `AirportEntity`; map `RouteAirportEntity` to it the way `main.dart` already does for map taps, or widen the callback type).
  - `app/lib/ui/tokens.dart`: big-time token, plus band tints if the existing success, danger and warn tints aren't enough.
  - `app/lib/services/`: a route-history fetch (follow `services/profile.dart`).
- Delete: `flight_route_info.dart`, if nothing else imports it (only `flight_info.dart` does today).
- Tests: `app/test/flight_detail_test.dart`; update `aircraft_section_test.dart` and `flight_timetable_test.dart` if they assert old text.

**Interfaces:** consumes `flightStatus()` from Task 3 and `RouteHistoryEntity` / `aircraftTypeName` from Task 2.

Fixed copy and behaviour:
- **Header:**
  - kicker `'${identIata} · ${identIcao} · ${EEE d MMM}'.toUpperCase()`, in departure-local time;
  - title `'${depCity} to ${arrCity}'`;
  - `'also sold as AA 1234, BA 5678'` from `codesharesIata`, falling back to `codesharesIcao`, shown only when non-empty.
- **⋮ action sheet:** opens an `AeroSheet` with six rows, in this order: Refresh tracking (only if the callback is set), Refresh flight data, Send to wearable, Get alerts, Booking details, Share. The send-to-wearable payload and the alerts and share code move over unchanged. Their `SnackBar`s become `showSuccessToast` / `showErrorToast`.
- **Band:** `flightStatus.bandText`. The tint is success for on time or early, warn for late, danger for cancelled or diverted. The ">7 days old" caption reads `'Older than 7 days — times may no longer update.'`.
- **Route block:**
  - airport rows `'STL · KSTL · St Louis Lambert Intl'`, with a chevron, tapping `onAirportTap`;
  - big time `HH:mm` (respecting `alwaysUse24HourFormat`), coloured success (early or on time), warn (late) or danger (cancelled);
  - scheduled time struck through, only when it differs;
  - `sideLine` under it;
  - gate chip `'↗ E4'` / `'↘ B28'` (`'--'` when unknown), with `'Terminal 2'` under it;
  - arrival baggage chip `'Belt 7'` when known;
  - the middle line `'3h 24m · 2,428 km'` (distance via `UnitCycle`).
- **Good to know rows:**
  - timezone shift;
  - weather `'STL 6°C · Clear'` and `'PHX 16°C · Partly cloudy'`, from `airport.conditions.observation` (`tempAir` + `conditions` or `cloudFriendly`), each tapping its airport sheet;
  - a delay row only when a delay is non-zero: `'PHX arrivals delayed ~25m'` plus the cause.
- **Route history section:**
  - title "My history on this route", subtitle `'LAX → JFK'`;
  - three figures (flights, distance via `UnitCycle`, time `formatLongDuration`);
  - up to 3 `PastFlightRow`s, each calling `onOpenFlight`;
  - hidden when `flightCount == 0` or while the request fails.
- **Booking section:** title "Booking". Token-styled rows for code, seat with type, class and reason.
- **Airline section:** title = airline name, then `'DL · DAL'` and the callsign when known (`callSign`).
- **Order:** header, band, route block, good to know, timetable, profile, aircraft, route history, booking, airline, Jet2 line.

- [ ] **Step 1: Failing widget tests** (`flight_detail_test.dart`, using a Task 3 fixture builder that also sets airports with conditions):
  - the sections appear in the order above (`tester.getTopLeft(find.text(...)).dy` increasing): band text, `'Good to know'`, `'Timetable'`, the aircraft title, `'My history on this route'`, `'Booking'`;
  - a late departure: the big time's `TextStyle.color == AeroColors.warn`, and a struck-through scheduled time is present;
  - an unknown gate shows `'--'`;
  - ⋮ opens a sheet listing the six action labels;
  - tapping the departure airport row calls `onAirportTap` with `STL`;
  - weather row text `'STL 6°C · Clear'` (°C units);
  - no "Delay 0m" or "Cause: None" text when the delay is 0;
  - route history: hidden at 0 flights, shown with `'2 flights'` at 2;
  - aircraft: title `'Boeing 737 MAX 8'` from `aircraftTypeName`; `'No photo yet'` and `'Age unknown'` when the image and age are null;
  - the Review Focus cases: no FlightAware data, cancelled, diverted (`'planned PHX'`), tz arrival.
- [ ] **Step 2:** `cd app && flutter test test/flight_detail_test.dart` → FAIL.
- [ ] **Step 3:** Implement the sections, rewrite `flight_info.dart`, apply the modifications and the wiring, delete `flight_route_info.dart`.
- [ ] **Step 4:** `cd app && flutter test` → all pass. Then `UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart` and run the suite again.
- [ ] **Step 5:** Commit `feat(app): flight detail redesign`.

### Task 5: Visual check
- [ ] **Step 1:** Throwaway golden of `FlightInfoWidget` (in flight, late, with conditions, booking and history) with real fonts. Compare against the Flighty screenshots. Delete the test.
- [ ] **Step 2:** On the phone with the API running, open an in-flight and a landed flight. Check the band, route block, airport-sheet tap, ⋮ sheet and history. Screencap each.
- [ ] **Step 3:** Commit `fix(app): flight detail polish` and update `docs/superpowers/HANDOFF.md`.
