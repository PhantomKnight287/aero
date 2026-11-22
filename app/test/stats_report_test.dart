import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/flight_stats_report.dart';
import 'package:aero/screens/profile/stats/passport_header.dart';
import 'package:aero/screens/profile/stats/sections/extremes_section.dart';
import 'package:aero/screens/profile/stats/sections/top_lists_section.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

Map<String, dynamic> airport(int i) => {
      'iata': 'A${i.toString().padLeft(2, '0')}',
      'icao': 'XA${i.toString().padLeft(2, '0')}',
      'name': 'Airport number $i',
      'city': 'City $i',
      'isoCountry': 'IN',
      'lat': 10 + i,
      'lon': 70 + i,
      'elevationFt': 100 * i,
    };

const hnl = {
  'iata': 'HNL',
  'icao': 'PHNL',
  'name': 'Daniel K. Inouye Intl',
  'city': 'Honolulu',
  'isoCountry': 'US',
  'lat': 21.32,
  'lon': -157.92,
  'elevationFt': 13,
};

Map<String, dynamic> summary() => {
      'id': 'f1',
      'flightNo': 'EK215',
      'identIata': 'EK215',
      'identIcao': 'UAE215',
      'airline': {'name': 'Emirates', 'iata': 'EK', 'icao': 'UAE'},
      'departure': airport(1),
      'arrival': hnl,
      'date': '2026-03-14T08:00:00.000Z',
      'localDate': '2026-03-14',
    };

ProfileStatsResponseEntity fixture(
    {bool withMap = false,
    bool noRunwaysOrTaxi = false,
    bool noCountries = false,
    num blockMinutes = 25139}) {
  final json = {
    'availableYears': [2025, 2026],
    'year': null,
    'passport': {
      'totalFlights': 104,
      'totalDistanceKm': 508005,
      'blockMinutes': blockMinutes,
      'airMinutes': 20000,
      'airBasedOn': 61,
      'taxiMinutes': 1500,
      'taxiBasedOn': 61,
      'totalAirports': 60,
      'totalAirlines': 40,
      'totalCountries': 2,
      'domestic': 41,
      'international': 63,
      'longHaul': 38,
    },
    'flightsPer': {
      'year': [
        {'year': 2025, 'count': 50},
        {'year': 2026, 'count': 54},
      ],
      'month': List.filled(12, 8),
      'weekday': List.filled(7, 14),
    },
    'records': {
      'shortestDistance': {'flight': summary(), 'value': 300},
      'longestDistance': {'flight': summary(), 'value': 13000},
    },
    'topAirports': [
      for (var i = 1; i <= 12; i++)
        {
          'airport': airport(i),
          'departures': 20 - i,
          'arrivals': 19 - i,
          'flightCount': 39 - 2 * i,
          'distanceKm': 1000.0 * (20 - i),
        },
    ],
    'topAirlines': [
      {
        'airline': {'name': 'Emirates', 'iata': 'EK', 'icao': 'UAE'},
        'flightCount': 10,
        'distanceKm': 50000,
      },
    ],
    'topRoutes': [
      {
        'from': airport(1),
        'to': hnl,
        'flightCount': 3,
        'distanceKm': 30000,
      },
    ],
    'countries': [
      {'isoCountry': 'IN', 'name': 'India', 'flightCount': 90},
      {'isoCountry': 'US', 'name': 'United States', 'flightCount': 4},
    ],
    'continents': [
      {
        'bucket': 'europe',
        'countryCount': 0,
        'flightShare': 0,
        'flightCount': 0
      },
      {
        'bucket': 'north_america',
        'countryCount': 1,
        'flightShare': 0.1,
        'flightCount': 4
      },
      {
        'bucket': 'asia',
        'countryCount': 14,
        'flightShare': 0.9,
        'flightCount': 82
      },
    ],
    'delays': {
      'basedOn': 0,
      'arrivedCount': 0,
      'delayedCount': 0,
      'minutesLost': 0,
      'avgDelayMinutes': 0,
    },
    'runways': {
      'basedOn': 9,
      'items': [
        {
          'airport': airport(1),
          'runway': '29R',
          'departures': 6,
          'arrivals': 1
        },
        {'airport': airport(1), 'runway': '28', 'departures': 0, 'arrivals': 2},
        {'airport': hnl, 'runway': '8L', 'departures': 1, 'arrivals': 0},
      ],
    },
    'taxiByAirport': {
      'basedOn': 9,
      'items': [
        {
          'airport': airport(1),
          'avgTaxiOutMin': 22,
          'taxiOutCount': 9,
          'avgTaxiInMin': null,
          'taxiInCount': 0,
        },
      ],
      'longest': {'flight': summary(), 'value': 45},
    },
    'extremes': {'north': airport(5), 'east': hnl, 'highest': airport(3)},
    'map': {
      'airports': withMap
          ? [
              {'iata': 'A01', 'icao': 'XA01', 'lat': 11, 'lon': 71},
              {'iata': 'HNL', 'icao': 'PHNL', 'lat': 21.32, 'lon': -157.92},
            ]
          : [],
      'routes': withMap
          ? [
              {
                'fromLat': 11,
                'fromLon': 71,
                'toLat': 21.32,
                'toLon': -157.92,
                'count': 3,
              },
            ]
          : [],
    },
    'mostFlownAircraft': {'aircraftName': 'Boeing 777', 'flightCount': 12},
  };
  if (noCountries) {
    json['countries'] = [];
    json['continents'] = [];
  }
  if (noRunwaysOrTaxi) {
    json['runways'] = {'basedOn': 0, 'items': []};
    json['taxiByAirport'] = {'basedOn': 0, 'items': [], 'longest': null};
  }
  return standardSerializers.deserializeWith(
      ProfileStatsResponseEntity.serializer, json)!;
}

Future<void> pumpReport(WidgetTester t, ProfileStatsResponseEntity s,
    {double width = 400}) async {
  t.view.physicalSize = Size(width, 2400);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  final c = StatsController(
    fetchStats: (_) async => s,
    fetchHistory: (_, __) async => null,
  );
  await t.pumpWidget(ChangeNotifierProvider(
    create: (_) => UnitsNotifier(),
    child: MaterialApp(home: FlightStatsReport(controller: c)),
  ));
  await t.pump();
}

void main() {
  testWidgets('report shows hero numbers', (t) async {
    await pumpReport(t, fixture());
    expect(find.text('60 total airports'), findsOneWidget);
    expect(find.text('3 runways used'), findsOneWidget);
    expect(find.text('418h 59m', findRichText: true), findsOneWidget);
    expect(find.text('taxi-out 22m avg (9 flights)'), findsOneWidget);
  });

  testWidgets('map placeholder when no coordinates', (t) async {
    await pumpReport(t, fixture());
    expect(find.byType(FlutterMap), findsNothing);
  });

  testWidgets('map renders when airports have coordinates', (t) async {
    await pumpReport(t, fixture(withMap: true));
    expect(find.byType(FlutterMap), findsOneWidget);
    // Let flutter_map's tile timers run out before the tree is torn down.
    await t.pumpWidget(const SizedBox());
    await t.pump(const Duration(seconds: 1));
  });

  testWidgets('show more opens sheet', (t) async {
    await pumpReport(t, fixture());
    expect(find.text('Airport number 9'), findsNothing);
    final more = find.text('Show more').first;
    await t.ensureVisible(more);
    await t.tap(more);
    await t.pumpAndSettle();
    expect(find.text('Airport number 9'), findsOneWidget);
  });

  testWidgets('extremes rows list both codes', (t) async {
    await pumpReport(t, fixture());
    expect(find.text('HNL · PHNL'), findsOneWidget);
    expect(find.text('157.9°W'), findsOneWidget);
  });

  testWidgets('runway sheet groups by airport', (t) async {
    await pumpReport(t, fixture());
    final more = find.text('Show all runways');
    await t.ensureVisible(more);
    await t.tap(more);
    await t.pumpAndSettle();
    expect(find.text('A01 · XA01 · Airport number 1'), findsOneWidget);
    expect(find.text('Runway 29R · 6 off · 1 on'), findsOneWidget);
  });

  testWidgets('hidden sections leave one gap', (t) async {
    await pumpReport(t, fixture(noRunwaysOrTaxi: true));
    expect(find.text('Runway log'), findsNothing);
    expect(find.text('Taxi by airport'), findsNothing);
    final gap = t.getTopLeft(find.byType(ExtremesSection)).dy -
        t.getBottomLeft(find.byType(TopRoutesSection)).dy;
    expect(gap, AeroSpace.xxl);
  });

  test('fitLongitudes crosses the Pacific when that is narrower', () {
    // HNL, NRT, DEL
    final lons = fitLongitudes([-158, 140, 77]);
    expect(lons, [202, 140, 77]);
    final span = lons.reduce((a, b) => a > b ? a : b) -
        lons.reduce((a, b) => a < b ? a : b);
    expect(span, closeTo(125, 1));
    // Europe-only stays put.
    expect(fitLongitudes([-0.5, 2.5, 13.4]), [-0.5, 2.5, 13.4]);
  });

  test('airport dots use the fitted longitude frame', () {
    MapAirportEntity a(String iata, num lat, num lon) =>
        MapAirportEntity((b) => b
          ..iata = iata
          ..lat = lat
          ..lon = lon);
    final pts = airportPoints(
        [a('HNL', 21.3, -158), a('NRT', 35.8, 140), a('DEL', 28.6, 77)]);
    expect(pts.map((p) => p.longitude), [202, 140, 77]);
    expect(pts.first.latitude, 21.3);
  });

  test('splitAtAntimeridian ends both pieces on the edge', () {
    final parts = splitAtAntimeridian(
        [const LatLng(10, 178), const LatLng(20, 182), const LatLng(30, 186)]);
    expect(parts, hasLength(2));
    expect(parts[0].last.longitude, 180);
    expect(parts[1].first.longitude, -180);
    expect(parts[0].last.latitude, closeTo(15, 1e-9));
    expect(parts[1].first.latitude, closeTo(15, 1e-9));
    expect(parts[1].last.longitude, closeTo(-174, 1e-9));
  });

  testWidgets('flights shows stacked lines', (t) async {
    await pumpReport(t, fixture());
    final dom = find.textContaining('domestic', findRichText: true);
    final intl = find.textContaining('international', findRichText: true);
    expect(dom, findsOneWidget);
    expect(intl, findsOneWidget);
    expect(t.widget(dom), isNot(same(t.widget(intl))));
    expect(find.text('41 domestic', findRichText: true), findsOneWidget);
    expect(find.text('38 long haul', findRichText: true), findsOneWidget);
  });

  testWidgets('distance shows average and three comparisons', (t) async {
    await pumpReport(t, fixture());
    expect(find.text('Average distance: 4,885 km'), findsOneWidget);
    expect(find.textContaining('Around Earth'), findsWidgets);
    expect(find.textContaining('To the Moon'), findsWidgets);
    expect(find.textContaining('Around the Sun'), findsWidgets);
    // Sun's circumference 4,370,000 km: 508,005 km → 0.12×.
    expect(find.textContaining('0.12×'), findsWidgets);
  });

  testWidgets('regions list replaces grid', (t) async {
    await pumpReport(t, fixture());
    expect(find.text('14 countries · 82 flights'), findsOneWidget);
    expect(find.text('1 country · 4 flights'), findsOneWidget);
    expect(find.text('Europe'), findsNothing);
    expect(find.byType(GridView), findsNothing);
    expect(find.text('90%'), findsNothing);
    // Sorted by flights: Asia above N. America.
    expect(t.getTopLeft(find.text('Asia')).dy,
        lessThan(t.getTopLeft(find.text('N. America')).dy));
    expect(find.text('90 flights'), findsOneWidget);
  });

  testWidgets('empty year hides lists', (t) async {
    await pumpReport(t, fixture(noCountries: true));
    expect(find.text('Countries & territories'), findsNothing);
    expect(find.text('REGIONS'), findsNothing);
    expect(find.text('Asia'), findsNothing);
  });

  testWidgets('time grid fits large values', (t) async {
    await pumpReport(t, fixture(blockMinutes: 7404960), width: 360);
    expect(t.takeException(), isNull);
    expect(find.text('Days'), findsOneWidget);
    expect(find.text('Taxiing'), findsOneWidget);
    expect(find.textContaining('WEEKS'), findsNothing);
    expect(find.text('61 flights with data'), findsNWidgets(2));
  });

  testWidgets('no emoji in report', (t) async {
    await pumpReport(t, fixture());
    final emoji =
        RegExp('[\u{1F1E6}-\u{1F1FF}\u{1F30D}\u{1F315}☀]', unicode: true);
    for (final r in t.widgetList<RichText>(find.byType(RichText))) {
      expect(emoji.hasMatch(r.text.toPlainText()), isFalse,
          reason: r.text.toPlainText());
    }
  });

  testWidgets('runway label stays on one line', (t) async {
    await pumpReport(t, fixture());
    final label = find.textContaining('A01 29R', findRichText: true);
    expect(label, findsOneWidget);
    expect(t.getSize(label).height, lessThan(30));
  });

  testWidgets('report shows error with Retry that refetches', (t) async {
    var calls = 0;
    final c = StatsController(
      fetchStats: (_) async {
        calls++;
        throw Exception('boom');
      },
      fetchHistory: (_, __) async => null,
    );
    await t.pumpWidget(ChangeNotifierProvider(
      create: (_) => UnitsNotifier(),
      child: MaterialApp(home: FlightStatsReport(controller: c)),
    ));
    await t.pump();
    expect(find.text('Retry'), findsOneWidget);
    final before = calls;
    await t.tap(find.text('Retry'));
    await t.pump();
    expect(calls, before + 1);
  });
}
