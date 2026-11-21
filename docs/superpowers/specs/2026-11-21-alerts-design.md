# Push alerts — design (draft)

Covers idea 17.

## Current state (found in recon)
- App subscribes via `alertsService.subscribe` → `POST /v1/flight/:flightId/alerts` (`app/lib/services/alerts_service.dart`, used at `flight_info.dart:113`) with OneSignal `playerId`.
- API has **no** alerts controller: `api/src/resources/alerts/*` was deleted in commit `5b44ca0`. `OneSignalService` exists; `.env.example` references a separate bun alerts worker (`ALERTS_WORKER_URL`, `/alerts`, `POST /v1/alerts/internal/refresh`) that is not in this repo. Subscribing likely 404s today.

## Goals
Push when, for a subscribed flight:
- Gate or terminal assigned / changed
- Departure or arrival delay changes by ≥ 15 min
- Inbound aircraft running late enough to delay you (after spec 3)
- Departure runway / takeoff (actualOff set), landing (actualOn set) with runway
- Baggage claim posted
- Cancelled / diverted

## Approaches
- **Poller inside the API (Nest `@nestjs/schedule` cron) (likely pick)**: every N min, fetch FA data for subscribed active flights, diff against stored `FlightAwareData`, send via `OneSignalService`. One deployable.
- Separate bun worker (the `.env` design) — fits if the worker already exists somewhere; need to know.
- FlightAware AeroAPI alerts (push webhooks) — cheapest on polling, but needs a public webhook URL and FA alert config.

## Data
- `FlightAlertSubscription { id, flightId, userId, playerId, createdAt }` table.
- Diffing: compare new FA payload to stored row before update; one pure function `diffFlightEvents(old, new): AlertEvent[]` with unit tests.

## Open (ask when we reach this)
- Does the alerts worker exist outside this repo, and why was the API alerts module deleted?
- Is the API reachable from the internet (for FA webhooks)?

## Left to builder
Notification copy, poll interval (respect FA rate limit).
