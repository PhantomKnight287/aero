# Export / import — design (draft)

Covers idea 15 (and CSV import, idea 16, listed as optional).

## Intent
Own your data: open tracks in Google Earth, keep a logbook spreadsheet, put flights on the calendar, bring history from other loggers.

## Goals
- **Track export** (per flight): GPX and KML from positions; KML includes altitude (`absolute`) so Google Earth draws the 3D profile.
- **Logbook CSV** (all flights): date, flight no, airline, from, to, aircraft type, registration, distance, block time, seat, class, booking code.
- **Calendar `.ics`** (per flight): departure → arrival with timezones, gate/terminal in description.
- Delivered through the share sheet (`share_plus`, installed).

## Optional
- **CSV import** from myFlightradar24 / OpenFlights: parse rows, create flights. Costly: each row needs flight lookup via FlightAware to fill details. Decide later.

## Approaches
- **Server endpoints that return files (picked)**: `GET /v1/flight/:id/export?format=gpx|kml|ics`, `GET /v1/profile/export.csv`. Server has all data (tracked endpoint caps at 50, so client can't build the full CSV); generators are pure functions with unit tests.
- Client-side generation — rejected for CSV (50 cap); fine for GPX/KML, but one place for all formats is simpler.

## Open (ask when we reach this)
- Is CSV import wanted now?

## Left to builder
CSV column order, file naming (`AI101-2026-11-21.gpx`).
