import 'dart:ui' show FontFeature;

import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens. The only place raw colors, radii, font sizes, curves and
/// durations may live (see app/DESIGN.md). Everything else references these.
abstract final class AeroColors {
  static const ink = Color(0xff000000);
  static const inkSoft = Color(0xdd000000); // body text
  static const muted = Color(0xff808080); // secondary text
  static const line = Color(0xffe0e0e0); // card borders
  static const handle = Color(0xffd6d6d6); // sheet drag handle
  static const surface = Color(0xffffffff);
  static const surfaceAlt = Color(0xfff6f6f6); // inset panels, inputs
  static const danger = Color(0xffe53935);
  static const dangerTint = Color(0xfffdecec);
  static const success = Color(0xff2e7d32);
  static const successTint = Color(0xffe8f5e9);
  static const warn = Color(0xffef6c00);
  static const onInk = Color(0xffffffff); // text on ink/danger buttons
}

abstract final class AeroRadius {
  static const double sm = 8; // chips inside cards, small tiles
  static const double md = 12; // cards, buttons, inputs
  static const double lg = 20; // sheets
  static const double pill = 999;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const lgTop = BorderRadius.vertical(top: Radius.circular(lg));
  static const pillAll = BorderRadius.all(Radius.circular(pill));
}

/// 4-pt spacing scale.
abstract final class AeroSpace {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class AeroFonts {
  /// Same family string the theme uses, so weights resolve identically.
  static final inter = GoogleFonts.inter().fontFamily!;
  static const calSans = 'CalSans';
}

/// Every style carries its fontFamily explicitly: some widgets (button
/// styles, toasts) *replace* the inherited text style instead of merging,
/// which silently falls back to the system font.
abstract final class AeroText {
  // Large text gets negative tracking, body stays at 0 (size-specific).
  static final display = TextStyle(
      fontFamily: AeroFonts.calSans,
      fontSize: 32,
      height: 1.1,
      letterSpacing: -0.6,
      color: AeroColors.ink);
  static final title = TextStyle(
      fontFamily: AeroFonts.calSans,
      fontSize: 20,
      height: 1.2,
      letterSpacing: -0.2,
      color: AeroColors.ink);
  static final heading = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
      color: AeroColors.ink);
  static final body = TextStyle(
      fontFamily: AeroFonts.inter, fontSize: 14, color: AeroColors.inkSoft);
  static final caption = TextStyle(
      fontFamily: AeroFonts.inter, fontSize: 12, color: AeroColors.muted);
  static final micro = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 11,
      letterSpacing: 0.2,
      color: AeroColors.muted);

  /// Tabular figures for times, codes and counts so digits don't jitter.
  static const tabular = [FontFeature.tabularFigures()];
}

/// Motion from Emil Kowalski's design-engineering rules: ease-out for
/// anything responding to the user, never ease-in; exits faster than enters.
abstract final class AeroMotion {
  static const easeOut = Cubic(0.23, 1, 0.32, 1);
  static const easeInOut = Cubic(0.77, 0, 0.175, 1);

  /// iOS-like sheet curve (Vaul): steep start, gentle settle.
  static const sheet = Cubic(0.32, 0.72, 0, 1);

  static const press = Duration(milliseconds: 160);
  static const sheetIn = Duration(milliseconds: 450);
  static const sheetOut = Duration(milliseconds: 250);

  /// Scale for pressed buttons/tiles (0.95-0.98 range).
  static const pressedScale = 0.97;
}
