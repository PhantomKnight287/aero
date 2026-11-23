# Stats Passport part 3: Aircraft report (short design)

Parent spec: `2026-11-22-stats-passport-design.md` ("Aircraft report", "Aircraft family" data rule). Layout approved by the user on 2026-11-23.

## Intent
The hub's "Most flown aircraft" card opens an Aircraft report that answers "what have I flown on". It includes the actual list of flights per type. The card also loses its pale periwinkle gradient, which the user reads as a stock-Material tint.

## Approaches
- **The server aggregates and the app renders (picked).** Same as parts 1 and 2: a new `aircraft` section in `GET /v1/profile/@me?year=`. One fetch per year switch.
- The app computes it from history pages: rejected, as in parts 1 and 2.
- Card style (user picked A): a dark blue-teal gradient with white text, matching the Passport and Delay cards. Rejected: B, the photo-led card (no-photo fallback, poor contrast) and C, the white card (breaks the three-card pattern).

## Data
- **Per flight** (`StatsFlight` gets `reg?`, `typeCode?`, `typeName?`):
  - `reg` is the stored aircraft reg/registration, otherwise the FlightAware registration.
  - `typeCode` (ICAO, e.g. `B77W`) is FlightAware `aircraftType`, otherwise the registry `modelCode` for the reg.
  - `typeName` is the registry `typeName` for the reg, otherwise the registry's typeName for that `typeCode`, otherwise the `typeCode` itself.
  - The registry lookups move out of `profile.service.ts` into `stats/aircraft-index.ts`, a bulk-loaded index like `airport-index.ts`.
- **`aircraft` section:**
  - `basedOn`: the number of counted flights that have a `typeCode` or `typeName`.
  - `types[]`: typeCode, typeName, image (from the registry), flightCount, and `flights[]` (`StatsFlightSummaryEntity`, newest first). Sorted by count, descending.
  - `families[]`: one entry for every family in the server's static map, flown or not:
    - family name, `typeCodes`, flightCount, `firstFlown` (local date, or null);
    - order: the flown families by count, then the unflown ones in map order.
  - `airframes`:
    - `medianAgeYears`;
    - `oldest` and `newest`, each with reg, typeCode, typeName, ageYears, image and its flight summary. Only airframes with an age count;
    - `mostFlownTail`: reg, typeName and count, shown only when the count is at least 2.
- **Family map (server):**

  | Family | Type codes |
  |---|---|
  | A220 | BCS1, BCS3 |
  | A320 family | A318, A319, A320, A321, A19N, A20N, A21N |
  | A330 | A332, A333, A338, A339 |
  | A340 | A342, A343, A345, A346 |
  | A350 | A359, A35K |
  | A380 | A388 |
  | 737 | B735–B739, B37M, B38M, B39M, B3XM |
  | 747 | B744, B748 |
  | 757 | B752, B753 |
  | 767 | B762, B763, B764 |
  | 777 | B772, B773, B77L, B77W, B778, B779 |
  | 787 | B788, B789, B78X |
  | ATR | AT43, AT45, AT72, AT75, AT76 |
  | Dash 8 | DH8A, DH8B, DH8C, DH8D |
  | E-Jets | E170, E75L, E75S, E190, E195, E290, E295 |
  | CRJ | CRJ1, CRJ2, CRJ7, CRJ9, CRJX |

- **Legacy `aircraftStats` / `mostFlownAircraft`:** only the hub card reads them (checked), so they are removed from the response together with the old registry block in `profile.service.ts`. The hub card reads `aircraft.types[0]`.

## App
- **Token:** `AeroAccent.aircraftGradient` becomes a deep blue-teal (for example `#0f4c6e` → `#082a3d`). `aircraftInk` is retired in favour of `onInk`, plus a muted `onAircraftMuted`.
- **Hub card:** "Most flown aircraft", then the type name (display), then "13 flights · A388". The photo band stays (16:9, flush). A `SummaryCard`-style CTA "All aircraft stats ›" pushes `/profile/stats/aircraft` with the year.
- **`aircraft_report.dart`** on `ReportScaffold`, with these sections:
  - **Aircraft types:** hero "N types flown". `StatBarList` rows (code + name), the top 8, then "Show more". Each row has a chevron; tapping it opens an `AeroSheet` titled with the type name, listing that type's flights as `PastFlightRow`s. A flight row pops an `OpenFlightRequest`.
  - **Type collection:** hero "N of 16 families". A 3-column grid of tiles: family name, count, "first 3 Mar 2024". Unflown tiles are muted, with no count.
  - **Airframes:** hero "median age X yrs". Oldest and Newest rows (photo thumb, typeCode · reg, age), each tappable to open its flight. "Most flown tail" row.
  - Footer: "based on N flights with aircraft data".
  - Empty state: "No aircraft data for this period yet."

## Non-goals
- Airline tail art.
- Seat maps.
- Per-registration history: the aircraft history feature already covers it.
- Share pills.

## Left to the builder
- The exact teal hex values (must pass a contrast check with white text).
- The tile styling.
- The file split under `sections/`.
