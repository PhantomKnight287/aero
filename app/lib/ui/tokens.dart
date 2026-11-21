import 'package:flutter/material.dart';

/// Design tokens. The only place raw colors, radii and font sizes may live
/// (see app/DESIGN.md). Everything else references these.
abstract final class AeroColors {
  static const ink = Color(0xff000000);
  static const inkSoft = Color(0xdd000000); // body text
  static const muted = Color(0xff808080); // secondary text
  static const line = Color(0xffe0e0e0); // card borders, dividers
  static const handle = Color(0xffd6d6d6); // sheet drag handle
  static const surface = Color(0xffffffff);
  static const surfaceAlt = Color(0xfffafafa); // inputs, nav bar
  static const danger = Color(0xffe53935);
  static const dangerTint = Color(0xffffebee);
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

abstract final class AeroText {
  static const _cal = 'CalSans';

  static const display = TextStyle(
      fontFamily: _cal, fontSize: 32, color: AeroColors.ink, height: 1.15);
  static const title = TextStyle(
      fontFamily: _cal, fontSize: 20, color: AeroColors.ink, height: 1.2);
  static const heading = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AeroColors.ink);
  static const body = TextStyle(fontSize: 14, color: AeroColors.inkSoft);
  static const caption = TextStyle(fontSize: 12, color: AeroColors.muted);
  static const micro = TextStyle(fontSize: 11, color: AeroColors.muted);
}
