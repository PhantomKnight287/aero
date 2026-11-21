# Crosswind + METAR decode — design (draft)

Covers idea 12.

## Intent
Show how windy the landing (and takeoff) actually was, and make the raw METAR readable.

## Goals
- For the runway used (`actualRunwayOn` / `actualRunwayOff`), show headwind/tailwind and crosswind components (left/right), including gust components.
- When the runway is unknown, show components for every runway at the airport and mark the most into-wind one as "likely in use".
- Decode raw METAR in the existing airport conditions card (`_buildObservationRow`, `flight_info.dart:1633`): wind, visibility, clouds, temp/dew, QNH, flight category (VFR/MVFR/IFR/LIFR) — check what FlightAware's observation already decodes first and only add what's missing.

## Constraint (blocking)
`airports` table has no runways. Need runway headings.

## Approaches
- **Import OurAirports `runways.csv` into a new `Runway` table (picked).** Same source and import style as `api/scripts/import-airports.ts`; has `le_ident`, `he_ident`, `le_heading_degT`, `he_heading_degT`, length, surface. Free, offline, stable.
- Derive heading from runway number × 10 — rejected as primary: ±5° error and wrong for magnetic vs true; keep as fallback when the table has no heading.
- FlightAware airport runway endpoint — rejected: per-call cost for static data.

## Design
- Prisma model `Runway { id, airportIdent, leIdent, heIdent, leHeadingTrue, heHeadingTrue, lengthFt, surface, closed }`, index on `airportIdent`. Migration + `api/scripts/import-runways.ts` (bun).
- Wind direction in METAR is true north; use true headings. Components: head = ws·cos(Δ), cross = ws·sin(Δ).
- Pure function `windComponents(windDirTrue, windKt, gustKt?, runwayHeadingTrue)` server-side in `api/src/common/` with a unit test (e.g. 270/20 on runway 27 → head 20, cross 0; 300/20 on 27 → cross 10 from right).
- New field on the airport details response: `runways[]` with components computed from the latest observation.

## Open (ask when we reach this)
- For past flights the current METAR is wrong; use historical METAR at landing time (needs a source) or only show for live/recent flights?

## Left to builder
Card layout, METAR fields to show when FA already decodes them.
