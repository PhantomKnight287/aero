# Stats Delay Report Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Hub delay card opens a full Delay report (Flighty benchmark) on the Passport design system.

**Architecture:** Server extends `delays` in `GET /v1/profile/@me?year=` with buckets, worst, per-airline, per-airport and per-flight lists; the app renders a new pushed route `/profile/stats/delays` built from existing stats widgets plus one track-bar widget.

**Tech Stack:** NestJS + Prisma + Jest (bun), openapi-generator Dart client, Flutter.

**Spec:** `docs/superpowers/specs/2026-11-23-stats-delay-report-design.md` (parent: `2026-11-22-stats-passport-design.md`, section "Data rules").

## Global Constraints
- Delayed = arrival delay > 15 min. Buckets: Early < −5; On time −5..15; 15m late 15..30 (exclusive 15, inclusive 30); 30m late 30..45; 45m+ late > 45.
- Diverted flights go in the Diverted bucket, not a time bucket. Cancelled only appear in the Cancelled bucket.
- Late departure = `departureDelayMin > 15`.
- UI: `app/lib/ui` tokens only; no raw colours/sizes; no `AlertDialog`/`SnackBar`; no Share pills; no text on charts; tap targets show a chevron.
- Numbers via `formatCount`/`formatDecimal`; durations via `formatLongDuration`; tabular figures.
- `dart format` only files you own. Run API tests with `cd api && bunx jest <path>`.
- Accent colours only inside stats cards/charts.

## Review Focus
- Year with flights but zero FlightAware times: report shows "No delay data for this year" not a 0% card. (Task 3 test `empty delays`.)
- Flight with `diverted` and a positive arrival delay: counted once, in Diverted only, not in `flights[]`. (Task 1 test.)
- Airline with empty `key` / airport with empty `key` (junk codes): skipped from per-airline/per-airport lists. (Task 1 test.)
- Very long airline names in performance rows: ellipsize, percent stays visible. (Task 3 test with 60-char name, no overflow.)
- Cancelled flight in another year or in the future: not counted in this year's Cancelled bucket. (Task 1 test.)

---

### Task 1: API delay report

**Files:**
- Create: `api/src/resources/profile/stats/sections/delays.ts`, `api/src/resources/profile/stats/sections/delays.spec.ts`
- Modify: `api/src/resources/profile/stats/sections/core.ts` (remove `delaySummary`; move to `delays.ts`), `core.spec.ts` (drop its delay assertion), `api/src/resources/profile/stats/load.ts`, `api/src/resources/profile/entities/stats-sections.entity.ts:110`, `api/src/resources/profile/profile.service.ts:22-27,363`, `api/src/resources/flight/flight.service.ts:1480` (only if `loadCountedFlights` signature changes; keep it unchanged)

**Interfaces:**
- Produces in `load.ts`: `loadFlights(userId, now): Promise<{ row; f: StatsFlight }[]>` (all normalized rows, unfiltered); `loadCountedFlights` keeps its signature and filters `loadFlights` with `isCounted`.
- Produces in `delays.ts`:
  ```ts
  delayReport(fs: StatsFlight[], cancelled: number): {
    basedOn; arrivedCount; delayedCount; minutesLost; avgDelayMinutes; // unchanged meaning
    netMinutes: number;               // signed sum of arrivalDelayMin over non-diverted flights with a value
    buckets: { early; onTime; late15; late30; late45; cancelled; diverted; total };
    worst: StatsRecord | null;        // max arrivalDelayMin among delayed
    airlines: { airline: StatsAirline; late: number; total: number; minutesLate: number }[];
    airports: { airport: StatsAirport; lateDepartures: number; total: number }[];
    flights: StatsRecord[];           // delayed flights, worst first
  }
  ```
- Entities: `DelayBucketsEntity`, `DelayAirlineEntity` (airline: StatsAirlineEntity), `DelayAirportEntity` (airport: StatsAirportEntity), and `DelaySummaryEntity` gains `netMinutes`, `buckets`, `worst: StatsRecordEntity | null` (nullable), `airlines`, `airports`, `flights: StatsRecordEntity[]`.

Rules: `basedOn`/`arrivedCount` = non-diverted flights with `arrivalDelayMin` defined. `total` = sum of all bucket counts. Airline rows: flights with `arrivalDelayMin` defined, not diverted, `airline.key` non-empty; `minutesLate` = sum of positive delays of delayed flights. Sort airlines by `late/total` desc, then `total` desc, then `minutesLate` desc. Airport rows: departure airport of flights with `departureDelayMin` defined, `dep.key` non-empty; sort by rate desc, then total desc. Worst airlines (UI top 3) = client sorts `airlines` by `minutesLate`; no extra field.

Cancelled count in service: from `loadFlights`, `f.cancelled && f.date <= now && (year == null || f.local.year === year)`.

- [ ] **Step 1: Write failing tests in `delays.spec.ts`** using `makeStatsFlight`:
  - `empty`: `delayReport([], 0)` → all counts 0, `worst: null`, empty arrays, `buckets.total 0`.
  - `buckets`: delays `[-10, -5, 0, 15, 16, 30, 31, 45, 46, 120]` + `cancelled 2` → `early 1, onTime 3, late15 2, late30 2, late45 2, cancelled 2, diverted 0, total 12`; `delayedCount 6`; `minutesLost 16+30+31+45+46+120 = 288`; `avgDelayMinutes 48`; `netMinutes 288` (−10 − 5 + 0 + 15 + 288).
  - `diverted wins`: one flight `{diverted: true, arrivalDelayMin: 90}` → `diverted 1`, `late45 0`, `flights []`, `basedOn 0`.
  - `worst and order`: delays 20, 200, 60 → `worst.value 200`, `flights.map(value)` `[200, 60, 20]`.
  - `airlines`: EK [20, 0], AI [100], blank-key airline [50] → `[{AI late1 total1 minutesLate100}, {EK late1 total2 minutesLate20}]`.
  - `airports`: dep DEL departureDelay [30, 0, 5], dep DXB [16]; dep key '' [40] → DXB (1/1) first, DEL (1/3), blank skipped.
- [ ] **Step 2:** `cd api && bunx jest src/resources/profile/stats/sections/delays.spec.ts` → FAIL (module not found).
- [ ] **Step 3:** Implement `delayReport` in `delays.ts`; move `delaySummary` logic into it and delete `delaySummary` from `core.ts` (+ its `core.spec.ts` line).
- [ ] **Step 4:** Add `loadFlights`; service computes `cancelled` and sets `delays: toDelays(delayReport(fs, cancelled))` mapping airlines/airports/records with `toAirline`/`toAirport`/`toRecord`. Add a case to `profile-stats.spec.ts`: a cancelled past flight in 2025 → `delays.buckets.cancelled 1` for `year 2025`, `0` for `year 2024`; a cancelled future flight → 0.
- [ ] **Step 5:** `cd api && bunx jest src/resources/profile` → PASS (ignore the old Nest boilerplate spec failures noted in HANDOFF).
- [ ] **Step 6:** Commit `feat(api): delay report stats`.

### Task 2: Regenerate Dart client

- [ ] **Step 1:** Boot API once (writes `api/openapi.json`), then `./generate-openapi-client.sh`.
- [ ] **Step 2:** `grep -n "netMinutes\|DelayBucketsEntity" app/openapi -r | head` → present. `cd app && flutter analyze lib/screens/profile/stats` → no new errors (fix `test/stats_hub_test.dart` `DelaySummaryEntity` builder by setting the new required fields).
- [ ] **Step 3:** Commit `chore(app): regenerate client for delay report`.

### Task 3: App delay report

**Files:**
- Create: `app/lib/screens/profile/stats/delay_report.dart`, `app/lib/screens/profile/stats/sections/delay_sections.dart`, `app/lib/screens/profile/stats/widgets/rate_bar.dart`, `app/test/stats_delay_report_test.dart`
- Modify: `app/lib/ui/tokens.dart` (`AeroAccent`), `app/lib/routes/main.dart`, `app/lib/screens/profile/stats/main.dart:56-60,100-104,167-194`, `app/test/stats_hub_test.dart:113`

**Interfaces:**
- Consumes: `DelaySummaryEntity` fields from Task 1/2; `StatSection`, `StatBarList`, `recordRow`, `showListSheet`, `SheetRow`, `basedOn`, `airportCodes` from `sections/shared.dart`; `AirlineLogo`; `CountryFlag`; `YearFilter`; `StatsController`; `SummaryCard`; `UnitText`.
- Produces:
  - `AeroAccent.delayBuckets`: `List<Color>` of 7 (early dark green, on time light green, 15m yellow, 30m orange, 45m+ red, cancelled grey, diverted dark red); `AeroAccent.rateTrack` (light neutral track).
  - `RateBar({required double fraction, required Color color})`: full-width rounded track with fill; `RateRow.inline({label, fraction, valueLabel, color})` (label | bar | %) and `RateRow.stacked({leading, label, valueLabel, detail, fraction, color})` (logo name … 100% (1/1), bar below).
  - `DelayReport({int? year, StatsController? controller})`, same skeleton as `FlightStatsReport` (title "Delay report").
  - Sections, each with `static bool shows(ProfileStatsResponseEntity s)`: `DelayHeroCard`, `DelayBreakdownSection`, `WorstAirlinesSection`, `AirlinePerformanceSection`, `AirportPerformanceSection`, `DelayedFlightsSection`.

Content (copy is fixed):
- `DelayHeroCard` (`SummaryCard`, `AeroAccent.delayGradient`, `onInk` text): hero `NN%` (delayedCount/arrivedCount, rounded); "flights delayed"; "N of M flights arrived later than scheduled"; `UnitText` hours/min lost + "lost to delays · avg Xh Ym late"; worst-delay row "WORST DELAY" label, `flightIdents`, `DEP → ARR`, duration, date, chevron (pops `OpenFlightRequest`).
- `DelayBreakdownSection`: title "Arrival performance", hero `formatLongDuration(|netMinutes|)` unit "late"/"early" by sign; seven `RateRow.inline` rows labelled Early / On time / 15m late / 30m late / 45m+ late / Cancelled / Diverted, `%` of `buckets.total`; footer `basedOn(buckets.total)` reading "based on N flights with FlightAware times" (extend `basedOn` with an optional suffix).
- `WorstAirlinesSection`: title "Worst airlines"; top 3 by `minutesLate` > 0 as `StatBarList` (logo + IATA label, value minutesLate, label `formatLongDuration`), colour `AeroColors.danger`.
- `AirlinePerformanceSection`: title "Airline performance", hero overall % (sum late / sum total) unit "late arrivals"; first 5 `RateRow.stacked` (logo, name, `100% (1/1)`); "Show more" → `showListSheet` with all rows.
- `AirportPerformanceSection`: title "Airport performance", hero % unit "late departures"; leading `CountryFlag`, label `airportCodes(a)`; same 5 + sheet.
- `DelayedFlightsSection`: title "Arrival delays", hero `delayedCount` unit "total"; first 5 rows via `recordRow(context, '', r, fmt)`-style rows (ident, red delay, route, date, chevron); "Show more" sheet lists all.
- Empty: if `delays.basedOn == 0 && buckets.cancelled == 0` show caption "No FlightAware times for this period yet." instead of sections.

- [ ] **Step 1: Write failing widget tests** in `stats_delay_report_test.dart` (fixture built like `stats_report_test.dart`, controller injected):
  - renders `'48%'`, `'14 of 29 flights arrived later than scheduled'`, `'Arrival performance'`, `'Airline performance'`, `'Airport performance'`, `'Arrival delays'` for a fixture with delayedCount 14 / arrivedCount 29.
  - `Show more` appears under Airline performance only when airlines > 5.
  - `empty delays`: basedOn 0 → finds `'No FlightAware times for this period yet.'`, finds no `'Arrival performance'`.
  - 60-char airline name at 360 px width: `tester.takeException()` is null.
  - tapping the worst-delay row pops an `OpenFlightRequest` with `flightNo 'AI185'`.
- [ ] **Step 2:** `cd app && flutter test test/stats_delay_report_test.dart` → FAIL.
- [ ] **Step 3:** Implement tokens, `rate_bar.dart`, `delay_sections.dart`, `delay_report.dart`; route `/profile/stats/delays` → `DelayReport(year: state.extra as int?)`.
- [ ] **Step 4:** Hub: `_delayCard` gets `ctaLabel: 'All delay stats'`, `onCta: _openDelays` (same shape as `_openReport`, path `/profile/stats/delays`). Update `stats_hub_test.dart` test "hub hides delay CTA in part 1" → "hub shows delay CTA" expecting `'All delay stats'` findsOneWidget.
- [ ] **Step 5:** `flutter test test/stats_delay_report_test.dart test/stats_hub_test.dart test/design_rules_test.dart` → PASS. `dart format` the new/changed files only.
- [ ] **Step 6:** Commit `feat(app): delay report`.

### Task 4: Visual check

- [ ] **Step 1:** Throwaway golden of `DelayReport` with the test fixture at 412×2400 using real fonts (HANDOFF "Look before saying done"); inspect PNG against the Flighty screenshots' structure; fix spacing/alignment; delete the test.
- [ ] **Step 2:** `flutter run --dart-define-from-file=.env`, open Passport → delay card → report; screencap per HANDOFF; check year switch and a "Show more" sheet.
- [ ] **Step 3:** Commit fixes `fix(app): delay report polish`; update `docs/superpowers/HANDOFF.md` (#8 part 2 done, next part 3).
