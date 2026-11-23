# Stats Passport part 2: Delay report (short design)

Parent spec: `2026-11-22-stats-passport-design.md` (data rules, buckets, non-goals all apply). Approved by the user on 2026-11-23.

## Intent
The hub's red delay card opens a full Delay report, Flighty-level detail (benchmark screenshots shared in conversation), in the same visual system as `flight_stats_report.dart`: white background, CalSans titles, Inter 800 heroes, `StatSection` / `StatBarList`, year filter.

## Approaches
- **Server aggregates, app renders (picked; same as part 1).** Extend `delays` in the existing stats response. One fetch per year switch.
- App computes from history pages: rejected for the same reasons as part 1 (paging, duplicated logic).

## Layout
```
 ‹  Delay report
 [All-time] 2026 2025 2024
┌─ red gradient card ────────────┐
│ 48%                            │
│ flights delayed                │
│ 14 of 29 arrived >15m late     │
│ 17 h lost · avg 1h 13m late    │
│ WORST  AI 185 · AI185 DEL→YVR  │
│        6h 32m · 6 May 2025   › │
└────────────────────────────────┘
 Arrival performance  11h 34m late      (net sum of arrival delays)
 Early / On time / 15m / 30m / 45m+ / Cancelled / Diverted  bars + %
 Worst airlines   total late time, top 3, logo bars
 Airline performance  50% late arrivals; logo, name, % (late/total), Show more
 Airport performance  61% late departures; flag, IATA · ICAO, % (late/total), Show more
 Arrival delays  14 total; ident, delay, route, date ›; top 5 + Show more sheet
 based on N flights with FlightAware times
```

## API (`delays` additions)
- `buckets`: early, onTime, late15, late30, late45, cancelled, diverted, plus `total` (denominator: FA-timed counted flights + cancelled).
- `netMinutes`: signed sum of arrival delays (the "11h 34m late" hero).
- `worst`: flight summary + minutes, or null.
- `airlines[]`: airline, late, total, minutesLate; sorted by late rate, then total.
- `airports[]`: departure airport, lateDepartures, total; sorted the same.
- `flights[]`: every delayed (>15m) flight, worst first, flight summary + minutes.
- Cancelled flights are excluded from the base query; the cancelled bucket comes from a separate count over the same user/year filter (past, FA `cancelled`).

## App
- `delay_report.dart` + `sections/delay_*.dart`, pushed at `/profile/stats/delays` with the hub's year, like the flight report.
- Hub delay card gets its CTA (`SummaryCard` CTA row) and opens the report; result pops back like `_openReport`.
- Bucket colours: existing status tokens (green early/on time, amber, orange, red, dark red). Accent red only inside the stats card/charts, per DESIGN.md.
- Rows open their flight (pop `OpenFlightRequest`).

## Non-goals
Dark theme, split-flap board, Share pills, airline tail images.

## Left to the builder
Exact token names for the bucket colours, section file split, empty-state per section (`shows()` pattern).
