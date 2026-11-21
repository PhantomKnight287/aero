import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/home/widgets/flight_profile.dart';
import 'package:aero/utils/flight_phases.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flight_phases_test.dart' as fp;

BuiltList<FlightPositionEntity> positions(List<ProfilePoint> pts) =>
    BuiltList([
      for (final p in pts)
        FlightPositionEntity((b) => b
          ..altitude = p.altitudeFt / 100
          ..groundspeed = p.groundSpeedKt
          ..heading = p.heading
          ..latitude = p.lat ?? 0
          ..longitude = p.lon ?? 0
          ..altitudeChange = FlightPositionEntityAltitudeChangeEnum.values.first
          ..timestamp = p.time.toIso8601String()),
    ]);

Future<void> pump(WidgetTester tester, Widget child) async {
  SharedPreferences.setMockInitialValues({'units.altitude': 'fl'});
  final units = UnitsNotifier();
  await units.load();
  await tester.pumpWidget(ChangeNotifierProvider.value(
    value: units,
    child: MaterialApp(home: Scaffold(body: ListView(children: [child]))),
  ));
}

void main() {
  testWidgets('hidden without enough positions', (tester) async {
    await pump(
        tester,
        FlightProfile(
            positions: positions(fp.stepClimbFlight().take(10).toList())));
    expect(find.text('Flight profile'), findsNothing);
  });

  testWidgets('summary, scrub reports a point then clears, events on expand',
      (tester) async {
    final scrubbed = <ProfilePoint?>[];
    await pump(
      tester,
      FlightProfile(
        positions: positions(fp.stepClimbFlight()),
        departureTz: 'UTC',
        onScrub: scrubbed.add,
      ),
    );
    expect(find.text('FL390 → FL410 · max 623 kt'), findsOneWidget);
    expect(find.text('Drag across the chart to explore'), findsOneWidget);

    final chart = find.byKey(const ValueKey('altitude-chart'));
    final g = await tester.startGesture(tester.getCenter(chart));
    await g.moveBy(const Offset(30, 0));
    await tester.pump();
    expect(scrubbed.last, isNotNull);
    expect(scrubbed.last!.lat, isNotNull);
    expect(find.text('Drag across the chart to explore'), findsNothing);
    await g.up();
    await tester.pump();
    expect(scrubbed.last, isNull);

    await tester.tap(find.text('Show speed & events'));
    await tester.pumpAndSettle();
    expect(find.text('Top of climb'), findsOneWidget);
    expect(find.text('Step climb'), findsOneWidget);
    expect(find.text('Top of descent'), findsOneWidget);
    expect(find.byKey(const ValueKey('speed-chart')), findsOneWidget);
  });
}
