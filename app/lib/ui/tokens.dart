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
  static const shadow = Color(0x1f000000); // soft elevation (12% black)
  // Dark translucent overlay chrome over the map.
  static const glass = Color(0x80000000);
  static const glassEdge = Color(0x4dffffff);
  static const onInkMuted = Color(0xccffffff);
}

/// Report accents: allowed only on stats cards and stats charts.
abstract final class AeroAccent {
  static const passport = Color(0xff5b3fe0); // bars, links, arcs
  static const passportGradient = [Color(0xff2b1f86), Color(0xff14093f)];
  static const delayGradient = [Color(0xffb3261e), Color(0xff4a0d08)];
  static const aircraftGradient = [Color(0xff0f4c6e), Color(0xff082a3d)];
  static const onAircraftMuted = Color(0xffa9d4e8);
  static const aircraftTile = Color(0xffe7f1f6); // flown family tile
  static const onPassportMuted = Color(0xffc9c2ff);
  static const onDelayMuted = Color(0xffffb4a8);
  static const late = Color(0xffe5483b); // late-rate bars, delay figures
  /// Arrival breakdown: early, on time, 15m, 30m, 45m+, cancelled, diverted.
  static const delayBuckets = [
    Color(0xff2e9e5b),
    Color(0xff6fd37a),
    Color(0xfff5c542),
    Color(0xfff0962e),
    late,
    Color(0xff9e9e9e),
    Color(0xff8e1b14),
  ];
  static const passportTint = Color(0xfff2f0fb); // comparison bar track
  // Passport card: flag ring (mid-gradient), machine-readable band, CTA rule.
  static const passportRing = Color(0xff1d1260);
  static const passportBand = Color(0x10ffffff);
  static const onPassportMrz = Color(0xb3ffffff);
  static const passportRule = Color(0x1fffffff);
  static const passportEmblem = [Color(0xffffffff), Color(0xffc9c2ff)];
  // Painted comparison icons, radial from centre to edge.
  static const earthGradient = [
    Color(0xff7ec8ff),
    Color(0xff1b6fd1),
    Color(0xff0b3d7a),
  ];
  static const moonGradient = [Color(0xffeeeeee), Color(0xff9a9a9a)];
  static const sunGradient = [Color(0xffffd24a), Color(0xfff39a1e)];
}

abstract final class AeroRadius {
  static const double sm = 8; // chips inside cards, small tiles
  static const double md = 12; // cards, buttons, inputs
  static const double lg = 20; // sheets
  static const double pill = 999;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const mdBottom = BorderRadius.vertical(bottom: Radius.circular(md));
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

  /// Big numeric readouts (scheduled times on the route card).
  static final figure = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      color: AeroColors.ink,
      fontFeatures: tabular);

  /// Passport card headline figures (flights, distance).
  static final figureLg = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 30,
      fontWeight: FontWeight.w800,
      height: 1.05,
      letterSpacing: -0.5,
      color: AeroColors.ink,
      fontFeatures: tabular);

  /// Machine-readable passport strip. No bundled mono font: platform mono.
  static const mono = TextStyle(
      fontFamily: 'monospace',
      fontFamilyFallback: ['Menlo', 'Courier New'],
      fontSize: 10.5,
      height: 1.5,
      letterSpacing: 1.2,
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

  /// Stats hero number.
  static final hero = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 52,
      fontWeight: FontWeight.w800,
      height: 1,
      letterSpacing: -1.2,
      color: AeroColors.ink,
      fontFeatures: tabular);
  static final heroUnit = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: AeroColors.muted);
  static final sectionTitle = TextStyle(
      fontFamily: AeroFonts.calSans,
      fontSize: 22,
      letterSpacing: -0.4,
      color: AeroColors.ink);

  /// Uppercase applied by the caller.
  static final label = TextStyle(
      fontFamily: AeroFonts.inter,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
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
  static const move = Duration(milliseconds: 220); // on-screen movement
  static const sheetIn = Duration(milliseconds: 450);
  static const sheetOut = Duration(milliseconds: 250);

  /// Scale for pressed buttons/tiles (0.95-0.98 range).
  static const pressedScale = 0.97;
}
