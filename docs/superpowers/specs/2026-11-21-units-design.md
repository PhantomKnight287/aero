# Unit toggles — design (draft)

## Intent
Aero is a nerd app; pilots and avgeeks think in knots, flight levels and Zulu. Let the user pick units once and have every screen respect it.

## Goals
- Preferences: distance (km / mi / nm), speed (kt / km/h / mph), altitude (ft / m / FL), time display (local airport time / device time / UTC "Z").
- One formatter used everywhere: flight detail, stats, charts, widgets, share card.
- Defaults match today's output (km, km/h?, ft, local airport time) so nothing changes until the user touches it.

## Non-goals
- Server-side unit handling. API keeps returning SI/raw values; conversion is client-only.
- Temperature/pressure units (METAR decode, spec 7, may add °C/°F and hPa/inHg later).

## Approaches
- **Client-only prefs in `shared_preferences` + `UnitsNotifier` (provider) + pure formatter functions (picked).** Both packages already installed; no sync needed for a single-user app.
- Store on User in DB — rejected: needs migration and endpoint for no gain (one device per user in practice).
- Per-screen toggles — rejected: inconsistent, user asked for app-wide.

## Design
- `app/lib/notifiers/units.dart`: `UnitsNotifier extends ChangeNotifier` with 4 enum fields, loads/saves to shared_preferences.
- `app/lib/formatters/units.dart`: pure functions `formatDistance(km, unit)`, `formatSpeed(kt, unit)`, `formatAltitude(ft, unit)` (FL = ft/100 rounded, `FL350`), `formatTime(DateTime utc, tz, mode)`. Inputs in the units the API gives (verify per field: GCD has all units; positions give ft and kt).
- Settings UI: new "Units" section on the profile screen (`app/lib/screens/profile/main.dart`), segmented buttons.
- Replace hardcoded conversions (e.g. stats `totalDistance * 0.621371`) with the formatter.
- Unit test for the formatter (pure Dart, `flutter test`) — `app/test/` does not exist yet; create it.

## Open (ask when we reach this)
- Should the time mode also apply to the Android widget?

## Left to builder
Exact rounding per unit, where the "Units" section sits on the profile screen.
