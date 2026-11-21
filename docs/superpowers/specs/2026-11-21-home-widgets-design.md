# Home widgets — design (draft)

## Intent
Improve home screen widgets. Today: one Android Glance widget, "current active flight" (`app/android/.../widgets/current_active_flight/main.kt`, fed by `WidgetUpdateService` via `home_widget` + `workmanager`). No iOS widget extension exists.

## Candidate improvements (pick in conversation)
- **Richer active-flight widget**: progress bar (FA `progressPercent`), gate/terminal, delay coloured, time-to-departure/arrival countdown, inbound aircraft status (after spec 3), sizes small/medium/large.
- **Next flight widget**: next upcoming flight that has a booking, countdown in days/hours.
- **Stats widget**: total km / flights this year, laps of Earth.
- **iOS WidgetKit extension**: parity with Android (bigger job: Swift + app group).
- Widget tap deep-links into that flight (check if done today).

## Approaches (to settle)
- Keep Glance + home_widget and extend (likely pick for Android).
- iOS: WidgetKit extension sharing data through `home_widget` app group.

## Open (ask when we reach this)
- What's wrong with the current widget, and which phone do you use daily (Android/iOS)? Decides whether iOS is in scope.

## Left to builder
Layouts per size.
