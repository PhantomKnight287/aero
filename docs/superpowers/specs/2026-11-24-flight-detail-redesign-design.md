# Flight detail redesign

The user approved the layout and approach A on 2026-11-24. Flighty is the benchmark (screenshots shared in conversation, DL 958 LAX→JFK).

## Intent
The flight detail sheet (`app/lib/screens/home/widgets/flight_info.dart`) is outdated, info-heavy and oddly structured. The user's diagnosis is "wrong order and grouping", not too much data. This is a nerd app, so **every piece of information stays**. It gets reordered and regrouped the way Flighty does it, on Aero's white theme and design system.

## Goals
- What matters now comes first: status, then big times with gates.
- Each time appears in one primary place. The route block shows the best-known time. The timetable shows scheduled and actual side by side.
- Consistent sections: plain-language titles, `AeroText.sectionTitle`, and the tokens and components from `app/lib/ui`.
- A whole-file migration of `flight_info.dart`, so its design-baseline entry drops to zero.
- Two additions: status colours, and "My history on this route".

## Non-goals
- Dark theme, Pro upsells, notes, a bottom share bar, airline phone/website/social buttons.
- FlightAware Foresight or any predicted times. Aero cannot use them. The data is scheduled, estimated (`revisedTime`) and actual only.
- Restyling the airport sheet (`airport_details_sheet.dart`). It is linked to, not changed. That is a later project.
- The map, the top info bar, and the sheet host in `home/main.dart`. Only `FlightInfoWidget`'s contents change.

## Anti-goals
- Losing data that is visible today. Airport conditions move behind a tap (the airport sheet already shows delays, METAR and TAF in full). Nothing else disappears.
- Zero or empty values shown as facts ("Delay 0m · Cause: None", "Age 0 months").
- Stock Material visuals: `PopupMenuButton` styling, `SnackBar`, `ListTile`, raw colours or sizes.

## Constraints
- DESIGN.md plus `test/design_rules_test.dart` (a ratchet). Regenerate the baseline after the migration.
- **Aircraft age and photo are first-class** (user, 2026-11-24): "treat it like it exists even now". Both get real slots. Only one airframe's missing or unknown value is hidden, because registry age `0` means unknown.
- Existing migrated widgets are reused: `FlightTimetable`, `FlightProfile`, `AircraftSection`, `TimezoneShift`, `AirlineLogo`, `AeroSheet`, `AeroPillButton`, toasts from `utils/error.dart`.
- Times are in each airport's local time zone, and the 12h/24h choice follows the device, as today.

## Approaches
- **A. Rewrite `flight_info.dart` whole into section files, and only link to the airport sheet (picked).** One screen, one merge.
- B. A plus restyle the airport sheet: rejected for now. It doubles the scope, and the sheet is its own screen.
- C. Reorder inside the existing file: rejected. It breaks the "migrate legacy files whole when touched" rule.

## Layout (top to bottom)

```
 [logo] WN 4187 · SWA4187 · MON 23 NOV         ⋮  ✕
        St Louis to Phoenix
        also sold as AA 1234
┌──────────────────────────────────────────────────┐
│ In flight · lands in 40m           (tinted band) │
└──────────────────────────────────────────────────┘
 ↗ STL · KSTL · St Louis Lambert Intl  ›
 9:42  9:35̶                              ┌──────┐
 7m late · departed 2h 10m ago           │ ↗ E4 │ Terminal 2
 ── ◷ 3h 24m · 2,428 km ──────────────────────────
 ↘ PHX · KPHX · Phoenix Sky Harbor Intl  ›
 12:06  11:40̶                            ┌──────┐
 26m late · arrives in 40m               │ ⊟ -- │ Terminal 4
 Good to know
 Timetable / Flight profile / Aircraft / My history on this route /
 Booking / Airline
```

1. **Header.**
   - Logo (`AirlineLogo`).
   - Kicker: IATA ident · ICAO ident · weekday and date, in departure-local time. Uses `AeroText.label` styling.
   - Title: "City to City" (`AeroText.title`).
   - "also sold as …" from `codesharesIcao`, only when there are codeshares. It replaces the old codeshare card.
   - **⋮ menu** with every existing action: refresh tracking, refresh flight data, send to wearable, get alerts, booking details, share. It opens as an `AeroSheet` action list, not a `PopupMenuButton`.
   - Close ✕.
2. **Status band.** A rounded tinted band with a single line.
   - Text by phase:
     - "Departs in 3h 12m"
     - "Boarding soon"
     - "Taxiing"
     - "In flight · lands in 40m"
     - "Landed 12m ago"
     - "Arrived at gate"
     - "Cancelled"
     - "Diverted to XXX"
   - Colour:
     - success tint when on time (arrival estimate not more than 15 min late);
     - warn tint when late;
     - danger tint when cancelled or diverted.
   - The ">7 days old, data may be inaccurate" note becomes a muted caption under the band, no longer a separate banner.
3. **Route block** (replaces `FlightRouteInfo`). For each side:
   - The airport row, "↗ STL · KSTL · St Louis Lambert Intl ›", taps open the existing airport sheet through a new `onAirportTap` callback, wired to `home/main.dart`'s `_showAirportDetailsSheet`.
   - **Big time** (new `AeroText` token, about 40 px, tabular): actual, otherwise revised, otherwise scheduled. Colour: green if early or on time, warn if late (more than 15 min), danger if cancelled. Scheduled time shown struck through and muted when it differs.
   - **Status line:** "7m late · departed 2h 10m ago", "3m early · arrives in 4h 13m", or "On time · in 2h".
   - **Gate chip:** a bold rounded chip with ↗ gate on departure and ↘ gate on arrival, with "Terminal N" under it. On arrival, baggage claim shows as a second smaller chip ("⊟ 7") when known. "--" when the gate is unknown.
   - **Between the two sides:** "◷ block time · distance", with a hairline (distance through `UnitCycle`, as today).
4. **Good to know** (a list of one-line rows, each shown only when it applies):
   - timezone shift (`TimezoneShift`, restyled as a row);
   - weather: "STL 6°C clear · PHX 16°C partly cloudy ›", from `airport.conditions.observation` (temperature in the user's unit plus the condition text). It opens the airport sheet for the departure airport. One row per airport if both don't fit;
   - airport delay: only when a delay is non-zero, e.g. "PHX arrivals delayed ~25m · cause". Tapping it opens the airport sheet;
   - "data may be outdated" for flights older than 7 days, if it isn't already under the band.
5. **Timetable.** The existing `FlightTimetable` content is reorganised into Scheduled and Actual columns, with gate out, takeoff (with runway), landing (with runway) and gate in. Delay pills stay in the Actual column. A taxi-out / taxi-in / block line goes underneath. The "Show timing details" pill keeps its extra detail.
6. **Flight profile:** `FlightProfile` unchanged (20 or more positions).
7. **Aircraft:** the existing `AircraftSection`, whole. Its title becomes the model name (e.g. "Boeing 737 MAX 8"), resolved from the ICAO type through the server's table, with the raw code as subtitle. Photo, age, registration and the inbound/rotation timeline stay as they are (see the calls below).
8. **My history on this route** (new). Hidden when there are 0 previous flights.
   - "LAX → JFK" subtitle, then flights, distance and time, matching the stats style, then up to 3 previous flights as `PastFlightRow`.
   - Tapping a row opens that flight.
   - "This flight" is never counted in the history.
9. **Booking** (only when `bookings` is non-empty): booking code, seat and type, class, reason, as token-styled rows instead of `ListTile`s.
10. **Airline:** name, IATA · ICAO, callsign (when known). No buttons.
11. Footer: the Jet2 easter egg stays.

## Data
- **Model name for the aircraft title.**
  - The API exposes an ICAO type → model name table: `stats/families.ts` `TYPE_NAMES`, served as a field on the flight response, e.g. `aircraftTypeName`.
  - The app doesn't keep its own copy. If the flight response already carries a type name, that is used first.
- **My history on this route:**
  - New `GET /v1/flight/route-history?dep=<ICAO>&arr=<ICAO>&exclude=<flightId>`.
  - It returns `{ flightCount, distanceKm, blockMinutes, recent: StatsFlightSummaryEntity[3] }`.
  - It uses `loadCountedFlights` and the same normalisation as stats. A route matches in this direction only (LAX→JFK, not JFK→LAX).
  - It is fetched lazily when the sheet opens.
- **Status band phase rules** use FlightAware OOOI actuals when present (`actualOut` / `actualOff` / `actualOn` / `actualIn`), then the stored departure and arrival times.
  - "Boarding soon" means 0–40 min before scheduled out with no `actualOut`.
  - "Taxiing" means `actualOut` is set but `actualOff` is not.

## Testing
- **Widget tests** for the status band (each phase, on fixture `FlightResponseEntity`s), route block colours and strike-through, gate chip "--", hiding "Age 0", and the ⋮ sheet listing all six actions.
- **API Jest test** for route history: direction, exclusion of the current flight, and the empty result.
- **Golden preview** with real fonts, then a phone pass on an in-flight flight and a landed flight.

## Calls made after the builder check (my calls; the user can override)
- **Aircraft section:** `AircraftSection` already draws the model heading, photo, age (including age on the flight's day), registration with registry country, registration history and raw data. It stays the single aircraft section, so there is no second photo or age row. The only change is that its title shows the model name (with the code as subtitle). Its content and order stay as they are.
- **Missing photo or age:** the slots stay, consistent with "treat it like it exists". A missing photo shows a 16:9 muted placeholder reading "No photo yet". A missing or zero age reads "Age unknown". Nothing collapses.
- **Route history:** every counted flight on the same directed route except the one being viewed, whatever its date. `recent` holds the 3 newest. Counts cover all of them.
- **Diverted flights:** the arrival side shows the airport the flight actually went to (FlightAware `destination*`), with "planned PHX" under the airport row. The band reads "Diverted to XXX". The airport sheet and weather use the actual airport when it's in the airport table, otherwise the planned one.
- **Which actual:** gate times (`actualOut` / `actualIn`) drive the big times, colours and "departed / arrives" text, as Flighty does. Runway times appear only in the timetable.
- **Late cutoff:** late means more than 15 minutes, everywhere (band, big-time colour, status line). This matches the stats delay rule, so exactly 15 minutes counts as on time.

## Left to the builder
- The exact big-time size token, and the tint values (built from the existing success, warn and danger tints).
- The section file split under `screens/home/widgets/flight_detail/`.
- Whether the weather row is one combined line or two lines.
