# Handoff: nerd features (state at end of 2026-11-22)

Read this first, then `docs/superpowers/specs/2026-11-21-roadmap.md` (the source of truth for what's done and what's next).

## Where things stand
- **Done and merged to `main`:** roadmap #1–#5:
  - delete flights from the log;
  - unit toggles;
  - aircraft history (rotation timeline, own-flights sheet, recent legs);
  - flight timing (collapsible OOOI timetable, runways, DST-correct timezone shift);
  - flight profile charts.
- **Parked:** #6 sun side (the user did not like it; it may return later). #7 crosswind is parked too (needs the OurAirports `runways.csv` imported). **In progress on `feat/stats-passport` (not merged yet):** #8 stats "Passport" redesign (`specs/2026-11-22-stats-passport-design.md`): part 1 (hub, flight stats report, paged history, map, runway log, taxi, extremes) plus the v3 visual revision (passport card, round flags via `circle_flags`, locale numbers from the device, Flighty-style bars, y-axis chart, regions list). **#8 is done and merged** (parts 1–3: hub, flight stats, delay report `specs/2026-11-23-stats-delay-report-design.md`, aircraft report `specs/2026-11-23-stats-aircraft-report-design.md`). Known older bug: opening a months-old flight from stats shows "Failed to fetch flight data". Then design improvements on other screens (user's complaints: type hierarchy, alignment, scattered info, short airport names, nerd detail, clipped images), #9 home widgets, #10 exports, #11 alerts.
- **Profiles:** dropped by the user. Deleting flights from the log covers that need.

## How the user likes to work
- **Per feature:** brainstorm → short design with an ASCII sketch → approval → build on a `feat/<name>` branch → visual check → merge locally when asked.
- **Plans:** for small features the user may say "skip the plan, build straight". Larger ones got a plan in `docs/superpowers/plans/` and a fresh reviewer at the end.
- **Questions:** ask one decision at a time, with your pick and a sketch. The user decides fast and often says "whichever works better". Then decide and say why.
- **Nerd app:** show maximum detail, e.g. both IATA and ICAO codes and flight numbers, cities, local times, delays.
- **Reference app:** the user compares with Flighty. Patterns from it are welcome (rotation timeline, one-line summaries, sheets).

## UI rules (strict; see `app/DESIGN.md`)
- **Components:** use `app/lib/ui/`:
  - `tokens.dart`: `AeroColors`, `AeroRadius`, `AeroSpace`, `AeroText` (every token carries its fontFamily), `AeroMotion`;
  - `AeroButton`, `AeroPillButton`, `AeroPressable`, `AeroSheet` / `showAeroConfirm`, `AeroSegmented`, `UnitCycle`, `AirlineLogo`.
- **Banned:** stock Material looks — no `AlertDialog` or `SnackBar` (use toasts from `utils/error.dart`), no raw colors, radii or font sizes. `test/design_rules_test.dart` is a ratchet against `test/design_baseline.json`. When a legacy file's count drops, regenerate the baseline with `UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart`.
- **Tap targets:** everything tappable shows an affordance before it's touched: a pill button, a chevron, or a verb like "View".
- **Collapsible detail:** dense detail goes behind a "Show … details" pill (timetable and profile already do this).
- **Charts:** a `CustomPainter` on tokens, not fl_chart (the user finds its look ugly). No text on the plot: put readouts, strips and event lists around it.
- **Look before saying done:** render a throwaway golden preview with the real fonts:
  - Inter TTF at `$SCRATCHPAD/fonts/Inter.ttf` (download it again if the scratchpad was cleared);
  - CalSans from `app/assets/fonts/calsans.ttf`;
  - `MaterialIcons-Regular.otf` from the Flutter SDK cache.
  - Set `GoogleFonts.config.allowRuntimeFetching = false`. Look at the PNG, then delete the test.

  Emoji flags and Material Symbols render as boxes in tests. That's expected; it's only the test environment.
- **Migration:** legacy files are migrated whole when a feature touches them. `flight_info.dart` is still partly legacy (status banner, codeshare pill, airport conditions, booking card).
- **Skills:** Emil Kowalski's design skills are installed in `.claude/skills/` (`emil-design-eng`, `apple-design`, `gestures`, …). Use them.

## Gotchas
- **Run the app with** `flutter run --dart-define-from-file=.env` (without it the app can't reach the API). Flutter's configured JDK 25 is too new for Gradle 8.14; `org.gradle.java.home` (Zulu 17) in `app/android/gradle.properties` fixes it for this project only (the user's other projects need the global JDK). The path is machine-specific.
- **Aircraft types:** registry `modelCode` is a manufacturer model ('777-31HER'), not an ICAO designator. Type codes come from FlightAware `aircraftType`; `stats/families.ts` holds the ICAO→name table. The debug package is `fyi.procrastinator.aero.debug`. The phone is a foldable: `adb exec-out screencap -p -d 4633128672291735937`.
- **Optional int query params:** use `OptionalIntPipe` (`api/src/common/pipes`), not `ParseIntPipe({optional})`: the global ValidationPipe turns a missing number query into NaN.
- **Locale:** `initLocale()` runs before `runApp`; display numbers via `formatCount`/`formatDecimal`, never `toStringAsFixed`.
- **Parallel subagents:** worktree agents start at a stale commit; tell them to `git reset --hard <base>` first and to use the Edit tool, not shell heredocs (one hung on a bare `cat`).
- **No `git stash`** on this tree. Something keeps re-adding an `exclude:` block to `app/analysis_options.yaml`, and stash pop conflicts on it. Uncommitted user files to leave alone: `api/dump.rdb`, `app/analysis_options.yaml`, `app/pubspec.lock`, `api/scripts/`, `.claude/settings.local.json`.
- **`dart format`:** never run it on whole directories. It reformats legacy files; format only the files you own.
- **API:**
  - Use bun. Run tests with `cd api && bunx jest <path>`.
  - The old Nest boilerplate `*.spec.ts` files fail because they can't resolve their dependencies. That's not caused by our changes.
  - `bun install` fails on `@openjs/opensky` (JSR 404). It's unused.
- **Dart client:** `./generate-openapi-client.sh` uses openapi-generator 7.25. Boot the API once first: `api/src/main.ts` writes `api/openapi.json` on boot. The user may have a dev server running in watch mode, which rewrites `openapi.json`; leave it running.
- **FlightAware:**
  - Rate limit is 10/min, global, and `checkRateLimit` *sleeps* when it's full.
  - `/flights/{ident}` takes `ident_type` (designator | registration | fa_flight_id). Registrations go without the dash (`A6EPO`).
  - FA only keeps about 10 days; older lookups 404.
  - Position altitude is in **hundreds of feet**.
- **Lookups add to the log:** opening any flight creates a `Flight` row for the user. That's accepted behaviour; the user deletes lookups by swiping.
- **`formatClock`:** the time formatter in `formatters/units.dart` is called `formatClock`. `formatters/time.dart` already has a different `formatTime`.

## Deferred minors (from reviews)
- Map bar: the FL flip-counter rolls digits at the 1,000 ft boundary instead of crossfading.
- Units: the "nm" label could read "NM".
- Unit-cycle test gaps: the first-ever double tap, and the map bar below 1,000 ft.
- Aircraft history: inbound data can be about 3 minutes stale in the worst case; a duplicate doc comment above `searchFlightsByIdent`.
- Delete flight: two DELETEs racing returns a 500 instead of a 404 (use a `deleteMany` count check).
- Flight timing and profile were built without a fresh-reviewer pass, at the user's request. Neither the map scrub marker nor the profile has been seen on a real device.
