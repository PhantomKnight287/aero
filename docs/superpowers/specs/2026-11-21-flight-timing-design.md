# Flight timing details — design (draft)

Covers ideas 4 (OOOI breakdown), 5 (runways on a flight), 13 (timezone shift).

## Intent
The timetable (`_buildFlightTimetable`, `flight_info.dart:1225`) already lists scheduled/estimated/actual out/off/on/in. Nerds want the derived numbers, not just timestamps.

## Goals
- **Derived durations row** under the timetable:
  - Taxi-out = actualOff − actualOut
  - Air time = actualOn − actualOff
  - Taxi-in = actualIn − actualOn
  - Block time = actualIn − actualOut, vs scheduled block (scheduledIn − scheduledOut) → "12 min early/late vs schedule"
  - Fall back to estimated times while the flight is in progress, styled as estimates.
- **Runways**: "Departed 27 · Landed 09L" chips from `actualRunwayOff` / `actualRunwayOn`; hidden when null (only 21/61 have it).
- **Timezone shift**: extend existing `_buildTimezonePill` (`flight_info.dart:1786`, currently "No Timezone Change" / local time) with signed offset delta "+5h30" and a "crossed N zones" note. Offset from `originTimezone` / `destinationTimezone` via `timezone` package already installed.

## Non-goals
- Runway diagrams.
- Delay prediction.

## Approaches
- **Client-only, computed in Flutter from fields the flight response already carries (picked).** No API change.
- Compute on server and add fields — rejected: duplicating data the client has; stats revamp (spec 8) will compute aggregates server-side separately.

## Design
- Pure helper `app/lib/utils/oooi.dart`: `OooiDurations? computeOooi(FlightAwareDataEntity fa)` → nullable durations. Unit test with a full, partial and in-progress fixture.
- "Crossed N zones" = |offset delta| in hours rounded down; note half-hour zones by showing exact delta.
- Uses units formatter (spec 2) for time display.

## Open (ask when we reach this)
- Show the timezone delta relative to the departure airport, or to the device's current zone?

## Left to builder
Placement inside the timetable card.
