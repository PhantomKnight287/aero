# Stats Passport v3 Visual Revision Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Apply the user's 12-point device review: a passport that looks like a passport; round flags; localised numbers; Flighty-style ranking bars, comparison bars, stacked flight counts and y-axis chart; grey units; a regions list; and a properly framed aircraft photo. Also resolve two data oddities.

**Architecture:**
- **App:** shared widgets change first (bars, pills, chart, unit text, flags, number formatting), then the hub and the report re-compose them.
- **API:** one small entity change (`ContinentEntity.flightCount`), plus airport-key hardening if the 87-airports check confirms double keys.

**Tech Stack:**
- Flutter: `intl` (installed), `circle_flags` (new), `flutter_map` 8;
- NestJS + Prisma, Jest (bun).

**Spec:** `docs/superpowers/specs/2026-11-22-stats-passport-design.md`, section "v3 visual revision". Mockup: `.superpowers/brainstorm/893-1795343443/content/stats-v3.html`.

## Global Constraints
- **The part-1 constraints still bind:** tokens only, no fl_chart, no text on plot areas, affordances on tappables, white background, no `git stash`, never `git add -A`, `dart format` only owned files.
- **Leave uncommitted:** `api/dump.rdb`, `app/analysis_options.yaml`, `.superpowers/`, `.claude/`.
- **Pub churn:** `app/pubspec.lock` is committed only by Task 3, together with the `circle_flags` dependency.
- **Numbers:** every displayed number goes through the locale-aware formatter from Task 2. `Intl.defaultLocale` comes from the phone (`findSystemLocale()` from `package:intl/intl_standalone.dart`) before `runApp`. en_IN → "4,96,500"; en_US → "496,500".
- **Unit letters** (h, m, d, km, mi, nm, ft) render grey (`AeroColors.muted`) and smaller than the digits, via the Task 4 `UnitText` widget.
- **No emoji anywhere** in stats UI. Flags use `CountryFlag` (Task 3). Comparison icons are painted.
- **Accent colours** only on stats cards and charts. Ranking bars use `AeroAccent.passport` with no track.
- **Branch:** `feat/stats-passport` (continue on it).

## Review Focus
1. **7-digit localised values at 360 dp width** (e.g. "49,65,000 km", "1,234h 56m"): no overflow or clipping on the passport card or in the grids. (Test: Task 5 `passport fits 7-digit values at 360dp`, Task 6 `time grid fits large values`.)
2. **A country code with no flag asset** (e.g. 'XK' or a junk code): shows a neutral grey circle, no crash. (Test: Task 3 `unknown code falls back`.)
3. **A year with zero flights:** the chart y-axis shows 0..1 ticks with no division by zero; the regions and countries lists are hidden. (Test: Task 4 `axis for all-zero values`, Task 6 `empty year hides lists`.)
4. **More than 11 countries:** the passport flag row shows 11 overlapping flags plus "+N". Exactly 11 shows no "+0". (Test: Task 5 `flag row overflow label`.)
5. **Locale without grouping or with a different separator** (e.g. de_DE "496.500"): the formatter follows the locale, and tests set `Intl.defaultLocale` explicitly so they're deterministic. (Test: Task 2 `formats per locale`.)

---

### Task 1: API — region flight counts, airport-key check, CGP→CGP check

**Files:**
- Modify: `api/src/resources/profile/stats/sections/places.ts`, `api/src/resources/profile/entities/stats-sections.entity.ts` (`ContinentEntity.flightCount: number`, `@ApiProperty({ type: Number })`)
- Possibly modify: `api/src/resources/profile/stats/stats-flight.ts` (airport key)
- Test: `sections/places.spec.ts`, `stats-flight.spec.ts`
- Regenerate: `api/openapi.json` (written by the user's running dev server) + `./generate-openapi-client.sh`

**Interfaces:**
- Produces: `continents()` rows `{ bucket, countryCount, flightShare, flightCount }`, where `flightCount` = flights touching the bucket, counted once per flight. Dart `ContinentEntity.flightCount` (num).

- [ ] **Step 1:** Failing test `continents flightCount counts each flight once`: DEL→BOM, DEL→DXB → asia `flightCount 2`, middle_east `flightCount 1`.
- [ ] **Step 2:** Implement and run `cd api && bunx jest src/resources/profile/stats`. Expected: PASS.
- [ ] **Step 3: Airport-key check (read-only).** Write a throwaway bun script under `$SCRATCHPAD` (not the repo) that loads the user's counted flights through `loadCountedFlights` and prints:
  - airports grouped by `key`, with their `iata`/`icao`/`name`;
  - any two keys that share a name or an IATA code.

  Use the dev DB from `api/.env`. The user id is the one owning the most `Flight` rows.
  - If duplicates exist: add a failing test `airport keyed through index row` (one flight stored with IATA only, one with ICAO only, same airport in the index → one key), then key airports by the index row's `ident` when a row is found. Fall back to `icao ?? iata`.
  - If there are none: record the evidence in the report and change nothing.
- [ ] **Step 4: CGP→CGP check (read-only), same script approach.** Print the raw stored `departure`/`arrival` JSON, `flightNo`, `callSign` and FA `status`/`diverted` for the shortest-distance record.
  - If it is a return-to-origin (departure airport == arrival airport): add a failing test `records skip same-airport flights` and exclude flights where `dep.key === arr.key` from distance and duration records only. They still count as flights.
  - If it is a normaliser bug: fix it with a test.
- [ ] **Step 5:** Commit as `feat(api): region flight counts; stats data fixes`. Let the dev server rewrite `api/openapi.json` (check `flightCount` is there), run `./generate-openapi-client.sh`, and commit as `chore: regenerate OpenAPI client`.

### Task 2: Locale-aware numbers, app-wide

**Files:**
- Modify: `app/lib/main.dart` (before `runApp`: `Intl.defaultLocale = await findSystemLocale();`)
- Modify: `app/lib/formatters/units.dart` (replace `NumberFormat.decimalPattern('en_US')`)
- Modify: `app/lib/screens/profile/stats/main.dart`, `app/lib/screens/profile/stats/sections/shared.dart` (use the shared helpers, drop their own `NumberFormat`s)
- Test: `app/test/number_format_test.dart`

**Interfaces:**
- Produces, in `app/lib/formatters/units.dart`:
  - `String formatCount(num v)`: integer, grouped, locale-aware.
  - `String formatDecimal(num v, {int digits = 1})`: fixed decimals, grouped.

  `formatDistance` etc. use `formatCount` internally. Create the `NumberFormat` per call, or cache it per `Intl.getCurrentLocale()`, so a locale change is respected.
- [ ] **Step 1:** Failing tests `formats per locale`:
  - with `Intl.defaultLocale = 'en_IN'`: `formatCount(496500) == '4,96,500'` and `formatDistance(384576, DistanceUnit.km) == '3,84,576 km'`;
  - `'en_US'` → `'496,500'`;
  - `'de_DE'` → `'496.500'`.

  Initialise date and number symbols as the intl package requires (`initializeDateFormatting` if needed).
- [ ] **Step 2:** Implement. Run `flutter test test/number_format_test.dart test/units_format_test.dart`. Expected: PASS (update `units_format_test` expectations only if they hard-code en_US and the test doesn't set a locale; set `Intl.defaultLocale = 'en_US'` there).
- [ ] **Step 3:** Commit as `feat(app): locale-aware number formatting from the device locale`.

### Task 3: Round flags

**Files:**
- Modify: `app/pubspec.yaml`, `app/pubspec.lock` (add `circle_flags`)
- Create: `app/lib/ui/components/country_flag.dart`
- Test: `app/test/country_flag_test.dart`

**Interfaces:**
- Produces: `CountryFlag({required String iso2, double size = 24, Color? ring})`. It is a circular flag. An unknown or empty code renders an `AeroColors.surfaceAlt` circle. `ring` draws a 2 dp outer ring, used for overlapping rows on the passport.
- [ ] **Step 1:** `cd app && flutter pub add circle_flags`. Confirm it resolves with the current SDK, and note the version.
- [ ] **Step 2:** Failing tests:
  - `renders a flag for IN`: finds the package's flag widget;
  - `unknown code falls back`: `'XX'` and `''` render a container, with no exception in `tester.takeException()`.
- [ ] **Step 3:** Implement and run the test. Expected: PASS. Run `flutter test test/design_rules_test.dart`, which must pass with no new baseline entries (colours via tokens).
- [ ] **Step 4:** Commit `app/pubspec.yaml`, `app/pubspec.lock`, the component and the test as `feat(app): round country flags`.

### Task 4: Shared widgets — ranking bars, comparison bars, y-axis chart, grey units

**Files:**
- Modify in `app/lib/screens/profile/stats/widgets/`: `stat_bar_list.dart`, `comparison_pill.dart`, `bar_chart.dart`, `stat_section.dart`
- Create: `app/lib/screens/profile/stats/widgets/unit_text.dart`
- Test: `app/test/stats_widgets_test.dart` (extend)

**Interfaces:**
- Produces:
  - `UnitText(List<(String, bool)> parts, {required TextStyle style})`: each part is (text, isUnit). Unit parts use `style.copyWith(color: AeroColors.muted, fontSize: style.fontSize! * 0.55, fontWeight: FontWeight.w500)` and sit on the digits' baseline, rendered as one `Text.rich`.
  - Helpers:
    - `UnitText.duration(int minutes, {required TextStyle style})` gives "623h 24m" with h/m as units; under an hour, "38m". From 1 day up, `UnitText.days` gives "25d 23h".
    - `UnitText.distance(num km, DistanceUnit u, {required TextStyle style})` gives "4,96,500 km".
  - `StatSection.hero` now accepts a `Widget heroWidget` alternative to `hero`/`heroUnit` strings, so sections can pass `UnitText`.
  - `StatBarList`: bars have no track. Bar height 22, radius `AeroRadius.sm`, width proportional to value/max of the available width minus the count label. The count sits right after the bar's end in `AeroText.body` muted tabular. The leading label column is a fixed 44 dp for codes, or an `AirlineLogo` of 28 dp. The `.switchable` API is unchanged.
  - `ComparisonPill({required ComparisonIcon icon, required double fraction, required String value, required String label})`:
    - full width, 48 dp, `AeroRadius.pill`, with an `AeroAccent.passport` fill;
    - a 40 dp circle painted by `ComparisonIcon.earth|moon|sun` (radial gradients; add tokens for the 3 icon colours);
    - text "12.4× Around Earth", value bold and label regular, right-aligned inside, white when the fill reaches the text and ink otherwise.
  - `BarChart(values, labels, color)`: adds a left y-axis column with 4–5 "nice" integer ticks (e.g. max 13 → 0,4,8,12,16), light `AeroColors.line` gridlines behind the bars, and tick labels outside the plot. An all-zero input gives ticks 0..1.
- [ ] **Step 1:** Failing tests:
  - `UnitText marks units grey`: `UnitText.duration(37404)` → spans '623','h',' 24','m', with the unit spans' colour == `AeroColors.muted`;
  - `ranking bar has no track`: no `Container` with `surfaceAlt` colour inside `StatBarList`;
  - `axis ticks are nice`: the static `niceTicks(13)` == [0,4,8,12,16], `niceTicks(0)` == [0,1];
  - `axis for all-zero values`: pumps without exception;
  - `comparison pill fills and caps`: fraction 3.0 renders a full-width fill.
- [ ] **Step 2:** Implement. Run `flutter test test/stats_widgets_test.dart test/design_rules_test.dart`. Expected: PASS, no new baseline entries.
- [ ] **Step 3:** Commit as `feat(app): ranking bars, comparison bars, y-axis chart, grey units`.

### Task 5: Hub — passport card, delay card, aircraft photo

**Files:**
- Modify: `app/lib/screens/profile/stats/main.dart` (hub)
- Create: `app/lib/screens/profile/stats/widgets/passport_card.dart`
- Test: `app/test/stats_hub_test.dart` (extend)

**Interfaces:**
- Consumes: Tasks 2–4 (`formatCount`, `CountryFlag`, `UnitText`), and the stats `countries[]` for the flag row.
- Produces: `PassportCard({required ProfileStatsResponseEntity stats, VoidCallback? onOpen})`.

The card's look (spec item 12, mockup left phone):
- **Top:** indigo gradient with the "AERO PASSPORT" CalSans title (letter spacing +0.5), the subtitle "PASSPORT · PASSEPORT · पासपोर्ट" (`AeroText.label`, `onPassportMuted`) and the emblem tile at top right.
- **Flag row:** `CountryFlag` 24 dp overlapping by 8 dp with a 2 dp ring in the gradient colour; at most 11 flags, then "+N · M countries".
- **Stats:**
  - **Row 1:** two columns, FLIGHTS (with "N long haul" under it) and DISTANCE (`UnitText.distance`, with "12.4× around Earth" under it). Values about 30 pt w800, `FittedBox(fit: scaleDown)` per value.
  - **Row 2:** three columns, TIME (`UnitText.days`), AIRPORTS and AIRLINES, at about 24 pt.
- **Machine-readable strip:** a translucent band with two monospace lines (add `AeroText.mono` with `fontFamily: 'monospace'` fallback; no new font asset), built by the pure function `passportMrz(stats) → (String, String)`:
  - line 1: `P<AERO<` + (`ALLTIME` or year) + `<<` + flights + `<FLT<<` + countries + `<CTRY`;
  - line 2: first airport IATA of the earliest flight (or `XXX`) + `<<FIRST<FLT<` + first year + `<<ISSUED<` + today as `ddMMMyy` uppercase;
  - both right-padded with `<` to 44 chars, no user name.
- **CTA row:** "All flight stats ›".
- **Delay card:** hero `UnitText` ("15" + grey " h", or minutes under 1 h), then "lost to delays" and the existing subtitle.
- **Aircraft card:** the photo bleeds to the left, right and bottom card edges: `ClipRRect` on the card's bottom corners only, `AspectRatio(16/9)`, `BoxFit.cover`. With no photo there's no band.

- [ ] **Step 1:** Failing tests:
  - `passport fits 7-digit values at 360dp`: set the window to 360 wide with distance 4965000 km → `tester.takeException()` is null and no `RenderFlex` overflow;
  - `flag row overflow label`: 36 countries → "+25 · 36 countries"; 11 countries → no "+";
  - `passportMrz pads to 44 and never contains the user name`;
  - `aircraft photo is 16:9 cover`: finds an `AspectRatio` with 16/9 holding an image with `BoxFit.cover`.
- [ ] **Step 2:** Implement. Run `flutter test test/stats_hub_test.dart test/design_rules_test.dart`. Expected: PASS.
- [ ] **Step 3:** Commit as `feat(app): passport card, delay and aircraft cards v3`.

### Task 6: Report — flights, distance, time, countries, regions

**Files:**
- Modify in `app/lib/screens/profile/stats/sections/`: `flights_section.dart`, `distance_section.dart`, `time_section.dart`, `countries_section.dart`, `extremes_section.dart`, `top_lists_section.dart`, `runways_section.dart`
- Modify: `app/lib/screens/profile/stats/passport_header.dart` (remove the flag `Wrap` and the summary strip; keep the map)
- Test: `app/test/stats_report_test.dart` (extend)

**Interfaces:**
- Consumes: Tasks 1–4. `ContinentEntity.flightCount`.

Content (spec items 1, 3, 6, 7, regions):
- **Flights:** the hero number, then three stacked lines with the number in w700 and the label grey, about 20 pt ("**38** domestic" …), then the "FLIGHTS PER" `AeroSegmented` and the y-axis `BarChart`.
- **Distance:**
  - the hero `UnitText.distance`;
  - the other unit in grey at about 18 pt;
  - "Average distance: …";
  - three `ComparisonPill`s: Earth 40,075 km, Moon 384,400 km and Sun about 940,000,000 km (the orbit circumference);
  - records.
- **Time:** the hero `UnitText.duration(blockMinutes)`, then a 2-column grid: Days (decimal), Avg flight, In the air ("N flights with data") and Taxiing. Each value is a `UnitText` at about 26 pt in a `FittedBox(scaleDown)`. Weeks are removed. Then the records.
- **Countries:** list rows with a 30 dp `CountryFlag`, the name (w600) and "N flights" (muted), top 3, then a "Show more" sheet with the same rows.
- **Regions:** a list right under it in the same row style, "Asia" with "14 countries · 82 flights", showing only buckets with `flightCount > 0`, sorted by `flightCount` desc. The tile grid is removed.
- **Extremes:** the flag via `CountryFlag` (20 dp) replaces the emoji.
- **Top lists / runways:** use the new `StatBarList` (Task 4); the labels are unchanged.

- [ ] **Step 1:** Failing tests:
  - `flights shows stacked lines`: finds `'domestic'` and `'international'` in separate `Text` widgets;
  - `regions list replaces grid`: finds `'14 countries · 82 flights'`, and no `GridView` or 3-column tile widget;
  - `empty year hides lists`: no countries or regions → neither the section title nor the rows;
  - `time grid fits large values`: blockMinutes 7404960 at 360 dp → no overflow;
  - `no emoji in report`: no `Text` whose data contains a regional-indicator code point (U+1F1E6–U+1F1FF) or 🌍🌕☀.
- [ ] **Step 2:** Implement. Run `flutter test test/stats_report_test.dart test/stats_widgets_test.dart test/design_rules_test.dart`. Expected: PASS.
- [ ] **Step 3:** Commit as `feat(app): report v3 — stacked flights, comparison bars, time grid, countries and regions`.

### Task 7: Visual check and docs

- [ ] **Step 1:** Golden preview (DESIGN.md §7) of the hub and the report at 390 wide with en_IN numbers and the user's real-ish values. Look, fix, then delete the test.
- [ ] **Step 2:** Phone pass. The user's phone (adb `RZGL80FNCXR`, screencap `-d 4633128672291735937`) is unlocked. `flutter run -d RZGL80FNCXR` in the background, then go to Profile → Flight Stats: All-time, then 2025, then "All flight stats". Screenshot every screen to `$SCRATCHPAD/shots/v3-*.png`, look at each against the mockup, and fix what's off. Then stop `flutter run`.
- [ ] **Step 3:** Full suites: `cd api && bunx jest src/resources/profile src/resources/flight/flight-history.spec.ts src/common` and `cd app && flutter test`.
- [ ] **Step 4:** Update `docs/superpowers/HANDOFF.md` and roadmap row #8. Commit as `docs: stats Passport v3 done`.
