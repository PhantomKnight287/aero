# Stats Aircraft Report Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Hub "Most flown aircraft" card (new dark blue-teal look) opens an Aircraft report: types with per-type flight lists, family collection grid, airframe age records.

**Architecture:** Server adds an `aircraft` section to `GET /v1/profile/@me?year=` from per-flight aircraft fields plus a bulk-loaded registry index; legacy `aircraftStats`/`mostFlownAircraft` and their registry block are deleted. App renders `/profile/stats/aircraft` on `ReportScaffold`.

**Tech Stack:** NestJS + Prisma + Jest (bun), openapi-generator Dart client, Flutter.

**Spec:** `docs/superpowers/specs/2026-11-23-stats-aircraft-report-design.md` (parent `2026-11-22-stats-passport-design.md`).

## Global Constraints
- Family map exactly as the spec table (16 families, listed codes; `B735–B739` = B735, B736, B737, B738, B739).
- Airframe age = registry `age` + years since the registry row's `createdAt` (same as today's code).
- `mostFlownTail` only when count ≥ 2.
- UI: `app/lib/ui` tokens only, no stock Material dialogs/snackbars, no Share pills, tap targets show a chevron, numbers via `formatCount`/`formatDecimal`.
- `dart format` only files you own. API tests: `cd api && bunx jest <path>`. Build the app with the local `org.gradle.java.home` line in `app/android/gradle.properties` (never commit it).

## Review Focus
- Flight with registration but no type anywhere: counts toward airframes/tail, not toward types or `basedOn`. (Task 1 test.)
- Same type reached by code on one flight and by registry name on another (`B77W` vs "Boeing 777-300ER"): one row, keyed by typeCode when known. (Task 1 test.)
- Unknown type code (not in the family map, e.g. `C25A`): appears in types, no family, no crash. (Task 1 test.)
- Year filter with zero aircraft data: report shows "No aircraft data for this period yet." and the hub card is hidden. (Task 3 test.)
- Type with 40+ flights: sheet scrolls, no overflow. (Task 3 test.)

---

### Task 1: API aircraft section

**Files:**
- Create: `api/src/resources/profile/stats/aircraft-index.ts`, `api/src/resources/profile/stats/families.ts`, `api/src/resources/profile/stats/sections/aircraft.ts`, `api/src/resources/profile/stats/sections/aircraft.spec.ts`
- Modify: `api/src/resources/profile/stats/stats-flight.ts` (interface + `normalizeFlight`), `api/src/resources/profile/entities/stats-sections.entity.ts`, `api/src/resources/profile/entities/profile-stats.entity.ts` (drop `MostFlownAircraftEntity`, `AircraftStatsEntity`, `AircraftWithAge`, `FlightSummaryEntity` if unused elsewhere; add `aircraft`), `api/src/resources/profile/profile.service.ts` (delete the whole legacy aircraft/airline block, lines ~36–345), `api/src/resources/profile/profile-stats.spec.ts`

**Interfaces:**
- `StatsFlight` gains `reg?: string` (`aircraft.reg || aircraft.registration || fa.registration`), `typeCode?: string` (`aircraft.modelCode || fa.aircraftType`), `typeName?: string` (`aircraft.typeName`).
- `aircraft-index.ts`:
  ```ts
  export interface RegistryAirframe { typeName?: string; modelCode?: string; ageYears?: number; image?: string }
  export interface AircraftIndex { byReg: Map<string, RegistryAirframe>; byCode: Map<string, { typeName: string; image?: string }> }
  export async function loadAircraftIndex(regs: string[], codes: string[], now: Date): Promise<AircraftIndex>
  ```
  Queries: `aircraftRegistration.findMany({ where: { reg: in regs }, include: { Aircraft: true } })` and `aircraft.findMany({ where: { OR: [reg in regs, modelCode in codes] } })`.
- `families.ts`: `export const FAMILIES: { name: string; codes: string[] }[]` (spec order); `familyOf(code?: string): string | undefined`.
- `sections/aircraft.ts`:
  ```ts
  aircraftReport(fs: StatsFlight[], idx: AircraftIndex): {
    basedOn: number;
    types: { typeCode?: string; typeName: string; image?: string; flightCount: number; flights: StatsFlight[] }[];
    families: { family: string; typeCodes: string[]; flightCount: number; firstFlown: string | null }[];
    airframes: {
      medianAgeYears: number | null;
      oldest: Airframe | null; newest: Airframe | null;
      mostFlownTail: { reg: string; typeName?: string; count: number } | null;
    };
  }
  type Airframe = { reg: string; typeCode?: string; typeName?: string; ageYears: number; image?: string; flight: StatsFlight };
  ```
  Resolution per flight: `code = f.typeCode ?? idx.byReg.get(reg)?.modelCode`; `name = idx.byReg.get(reg)?.typeName ?? f.typeName ?? (code && idx.byCode.get(code)?.typeName) ?? code`. Type key = `code ?? name`. Image = registry image by code, else by the type's first reg. `flights` newest first. `firstFlown` = earliest `local` date as `YYYY-MM-DD`. Airframes use unique regs with `ageYears`; median over unique regs; airframe `flight` = most recent flight on that reg.
- Entities: `AircraftTypeEntity` (`flights: StatsFlightSummaryEntity[]`), `AircraftFamilyEntity`, `AirframeEntity` (`flight: StatsFlightSummaryEntity`), `MostFlownTailEntity`, `AirframesEntity`, `AircraftSectionEntity`; `ProfileStatsResponseEntity.aircraft: AircraftSectionEntity`.

- [ ] **Step 1: Failing tests in `aircraft.spec.ts`** (fixtures via `makeStatsFlight`, a hand-built `AircraftIndex`):
  - `empty`: `aircraftReport([], idx0)` → `basedOn 0`, `types []`, `families.length 16`, all `flightCount 0`/`firstFlown null`, airframes all null.
  - `merges code and registry name`: flight A `{typeCode:'B77W'}`, flight B `{reg:'A6EPO'}` with `byReg A6EPO {modelCode:'B77W', typeName:'Boeing 777-300ER'}` → one type `{typeCode:'B77W', typeName:'Boeing 777-300ER', flightCount:2}`.
  - `reg without type`: flight `{reg:'X'}`, no registry entry → `basedOn 0`, `types []`.
  - `unknown family`: `{typeCode:'C25A'}` → in `types`, every family count 0.
  - `families`: A20N on 2025-03-01 and A321 on 2024-06-01 → A320 family `{flightCount 2, firstFlown '2024-06-01'}`; families order puts flown first.
  - `airframes`: regs R1 age 27.1, R2 age 0.8, R3 age 9.4 (R1 flown twice) → oldest R1, newest R2, `medianAgeYears 9.4`, `mostFlownTail {reg:'R1', count:2}`; with each reg flown once → `mostFlownTail null`.
- [ ] **Step 2:** `cd api && bunx jest src/resources/profile/stats/sections/aircraft.spec.ts` → FAIL (module not found).
- [ ] **Step 3:** Implement `families.ts`, `aircraft-index.ts`, `aircraft.ts`, new `StatsFlight` fields.
- [ ] **Step 4:** Service: load index from `fs` regs/codes, set `aircraft` (map flights with `toFlightSummary`), delete the legacy block and response fields. Update `profile-stats.spec.ts` ("handles an empty log" asserted `mostFlownAircraft.flightCount`; assert `aircraft.types` is `[]` instead) and mock `aircraftRegistration`/`aircraft` already present.
- [ ] **Step 5:** `cd api && bunx jest src/resources/profile src/resources/flight/flight-history` → PASS; `bunx tsc --noEmit -p .` shows no new errors in `src/resources/profile`.
- [ ] **Step 6:** Commit `feat(api): aircraft stats section`.

### Task 2: Regenerate Dart client

- [ ] **Step 1:** Boot the API once (writes `api/openapi.json`), stop it, run `./generate-openapi-client.sh`.
- [ ] **Step 2:** `grep -c AircraftSectionEntity api/openapi.json` ≥ 1. App compile errors in `main.dart` and tests are expected here and fixed in Task 3.
- [ ] **Step 3:** Commit `chore(app): regenerate client for aircraft report`.

### Task 3: App aircraft card + report

**Files:**
- Create: `app/lib/screens/profile/stats/aircraft_report.dart`, `app/lib/screens/profile/stats/sections/aircraft_sections.dart`, `app/test/stats_aircraft_report_test.dart`
- Modify: `app/lib/ui/tokens.dart` (`AeroAccent.aircraftGradient` → blue-teal, delete `aircraftInk`, add `onAircraftMuted`), `app/lib/screens/profile/stats/main.dart` (`_aircraftCard`), `app/lib/routes/main.dart`, `app/test/stats_hub_test.dart`, `app/test/stats_report_test.dart` (fixture JSON: replace `mostFlownAircraft` with an `aircraft` object)

**Interfaces:**
- Consumes: `AircraftSectionEntity` (Task 2), `ReportScaffold`, `StatSection`, `StatBarList`, `PastFlightRow`, `RecordRow`-style rows, `showListSheet`, `popFlight`, `basedOn(n, suffix:)`, `SummaryCard`.
- Produces: `AircraftReport({int? year, StatsController? controller})`; sections `AircraftTypesSection`, `TypeCollectionSection`, `AirframesSection`, each with `static bool shows(AircraftSectionEntity a)`.

Fixed copy and behaviour:
- Hub card (shown when `aircraft.types.isNotEmpty`): label "Most flown aircraft", `types[0].typeName` in `AeroText.display` white, "N flights · CODE" in `onAircraftMuted`, photo band unchanged (16:9 flush, collapses on failure), CTA "All aircraft stats" → push `/profile/stats/aircraft` with `extra: c.year`, popping an `OpenFlightRequest` back like `_openReport`.
- Types: title "Aircraft types", hero `count(types.length)` unit "types flown"; first 8 rows as bars (label: code, or name when no code; colour `AeroAccent.passport`), each row tappable with a chevron → `showListSheet(context, typeName, [PastFlightRow per flight, onTap: popFlight])`; "Show more" sheet lists all types, each opening the same per-type sheet.
- Collection: title "Type collection", hero `'${flown} of ${families.length}'` unit "families"; 3-column grid; flown tile: family name (heading), count, "first d MMM y"; unflown tile: name in muted on `surfaceAlt`, no count.
- Airframes: title "Airframes", hero `formatDecimal(medianAgeYears, 1)` unit "yrs median age" (omit hero when null); rows "Oldest", "Newest" (`RecordRow` with caption, value `'27.1 yrs'`, tap → popFlight), "Most flown tail" line `'A6EPO · Boeing 777-300ER · 3 flights'`; section hidden when all three are null.
- Footer: `basedOn(a.basedOn, suffix: ' with aircraft data')`.
- Empty (`types.isEmpty && airframes.oldest == null`): "No aircraft data for this period yet."

- [ ] **Step 1: Failing widget tests** in `stats_aircraft_report_test.dart` (fixture by rebuilding `fixture()` from `stats_report_test.dart` with an `AircraftSectionEntity`):
  - renders 'Aircraft types', '21 types flown'-style hero, 'Type collection', 'Airframes', 'based on N flights with aircraft data'.
  - tapping the 'A388' row opens a sheet containing that type's flight route text.
  - type with 45 flights: open sheet, `t.takeException()` null.
  - empty fixture → 'No aircraft data for this period yet.'
  - tapping 'Oldest' pops an `OpenFlightRequest` with that flight's `flightNo`.
  - hub (`stats_hub_test.dart`): card shows 'All aircraft stats' and type name when types present; card absent when `types` empty.
- [ ] **Step 2:** `cd app && flutter test test/stats_aircraft_report_test.dart` → FAIL.
- [ ] **Step 3:** Implement tokens, sections, report, route, hub card.
- [ ] **Step 4:** `cd app && flutter test` → all pass (includes `design_rules_test.dart`). Format owned files only.
- [ ] **Step 5:** Commit `feat(app): aircraft report`.

### Task 4: Visual check

- [ ] **Step 1:** Throwaway golden of the hub card and `AircraftReport` with real fonts (HANDOFF recipe); check teal card contrast and tile grid; delete the test.
- [ ] **Step 2:** `flutter run --dart-define-from-file=.env` on the phone with the API running; screencap hub card and report; open a type sheet.
- [ ] **Step 3:** Commit fixes `fix(app): aircraft report polish`; update `docs/superpowers/HANDOFF.md`.
