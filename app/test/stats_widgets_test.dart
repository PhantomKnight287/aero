import 'package:aero/screens/profile/stats/widgets/bar_chart.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/screens/profile/stats/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

final flight = StatsFlightSummaryEntity((b) => b
  ..id = 'f1'
  ..flightNo = 'EK215'
  ..identIata = 'EK215'
  ..identIcao = 'UAE215'
  ..date = '2026-03-14T23:30:00.000Z'
  ..localDate = '2026-03-15'
  ..airline.name = 'Emirates'
  ..airline.iata = 'EK'
  ..airline.icao = 'UAE'
  ..departure.iata = 'DXB'
  ..departure.icao = 'OMDB'
  ..departure.name = 'Dubai Intl'
  ..departure.city = 'Dubai'
  ..arrival.iata = 'LAX'
  ..arrival.icao = 'KLAX'
  ..arrival.name = 'Los Angeles Intl'
  ..arrival.city = 'Los Angeles');

Widget wrap(Widget w) =>
    MaterialApp(home: Scaffold(body: SingleChildScrollView(child: w)));

void main() {
  testWidgets('PastFlightRow shows both idents and cities', (t) async {
    await t.pumpWidget(wrap(PastFlightRow(flight: flight, onTap: () {})));
    expect(find.text('EK 215 · UAE215'), findsOneWidget);
    expect(find.text('DXB → LAX'), findsOneWidget);
    expect(find.text('Dubai to Los Angeles'), findsOneWidget);
    expect(find.text('15 Mar 2026'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
  });

  testWidgets('SummaryCard hides CTA without callback', (t) async {
    await t.pumpWidget(wrap(const SummaryCard(
        gradient: [Colors.black, Colors.black],
        ctaLabel: 'See details',
        child: Text('x'))));
    expect(find.text('See details'), findsNothing);
  });

  testWidgets('StatSection hides Show more without callback', (t) async {
    await t.pumpWidget(wrap(
        const StatSection(title: 'T', hero: '1', child: SizedBox.shrink())));
    expect(find.text('Show more'), findsNothing);
  });

  testWidgets('BarChart paints with all-zero values', (t) async {
    await t.pumpWidget(wrap(const BarChart(
        values: [0, 0, 0], labels: ['a', 'b', 'c'], color: Colors.blue)));
    expect(t.takeException(), isNull);
  });
}
