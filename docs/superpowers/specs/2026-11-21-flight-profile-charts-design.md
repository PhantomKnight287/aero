# Flight profile charts — design (draft)

Covers idea 2.

## Intent
See how the flight was actually flown: climb, cruise, step climbs, descent, speed. Data exists: 44 flights have positions (avg 308 points, 98% ADS-B).

## Goals
- Altitude vs time and ground speed vs time on flight detail, shared time axis.
- Annotations: top of climb, top of descent, step climbs (altitude level changes ≥ 1,000 ft held ≥ 5 min), max ground speed point.
- Tap/scrub a point → show time, altitude, speed, heading, and highlight the matching position on the map if the map is visible.
- Summary chips: cruise altitude(s), max GS, average cruise GS.
- Respects units (spec 2).

## Non-goals
- Data-source breakdown (98% ADS-B — boring, dropped).
- Vertical speed chart (could derive later).

## Approaches
- **fl_chart `LineChart` (picked)** — already a dependency, used in stats screen. Leftover unused `_ChartPosition` class at `flight_info.dart:2035` hints at an earlier attempt; reuse or delete it.
- `graphic` package (also installed) — rejected: fl_chart already in use; one chart lib in new code.
- Server-rendered PNG — rejected: no interactivity.

## Design
- Data from existing track endpoint (`GET /v1/flight/track` → `FlightTrackResponseEntity`).
- Phase detection as pure Dart in `app/lib/utils/flight_phases.dart`: `FlightPhases detectPhases(List<Position>)`. Smooth with a small moving window; TOC = first point reaching ≥ 95% of max altitude after takeoff; TOD = last such point before landing. Unit test with synthetic profile.
- Downsample to ≤ 300 points for rendering.
- Hide the section when < 20 positions.

## Open (ask when we reach this)
- Its own expandable card, or a full-screen chart page from a "Profile" button?

## Left to builder
Colors from the existing theme, smoothing window size.
