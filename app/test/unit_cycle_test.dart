import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

void main() {
  testWidgets('tap cycles the dimension globally, hint shown once',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final units = UnitsNotifier();
    await units.load();

    await tester.pumpWidget(ToastificationWrapper(
      child: MaterialApp(
        home: ChangeNotifierProvider.value(
          value: units,
          child: Scaffold(
            body: Column(children: [
              UnitCycle(
                dimension: UnitDimension.altitude,
                builder: (_, u) => Text(formatAltitude(39000, u.altitude)),
              ),
              // Second surface: must follow the same global setting.
              Builder(
                builder: (context) => Text(
                  'other ${formatAltitude(1000, context.watch<UnitsNotifier>().altitude)}',
                ),
              ),
            ]),
          ),
        ),
      ),
    ));

    expect(find.text('39,000 ft'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Change altitude unit')), findsOneWidget);
    await tester.tap(find.text('39,000 ft'));
    await tester.pumpAndSettle();
    expect(find.text('11,887 m'), findsOneWidget);
    expect(find.text('other 305 m'), findsOneWidget);
    expect(units.hintShown, isTrue);
    expect(find.textContaining('now in m everywhere'), findsOneWidget);

    // Two quick taps: m -> FL -> ft, exactly one step each.
    await tester.tap(find.text('11,887 m'));
    await tester.pump();
    await tester.tap(find.byType(UnitCycle));
    await tester.pumpAndSettle();
    expect(units.altitude, AltitudeUnit.ft);
    expect(find.text('39,000 ft'), findsOneWidget);

    // Let toast timers finish.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });
}
