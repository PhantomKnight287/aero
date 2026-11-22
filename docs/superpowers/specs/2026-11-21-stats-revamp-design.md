# Stats screen revamp — design (superseded)

Superseded on 2026-11-22 by `2026-11-22-stats-passport-design.md`, which absorbs everything below.

Covers the stats screen improvement, idea 10 (type collection), runway log (5), delay stats, taxi stats (4).

## Intent
Stats screen (`app/lib/screens/profile/stats/main.dart`, 1,682 lines in one file) shows totals, distance, time, aircraft stats/ages, top airlines/airports/routes. Make it the place a nerd lingers. Now that users can delete lookups (spec 1), stats reflect real flying.

## Current sections (for reference)
My Stats header → Flight Distance → Flight Time → Aircraft Stats (most flown, age records) → Top Airlines → Top Airports → Top Routes. Server: `GET /v1/profile/stats` (`profile.service.ts`).

## Proposed additions
- **Type collection**: grid of aircraft families flown (A320 family, 737, 777, 787, A350, ATR, Dash 8…), count per type, first-flown date; greyed "not yet" families from a fixed list. Needs ICAO type → family map (static, server).
- **Runway log**: per airport, runways used with counts (`actualRunwayOff/On`).
- **Punctuality**: on-time % (arrival delay ≤ 15 min, the industry standard), average dep/arr delay, per airline; worst delay flight.
- **Taxi**: average taxi-out / taxi-in, longest taxi, per airport.
- **Extremes** (idea 8 crept in — drop if unwanted): northern/southern/eastern/westernmost airport, highest airport.
- **Year filter**: all time / per year.

## Structure
- Split the 1,682-line file into one widget file per section under `app/lib/screens/profile/stats/sections/` while touching it — needed to keep edits reliable, not a rewrite for its own sake.
- Server: extend `ProfileStatsEntity` with `typeCollection`, `runways`, `punctuality`, `taxi`; each computed in its own function in `profile.service.ts` with a unit test on fixture flights. `year` query param.

## Approaches
- **Extend the single stats endpoint (picked).** One fetch, existing pattern; 108 flights is tiny.
- One endpoint per section — rejected: more requests, no scale problem to solve.
- Compute client-side from tracked flights — rejected: tracked endpoint caps at 50.

## Open (ask when we reach this)
- What bugs you about the current stats screen? (layout, missing numbers, looks?) — biggest unknown for this spec.
- Keep extremes section?

## Left to builder
Section order, chart choices (fl_chart).
