# Stats Passport — Part 1 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the legacy stats screen with the Passport hub and the flight stats report. This includes a paged past-flights list, the passport header (map, flags, summary strip), the runway log, taxi times by airport, extremes, and correct airport and airline counts.

**Architecture:**
- **Server:** loads the user's flights once, normalises each into a `StatsFlight` (airport metadata from the `airports` table, local dates, block, air and taxi times, delays), then runs pure section functions. `GET /v1/profile/@me?year=` returns all sections. `GET /v1/flight/history` pages the log.
- **App:** draws only. A `StatsController` (ChangeNotifier) holds the year, the stats and the history pages. The hub and the report are new widget files under `app/lib/screens/profile/stats/`.

**Tech Stack:**
- NestJS + Prisma (bun, Jest);
- Flutter, with the openapi dart-dio generated client, `flutter_map` 8, `latlong2`, `go_router` and `provider`.

**Spec:** `docs/superpowers/specs/2026-11-22-stats-passport-design.md`. Read it first; this plan only covers its "Build order → 1".

## Global Constraints
- **UI components:** use `app/lib/ui/` tokens and components only. No `AlertDialog`, `SnackBar`, raw colours, raw radii, raw font sizes or `fl_chart`. Charts are a `CustomPainter`, with no text on the plot.
- **Accent colours:** only on stats cards and stats charts. DESIGN.md gains the rule "Report accent colours are allowed only on stats cards and stats charts."
- **White background everywhere.** No dark theme.
- **Tappable things show an affordance** (pill, chevron or verb). There are no Share buttons in this project.
- **Tabular figures** (`AeroText.tabular`) on numbers, but not on registrations or type names.
- **Counted flights:** every log flight except a `date` after now and FlightAware `cancelled`. Diverted flights count.
- **Block time:**
  1. FlightAware `actualIn − actualOut`;
  2. otherwise the stored JSON `departure`/`arrival` times (actualTime → revisedTime → scheduledTime, `.utc`);
  3. otherwise `distanceKm / 800 * 60`.

  Delays are never added.
- **Long haul:** `blockMinutes > 360`.
- **Domestic:** both airports have the same ISO country (from the `airports` table). Flights with an unknown country are counted as neither domestic nor international.
- **Delayed:** arrival delay over 15 minutes.
  - Arrival delay = `arrivalDelay / 60`, else `(actualIn − scheduledIn)` in minutes.
  - Departure delay = `departureDelay / 60`, else `(actualOut − scheduledOut)` in minutes.
- **Taxi times:** taxi-out = `actualOff − actualOut`, taxi-in = `actualIn − actualOn`. Only when both ends are actual times.
- **Unique keys:**
  - airport: ICAO if present, else IATA;
  - airline: ICAO, else IATA, else name.

  Never put two codes for the same thing into one set.
- **Year:** a flight's year, month and weekday come from `date` in the departure airport's IANA `timeZone` (stored JSON `departure.airport.timeZone`, falling back to `UTC`). Weekday: 0 = Sunday … 6 = Saturday.
- **Continent buckets:** `asia`, `europe`, `north_america`, `middle_east`, `oceania`, `africa`, `central_america`, `caribbean`, `south_america`.
- **API:**
  - use bun; run tests with `cd api && bunx jest <path>`;
  - never `git stash`;
  - never `dart format` whole directories, only the files you own;
  - leave `api/dump.rdb`, `app/analysis_options.yaml`, `app/pubspec.lock`, `api/scripts/`, `.superpowers/` and `.claude/settings.local.json` uncommitted.
- **Branch:** `feat/stats-passport` off `main`.

## Review Focus
1. **A year with zero flights, or an empty log:** every section returns empty lists or nulls and zero counts. There's no `NaN` and no division by zero, and the app shows an empty state instead of crashing. (Test: Task 2 `empty input`, Task 9 `hub renders empty stats`.)
2. **A flight whose airport isn't in the `airports` table** (no country, coordinates or elevation): it still counts in flights, distance and airlines. It is skipped in countries, the map, extremes and domestic/international. (Test: Task 1 `unknown airport`, Task 3 `countries skip unknown`.)
3. **A flight at 00:30 local on 1 January:** it belongs to the new year even though UTC is still 31 December. (Test: Task 1 `local new year`.)
4. **Routes crossing the antimeridian** (HNL → NRT): the arc takes the short way across the Pacific, not across Africa. (Test: Task 8 `great circle crosses antimeridian`.)
5. **History paging when several flights share the same `date`:** no row is skipped or repeated across pages. (Test: Task 6 `stable cursor on equal dates`.)

---

### Task 1: Normalise flights for stats

**Files:**
- Create: `api/src/resources/profile/stats/stats-flight.ts`
- Create: `api/src/resources/profile/stats/airport-index.ts`
- Create: `api/src/resources/profile/stats/fixtures.ts`, holding `makeFlightRow(overrides)` and `makeAirport(overrides)` test builders. They are reused by Tasks 2–6.
- Test: `api/src/resources/profile/stats/stats-flight.spec.ts`

**Interfaces:**
- Produces:

```ts
export interface StatsAirport { key: string; iata?: string; icao?: string; name: string; city: string;
  isoCountry?: string; continent?: string; lat?: number; lon?: number; elevationFt?: number; }
export interface StatsAirline { key: string; name: string; iata?: string; icao?: string; image?: string; }
export interface StatsFlight {
  id: string; flightNo: string; identIata?: string; identIcao?: string; faFlightId?: string;
  airline: StatsAirline; dep: StatsAirport; arr: StatsAirport; date: Date;
  local: { year: number; month: number /*1-12*/; weekday: number /*0=Sun*/ };
  distanceKm: number; blockMinutes: number; airMinutes?: number;
  taxiOutMin?: number; taxiInMin?: number; arrivalDelayMin?: number; departureDelayMin?: number;
  hasFa: boolean; cancelled: boolean; diverted: boolean; runwayOff?: string; runwayOn?: string;
}
export type AirportIndex = Map<string, Airport>; // keys 'I:<iata>' and 'C:<icao>' (Prisma Airport)
export function normalizeFlight(row: FlightRow, airports: AirportIndex): StatsFlight;
export function isCounted(f: StatsFlight, now: Date): boolean; // !cancelled && date <= now
export async function loadAirportIndex(codes: { iata?: string; icao?: string }[]): Promise<AirportIndex>;
// FlightRow = Prisma Flight & { greatCircleDistance; flightAwareData }
```

- [ ] **Step 1: Write failing tests in `stats-flight.spec.ts`**
  - `block time prefers FA gate times`: FA `actualOut 10:00Z`, `actualIn 12:30Z` → `blockMinutes 150`.
  - `block time falls back to stored JSON then distance`: no FA, `departure.actualTime.utc 10:00Z`, `arrival.scheduledTime.utc 11:00Z` → `60`. With no times and `distanceKm 800` → `60`.
  - `taxi needs both actual ends`: `actualOut` + `actualOff` 18 min apart → `taxiOutMin 18`. Without `actualOn` → `taxiInMin undefined`.
  - `arrival delay from seconds else times`: `arrivalDelay 1800` → `30`. Null, with `scheduledIn 12:00Z` and `actualIn 12:20Z` → `20`.
  - `airport metadata from index`: a dep with ICAO `VIDP`, where the index holds `makeAirport({ gpsCode:'VIDP', isoCountry:'IN', continent:'AS' })` → `dep.isoCountry 'IN'`, `dep.key 'VIDP'`.
  - `unknown airport`: codes not in the index → `isoCountry undefined`, `lat undefined`, `key` = the stored ICAO.
  - `distance falls back to haversine`: no `greatCircleDistance`, index coordinates DEL (28.5665, 77.1031) to DXB (25.2532, 55.3657) → within 10 km of 2,190.
  - `local new year`: `date 2025-12-31T19:00:00Z`, dep `timeZone 'Asia/Kolkata'` → `local.year 2026`, `month 1`, `weekday 4` (Thursday).
  - `isCounted`: cancelled → false; `date` tomorrow → false; diverted → true.
- [ ] **Step 2: Run** `cd api && bunx jest src/resources/profile/stats/stats-flight.spec.ts`. Expected: FAIL, module not found.
- [ ] **Step 3: Implement `stats-flight.ts` and `airport-index.ts`**
  - Local dates: use `Intl.DateTimeFormat('en-US', { timeZone, year:'numeric', month:'numeric', weekday:'short' })` with `formatToParts`.
  - Haversine with R = 6371 km.
  - `loadAirportIndex`: one `prisma.airport.findMany({ where: { OR: [{ iataCode: { in } }, { gpsCode: { in } }, { ident: { in } }] } })`. Index each row under `I:iataCode`, `C:gpsCode` and `C:ident`.
- [ ] **Step 4: Run** the same command. Expected: PASS.
- [ ] **Step 5: Commit** `git add api/src/resources/profile/stats && git commit -m "feat(api): normalise flights for stats"`

### Task 2: Passport, per-period counts, records, delay summary

**Files:**
- Create: `api/src/resources/profile/stats/sections/core.ts`
- Test: `api/src/resources/profile/stats/sections/core.spec.ts`

**Interfaces:**
- Consumes: `StatsFlight` from Task 1, and the fixtures (build `StatsFlight`s with a `makeStatsFlight(overrides)` helper; add it to `fixtures.ts`).
- Produces:

```ts
export function passport(fs: StatsFlight[]): {
  totalFlights; totalDistanceKm; blockMinutes; airMinutes; airBasedOn; taxiMinutes; taxiBasedOn;
  totalAirports; totalAirlines; totalCountries; domestic; international; longHaul } // all numbers
export function flightsPer(fs: StatsFlight[]): { year: { year: number; count: number }[]; month: number[] /*12*/; weekday: number[] /*7*/ };
export interface StatsRecord { flight: StatsFlight; value: number }
export function records(fs: StatsFlight[]): { shortestDistance: StatsRecord|null; longestDistance: StatsRecord|null;
  shortestDuration: StatsRecord|null; longestDuration: StatsRecord|null };
export function delaySummary(fs: StatsFlight[]): { basedOn; arrivedCount; delayedCount; minutesLost; avgDelayMinutes };
```

- [ ] **Step 1: Write failing tests**
  - `empty input`: every function on `[]` returns zeros, empty arrays or nulls. `month` has length 12 and `weekday` length 7, all zeros. `avgDelayMinutes` is 0.
  - `counts unique by one key`: two flights on the same airline, one stored with IATA+ICAO `EK/UAE`, one with only ICAO `UAE`. DEL→DXB and DXB→DEL → `totalAirlines 1`, `totalAirports 2`. Regression for 80/177.
  - `domestic vs international vs long haul`: DEL→BOM IN/IN 130 min; DEL→LHR IN/GB 540 min; and one with an unknown country → `domestic 1`, `international 1`, `longHaul 1`.
  - `air and taxi basedOn`: of 3 flights, 2 have `airMinutes` → `airBasedOn 2`.
  - `records pick extremes`: distances 228 and 15594 → `shortestDistance.value 228`, `longestDistance.value 15594`.
  - `delay summary`: arrival delays `[-10, 5, 20, 90]` plus one without FA → `basedOn 4`, `arrivedCount 4`, `delayedCount 2`, `minutesLost 110`, `avgDelayMinutes 55`.
- [ ] **Step 2: Run** `bunx jest src/resources/profile/stats/sections/core.spec.ts`. Expected: FAIL.
- [ ] **Step 3: Implement** the four functions in `core.ts`. `totalCountries` counts distinct dep/arr `isoCountry`, ignoring undefined. `flightsPer.year` is sorted ascending.
- [ ] **Step 4: Run** the tests. Expected: PASS.
- [ ] **Step 5: Commit** `feat(api): passport, period, record and delay summary stats`

### Task 3: Top lists, countries, continents, map

**Files:**
- Create: `api/src/resources/profile/stats/sections/places.ts`
- Create: `api/src/resources/profile/stats/regions.ts`
- Test: `api/src/resources/profile/stats/sections/places.spec.ts`

**Interfaces:**
- Produces:

```ts
export function topAirports(fs): { airport: StatsAirport; departures: number; arrivals: number; flightCount: number; distanceKm: number }[]; // sorted by flightCount desc, then key
export function topAirlines(fs): { airline: StatsAirline; flightCount: number; distanceKm: number }[];
export function topRoutes(fs): { from: StatsAirport; to: StatsAirport; flightCount: number; distanceKm: number }[]; // directional
export function countries(fs): { isoCountry: string; name: string; flightCount: number }[]; // name via new Intl.DisplayNames(['en'],{type:'region'})
export function continents(fs): { bucket: ContinentBucket; countryCount: number; flightShare: number /*0-1*/ }[]; // all 9 buckets, fixed order
export function mapData(fs): { airports: { iata?: string; icao?: string; lat: number; lon: number }[];
  routes: { fromLat; fromLon; toLat; toLon; count }[] }; // routes undirected + unique
// regions.ts
export type ContinentBucket = 'asia'|'europe'|'north_america'|'middle_east'|'oceania'|'africa'|'central_america'|'caribbean'|'south_america';
export function continentBucket(isoCountry: string, ourAirportsContinent: string): ContinentBucket;
```

- [ ] **Step 1: Write failing tests**
  - `top airports count dep and arr`: DEL→DXB and DXB→DEL → DXB `departures 1`, `arrivals 1`, `flightCount 2`. `distanceKm` sums both legs.
  - `routes are directional`: DEL→LHR ×2 and LHR→DEL ×1 → two rows, counts 2 and 1.
  - `countries skip unknown`: one unknown-country airport is not listed. `IN` → name `India`.
  - `continent buckets`: `continentBucket('AE','AS')` → `middle_east`; `('MX','NA')` → `central_america`; `('JM','NA')` → `caribbean`; `('US','NA')` → `north_america`; `('IN','AS')` → `asia`. `continents()` always returns 9 rows, in the order of the type union.
  - `map routes undirected`: DEL→LHR plus LHR→DEL → one route with `count 2`. Airports without coordinates are excluded.
- [ ] **Step 2: Run** `bunx jest src/resources/profile/stats/sections/places.spec.ts`. Expected: FAIL.
- [ ] **Step 3: Implement**
  - In `regions.ts`, use static ISO lists:
    - `MIDDLE_EAST = AE BH CY EG IL IQ IR JO KW LB OM PS QA SA SY TR YE`;
    - `CENTRAL_AMERICA = BZ CR GT HN MX NI PA SV`;
    - `CARIBBEAN = AG AI AW BB BL BQ BS CU CW DM DO GD GP HT JM KN KY LC MF MQ MS PR SX TC TT VC VG VI`.
  - Otherwise map the OurAirports continent: `AS→asia`, `EU→europe`, `NA→north_america`, `OC→oceania`, `AF→africa`, `SA→south_america`. Unknown codes map to `asia` only if nothing else matches. Never throw.
- [ ] **Step 4: Run** the tests. Expected: PASS.
- [ ] **Step 5: Commit** `feat(api): top lists, countries, continents and map stats`

### Task 4: Runway log, taxi by airport, extremes

**Files:**
- Create: `api/src/resources/profile/stats/sections/ops.ts`
- Test: `api/src/resources/profile/stats/sections/ops.spec.ts`

**Interfaces:**
- Produces:

```ts
export function runways(fs): { basedOn: number; items: { airport: StatsAirport; runway: string; departures: number; arrivals: number }[] }; // sorted by departures+arrivals desc
export function taxiByAirport(fs): { basedOn: number; items: { airport: StatsAirport; avgTaxiOutMin: number|null; taxiOutCount: number;
  avgTaxiInMin: number|null; taxiInCount: number }[]; longest: StatsRecord|null }; // longest = max(taxiOut, taxiIn) single flight
export function extremes(fs): { north; south; east; west; highest: StatsAirport|null };
```

- [ ] **Step 1: Write failing tests**
  - `runways split off and on`: DEL `runwayOff 29R` ×2, plus an arrival into DEL `runwayOn 29R` ×1 → item DEL/29R with `departures 2`, `arrivals 1`. `basedOn` = number of flights with either runway.
  - `taxi averages per airport`: DEL taxi-out of 20 and 30 → `avgTaxiOutMin 25`, `taxiOutCount 2`. An airport with only taxi-in has `avgTaxiOutMin null`. `longest.value` is the largest single taxi.
  - `extremes`: airports with latitudes 64.1 / −33.9 / 1.3 and longitudes −157.9 / 151.2 → `north.lat 64.1`, `south.lat −33.9`, `east.lon 151.2`, `west.lon −157.9`. `highest` = max `elevationFt`. Airports without coordinates are ignored. Empty input → all null.
- [ ] **Step 2: Run** `bunx jest src/resources/profile/stats/sections/ops.spec.ts`. Expected: FAIL.
- [ ] **Step 3: Implement** in `ops.ts`. Averages are rounded to whole minutes.
- [ ] **Step 4: Run** the tests. Expected: PASS.
- [ ] **Step 5: Commit** `feat(api): runway log, taxi by airport and extremes stats`

### Task 5: Wire the stats endpoint

**Files:**
- Modify: `api/src/resources/profile/entities/profile-stats.entity.ts`. Rewrite it:
  - keep `MostFlownAircraftEntity`, `AircraftWithAge` and `AircraftStatsEntity` unchanged;
  - replace the rest with entities matching the Task 2–4 return types, plus `StatsAirportEntity`, `StatsFlightSummaryEntity` and `StatsRecordEntity`.
- Modify: `api/src/resources/profile/profile.service.ts`:
  - `getProfileStats(userId: string, year?: number)`;
  - keep the existing aircraft block;
  - delete the old passport, top-list and record code.
- Modify: `api/src/resources/profile/profile.controller.ts`: add `@ApiQuery({ name: 'year', required: false, type: Number })` and parse it to an int.
- Test: `api/src/resources/profile/profile-stats.spec.ts`, with `src/db` mocked as in `flight/flight-delete.spec.ts`.

**Interfaces:**
- Produces `ProfileStatsResponseEntity`:

```ts
{ availableYears: number[] /*desc*/; year: number|null; passport; flightsPer; records /*StatsRecordEntity: { flight: StatsFlightSummaryEntity; value }*/;
  topAirports; topAirlines; topRoutes; countries; continents; delays /*delaySummary*/; runways; taxiByAirport; extremes; map;
  mostFlownAircraft; aircraftStats? }
```

  - `StatsFlightSummaryEntity`: `{ id, flightNo, identIata?, identIcao?, faFlightId?, airline { name, iata?, icao?, image? }, departure: StatsAirportEntity, arrival: StatsAirportEntity, date }`.
  - `StatsAirportEntity`: `{ iata?, icao?, name, city, isoCountry?, lat?, lon?, elevationFt? }`.

  Mark every `?` field `@ApiPropertyOptional({ nullable: true })` so the Dart client gets nullable types.
- [ ] **Step 1: Write failing tests**
  - `filters by year and lists all years`: a mocked `prisma.flight.findMany` returns flights in 2024, 2025 and a future 2027 date, plus `prisma.airport.findMany` → `availableYears [2025, 2024]`. With `year 2024`, `passport.totalFlights` = only the 2024 count.
  - `cancelled excluded`: a cancelled FA flight is not in `totalFlights`.
  - `empty log`: no flights → `availableYears []`, `passport.totalFlights 0`, no throw.
- [ ] **Step 2: Run** `bunx jest src/resources/profile/profile-stats.spec.ts`. Expected: FAIL.
- [ ] **Step 3: Implement** the service:
  1. load the flights (include `greatCircleDistance`, `flightAwareData`);
  2. load the airport index;
  3. normalise;
  4. `counted = filter(isCounted)`;
  5. `availableYears` from `counted`;
  6. apply the year filter;
  7. run the sections;
  8. map `StatsFlight` to the summary entities.
- [ ] **Step 4: Run** the tests, then `bunx tsc --noEmit -p .`. Expected: PASS, no type errors.
- [ ] **Step 5: Commit** `feat(api): Passport stats endpoint with year filter`

### Task 6: Paged flight history

**Files:**
- Create: `api/src/resources/flight/entities/flight-history.entity.ts`
- Modify: `api/src/resources/flight/flight.service.ts` (add `getFlightHistory`)
- Modify: `api/src/resources/flight/flight.controller.ts` (add `@Get('history')` before the `@Get()` handler)
- Test: `api/src/resources/flight/flight-history.spec.ts`

**Interfaces:**
- Produces:
  - `GET /v1/flight/history?cursor&limit&year` → `FlightHistoryResponseEntity { items: StatsFlightSummaryEntity[]; nextCursor: string|null; yearCounts: YearCountEntity[] /*{year,count} desc, all years*/ }`. Reuse `StatsFlightSummaryEntity` from Task 5.
  - `FlightService.getFlightHistory(userId: string, opts: { cursor?: string; limit?: number; year?: number }): Promise<FlightHistoryResponseEntity>`
- [ ] **Step 1: Write failing tests**
  - `pages newest first`: 5 counted flights, `limit 2` → three calls return 2, 2 and 1 items. `nextCursor` is null on the last page.
  - `stable cursor on equal dates`: 3 flights with an identical `date` → across pages, every id appears exactly once. Order by `date desc, id desc`.
  - `year filter and yearCounts`: `year 2025` → only 2025 items. `yearCounts` still lists every year.
  - `excludes future and cancelled`: same rule as stats.
- [ ] **Step 2: Run** `bunx jest src/resources/flight/flight-history.spec.ts`. Expected: FAIL.
- [ ] **Step 3: Implement**
  - Load the counted flights with the Task 1 helpers (the log is small; `ponytail:` comment: in-memory paging, move to a keyset query when logs reach thousands).
  - Sort, filter by year, then slice after the cursor id.
  - `limit` defaults to 30, max 100.
- [ ] **Step 4: Run** the tests. Expected: PASS.
- [ ] **Step 5: Commit** `feat(api): paged flight history endpoint`

### Task 7: Regenerate the Dart client

**Files:** `api/openapi.json`, `openapi/` (generated)

- [ ] **Step 1:** Boot the API once so `main.ts` writes `api/openapi.json`: `cd api && bun run start` until it logs that it's listening, then stop it. If the user's watch server is already running, it rewrites the file itself; leave that server running.
- [ ] **Step 2:** Run `./generate-openapi-client.sh` from the repo root. Expected: "Done!".
- [ ] **Step 3:** Run `grep -n "year\|getFlightHistory" openapi/lib/src/api/profile_api.dart openapi/lib/src/api/flight_api.dart`. Expected: `profileControllerGetProfileStatsV1({int? year…})` and a `flightControllerGetFlightHistoryV1` method. Note the exact generated names for Task 10.
- [ ] **Step 4: Commit** `chore: regenerate OpenAPI client for stats Passport`

### Task 8: Tokens, design rule, app utilities

**Files:**
- Modify: `app/lib/ui/tokens.dart`
- Modify: `app/DESIGN.md` (§1 colours, plus one line on accents)
- Modify: `app/lib/constants/map.dart`
- Create: `app/lib/utils/flag.dart`
- Create: `app/lib/utils/great_circle.dart`
- Modify: `app/lib/formatters/time.dart`
- Test: `app/test/stats_utils_test.dart`

**Interfaces:**
- Produces:

```dart
// tokens.dart
abstract final class AeroAccent {
  static const passport = Color(0xff5b3fe0);           // bars, links, arcs
  static const passportGradient = [Color(0xff2b1f86), Color(0xff14093f)];
  static const delayGradient = [Color(0xffb3261e), Color(0xff4a0d08)];
  static const aircraftGradient = [Color(0xffe4defa), Color(0xffc5d7f5)];
  static const aircraftInk = Color(0xff1b2a55);
  static const onPassportMuted = Color(0xffc9c2ff);
  static const onDelayMuted = Color(0xffffb4a8);
}
// AeroText additions
static final hero;      // Inter w800 52, height 1, letterSpacing -1.2, tabular
static final heroUnit;  // Inter w500 26, muted
static final sectionTitle; // CalSans 22, letterSpacing -0.4
static final label;     // Inter w600 11, letterSpacing 0.6 (uppercase applied by caller)
// map.dart
TileLayer get lightMapTileLayer; // mapbox/light-v11, same options as openStreetMapTileLayer
// utils
String flagEmoji(String iso2);                                   // 'IN' → 🇮🇳
List<LatLng> greatCirclePoints(LatLng a, LatLng b, {int segments = 48});
String formatLongDuration(int minutes);                          // ≥1 day '17d 11h', else '7h 34m'
```

- [ ] **Step 1: Write failing tests in `stats_utils_test.dart`**
  - `flagEmoji('IN') == '🇮🇳'`; `flagEmoji('gb') == '🇬🇧'`.
  - `great circle crosses antimeridian`: HNL (21.32, −157.92) → NRT (35.77, 140.39). No consecutive pair differs by more than 180° in longitude, and every longitude is ≤ −140 or ≥ 140 after normalising to [−180, 180]. (Unwrap the longitudes so they're continuous; flutter_map draws them fine.)
  - `formatLongDuration(25139) == '17d 11h'`; `formatLongDuration(454) == '7h 34m'`; `formatLongDuration(0) == '0h 0m'`.
- [ ] **Step 2: Run** `cd app && flutter test test/stats_utils_test.dart`. Expected: FAIL.
- [ ] **Step 3: Implement**
  - Tokens and utilities: slerp on unit vectors, then unwrap each longitude relative to the previous one.
  - DESIGN.md: add the accent rule under §1.
- [ ] **Step 4: Run** the tests. Expected: PASS.
- [ ] **Step 5: Commit** `feat(app): stats accent tokens, flag, great-circle and duration utils`

### Task 9: Shared stats widgets

**Files:**
- Create in `app/lib/screens/profile/stats/widgets/`:
  - `year_filter.dart`
  - `stat_section.dart`
  - `stat_bar_list.dart`
  - `bar_chart.dart`
  - `comparison_pill.dart`
  - `record_row.dart`
  - `summary_card.dart`
  - `past_flight_row.dart`
- Test: `app/test/stats_widgets_test.dart`

**Interfaces:**
- Produces:

```dart
YearFilter({required List<int> years, required int? selected, required ValueChanged<int?> onChanged}) // 'All-time' + years, horizontal scroll
StatSection({required String title, required String hero, String? heroUnit, required Widget child, VoidCallback? onShowMore, String showMoreLabel = 'Show more'})
StatBarList({required List<StatBar> rows, required Color color}) // StatBar(label: Widget, value: num, valueLabel: String)
StatBarList.switchable({required List<StatBar> byFlights, required List<StatBar> byDistance, required Color color}) // Flights/Distance AeroSegmented
BarChart({required List<int> values, required List<String> labels, required Color color}) // CustomPainter, labels below plot
ComparisonPill({required String icon /*emoji*/, required double fraction /*clamped 0-1*/, required String label})
RecordRow({required String caption, required StatsFlightSummaryEntity flight, required String value, VoidCallback? onTap})
SummaryCard({required List<Color> gradient, required Widget child, String? ctaLabel, VoidCallback? onCta}) // CTA row hidden when onCta null
PastFlightRow({required StatsFlightSummaryEntity flight, required VoidCallback onTap})
```

- [ ] **Step 1: Write failing widget tests**
  - `PastFlightRow shows both idents and cities`: a fixture flight EK215/UAE215 from DXB Dubai to LAX Los Angeles, 14 Mar 2026 → finds `'EK 215 · UAE215'`, `'DXB → LAX'`, `'Dubai to Los Angeles'`, `'14 Mar 2026'`, and a chevron icon.
  - `SummaryCard hides CTA without callback`: no `onCta` → the `ctaLabel` text is not found.
  - `StatSection hides Show more without callback`.
  - `BarChart paints with all-zero values`: pump with `[0,0,0]`, no exception.
- [ ] **Step 2: Run** `flutter test test/stats_widgets_test.dart`. Expected: FAIL.
- [ ] **Step 3: Implement** the widgets:
  - `AeroPressable` on every tappable;
  - `AirlineLogo` for logos;
  - `AeroText` tokens only;
  - a 16 px gutter is the caller's job; widgets have no outer padding.
- [ ] **Step 4: Run** the tests, plus `flutter test test/design_rules_test.dart`. Expected: PASS.
- [ ] **Step 5: Commit** `feat(app): shared stats widgets`

### Task 10: Stats controller and services

**Files:**
- Modify: `app/lib/services/profile.dart`. Add `getProfileStats({int? year})` and `getFlightHistory({String? cursor, int? year})`, using the generated names from Task 7.
- Create: `app/lib/screens/profile/stats/stats_controller.dart`
- Create: `app/lib/screens/profile/stats/open_flight_request.dart`
- Test: `app/test/stats_controller_test.dart`

**Interfaces:**
- Produces:

```dart
class OpenFlightRequest { final String flightNo; final DateTime date; final String? faFlightId; }
typedef StatsFetcher = Future<ProfileStatsResponseEntity?> Function(int? year);
typedef HistoryFetcher = Future<FlightHistoryResponseEntity?> Function(String? cursor, int? year);
class StatsController extends ChangeNotifier {
  StatsController({required StatsFetcher fetchStats, required HistoryFetcher fetchHistory});
  int? year; ProfileStatsResponseEntity? stats; bool loading; String? error;
  List<StatsFlightSummaryEntity> history; bool historyLoading; bool historyDone; List<YearCountEntity> yearCounts;
  Future<void> load();                 // stats + first history page
  Future<void> setYear(int? y);        // refetch both, reset history
  Future<void> loadMoreHistory();      // no-op while loading or done
}
```

- [ ] **Step 1: Write failing tests** (fake fetchers):
  - `load fetches stats and first page`.
  - `setYear resets history and passes year`.
  - `loadMoreHistory appends and stops at null cursor`: two pages, then `historyDone == true`, and a third call doesn't call the fetcher.
  - `stale year response is ignored`: `setYear(2024)` then quickly `setYear(2025)`. If the 2024 response resolves last, `stats` stays at 2025.
- [ ] **Step 2: Run** `flutter test test/stats_controller_test.dart`. Expected: FAIL.
- [ ] **Step 3: Implement.** Use a request counter to drop stale responses. Errors go into `error` and are shown with `showErrorToast` by the screen.
- [ ] **Step 4: Run** the tests. Expected: PASS.
- [ ] **Step 5: Commit** `feat(app): stats controller with year filter and paged history`

### Task 11: Passport hub screen and the open-flight path

**Files:**
- Replace: `app/lib/screens/profile/stats/main.dart`. Delete the legacy 1,680-line file. The new `FlightStatsScreen` is the hub. Before deleting, read how the legacy aircraft card got its image from `aircraftStats`, and reuse that field.
- Modify: `app/lib/routes/main.dart`. Add `/profile/stats/flights` → `FlightStatsReport(year: state.extra as int?)`.
- Modify: `app/lib/screens/profile/main.dart`. On the "Flight Stats" tap, `final r = await push<OpenFlightRequest>(...)`; if `r != null`, `context.pop(r)`.
- Modify: `app/lib/screens/home/widgets/search_header.dart`. Add `final ValueChanged<OpenFlightRequest>? onOpenFlight;` and await `push<OpenFlightRequest>('/profile')`.
- Modify: `app/lib/screens/home/main.dart:345`. `SearchHeader(onOpenFlight: (r) => controller.loadFlightInfo(r.flightNo, r.flightNo, r.date, forceUpdate: true, faFlightId: r.faFlightId))`.
- Modify: `app/test/design_baseline.json` (regenerate).
- Test: `app/test/stats_hub_test.dart`

**Interfaces:**
- Consumes: Tasks 8–10.
- Produces: `FlightStatsScreen()` (hub). A row tap pops `OpenFlightRequest` all the way to home.

The hub's layout (spec "Hub screen", mockup `stats-look-v2.html`):
- the "Passport" display title, then `YearFilter`;
- **passport `SummaryCard`:**
  - flights + "N long haul";
  - distance via `formatDistance` and the unit notifier, with "×N around Earth" (40,075 km);
  - time via `formatLongDuration(blockMinutes)`;
  - airports and airlines;
  - CTA "All flight stats" → pushes `/profile/stats/flights` with `extra: year`.
- **delay `SummaryCard`:** `delays.minutesLost` as whole hours, "hours lost to delays", "Delayed flights averaged …". No CTA in part 1. Hidden when `delays.basedOn == 0`.
- **aircraft `SummaryCard`:** "Most flown aircraft", the type in CalSans, "N flights", and the image in an `AspectRatio(16/6)` with `BoxFit.contain`. No CTA. Hidden when there's no data.
- **"Past flights":** groups with a year header ("2025" plus "21 flights" from `yearCounts`) and `PastFlightRow`s. `loadMoreHistory` fires within 600 px of the end.

- [ ] **Step 1: Write failing widget tests** (controller with fake fetchers, injected through an optional constructor parameter `FlightStatsScreen({StatsController? controller})`):
  - `hub renders empty stats`: an empty response → "Passport" title, a "No flights yet" empty state, no exception.
  - `hub hides delay CTA in part 1`: "All delay stats" isn't found.
  - `tapping a past flight pops an OpenFlightRequest`: inside a `GoRouter` test harness, push the hub, tap the row, and expect the awaited result's `flightNo == 'EK215'`.
- [ ] **Step 2: Run** `flutter test test/stats_hub_test.dart`. Expected: FAIL.
- [ ] **Step 3: Implement** the hub and the pop chain. Switching the year keeps the scroll position (no jump to the top), per the spec.
- [ ] **Step 4: Run** `flutter test test/stats_hub_test.dart`, then `UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart`, then `flutter test test/design_rules_test.dart` and `flutter analyze lib/screens/profile lib/screens/home/widgets/search_header.dart`. Expected:
  - all tests pass;
  - the baseline no longer lists `lib/screens/profile/stats/main.dart`;
  - no new analyzer errors.
- [ ] **Step 5: Commit** `feat(app): Passport hub replaces legacy stats screen`

### Task 12: Flight stats report

**Files:**
- Create: `app/lib/screens/profile/stats/flight_stats_report.dart`
- Create: `app/lib/screens/profile/stats/passport_header.dart`
- Create in `app/lib/screens/profile/stats/sections/`:
  - `flights_section.dart`
  - `distance_section.dart`
  - `time_section.dart`
  - `top_lists_section.dart`
  - `runways_section.dart`
  - `taxi_section.dart`
  - `extremes_section.dart`
  - `countries_section.dart`
- Test: `app/test/stats_report_test.dart`

**Interfaces:**
- Consumes: Tasks 8–11 (a `StatsController` created by the report for its year; the `YearFilter` at the top switches it).
- Produces: `FlightStatsReport({int? year, StatsController? controller})`

Sections in order, each a `StatSection` (spec "Flight stats report" lists the content). Notes:
- **PassportHeader:**
  - a `FlutterMap` of height 220 inside `ClipRRect(AeroRadius.mdAll)`, with `InteractionOptions(flags: InteractiveFlag.none)`, `initialCameraFit: CameraFit.bounds(bounds, padding: 24)`, `lightMapTileLayer`;
  - a `PolylineLayer` of `greatCirclePoints` in `AeroAccent.passport` at 2 px, and a `CircleLayer` of radius 3;
  - the flag `Wrap` plus "N countries";
  - the summary strip.
  - If `map.airports` is empty, it shows a `surfaceAlt` panel instead of the map.
- **Flights:** "N domestic / N international / N long haul", plus `AeroSegmented` Year|Month|Weekday over `BarChart`. Year is hidden when a year is selected.
- **Distance:**
  - the hero is the distance in the user's unit, with the other unit below and the average;
  - `ComparisonPill`s for Earth (40,075 km) and the Moon (384,400 km);
  - records: shortest and longest by distance.
- **Time:** the hero is `blockMinutes` as "418h 59m"; a grid of days, weeks and average; "In the air" and "Taxiing" with "based on N flights"; records: shortest and longest by duration.
- **Top airports, airlines and routes:** `StatBarList.switchable`, first 8 rows. "Show more" opens `showAeroSheet` with the full list. Airport rows in the sheet show IATA, ICAO, name, city, and dep vs arr.
- **Runway log, taxi by airport, extremes, countries & territories:** content as in the spec. The continent grid is 3 columns showing `countryCount` and `flightShare` as %.
- **Record rows:** tapping pops an `OpenFlightRequest` (`context.pop(r)` up to the hub, which re-pops).

- [ ] **Step 1: Write failing widget tests** with a fixture `ProfileStatsResponseEntity`:
  - `report shows hero numbers`: finds "60" + "total airports" and "N runways used".
  - `map placeholder when no coordinates`: `map.airports` empty → no `FlutterMap` widget.
  - `show more opens sheet`: tap "Show more" under Top airports → the 9th airport's name is visible.
  - `extremes rows list both codes`: finds `'HNL · PHNL'`.
- [ ] **Step 2: Run** `flutter test test/stats_report_test.dart`. Expected: FAIL.
- [ ] **Step 3: Implement** the report and its sections.
- [ ] **Step 4: Run** `flutter test test/stats_report_test.dart test/design_rules_test.dart`. Expected: PASS.
- [ ] **Step 5: Commit** `feat(app): flight stats report with passport header, runways, taxi and extremes`

### Task 13: Visual check and docs

**Files:**
- Create, then delete: `app/test/zz_stats_preview_test.dart` (golden preview)
- Modify: `docs/superpowers/HANDOFF.md`
- Modify: `docs/superpowers/specs/2026-11-21-roadmap.md`

- [ ] **Step 1:** Write a throwaway golden test that renders the hub and the report at 390×2400 with the real fonts:
  - Inter at `<scratchpad>/fonts/Inter.ttf` (download it again if missing);
  - `assets/fonts/calsans.ttf`;
  - `MaterialIcons-Regular.otf` from the Flutter SDK cache;
  - `GoogleFonts.config.allowRuntimeFetching = false`.

  Replace the map with its placeholder in the test. Run `flutter test --update-goldens test/zz_stats_preview_test.dart`, look at both PNGs, fix alignment and hierarchy issues, then delete the test and the PNGs.
- [ ] **Step 2:** Run on the user's phone (adb device `RZGL80FNCXR`; use `-d 4633128672291735937` for screencap). Open Profile → Flight Stats, capture the hub and the report, and compare them with `stats-look-v2.html`.
- [ ] **Step 3:** Run the full suites:
  - `cd api && bunx jest src/resources/profile src/resources/flight/flight-history.spec.ts`;
  - `cd app && flutter test`.

  Expected: everything new passes. The pre-existing Nest boilerplate spec failures are not caused by this work.
- [ ] **Step 4:** Update HANDOFF (part 1 done; parts 2 and 3 next) and the roadmap row #8. Commit with `docs: stats Passport part 1 done`.
