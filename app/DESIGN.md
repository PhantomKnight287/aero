# Aero design standards

Aero has its own look: white surfaces, black Inter text, CalSans titles, soft grey panels, and color only for status (red for late or destructive, green for OK). It's a nerd app, so show everything that identifies a thing. Nothing should look like stock Material.

Interaction and motion rules come from Emil Kowalski's design-engineering skills (https://github.com/emilkowalski/skills: `emil-design-eng`, `apple-design`, `gestures`), adapted here for Flutter.

## 1. Tokens, never raw values

Everything comes from `lib/ui/tokens.dart`:
- `AeroColors`: ink, inkSoft, muted, line, surface, surfaceAlt, danger, success, warn and their tints.
- `AeroRadius`: sm 8 (chips, small tiles), md 12 (cards, buttons, inputs, panels), lg 20 (sheets), pill.
- `AeroSpace`: xs 4, sm 8, md 12, lg 16, xl 24, xxl 32.
- `AeroText`: display (CalSans 32), title (CalSans 20), heading (Inter 16 w600), body (Inter 14), caption (Inter 12, muted), micro (Inter 11, muted).
- `AeroMotion`: curves, durations and the press scale.

For a one-off variant, use `copyWith` on a token style. If you need a new value, add a token to `tokens.dart`. Never inline it.

## 2. Typography

- **Every `AeroText` style carries its `fontFamily`.** Some APIs *replace* the inherited style instead of merging with it, for example `TextButton.styleFrom(textStyle:)` and toast libraries. A bare `TextStyle(fontSize: 14)` in those places silently renders in the system font. Always start from an `AeroText` token.
- **Tracking depends on size.** Large CalSans text gets negative letter-spacing (already in the tokens). Body text stays at 0.
- **Use tabular figures (`AeroText.tabular`)** for times, durations, counts and flight numbers, so digits line up and don't jitter. Don't use them on text that mixes letters and hyphens (registrations like `A6-EOF`, type names like `A380-800`): they widen the hyphens.

## 3. Layout and grouping

- **Group with spacing, not lines.** Don't put a divider between a title and the content it introduces: it splits the question from its subject. Dividers only separate repeated rows in a list.
- **Use filled panels, not bordered boxes,** for inset content inside a sheet or card: `AeroColors.surfaceAlt` fill with an `AeroRadius.md` corner.
- **Make things recognisable at a glance.** For a flight, that means airline, both flight numbers (IATA · ICAO), both airports (IATA plus ICAO), cities, scheduled local times, duration, distance, aircraft and registration. Use `FlightSummaryCard` (`lib/screens/home/widgets/flight_summary_card.dart`) instead of writing a new summary.
- **Airline logos:** use `AirlineLogo`, which falls back from our SVG to the FlightAware PNG to a plane icon.

## 4. Surfaces

- **No dialogs.** Confirmations use `showAeroConfirm(...)`:
  - a bottom sheet with the title and message;
  - optional `details` (what is being acted on);
  - optional `warning` (side effects such as linked data being deleted);
  - a confirm button and a cancel button, with specific labels like "Delete flight" / "Keep it", not "OK" / "Cancel".
- **Other modal content** uses `AeroSheet` via `showAeroSheet`.
- **No SnackBars.** Use `showErrorToast` and `showSuccessToast` from `lib/utils/error.dart`.

## 5. Buttons and press feedback

- **Use `AeroButton`, `AeroButton.secondary` or `AeroButton.destructive`.** Don't use bare `ElevatedButton`, `OutlinedButton` or `TextButton` in new code.
- **Every custom tappable surface gets `AeroPressable`.** It scales to 0.97 on pointer-down (not on release) over 160ms with `AeroMotion.easeOut`, so the press feels heard instantly.
- **Haptics only where they earn it:** committing a destructive action (built into `AeroButton.destructive`), or a snap/success moment. Never on every tap.

## 6. Motion

- **Decide whether it should animate at all.** Things used dozens of times a day (list taps, tab switches) get little or no animation. Occasional things (sheets, toasts) get standard motion.
- **Never use `Curves.easeIn` for UI;** it feels sluggish. Use `AeroMotion.easeOut` for anything responding to the user, and `AeroMotion.easeInOut` for things moving on screen. The test enforces this.
- **Durations:** UI animations stay under 300ms. Sheets use the iOS-like `AeroMotion.sheet` curve (450ms in, 250ms out). Exits are faster than enters.
- **Never animate from scale 0.** Start from 0.95 or more, combined with opacity.
- **Respect reduced motion:** check `MediaQuery.disableAnimationsOf(context)` and drop movement and scale, keeping only opacity.
- **Gestures:**
  - Track the finger 1:1.
  - Let a quick flick dismiss, regardless of distance.
  - An element dismisses in the direction it entered.

## 7. Verify visually before calling UI done

`flutter analyze` and the unit tests can't see fonts, spacing or grouping. Before claiming a UI change is done:
1. Write a throwaway golden test that renders the widget with the real fonts:
   - Inter: load the Inter TTF under `AeroFonts.inter`.
   - CalSans: from `assets/fonts/calsans.ttf`.
   - Icons: `MaterialIcons-Regular.otf` from the Flutter SDK cache.
   - Load all three with `FontLoader`, and set `GoogleFonts.config.allowRuntimeFetching = false`.
2. Look at the PNG.
3. Delete the test.

Running on a real device is better when one is available.

## 8. Enforcement

`test/design_rules_test.dart` scans `lib/`. It skips `lib/ui/` and generated `*.g.dart` files. These patterns are banned:

| Rule | Pattern |
|------|---------|
| `alert_dialog` | `AlertDialog` |
| `show_dialog` | `showDialog` |
| `snackbar` | `SnackBar(` |
| `material_color` | `Colors.x` (except `Colors.transparent`) |
| `hex_color` | `Color(0x…)` |
| `raw_radius` | `Radius.circular(<number>)` / `BorderRadius.circular(<number>)` |
| `raw_font_size` | `fontSize: <number>` |
| `ease_in` | `Curves.easeIn` |

Legacy code is grandfathered per file in `test/design_baseline.json`. The test fails if:
- any file's count goes **up**,
- a new file has violations,
- a count goes **down** and the baseline was not regenerated.

## 9. Migrating legacy code

Migrate a file whenever a feature touches it, and migrate the whole file, not only the lines you changed. Then regenerate the baseline:

```bash
UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart
```

Commit the smaller `design_baseline.json` with the change. Legacy button themes (`blueAccent`) in `lib/ui/theme.dart` stay until their screens are migrated.
