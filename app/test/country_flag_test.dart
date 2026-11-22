import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aero/ui/components/country_flag.dart';

Future<void> pump(WidgetTester t, Widget w) =>
    t.pumpWidget(MaterialApp(home: Scaffold(body: Center(child: w))));

void main() {
  testWidgets('renders a flag for IN (case-insensitive)', (t) async {
    await pump(t, const CountryFlag(iso2: 'in'));
    expect(find.byType(CircleFlag), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('unknown code falls back', (t) async {
    for (final c in ['XX', '', 'ZZ', 'I', 'IND', '1N', 'é!']) {
      await pump(t, CountryFlag(iso2: c));
      expect(find.byType(CircleFlag), findsNothing, reason: c);
      expect(find.byType(Container), findsWidgets, reason: c);
      expect(t.takeException(), isNull, reason: c);
    }
  });

  testWidgets('ring adds an outer circle', (t) async {
    await pump(t, const CountryFlag(iso2: 'IN', ring: Colors.red));
    expect(find.byType(CircleFlag), findsOneWidget);
    expect(t.getSize(find.byType(CountryFlag)), const Size(28, 28));
  });
}
