import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

/// App theme. The explicit monochrome ColorScheme keeps Material 3's default
/// purple seed from leaking into any widget that isn't styled by hand.
ThemeData aeroTheme() {
  const scheme = ColorScheme.light(
    primary: AeroColors.ink,
    onPrimary: AeroColors.onInk,
    secondary: AeroColors.ink,
    onSecondary: AeroColors.onInk,
    error: AeroColors.danger,
    onError: AeroColors.onInk,
    surface: AeroColors.surface,
    onSurface: AeroColors.ink,
    surfaceContainerLowest: AeroColors.surface,
    surfaceContainerLow: AeroColors.surfaceAlt,
    surfaceContainer: AeroColors.surfaceAlt,
    surfaceContainerHigh: AeroColors.surfaceAlt,
    surfaceContainerHighest: AeroColors.surfaceAlt,
    outline: AeroColors.line,
    outlineVariant: AeroColors.line,
    surfaceTint: Colors.transparent,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AeroColors.surface,
    fontFamily: GoogleFonts.inter().fontFamily,
    brightness: Brightness.light,
    primaryColor: AeroColors.ink,
    splashFactory: InkRipple.splashFactory,
    dividerTheme: const DividerThemeData(color: AeroColors.line, thickness: 1),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AeroColors.ink),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AeroColors.ink),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AeroColors.surface,
      modalBackgroundColor: AeroColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AeroRadius.lgTop),
      showDragHandle: false,
    ),
    // Dialogs are banned in new code (use showAeroConfirm); legacy ones at
    // least stop looking stock.
    dialogTheme: const DialogThemeData(
      backgroundColor: AeroColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AeroRadius.mdAll),
      titleTextStyle: AeroText.title,
      contentTextStyle: AeroText.body,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AeroColors.ink,
      contentTextStyle: TextStyle(color: AeroColors.onInk),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AeroRadius.mdAll),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 14)),
      backgroundColor: AeroColors.surfaceAlt,
      indicatorColor: AeroColors.ink.withValues(alpha: .4),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: AeroText.title,
      toolbarHeight: 50,
      backgroundColor: AeroColors.surface,
    ),
    textTheme: const TextTheme(
      labelMedium: TextStyle(fontSize: 20),
      titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 16, color: AeroColors.muted),
      titleMedium: TextStyle(fontSize: 20),
      bodyMedium: AeroText.body,
    ),
    // Legacy button themes kept as-is so existing screens don't shift;
    // new code uses AeroButton.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.blueAccent, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    ),
  );
}
