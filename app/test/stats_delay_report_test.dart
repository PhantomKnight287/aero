import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/delay_report.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'stats_report_test.dart' show fixture, summary, airport;

Map<String, dynamic> flight(String no, String iata) => {
      ...summary(),
      'flightNo': no,
      'identIata': no,
      'identIcao': no,
      'airline': {'name': 'Air $iata', 'iata': iata, 'icao': '${iata}X'},
    };

Map<String, dynamic> airline(String name, int late, int total, int mins) => {
      'airline': {'name': name, 'iata': name.substring(0, 2)},
      'lateArrivals': late,
      'total': total,
      'minutesLate': mins,
    };

ProfileStatsResponseEntity delayFixture(
    {int airlines = 3,
    int basedOn = 29,
    int cancelled = 0,
    int delayedExtra = 0,
    String firstAirline = 'Air India'}) {
  final json = {
    'basedOn': basedOn,
    'arrivedCount': basedOn,
    'delayedCount': basedOn == 0 ? 0 : 14,
    'minutesLost': 1020,
    'avgDelayMinutes': 73,
    'netMinutes': 694,
    'buckets': {
      'early': 12,
      'onTime': 5,
      'late15': 1,
      'late30': 2,
      'late45': 6,
      'cancelled': cancelled,
      'diverted': basedOn == 0 ? 0 : 2,
      'total': (basedOn == 0 ? 0 : 28) + cancelled,
    },
    'worst':
        basedOn == 0 ? null : {'flight': flight('AI185', 'AI'), 'value': 392},
    'airlines': basedOn == 0
        ? []
        : [
            airline(firstAirline, 2, 3, 420),
            for (var i = 1; i < airlines; i++) airline('Line $i', 1, 2, 30 * i),
          ],
    'airports': basedOn == 0
        ? []
        : [
            {'airport': airport(1), 'lateDepartures': 3, 'total': 5},
          ],
    'flights': basedOn == 0
        ? []
        : [
            {'flight': flight('AI185', 'AI'), 'value': 392},
            {'flight': flight('TG316', 'TG'), 'value': 167},
            for (var i = 0; i < delayedExtra; i++)
              {'flight': flight('6E${100 + i}', '6E'), 'value': 30 - i},
          ],
  };
  final d =
      standardSerializers.deserializeWith(DelaySummaryEntity.serializer, json)!;
  return fixture().rebuild((b) => b.delays.replace(d));
}

Future<void> pumpDelays(WidgetTester t, ProfileStatsResponseEntity s,
    {double width = 400}) async {
  t.view.physicalSize = Size(width, 3000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final c = StatsController(
    fetchStats: (_) async => s,
    fetchHistory: (_, __) async => null,
  );
  await t.pumpWidget(ChangeNotifierProvider(
    create: (_) => UnitsNotifier(),
    child: MaterialApp(home: DelayReport(controller: c)),
  ));
  await t.pump();
}

void main() {
  testWidgets('delay report shows every section', (t) async {
    await pumpDelays(t, delayFixture());
    expect(find.text('48%'), findsOneWidget);
    expect(find.text('14 of 29 flights arrived more than 15m late'),
        findsOneWidget);
    for (final s in [
      'Arrival performance',
      'Worst airlines',
      'Airline performance',
      'Airport performance',
      'Arrival delays',
    ]) {
      expect(find.text(s), findsOneWidget, reason: s);
    }
    expect(find.text('based on 28 flights with FlightAware times'),
        findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('no show more at five airlines', (t) async {
    await pumpDelays(t, delayFixture(airlines: 5));
    expect(find.text('Show more'), findsNothing);
  });

  testWidgets('show more past five airlines opens the full list', (t) async {
    await pumpDelays(t, delayFixture(airlines: 6));
    expect(find.textContaining('Line 5', findRichText: true), findsNothing);
    await t.tap(find.text('Show more'));
    await t.pumpAndSettle();
    expect(find.textContaining('Line 5', findRichText: true), findsOneWidget);
  });

  testWidgets('empty delays', (t) async {
    await pumpDelays(t, delayFixture(basedOn: 0));
    expect(
        find.text('No FlightAware times for this period yet.'), findsOneWidget);
    expect(find.text('Arrival performance'), findsNothing);
  });

  testWidgets('cancelled-only period has no 0% card', (t) async {
    await pumpDelays(t, delayFixture(basedOn: 0, cancelled: 1));
    expect(find.text('flights delayed'), findsNothing);
    expect(find.text('Arrival performance'), findsOneWidget);
  });

  testWidgets('long airline name does not overflow', (t) async {
    await pumpDelays(t, delayFixture(firstAirline: 'A' * 60), width: 360);
    expect(t.takeException(), isNull);
  });

  testWidgets('worst delay pops an OpenFlightRequest', (t) async {
    expect(
        await openFrom(t, delayFixture(), (t) async {
          await t.tap(find.text('WORST DELAY'));
        }),
        'AI185');
  });

  testWidgets('a flight in the Show more sheet pops through the sheet',
      (t) async {
    expect(
        await openFrom(t, delayFixture(delayedExtra: 5), (t) async {
          final more = find.text('Show more').last;
          await t.ensureVisible(more);
          await t.tap(more);
          await t.pumpAndSettle();
          await t.tap(find.textContaining('6E 104 · 6E104').last);
        }),
        '6E104');
  });
}

/// Pushes the report from a stub page, runs [act], returns the popped
/// request's flight number.
Future<String?> openFrom(WidgetTester t, ProfileStatsResponseEntity s,
    Future<void> Function(WidgetTester) act) async {
  {
    OpenFlightRequest? result;
    final c = StatsController(
      fetchStats: (_) async => s,
      fetchHistory: (_, __) async => null,
    );
    final router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => TextButton(
          onPressed: () async {
            result = await context.push<OpenFlightRequest>('/d');
          },
          child: const Text('open'),
        ),
      ),
      GoRoute(path: '/d', builder: (_, __) => DelayReport(controller: c)),
    ]);
    t.view.physicalSize = const Size(400, 3000);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    await t.pumpWidget(ChangeNotifierProvider(
        create: (_) => UnitsNotifier(),
        child: MaterialApp.router(routerConfig: router)));
    await t.tap(find.text('open'));
    await t.pumpAndSettle();
    await act(t);
    await t.pumpAndSettle();
    return result?.flightNo;
  }
}
