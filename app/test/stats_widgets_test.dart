import 'package:aero/formatters/units.dart';
import 'package:aero/screens/profile/stats/widgets/bar_chart.dart';
import 'package:aero/screens/profile/stats/widgets/comparison_pill.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/screens/profile/stats/widgets/stat_bar_list.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/screens/profile/stats/widgets/summary_card.dart';
import 'package:aero/screens/profile/stats/widgets/unit_text.dart';
import 'package:aero/ui/tokens.dart';
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

  testWidgets('UnitText marks units grey', (t) async {
    await t.pumpWidget(
        wrap(UnitText.duration(37404, style: const TextStyle(fontSize: 20))));
    final root = t.widget<RichText>(find.descendant(
        of: find.byType(UnitText), matching: find.byType(RichText)));
    final spans = <TextSpan>[];
    root.text.visitChildren((s) {
      if (s is TextSpan && s.text != null) spans.add(s);
      return true;
    });
    expect(spans.map((s) => s.text), ['623', 'h', ' 24', 'm']);
    expect(spans[1].style!.color, AeroColors.muted);
    expect(spans[3].style!.color, AeroColors.muted);
    expect(spans[0].style!.color, isNot(AeroColors.muted));
  });

  testWidgets('UnitText under an hour, days and distance', (t) async {
    String text(UnitText u) => u.parts.map((p) => p.$1).join();
    const s = TextStyle(fontSize: 20);
    expect(text(UnitText.duration(38, style: s)), '38m');
    expect(text(UnitText.days(25 * 1440 + 23 * 60, style: s)), '25d 23h');
    expect(text(UnitText.distance(496500, DistanceUnit.km, style: s)),
        '496,500 km');
  });

  testWidgets('ranking bar has no track', (t) async {
    await t
        .pumpWidget(wrap(const StatBarList(color: AeroAccent.passport, rows: [
      StatBar(label: Text('DEL'), value: 29, valueLabel: '29'),
      StatBar(label: Text('DXB'), value: 14, valueLabel: '14'),
    ])));
    bool isTrack(Widget w) =>
        (w is ColoredBox && w.color == AeroColors.surfaceAlt) ||
        (w is Container &&
            (w.color == AeroColors.surfaceAlt ||
                (w.decoration as BoxDecoration?)?.color ==
                    AeroColors.surfaceAlt));
    expect(
        find.descendant(
            of: find.byType(StatBarList),
            matching: find.byWidgetPredicate(isTrack)),
        findsNothing);
    expect(find.text('29'), findsOneWidget);
  });

  test('axis ticks are nice', () {
    expect(niceTicks(13), [0, 4, 8, 12, 16]);
    expect(niceTicks(0), [0, 1]);
    expect(niceTicks(17), [0, 5, 10, 15, 20]);
    expect(niceTicks(90), [0, 25, 50, 75, 100]);
  });

  testWidgets('axis for all-zero values', (t) async {
    await t.pumpWidget(wrap(const BarChart(
        values: [0, 0], labels: ['a', 'b'], color: AeroAccent.passport)));
    expect(t.takeException(), isNull);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('comparison pill fills and caps', (t) async {
    await t.pumpWidget(wrap(const ComparisonPill(
        icon: ComparisonIcon.earth,
        fraction: 3.0,
        value: '3.0×',
        label: 'Around Earth')));
    final pill = t.getSize(find.byType(ComparisonPill));
    expect(t.getSize(find.byKey(ComparisonPill.fillKey)).width, pill.width);
    expect(pill.height, 48);
  });
}
