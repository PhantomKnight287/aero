# Stats "Passport" redesign — design

Replaces the stats screen (`app/lib/screens/profile/stats/main.dart`, about 1,680 lines) and absorbs roadmap #8 (`2026-11-21-stats-revamp-design.md`). Status: approved by the user on 2026-11-22.

## Intent
The user finds the current stats screen poorly designed:
- no type hierarchy and no alignment;
- information scattered and repeated;
- airports shown by short codes only;
- no nerdy detail;
- clipped and broken images.

They want it to work like Flighty's Passport (23 reference screenshots reviewed in the brainstorm), in Aero's white skin. Aero is a nerd app: show everything that identifies a thing.

## Goals
- **Hub screen.** It replaces `/profile/stats` and keeps the "Flight Stats" entry in Profile. From top to bottom:
  - the title "Passport" (CalSans display);
  - a year filter: All-time, then every year that has a flight, newest first;
  - three summary cards, each with a Share icon and an "All … stats ›" button:
    1. **Passport card**, indigo gradient: flights (with the long-haul count), distance (with "× around Earth"), time, airports, airlines. Opens the flight stats report.
    2. **Delay card**, red gradient: hours lost to delays, plus how late delayed flights were on average. Opens the delay report.
    3. **Most flown aircraft card**, pale periwinkle gradient: type name, flight count, and an aircraft image at a fixed aspect ratio (never cropped). Opens the aircraft report.
  - **Past flights:** your whole log, newest first, loaded page by page, grouped by year ("2025 · 21 flights").
    - Each row shows the airline logo, "EK 215 · UAE215", "DXB → LAX", "Dubai to Los Angeles" and the date.
    - Tapping a row opens the flight, as the home list does.
- **Flight stats report header (Flighty's passport screen):**
  - **World map:** a still `flutter_map`, not draggable, using the app's existing map tile setup in a light white/grey style.
    - Draws a great-circle arc in passport indigo for every unique route, plus a dot per airport.
    - Fits the bounds of all airports in the selected year.
    - Tapping it does nothing in this project. A full-screen map you can move around may come later.
  - **Flag row:** emoji flags, one per country visited in the selected year (from ISO codes, no assets), followed by "N countries".
  - **Summary strip:** flights · distance · time · airports · airlines.
- **Flight stats report.** Every section has the same shape: a CalSans title with a Share pill, a huge number with a grey unit, bars or a list, then "Show more", which opens an `AeroSheet` with the full list.
  - **Flights:**
    - domestic, international and long-haul counts;
    - a "Flights per Year / Month / Weekday" switch over a bar chart.
  - **Distance:**
    - km, with miles underneath and the average;
    - "× around Earth" and "× to the Moon" pill bars;
    - shortest and longest flight. Each record row shows:
      - airline logo;
      - "City → City";
      - IATA and ICAO flight numbers;
      - date;
      - the value.
  - **Flight time:**
    - total;
    - days and weeks;
    - average flight;
    - in the air vs taxiing;
    - shortest and longest by duration.
  - **Top airports:** "N total airports", with a Flights / Distance switch. Rows: IATA code with a bar and count; "Show more" lists name, city, ICAO, and departures vs arrivals.
  - **Top airlines:** a Flights / Distance switch. Logo rows.
  - **Top routes:** a Flights / Distance switch. Rows show "DEL-BLR"; the sheet adds city names.
  - **Runway log:** "N runways used".
    - Top runways as bars: "DEL 29R · 6", with departures vs arrivals.
    - "Show more" opens a sheet grouped by airport, listing every runway used with off/on counts.
    - Source: FlightAware `actualRunwayOff` / `actualRunwayOn`. The section says "based on N flights" (prod has much more coverage than dev).
  - **Taxi by airport:**
    - average taxi-out per departure airport and average taxi-in per arrival airport, with the sample size, e.g. "DEL · taxi-out 22m avg (9 flights)";
    - the longest single taxi, with its flight.
    - Same actual-only rule as taxi time.
  - **Extremes:** northernmost, southernmost, easternmost and westernmost airport, plus the highest airport by elevation. Each row shows IATA and ICAO, name, city, country and the value (latitude, longitude or elevation). Source: the `airports` table.
  - **Countries & territories:** "N total", the top 3 countries with flight counts, plus "Show more", and a continent grid: Asia, Europe, N. America, Middle East, Oceania, Africa, C. America, Caribbean, S. America, each with a count and %.
- **Delay report:**
  - the % of flights delayed, plus "N of M flights arrived later than scheduled";
  - hours lost to delays, and the average delay of delayed flights;
  - the worst delay (flight, route, duration);
  - the worst airline (total late time), with the next two;
  - a breakdown: Early / On time / 15m late / 30m late / 45m+ late / Cancelled / Diverted;
  - airline performance: % late arrivals per airline, with (late/total);
  - airport performance: % late departures per airport;
  - every delayed flight, worst first, in a sheet.
  - The report says "Based on N flights with FlightAware times".
- **Aircraft report:**
  - most flown types (bars);
  - **type collection:** a grid of aircraft families (A320 family, 737, 777, 787, A350, A380, ATR, Dash 8, E-Jets, CRJ, …), each with a count and the date first flown. Families not yet flown are greyed out.
  - age records: oldest and newest airframe flown, if the existing data supports them.
- **Correct counts.** Unique airports and airlines are counted once each. Today `profile.service.ts:254-271` adds both the IATA and the ICAO code to the same set, giving 80 airlines instead of 40 and 177 airports instead of 60.

## Non-goals
- **Dark background.** The user explicitly rejected it; the app's theme is white.
- **Flighty branding:**
  - the passport machine-readable strip;
  - the split-flap delay board;
  - the "Pro" upsell;
  - the name "Flighty Passport".
- **A full-screen map you can move around.** Only the still header map is in scope.
- **Merging connections into trips** (Flighty's "connections under 8 hours count as one visit").
- **Share images.** No Share pills or icons in this project (my call). A visible button that does nothing breaks the tap-affordance rule. They come back with a later share feature.

## Anti-goals
- Stock Material look, `fl_chart`, or text drawn on charts. Charts are `CustomPainter` on tokens; labels sit outside the plot.
- Colour used outside stats. The new accent colours appear only on stats cards and stats charts.
- Cropped images or black placeholder squares. Logos use `AirlineLogo` (SVG, then FlightAware PNG, then a plane icon).

## Constraints
- **Design rules:** DESIGN.md and `test/design_rules_test.dart`. New colours are added as tokens in `app/lib/ui/tokens.dart`:
  - the passport indigo gradient, with an accent indigo for bars and links;
  - the delay red gradient;
  - the aircraft periwinkle gradient.

  DESIGN.md gets one rule: "Report accent colours are allowed only on stats cards and stats charts." Status colours (red late, green on time) stay as they are.
- **Rewrite the file whole.** The legacy stats file is rewritten whole, as one widget file per section under `app/lib/screens/profile/stats/`, so the design baseline entry for it drops to zero and the baseline is regenerated.
- **API stack:** bun and Jest (`cd api && bunx jest <path>`). Regenerate the Dart client after the API changes (`./generate-openapi-client.sh`, after booting the API once).
- **Stored country codes are wrong for this.** `countryCode` on the stored departure/arrival JSON is the ICAO *prefix* (for example "OM"), not an ISO country code. Countries must come from the `airports` table (`isoCountry`), looked up by IATA or ICAO.
- **FlightAware coverage:** FlightAware data exists on about 61 of 104 flights. Delay and taxi stats use only those, and the report says so.

## Data rules
- **Which flights count (my call, builder check):**
  - Every `Flight` row in the user's log counts. Lookups land in the log by design, and the user removes the ones they didn't fly by swiping (spec 1).
  - Not counted:
    - flights not flown yet (`date` in the future). FlightAware status is not used, because old lookups keep a FlightAware snapshot taken before landing;
    - flights FlightAware marks `cancelled`. These appear only in the delay breakdown's Cancelled bucket.
  - Diverted flights count everywhere, using the stored route.
  - The same base query feeds the stats, `availableYears`, the history endpoint and `yearCounts`.
- **Flight time (my call, builder check):** block time, gate to gate.
  - Use FlightAware `actualIn − actualOut` when both exist.
  - Otherwise use the stored departure/arrival JSON times (actual, then revised, then scheduled, in UTC).
  - Otherwise estimate from distance at 800 km/h.
  - "In the air" and "taxiing" use only FlightAware actual times, and say "based on N flights".
  - Delays are never added on top (today's code does; that is dropped).
- **Year filter:** `year` is optional; leaving it out means all-time. A flight belongs to a year by its `date` in the departure airport's local time; weekday uses the same date.
  - The Past flights list follows the filter (my call): the history endpoint takes `?year=` too, and `yearCounts` always covers all years.
- **Domestic:** both airports are in the same ISO country. Otherwise the flight is international.
- **Long haul:** flight time over 6 hours. Use FlightAware block time (`actualIn − actualOut`) or air time if available; otherwise the great-circle distance at 800 km/h.
- **Arrival delay:** `arrivalDelay` (seconds) if set; otherwise `actualIn − scheduledIn`.
  - The buckets:

    | Bucket | Arrival delay |
    |---|---|
    | Early | under −5 min |
    | On time | −5 to +15 min |
    | 15m late | 15 to 30 min |
    | 30m late | 30 to 45 min |
    | 45m+ late | over 45 min |

  - "Delayed" means more than 15 minutes late (the industry standard).
  - "Hours lost" is the sum of the positive arrival delays of delayed flights.
  - Cancelled and diverted come from the FlightAware flags.
  - The breakdown's denominator is every counted flight with FlightAware data, plus the cancelled ones. The "N of M flights arrived late" line uses only flights that arrived.
- **Departure delay** (for airport performance): `departureDelay` (seconds) if set; otherwise `actualOut − scheduledOut`. Late means over 15 minutes.
- **Taxi time:** `(actualOff − actualOut) + (actualIn − actualOn)`, counting only pairs where both ends are actual times.
- **Airport visit count:** one per departure or arrival.
- **Continents:** `airports.continent` (OurAirports codes AS, EU, NA, OC, AF, SA). The Middle East, Central America and Caribbean buckets are carved out by a static ISO-country list in the server.
- **Aircraft family:** a static ICAO type → family map in the server (for example A319/A320/A321/A20N/A21N → A320 family; B77W/B772/B773/B77L → 777). The "not yet flown" list is the fixed set of families in that map.

## Approaches
- **The server computes all the stats (picked by the user).** Extend `GET /v1/profile/stats` with `?year=` and every section above. Each section is its own function in `profile.service.ts` (or a `stats/` folder beside it), unit-tested on fixture flights. The app only renders. Fine for logs of this size; one fetch per year switch.
- The app computes from the full log: rejected. All-time stats would need every page downloaded, which defeats paging, and the airport, country and delay logic would be duplicated.
- One endpoint per report: rejected. It only pays off with thousands of flights.

## Design
### API
- `GET /v1/profile/@me?year=YYYY` (the existing stats route) returns `ProfileStatsResponseEntity`, extended with:
  - `availableYears: number[]`;
  - `passport`, with corrected counts plus `countries`, `longHaul`, `domestic`, `international`, `airMinutes`, `taxiMinutes`;
  - `flightsPer: { year[], month[12], weekday[7] }`;
  - `records`: shortest and longest by distance and by duration. Each is a `FlightSummaryEntity` extended with the ICAO flight number, the departure and arrival city, and the date.
  - `topAirports`, `topAirlines` and `topRoutes`, each with `flightCount` and `distanceKm`, so the Flights / Distance switch needs no refetch. The full lists are returned; the app shows the first 8.
  - `countries[]` (ISO code, name, flightCount) and `continents[]` (bucket, countryCount, flightShare).
  - `runways`:
    - `basedOn`;
    - `items[]`: airport (IATA, ICAO, name), runway ident, departures, arrivals.
  - `taxiByAirport`:
    - `basedOn`;
    - `items[]`: airport, avgTaxiOutMin, taxiOutCount, avgTaxiInMin, taxiInCount;
    - `longest`: flight summary plus minutes.
  - `map`:
    - `airports[]`: IATA, lat, lon;
    - `routes[]`: departure lat/lon, arrival lat/lon, count. Undirected and unique.

    The app draws the arcs.
  - `extremes`: north, south, east, west, highest. Each is an airport (IATA, ICAO, name, city, ISO country, lat, lon, elevationFt).
  - `delays` (part 1 ships only `basedOn`, `delayedCount`, `arrivedCount`, `minutesLost` and `avgDelayMinutes` for the hub card; part 2 adds the rest):
    - `basedOn`, `delayedCount`, `minutesLost`, `avgDelayMinutes`;
    - `buckets`;
    - `worst` (flight summary plus minutes);
    - `airlines[]` (late, total, minutesLate);
    - `airports[]` (lateDepartures, total);
    - `flights[]` (every delayed flight, worst first).
  - `aircraft`:
    - `mostFlown`, with an image URL;
    - `types[]`;
    - `families[]` (family, count, firstFlown, flown);
    - the age records already computed today.
- `GET /v1/flight/history?cursor=<flightId>&limit=30&year=YYYY` (on the existing `flight` controller) returns:
  - the user's flights, newest `date` first, as `FlightSummaryEntity`-shaped rows (airline with logo, IATA and ICAO idents, IATA and ICAO codes for both airports, cities, date);
  - `nextCursor`;
  - `yearCounts: {year: count}`, so the group headers show totals before every page has loaded.
- **Bug fix:** count unique airports and airlines by one key each. Use the ICAO code if present, otherwise the IATA code. Never add both to the same set.

### App
- `app/lib/screens/profile/stats/`:
  - `main.dart` (the hub);
  - `flight_stats_report.dart`;
  - `delay_report.dart`;
  - `aircraft_report.dart`;
  - `widgets/`: shared pieces:
    - `StatSection` (title, Share pill, hero number with grey unit);
    - `StatBarList`;
    - `YearFilter`;
    - `SummaryCard` (gradient, CTA row);
    - `BarChartPainter`;
    - `ComparisonPill`;
    - `RecordRow`;
    - `PastFlightRow`.
- **Year filter:** a horizontal pill row, shared state. Switching the year refetches the stats and keeps the scroll position.
- **Past flights:** a paged list (load more near the end of the list). Year headers come from `yearCounts`.
- **Type:**
  - display: CalSans 32 for "Passport";
  - section titles: CalSans 22;
  - hero numbers: Inter 800 at 52, with a grey unit at 26 (new `AeroText` tokens);
  - tabular figures on all numbers.

  Everything aligns to the 16 px gutter.
- **Navigation:** reports are pushed routes (`/profile/stats/flights`, `/profile/stats/delays`, `/profile/stats/aircraft`) that inherit the selected year. "Show more" opens an `AeroSheet`.

## Build order (three parts, each merged on its own)
1. **Hub, flight stats report, paged history and the count fix.** Includes the colour tokens, the DESIGN.md rule and the whole-file migration of the legacy screen. The delay and aircraft cards appear, but their buttons are hidden until parts 2 and 3 land. The aircraft card shows the existing "most flown" data.
2. **Delay report.** Turns on the delay card's button.
3. **Aircraft report and type collection.** Turns on the aircraft card's button.

## Testing
- **API:** Jest unit tests per section function on a fixture set covering:
  - flights with and without FlightAware data;
  - domestic and international;
  - a cancelled and a diverted flight;
  - a flight with both IATA and ICAO codes (regression for the count bug);
  - two years.

  Plus a history pagination test: cursor, `limit`, and `yearCounts`.
- **App:**
  - widget tests for `StatSection` and `PastFlightRow` content;
  - the design rules test passes with the baseline entry removed.
- **Visual:** a golden preview with real fonts (the HANDOFF rule) of the hub and the flight stats report, then a check on the user's phone via adb.

## Decided with the user
- **The passport header is in part 1:** world map with route arcs, flag row and summary strip, on the flight stats report.
- **The #8 extras are all in part 1:** runway log, taxi by airport and extremes. The user asked for them because production has much more FlightAware data than dev.

## Left to builder
- Exact gradient stops and the accent shades, within the mockup's look (`.superpowers/brainstorm/.../stats-look-v2.html`).
- The paging page size (about 30).
- How the year switch animates (keep it subtle; DESIGN.md motion rules apply).
