# Design system — design

## Intent
The app has its own look (white, black Inter text, CalSans headings, 1px grey bordered cards, outlined pill chips, red/green only for status) but Material defaults leak through (purple "Hide more info" link, stock AlertDialogs) and values have drifted (10 radii, 12 font sizes, SnackBar and toastification both used). Set a strict standard so everything is consistent and never looks like default Material.

## Decisions (user)
- Bottom-sheet confirm replaces AlertDialog (sketch approved).
- **Gradual migration**: new code follows the standard; existing code is migrated when a feature touches it. A ratchet test stops violations from growing.

## Approaches
- **Ratchet (picked):** design-rules test with a per-file baseline of today's violations; fails if any file's count grows, and if it shrinks without the baseline being updated (so progress gets locked in).
- Migrate everything now — rejected by user: huge diff, delays roadmap.
- Custom analyzer lint plugin — rejected: heavy setup for a source scan a test does fine.

## Design
- `app/lib/ui/tokens.dart`: `AeroColors`, `AeroRadius` (sm 8, md 12, lg 20, pill), `AeroSpace` (4-pt scale), `AeroText` (display, title, heading, body, caption, micro).
- `app/lib/ui/theme.dart`: `aeroTheme()` — explicit monochrome `ColorScheme` (removes M3 purple) plus dialog, bottom sheet, text/elevated/outlined button, snackbar, divider, progress themes. Existing theme settings in `main.dart` move here.
- `app/lib/ui/components/`: `AeroButton` (primary / secondary / destructive), `AeroSheet` (handle + title + close), `showAeroConfirm(...)` returning `Future<bool>`. Card and chip components get added by the first migration that needs them (not built speculatively).
- Feedback: existing `showErrorToast` / `showSuccessToast` (`utils/error.dart`). SnackBar banned.
- Rules in `app/DESIGN.md`; enforced by `app/test/design_rules_test.dart` against `app/test/design_baseline.json`. Banned outside `lib/ui/`: `AlertDialog`, `showDialog(`, `SnackBar(`, `Colors.` (except `Colors.transparent`), `Color(0x`, `BorderRadius.circular(<number>)`, `fontSize:`. Regenerate the baseline with `UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart`.
- First users: the delete-flight confirm (`tracked_flights_list.dart`) and the delete-booking confirm (`booking_details_sheet.dart`).
