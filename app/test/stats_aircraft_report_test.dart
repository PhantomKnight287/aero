import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/aircraft_report.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'stats_report_test.dart' show fixture, summary, airport;

const familyNames = [
  'A220', 'A320 family', 'A330', 'A340', 'A350', 'A380', '737', '747', //
  '757', '767', '777', '787', 'ATR', 'Dash 8', 'E-Jets', 'CRJ',
];

Map<String, dynamic> flightOn(int i) => {
      ...summary(),
      'id': 'f$i',
      'flightNo': 'EK${200 + i}',
      'identIata': 'EK${200 + i}',
      'identIcao': 'UAE${200 + i}',
      'arrival': airport(i % 9 + 2),
    };

Map<String, dynamic> aircraftJson({int a388Flights = 2, bool empty = false}) {
  if (empty) {
    return {
      'basedOn': 0,
      'types': [],
      'families': [
        for (final f in familyNames)
          {'family': f, 'typeCodes': [], 'flightCount': 0, 'firstFlown': null}
      ],
      'airframes': {
        'medianAgeYears': null,
        'oldest': null,
        'newest': null,
        'mostFlownTail': null,
      },
    };
  }
  return {
    'basedOn': 81,
    'types': [
      {
        'typeCode': 'A388',
        'typeName': 'Airbus A380-800',
        'flightCount': a388Flights,
        'flights': [for (var i = 0; i < a388Flights; i++) flightOn(i)],
      },
      {
        'typeCode': 'B77W',
        'typeName': 'Boeing 777-300ER',
        'flightCount': 1,
        'flights': [flightOn(99)],
      },
    ],
    'families': [
      {
        'family': 'A380',
        'typeCodes': ['A388'],
        'flightCount': a388Flights,
        'firstFlown': '2025-10-27',
      },
      {
        'family': '777',
        'typeCodes': ['B77W'],
        'flightCount': 1,
        'firstFlown': '2025-10-26',
      },
      for (final f in familyNames.where((f) => f != 'A380' && f != '777'))
        {'family': f, 'typeCodes': [], 'flightCount': 0, 'firstFlown': null},
    ],
    'airframes': {
      'medianAgeYears': 10.8,
      'oldest': {
        'reg': 'C-FXCA',
        'typeCode': 'B763',
        'typeName': 'Boeing 767-300',
        'ageYears': 36.6,
        'flight': {...summary(), 'flightNo': 'AC100'},
      },
      'newest': {
        'reg': 'VT-NCO',
        'typeCode': 'A21N',
        'typeName': 'Airbus A321neo',
        'ageYears': 1.6,
        'flight': flightOn(5),
      },
      'mostFlownTail': {
        'reg': 'JA381A',
        'typeName': 'Airbus A380-800',
        'count': 3
      },
    },
  };
}

AircraftSectionEntity aircraftEntity(
        {int a388Flights = 2, bool empty = false}) =>
    standardSerializers.deserializeWith(AircraftSectionEntity.serializer,
        aircraftJson(a388Flights: a388Flights, empty: empty))!;

ProfileStatsResponseEntity aircraftFixture(
        {int a388Flights = 2, bool empty = false}) =>
    fixture().rebuild((b) => b.aircraft
        .replace(aircraftEntity(a388Flights: a388Flights, empty: empty)));

Future<void> pumpAircraft(WidgetTester t, ProfileStatsResponseEntity s) async {
  t.view.physicalSize = const Size(400, 3000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final c = StatsController(
    fetchStats: (_) async => s,
    fetchHistory: (_, __) async => null,
  );
  await t.pumpWidget(ChangeNotifierProvider(
    create: (_) => UnitsNotifier(),
    child: MaterialApp(home: AircraftReport(controller: c)),
  ));
  await t.pump();
}

void main() {
  testWidgets('aircraft report shows every section', (t) async {
    await pumpAircraft(t, aircraftFixture());
    for (final s in [
      'Aircraft types',
      '2 types flown',
      'Type collection',
      'Airframes',
      'based on 81 flights with aircraft data',
      'MOST FLOWN TAIL',
    ]) {
      expect(find.textContaining(s, findRichText: true), findsWidgets,
          reason: s);
    }
    expect(find.text('2 of 16 families', findRichText: true), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('tapping a type opens its flights', (t) async {
    await pumpAircraft(t, aircraftFixture());
    await t.tap(find.text('A388'));
    await t.pumpAndSettle();
    expect(find.text('Airbus A380-800'), findsWidgets);
    expect(find.text('EK 201 · UAE201'), findsOneWidget);
  });

  testWidgets('type with 45 flights scrolls in its sheet', (t) async {
    await pumpAircraft(t, aircraftFixture(a388Flights: 45));
    await t.tap(find.text('A388'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });

  testWidgets('code-less type label gets room for its name', (t) async {
    final s = aircraftFixture()
        .rebuild((b) => b.aircraft.types.add(AircraftTypeEntity((t) => t
          ..typeName = 'Boeing 777'
          ..flightCount = 1)));
    await pumpAircraft(t, s);
    final box = t.widget<SizedBox>(find
        .ancestor(of: find.text('Boeing 777'), matching: find.byType(SizedBox))
        .first);
    expect(box.width, greaterThanOrEqualTo(110));
  });

  testWidgets('empty aircraft data', (t) async {
    await pumpAircraft(t, aircraftFixture(empty: true));
    expect(find.text('No aircraft data for this period yet.'), findsOneWidget);
    expect(find.text('Aircraft types'), findsNothing);
  });

  testWidgets('oldest airframe pops an OpenFlightRequest', (t) async {
    OpenFlightRequest? result;
    final c = StatsController(
      fetchStats: (_) async => aircraftFixture(),
      fetchHistory: (_, __) async => null,
    );
    final router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => TextButton(
          onPressed: () async {
            result = await context.push<OpenFlightRequest>('/a');
          },
          child: const Text('open'),
        ),
      ),
      GoRoute(path: '/a', builder: (_, __) => AircraftReport(controller: c)),
    ]);
    t.view.physicalSize = const Size(400, 3000);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    await t.pumpWidget(ChangeNotifierProvider(
        create: (_) => UnitsNotifier(),
        child: MaterialApp.router(routerConfig: router)));
    await t.tap(find.text('open'));
    await t.pumpAndSettle();
    await t.tap(find.text('OLDEST'));
    await t.pumpAndSettle();
    expect(result?.flightNo, 'AC100');
  });
}
