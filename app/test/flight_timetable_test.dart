import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/home/widgets/flight_timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime t(int h, int m) => DateTime.utc(2026, 11, 15, h, m);

final fa = FlightAwareDataEntity((b) => b
  ..id = 'fa1'
  ..ident = 'UAE380'
  ..status = 'Arrived'
  ..foresightPredictionsAvailable = false
  ..blocked = false
  ..diverted = false
  ..cancelled = false
  ..positionOnly = false
  ..createdAt = t(0, 0)
  ..updatedAt = t(0, 0)
  ..scheduledOut = t(6, 36)
  ..actualOut = t(6, 40)
  ..scheduledOff = t(6, 50)
  ..actualOff = t(6, 54)
  ..actualRunwayOff = '30R'
  ..scheduledOn = t(13, 55)
  ..actualOn = t(14, 2)
  ..actualRunwayOn = '07L'
  ..scheduledIn = t(14, 3)
  ..actualIn = t(14, 9));

void main() {
  testWidgets('collapsed: phases + block; expanded: runways, taxi, air',
      (tester) async {
    SharedPreferences.setMockInitialValues({'units.time': 'utc'});
    final units = UnitsNotifier();
    await units.load();
    await tester.pumpWidget(ChangeNotifierProvider.value(
      value: units,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: FlightTimetable(
                fa: fa, departureTz: 'Asia/Dubai', arrivalTz: 'Asia/Hong_Kong'),
          ),
        ),
      ),
    ));

    expect(find.text('06:40Z'), findsOneWidget);
    expect(find.text('4 min late'), findsWidgets);
    expect(find.textContaining('Block 7 h 29 min'), findsOneWidget);
    expect(find.textContaining('2 min longer than scheduled'), findsOneWidget);
    expect(find.textContaining('Taxi'), findsNothing);
    expect(find.textContaining('Rwy'), findsNothing);

    await tester.tap(find.text('Show timing details'));
    await tester.pumpAndSettle();
    expect(find.text('Takeoff · Rwy 30R'), findsOneWidget);
    expect(find.text('Landing · Rwy 07L'), findsOneWidget);
    expect(find.text('Taxi 14 min'), findsOneWidget);
    expect(find.text('Air 7 h 08 min · sched 7 h 05 min'), findsOneWidget);
    expect(find.text('Taxi 7 min'), findsOneWidget);
    expect(find.text('sched 06:36Z · act 06:40Z'), findsOneWidget);
    expect(find.text('Hide timing details'), findsOneWidget);
  });
}
