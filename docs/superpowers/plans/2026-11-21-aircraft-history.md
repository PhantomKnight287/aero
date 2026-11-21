# Aircraft History Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Inbound-aircraft card, "you've flown this tail" list, on-demand recent legs of the tail, and an aircraft biography (registration country, age on the day) on the flight screen.

**Architecture:** Two new Nest endpoints on `FlightController` backed by `FlightAwareService.searchFlightsByIdent` (now with `ident_type`) and Prisma; pure mapping/TTL helpers with jest tests. Flutter: registry lookup utils (pure, tested), aircraft section extracted from `flight_info.dart` into its own token-based file, history cards fed by `HomeController`.

**Tech Stack:** NestJS, Prisma, Redis, jest (bun), openapi-generator dart-dio, Flutter, provider.

**Spec:** `docs/superpowers/specs/2026-11-21-aircraft-history-design.md`

## Global Constraints
- bun in `api/`. Use `bunx jest <file>`; `api/package.json` has the `src/` moduleNameMapper.
- New/extracted UI follows `app/DESIGN.md`; `flutter test` incl. `design_rules_test.dart` passes; regenerate the baseline when counts drop. Never run `dart format` on whole directories — only on files you changed and whose formatting you own.
- Visual check (DESIGN.md §7) of the aircraft section before claiming done.
- Never `git stash`.

## Review Focus
- Flight without registration / without inbound id → endpoint returns `{registration: null, inbound: null, ownFlights: []}`, cards hide. (Task 2 test)
- Another user's flight id → 404 on both endpoints. (Tasks 2, 3 tests)
- Inbound leg still airborne → cached ≤120 s; landed → 3600 s. (Task 1 test)
- Hex not in any block / malformed (`'ZZZ'`, `''`) → null, falls back to registration prefix; unknown prefix → no flag, no crash. (Task 5 test)
- FA error/429 on recent → endpoint returns `[]` with 200, app shows "Couldn't load recent flights" toast, button usable again. (Task 3 test)

---

### Task 1: FlightAware `ident_type` + adaptive inbound TTL

**Files:**
- Modify: `api/src/services/flightaware/flightaware.service.ts` (`searchFlightsByIdent`, ~433)
- Modify: `api/src/resources/flight/flight.service.ts` (`getFaFlightById`, ~384)
- Create: `api/src/resources/flight/aircraft-history.util.ts`
- Test: `api/src/resources/flight/aircraft-history.util.spec.ts`

**Interfaces:**
- Produces: `searchFlightsByIdent(ident: string, identType?: 'designator' | 'registration' | 'fa_flight_id', ttlSeconds?: number)` — appends `ident_type` when given; cache key `flightaware:search:${identType ?? 'any'}:${ident}`; TTL defaults to existing `cacheTTL`.
- Produces: `inboundCacheTtl(faFlight: any): number` → 3600 if `actual_on`/`actual_in` set or `cancelled`, else 120.
- `getFaFlightById` calls `searchFlightsByIdent(id, 'fa_flight_id')` and caches with `inboundCacheTtl(faFlight)`.
- [ ] Step 1: failing tests for `inboundCacheTtl` (airborne → 120; `actual_in` set → 3600; `cancelled: true` → 3600).
- [ ] Step 2: run `cd api && bunx jest src/resources/flight/aircraft-history.util.spec.ts` → FAIL (module missing).
- [ ] Step 3: implement util + service changes.
- [ ] Step 4: run → PASS; `bunx tsc --noEmit -p tsconfig.json` shows only the pre-existing auth.middleware.spec error.
- [ ] Step 5: commit `feat(api): ident_type on FlightAware lookups, adaptive inbound cache`.

### Task 2: `GET /v1/flight/:flightId/aircraft-history`

**Files:**
- Create: `api/src/resources/flight/entities/aircraft-history.entity.ts`
- Modify: `aircraft-history.util.ts`, `flight.service.ts`, `flight.controller.ts` (register `@Get(':flightId/aircraft-history')`)
- Test: `api/src/resources/flight/aircraft-history.spec.ts`

**Interfaces:**
- Produces entities: `AircraftLegEntity { faFlightId: string; identIata?: string; identIcao?: string; ident: string; originIata?: string; originIcao?: string; originCity?: string; originTimezone?: string; destinationIata?: string; destinationIcao?: string; destinationCity?: string; destinationTimezone?: string; status: string; scheduledOut?: string; estimatedOut?: string; actualOut?: string; scheduledIn?: string; estimatedIn?: string; actualIn?: string; arrivalDelay?: number; progressPercent?: number; cancelled: boolean }` (ISO strings); `AircraftHistoryEntity { registration: string | null; inbound: AircraftLegEntity | null; ownFlights: FlightSummaryEntity[] }` (reuse `FlightSummaryEntity` from profile stats).
- Produces: `toAircraftLeg(faFlight: any): AircraftLegEntity` (util, pure); `FlightService.getAircraftHistory(flightId: string, userId: string): Promise<AircraftHistoryEntity>`.
- [ ] Step 1: failing tests: `toAircraftLeg` maps a FA fixture (origin.code_iata, destination.city, arrival_delay, estimated_in…); service with mocked prisma/FA: not owned → `NotFoundException`; no FA data → `{registration: null, inbound: null, ownFlights: []}`; own flights query uses `{ userId, id: { not: flightId }, flightAwareData: { registration } }` ordered by `date desc`; inbound uses `getFaFlightById(inboundFaFlightId)`.
- [ ] Step 2: run → FAIL. Step 3: implement (own flights mapped like profile stats' flight summaries). Step 4: run → PASS.
- [ ] Step 5: commit `feat(api): aircraft history endpoint`.

### Task 3: `GET /v1/flight/:flightId/aircraft-recent`

**Files:** `flight.service.ts`, `flight.controller.ts`, test `aircraft-history.spec.ts`.
**Interfaces:** `FlightService.getAircraftRecent(flightId, userId): Promise<AircraftLegEntity[]>` — registration from FA data (fallback aircraft json `registration`); none → `[]`; `searchFlightsByIdent(reg.replace(/-/g, ''), 'registration', 3600)`; map with `toAircraftLeg`, sort by `scheduledOut` desc, take 10; FA throws → log + `[]`.
- [ ] Step 1: failing tests: not owned → 404; FA called with `('A6EPO', 'registration', 3600)` for `A6-EPO`; FA throws → `[]`; 12 legs → 10 newest.
- [ ] Step 2: FAIL. Step 3: implement. Step 4: PASS. Step 5: commit `feat(api): aircraft recent legs endpoint`.

### Task 4: Regenerate client

- [ ] Boot API once (`cd api && bun run start`, wait for `openapi.json` to contain `aircraft-history`, kill); `./generate-openapi-client.sh` → `Done!`; `grep -rn flightControllerGetAircraftHistoryV1 openapi/lib` hits. Commit `chore: regenerate openapi client`.

### Task 5: Registry lookups (Dart)

**Files:** Create `app/lib/utils/aircraft_registry.dart`; test `app/test/aircraft_registry_test.dart`.
**Interfaces:** `class RegistryCountry { final String iso2; final String name; }`; `RegistryCountry? countryFromHex(String? hex)` (ICAO 24-bit allocation blocks); `RegistryCountry? countryFromRegistration(String? reg)` (longest-prefix match on nationality marks, e.g. `VT-`, `A6-`, `N`, `G-`, `JA`, `EI-`, `HS-`); `String flagEmoji(String iso2)`; `RegistryCountry? registryCountry({String? hex, String? reg})` = hex first, then prefix.
- [ ] Step 1: failing tests: `89639F` → AE; `8005F0` → IN; `885170` → TH; `A31A7B` → US; `400F3C` → GB; `ZZZ`/`''`/null → null; `countryFromRegistration('JA381A')` → JP; `('EI-IKH')` → IE; `('XX-123')` → null; `flagEmoji('AE')` → '🇦🇪'.
- [ ] Step 2: FAIL. Step 3: implement (table of ICAO allocation blocks for at least the 60 largest civil registries + prefixes). Step 4: PASS. Step 5: commit `feat(app): aircraft registry country lookup`.

### Task 6: Extract + migrate aircraft section, biography

**Files:** Create `app/lib/screens/home/widgets/aircraft_section.dart`; modify `flight_info.dart` (replace the aircraft section + `_buildRegistrationHistoryCard`/`_buildRegistrationRow` with `AircraftSection(info: widget.info)`).
**Interfaces:** `AircraftSection({required FlightResponseEntity info, AircraftHistoryEntity? history, bool historyLoading, VoidCallback? onLoadRecent, List<AircraftLegEntity>? recent, bool recentLoading, void Function(String ident, DateTime date)? onOpenFlight})` — history params unused until Task 7.
- [ ] Step 1: move code verbatim, then convert to tokens (no behaviour change; payload list, photo, registration history keep their content). Add biography line: `<reg> · <flag> <country> · <type>`, `"<age> years old · <ageOnDay> on <d MMM yyyy>"` (age on day from `firstFlightDate ?? deliveryDate` vs `info.date`; hidden if neither).
- [ ] Step 2: regenerate baseline; `flutter test`; `flutter analyze` 0 errors.
- [ ] Step 3: visual check (golden preview of `AircraftSection` with fixture aircraft), delete preview.
- [ ] Step 4: commit `refactor(app): extract aircraft section onto design tokens, add biography`.

### Task 7: History cards + wiring

**Files:** `app/lib/services/main.dart` (`getAircraftHistory(String flightId)`, `getAircraftRecent(String flightId)`), `home_controller.dart` (state `aircraftHistory`, `recentLegs`, `recentLoading`; load history after `flightInfo` loads and on each refresh; `loadRecentLegs()`; clear on flight change), `aircraft_section.dart` (cards), `flight_info.dart` (pass props).
- Inbound card: `<ident IATA> <ORIG> → <DEST>` + status chip; "Arrives/Arrived <time> · <delay>"; red headline "Your aircraft lands at <DEST> <n> min late" when inbound arrival (actual ?? estimated ?? scheduled) > this flight's scheduled departure − 45 min. Tap → `onOpenFlight(identIata ?? identIcao ?? ident, scheduledOut)`.
- Own tail list: up to 5 rows (date, both idents, route) + "Show all (n)" expanding; tap → open.
- Recent: `AeroButton.secondary('Show recent flights of <reg>')` → loading state → rows; on `[]` after load: caption "No recent flights found"; on error: `showErrorToast`.
- [ ] Step 1: widget test `aircraft_section_test.dart`: given history with late inbound → red headline text present; `ownFlights` 7 → 5 rows + "Show all (7)"; tapping recent button calls `onLoadRecent`. FAIL → implement → PASS.
- [ ] Step 2: baseline/test/analyze. Step 3: visual check with fixture (inbound late, 3 own flights, recent list). Step 4: commit `feat(app): inbound aircraft, tail history and recent legs`.
