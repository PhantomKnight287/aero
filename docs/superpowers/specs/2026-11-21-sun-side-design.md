# Sun side — design (draft)

Covers idea 11.

## Intent
Pick the right window seat: which side gets the sun, sunrise or sunset, and how much of the flight is in daylight. Pure math, no AI, no new data.

## Goals
- On flight detail for scheduled and active flights: "Sun mostly on the LEFT (A side)", plus "Sunset at ~14:20 into flight, on the right".
- Day / night / twilight split of the flight as a thin bar.
- For past flights with positions, use the real track; otherwise use the great-circle path and scheduled times.

## Non-goals
- Seat map by aircraft type (A/F mapping is "left = A" convention only, stated in the UI).
- Moon position.

## Approaches
- **Client-side Dart solar-position algorithm (NOAA simplified) (picked).** About 60 lines, no dependency; runs on ~100 sample points.
- Server-side — rejected: no reason to round-trip; nothing to store.
- Package from pub.dev — possible, but adds a dependency for a short formula.

## Design
- `app/lib/utils/sun.dart`: `SunPosition sunAt(DateTime utc, double lat, double lon)` → azimuth, elevation.
- `app/lib/utils/sun_side.dart`: sample path every ~2 min; aircraft heading from consecutive points; relative bearing = sunAzimuth − heading; left if in (180, 360). Count minutes where sun elevation > −0.833° (day), −6°..−0.833° (civil twilight), else night. Sunrise/sunset = elevation sign change.
- Great-circle sampling via `latlong2` (installed).
- Unit tests: known sun position (e.g. Greenwich at equinox noon), and a north-bound morning flight → sun on the right.

## Open (ask when we reach this)
- Card on flight detail only, or also on the share card?

## Left to builder
Sample interval, visual design of the day/night bar.
