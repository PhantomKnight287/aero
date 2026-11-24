import 'dart:async';
import 'dart:io';

import 'package:aero/formatters/units.dart';
import 'package:aero/screens/home/widgets/share/share_cards.dart';
import 'package:aero/screens/home/widgets/share/share_data.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import 'flight_detail_test.dart' show inFlight;
import 'flight_status_test.dart' show at, flight;

/// Share cards rendered with the real fonts. The PNGs under goldens/ are the
/// visual spec: regenerate with
///   flutter test test/share_card_golden_test.dart --update-goldens
/// and look at them before committing. Rendering differs per OS; these are
/// macOS goldens.
Future<void> _font(String family, String path) async {
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.sublistView(File(path).readAsBytesSync())));
  await loader.load();
}

FlightResponseEntity _real(FlightResponseEntity f) => f.rebuild((b) => b
  ..airline.name = 'Southwest Airlines'
  ..airline.icao = null
  ..departure.airport.location.lat = 38.7487
  ..departure.airport.location.lon = -90.37
  ..arrival.airport.location.lat = 33.4342
  ..arrival.airport.location.lon = -112.0116
  ..arrival.gate = 'B12');

ShareData _data(FlightResponseEntity f, DateTime now, {bool photo = true}) =>
    ShareData.from(_real(f), now,
        distanceUnit: DistanceUnit.km,
        timeMode: TimeMode.airport,
        use24: false,
        photo: photo
            ? MemoryImage(
                File('test/goldens/photo_fixture.png').readAsBytesSync())
            : null);

Future<void> _golden(
    WidgetTester t, ShareStyle style, ShareData d, String name) async {
  t.view.physicalSize = style.size * 2;
  t.view.devicePixelRatio = 2;
  addTearDown(t.view.reset);
  // flutter_test draws shadows as hard outlines; the cards need the real ones.
  debugDisableShadows = false;
  await t.pumpWidget(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      color: AeroColors.surfaceAlt,
      child: Center(
        child: RepaintBoundary(
          key: const ValueKey('card'),
          child: buildShareCard(style, d, tiles: false),
        ),
      ),
    ),
  ));
  await t.runAsync(() async {
    for (final e in find.byType(Image).evaluate()) {
      await precacheImage((e.widget as Image).image, e);
    }
  });
  await t.pumpAndSettle();
  try {
    await expectLater(find.byKey(const ValueKey('card')),
        matchesGoldenFile('goldens/$name.png'));
  } finally {
    debugDisableShadows = true;
  }
}

void main() {
  setUpAll(() async {
    // First touch of AeroFonts starts google_fonts' download, which fails
    // offline; keep that failure out of the test zone.
    final inter = runZonedGuarded(() => AeroFonts.inter, (_, __) {})!;
    await _font(inter, 'test/fonts/Inter.ttf');
    await _font(AeroFonts.calSans, 'assets/fonts/calsans.ttf');
    await _font('MaterialIcons',
        '${Platform.environment['FLUTTER_ROOT']}/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
  });

  final now = at(18, 26);
  final early = flight(
      actualOut: at(15, 30),
      actualOff: at(15, 40),
      actualOn: at(18, 20),
      actualIn: at(18, 28));

  testWidgets('card in flight', (t) async {
    await _golden(t, ShareStyle.card, _data(inFlight(), now), 'card_in_flight');
  });
  testWidgets('card cancelled, no photo', (t) async {
    await _golden(t, ShareStyle.card,
        _data(inFlight(cancelled: true), now, photo: false), 'card_cancelled');
  });
  testWidgets('pass in flight', (t) async {
    await _golden(t, ShareStyle.pass, _data(inFlight(), now), 'pass_in_flight');
  });
  testWidgets('board in flight', (t) async {
    await _golden(
        t, ShareStyle.board, _data(inFlight(), now), 'board_in_flight');
  });
  testWidgets('board arrived early', (t) async {
    await _golden(
        t, ShareStyle.board, _data(early, at(19, 0)), 'board_arrived');
  });
  testWidgets('story in flight', (t) async {
    await _golden(
        t, ShareStyle.story, _data(inFlight(), now), 'story_in_flight');
  });
}
