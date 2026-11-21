# Aero design standards

Aero has its own look: white surfaces, black Inter text, CalSans titles, 1px grey-bordered cards, outlined pill chips, and color only for status (red late or destructive, green ok). Nothing should look like stock Material.

## The rules

1. **Use tokens, never raw values.** Colors, radii, spacing and text styles come from `lib/ui/tokens.dart`:
   - `AeroColors`: ink, inkSoft, muted, line, surface, surfaceAlt, danger, success, warn and their tints.
   - `AeroRadius`: sm 8 (chips, small tiles), md 12 (cards, buttons, inputs), lg 20 (sheets), pill.
   - `AeroSpace`: xs 4, sm 8, md 12, lg 16, xl 24, xxl 32.
   - `AeroText`: display (CalSans 32), title (CalSans 20), heading (16 w600), body (14), caption (12, muted), micro (11, muted).

   For a one-off variant, use `copyWith` on a token style. If you need a new value, add a token to `lib/ui/tokens.dart`. Do not inline it.
2. **No dialogs.** Confirmations use `showAeroConfirm(...)`, a bottom sheet. Other modal content uses `AeroSheet` via `showAeroSheet`.
3. **No SnackBars.** Use `showErrorToast` and `showSuccessToast` from `lib/utils/error.dart`.
4. **Buttons:** use `AeroButton` (primary = black), `AeroButton.secondary` (outlined) or `AeroButton.destructive` (red). Don't use bare `ElevatedButton`, `OutlinedButton` or `TextButton` in new code.
5. **Reuse before you build.** If a pattern already exists (card, chip, sheet), use it or move it into `lib/ui/components/`.
6. **Add components only when used.** A component goes into `lib/ui/components/` with its first real use, not ahead of time.

## Enforcement

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

Legacy code is grandfathered per file in `test/design_baseline.json`. The test fails if:
- any file's count goes **up**,
- a new file has violations,
- a count goes **down** and the baseline was not regenerated. This locks the cleanup in.

## Migrating legacy code

Migrate a file whenever a feature touches it, and migrate the whole file, not only the lines you changed. Then regenerate the baseline:

```bash
UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart
```

Commit the smaller `design_baseline.json` with the change. Legacy button themes (`blueAccent`) in `lib/ui/theme.dart` stay until their screens are migrated.
