# Sun side — design

Covers idea 11. Status: parked on 2026-11-22. The user did not like it; it may come back later. The design below was written but never approved.

## Intent
Help the user pick a window seat: which side gets the sun, when sunrise or sunset happens and on which side, and how the flight splits into day, twilight and night. Pure math, no AI, no new data.

## Goals
- A "Sun" card on flight detail (`flight_info.dart`), after Profile and before Airport conditions.
- Headline: the side that gets the sun most of the daylight ("Left side A"), plus the left/right share in percent.
- A thin day / twilight / night bar with the duration of each.
- An event list: sunrise and sunset (with side and time into the flight, plus local clock time), and the start or end of civil twilight.
- A footnote: "Left = seat A by convention", plus the data source ("Planned route + scheduled times" or "Actual track").

## Non-goals
- Share card: untouched (option A picked in the visual companion).
- Seat maps by aircraft type, and moon position.

## Anti-goals
- No text on a plot, and no fl_chart. The bar is a plain token-coloured widget or `CustomPainter`.
- No stock Material look; use `app/lib/ui/` tokens only.

## Approaches
- **On the phone, NOAA simplified sun-position formula (picked).** About 60 lines, no dependency. Airports already carry lat/lon, and the app already holds the positions and best-known times.
- On the server: rejected. Nothing to store; it would only add a round trip and a client regeneration.
- A pub.dev sun package: rejected. A dependency for one short formula.

## Design
- `app/lib/utils/sun.dart`: `sunAt(DateTime utc, double lat, double lon)` returns azimuth and elevation in degrees.
- `app/lib/utils/sun_side.dart`: `computeSunSide(path)`, where the path is a list of `(utc, lat, lon)` samples. It returns:
  - minutes on each side, counted only while the sun is up;
  - day / twilight / night minutes;
  - events.
- **How it works:**
  - Heading comes from consecutive samples.
  - Relative bearing = sun azimuth − heading, normalised to 0–360°. 0–180° is the right side; 180–360° is the left.
  - Thresholds:

    | Band | Sun elevation |
    |---|---|
    | Day | above −0.833° |
    | Civil twilight | −6° to −0.833° |
    | Night | below −6° |

  - Sunrise and sunset happen where the elevation crosses −0.833°. Twilight start and end happen where it crosses −6°.
- **Path source:**
  - Takeoff and landing times: FlightAware off/on (actual, then estimated, then scheduled). With no FlightAware data, the departure/arrival times from `flight_info` (revised, then scheduled).
  - Flight not yet flown: the shortest route between the two airports (`latlong2`), spread evenly between takeoff and landing.
  - Flight in the air: the real positions so far, then the shortest route from the last position to the arrival airport, timed to landing.
  - Flight landed with positions: the real track only.
- **Hidden when:** an airport has no coordinates, or there are no usable times.
- Local clock times reuse `formatClock` and the departure and arrival time zones.

## Tests
- `sun.dart`: known sun positions. Greenwich at equinox noon gives elevation ≈ 51.5° and azimuth ≈ 180°; check one more NOAA reference point.
- `sun_side.dart`: a north-bound morning flight gets the sun on the right; a west-bound evening flight gets a sunset event; a short night flight is all night.
- Golden preview with real fonts before calling it done (HANDOFF rule); the preview is deleted afterwards.

## Left to builder
- Sample interval: about 2 minutes.
- Exact styling of the bar and event rows, within the tokens.
- Whether the card sits behind a "Show sun details" pill. Default: headline and bar always visible; events behind the pill if the card gets tall.
