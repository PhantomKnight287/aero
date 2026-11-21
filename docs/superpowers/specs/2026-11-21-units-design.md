# Unit toggles — design (approved 2026-11-21)

## Intent
Aero is a nerd app; pilots and avgeeks think in knots, flight levels and Zulu. Let the user pick units and flip them instantly by tapping any value.

## Decisions (user)
- **Tap to cycle** any unit-bearing value, plus a "Units" section in Profile settings.
- Approved design below, including the process call: in huge files (`flight_info.dart`, `profile/stats/main.dart`, `airport_details_sheet.dart`) only the unit values change now; full design migration happens with the features that rework them (#3–5, #8). Small files touched are fully migrated.

## Behaviour
- Dimensions and options; **defaults match today's display**:
  - distance: **km** / mi / nm
  - speed: **kt** / km/h / mph
  - altitude: **ft** / m / FL (airport elevation shows ft when FL is selected — FL isn't meaningful for ground elevation)
  - temperature: **°C** / °F
  - time: **airport local** / my time (device zone) / UTC (`06:40Z`, always 24h)
- One global setting per dimension. Tapping a value cycles that dimension's setting globally (map bar, cards, stats all update) — never per-spot.
- First cycle ever shows a toast: "<Dimension> now in <unit> everywhere · change anytime in Profile → Units".
- Feel: `AeroPressable` press scale; value crossfades 150ms `AeroMotion.easeOut`; tabular figures; `HapticFeedback.selectionClick()` per cycle; reduced motion → instant swap.
- Home widget times follow the time setting.
- METAR cloud bases stay in ft (aviation convention).

## Approaches
- **Client-only `UnitsNotifier` (provider) + `shared_preferences` + pure formatters (picked).** Both packages already installed.
- Store on User in DB — rejected: migration + endpoint for a per-device preference.
- Settings-only toggles — rejected by user in favour of tap-to-cycle.

## Surfaces
Map bar (alt/speed), route info (distance, times), flight summary card (distance, times), flight timetable times, METAR temperature, airport elevation, stats distances, share card distance/times, home widget times. Remove `utils/distance.dart` (unused) and hand-written `* 0.621371` conversions.
