# Delete flights from log — design

## Intent
Stats are computed from every flight a user has tracked, so random "nerdy" lookups pollute real travel stats. Profiles were considered and dropped; instead users can delete flights from their log.

## Goals / non-goals
- Goal: user can delete a tracked flight (and everything hanging off it) from their log.
- Non-goal: profiles; opt-in "add to log" (lookups still auto-create a Flight row — deleting then re-opening a flight re-adds it; accepted).
- Non-goal: undo / soft delete.

## Approaches
- **Hard delete via new endpoint (picked).** Simple, stats read straight from DB.
- Soft delete flag — rejected: every query needs a filter, no undo requirement.
- Delete button on flight detail screen — deferred; swipe on list is enough.

## Design
API
- `DELETE /v1/flight/:flightId` in `api/src/resources/flight/flight.controller.ts`, scoped to auth user; 404 if not owned.
- Transaction: `flightPositions.deleteMany({ flightId })`, then `flight.delete`. Positions have no cascade (optional relation); bookings, GreatCircleDistance, FlightAwareData cascade.
- Invalidate any per-user Redis keys for tracked flights / stats if such caching exists.
- Regenerate Dart client via `generate-openapi-client.sh`.

App
- `TrackedFlightsList` ("Recently Tracked"): swipe-to-delete (`Dismissible`, end-to-start) with confirm dialog; dialog warns booking is deleted too when one exists.
- On success: reload `trackedFlights` in `HomeController`, trigger Android widget update.

## Left to builder
Exact dialog copy, error snackbar on failure.
