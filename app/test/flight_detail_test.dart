import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/home/widgets/flight_info.dart';
import 'package:aero/ui/tokens.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flight_status_test.dart' show flight, at;
import 'stats_aircraft_report_test.dart' show flightOn;

AirportConditionsEntity conditions(
        {required String code,
        int temp = 6,
        String sky = 'clear',
        int delaySecs = 0}) =>
    standardSerializers.deserializeWith(AirportConditionsEntity.serializer, {
      'observation': {
        'airport_code': code,
        'raw_data': 'METAR K$code',
        'time': '2026-11-23T15:00:00Z',
        'temp_air': temp,
        'conditions': sky,
        'wind_direction': 0,
        'wind_friendly': 'Light winds',
        'wind_speed': 3,
        'wind_speed_gust': 0,
        'wind_units': 'KT',
      },
      'delays': {
        'airport': code,
        'category': 'arrival',
        'color': 'green',
        'delay_secs': delaySecs,
        'reasons': [
          if (delaySecs > 0)
            {
              'category': 'weather',
              'color': 'yellow',
              'delay_secs': delaySecs,
              'reason': 'Low ceilings'
            }
        ],
      },
    })!;

/// In flight, departed 7m late from E4, arrival gate unknown.
FlightResponseEntity inFlight({
  int phxDelaySecs = 0,
  bool withImage = false,
  String? age,
  bool cancelled = false,
  bool diverted = false,
  bool fa = true,
}) =>
    flight(
      fa: fa,
      actualOut: fa ? at(15, 42) : null,
      actualOff: fa ? at(15, 52) : null,
      estimatedIn: fa ? at(19, 6) : null,
      cancelled: cancelled,
      diverted: diverted,
      destinationIata: diverted ? 'TUS' : null,
      arrRevised: fa ? null : '2026-11-23T19:06:00Z',
    ).rebuild((b) {
      b
        ..aircraftTypeName = 'Boeing 737 MAX 8'
        ..aircraft.registration = 'N8872Q'
        ..aircraft.model = '737-8'
        ..aircraft.image = withImage ? 'https://example.com/p.jpg' : null
        ..aircraft.age = age
        ..departure.gate = 'E4'
        ..departure.terminal = '2'
        ..arrival.terminal = '4'
        ..departure.airport.municipalityName = 'St Louis'
        ..departure.airport.name = 'St Louis Lambert Intl'
        ..arrival.airport.municipalityName = 'Phoenix'
        ..arrival.airport.name = 'Phoenix Sky Harbor Intl'
        ..departure.airport.conditions.replace(conditions(code: 'STL'))
        ..arrival.airport.conditions.replace(conditions(
            code: 'PHX',
            temp: 16,
            sky: 'partly cloudy',
            delaySecs: phxDelaySecs))
        ..bookings.add(FlightBookingEntity((k) => k
          ..id = 'b1'
          ..flightId = 'f1'
          ..userId = 'u1'
          ..createdAt = DateTime.utc(2026)
          ..updatedAt = DateTime.utc(2026)
          ..seatType = FlightBookingEntitySeatTypeEnum.window
          ..seatingClass = FlightBookingEntitySeatingClassEnum.economy));
      if (fa) b.flightAwareData.aircraftType = 'B38M';
    });

RouteHistoryEntity history(int n) =>
    standardSerializers.deserializeWith(RouteHistoryEntity.serializer, {
      'flightCount': n,
      'distanceKm': 2428 * n,
      'blockMinutes': 204 * n,
      'recent': [for (var i = 0; i < n && i < 3; i++) flightOn(i)],
    })!;

RouteAirportEntity? tappedAirport;

Future<void> pump(
  WidgetTester t,
  FlightResponseEntity f, {
  int historyCount = 2,
  DateTime? now,
}) async {
  SharedPreferences.setMockInitialValues({});
  t.view.physicalSize = const Size(412, 5000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
  tappedAirport = null;
  await t.pumpWidget(ChangeNotifierProvider(
    create: (_) => UnitsNotifier(),
    child: MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: FlightInfoWidget(
            info: f,
            onClose: () {},
            onRefreshTracking: () {},
            flightPositions: BuiltList(),
            now: now ?? at(18, 26),
            onAirportTap: (a) => tappedAirport = a,
            loadRouteHistory: () async => history(historyCount),
          ),
        ),
      ),
    ),
  ));
  await t.pumpAndSettle();
}

double y(WidgetTester t, Finder f) => t.getTopLeft(f.first).dy;

void main() {
  testWidgets('sections in Flighty order', (t) async {
    await pump(t, inFlight());
    final order = [
      find.text('In flight · lands in 40m'),
      find.text('Good to know'),
      find.text('Timetable'),
      find.text('Boeing 737 MAX 8'),
      find.text('My history on this route'),
      find.text('Booking'),
    ];
    for (var i = 1; i < order.length; i++) {
      expect(y(t, order[i]), greaterThan(y(t, order[i - 1])), reason: '$i');
    }
    expect(t.takeException(), isNull);
  });

  testWidgets('header kicker, title and route rows', (t) async {
    await pump(t, inFlight());
    expect(find.text('St Louis to Phoenix'), findsOneWidget);
    expect(find.textContaining('SWA4187'), findsWidgets);
    expect(find.text('STL · KSTL'), findsOneWidget);
    expect(find.text('St Louis Lambert Intl'), findsOneWidget);
    expect(find.text('7m late'), findsOneWidget);
    expect(find.text('Gate E4'), findsOneWidget);
    expect(find.text('Terminal 2'), findsOneWidget);
  });

  testWidgets('times stay ink; only lateness is coloured', (t) async {
    await pump(t, inFlight());
    // 19:06Z is 12:06 PM in Phoenix.
    final big = t.widget<Text>(find.text('12:06 PM').first);
    expect(big.style?.color, AeroColors.ink);
    final struck = find.byWidgetPredicate((w) =>
        w is Text &&
        w.data == '11:40 AM' &&
        w.style?.decoration == TextDecoration.lineThrough);
    expect(struck, findsOneWidget);
    expect(t.widget<Text>(find.text('26m late')).style?.color, AeroColors.warn);
    // 7m late is not "late" (> 15 min), so it stays muted.
    expect(t.widget<Text>(find.text('7m late')).style?.color, AeroColors.muted);
  });

  testWidgets('unknown arrival gate shows --', (t) async {
    await pump(t, inFlight());
    expect(find.text('Gate --'), findsOneWidget);
  });

  testWidgets('menu opens a sheet with all six actions', (t) async {
    await pump(t, inFlight());
    await t.tap(find.byTooltip('Flight actions'));
    await t.pumpAndSettle();
    for (final l in [
      'Refresh tracking',
      'Refresh flight data',
      'Send to wearable',
      'Get alerts',
      'Booking details',
      'Share',
    ]) {
      expect(find.text(l), findsOneWidget, reason: l);
    }
  });

  testWidgets('tapping the departure airport row opens its airport', (t) async {
    await pump(t, inFlight());
    await t.tap(find.text('STL · KSTL'));
    expect(tappedAirport?.iata, 'STL');
  });

  testWidgets('weather rows; no zero-delay noise', (t) async {
    await pump(t, inFlight());
    expect(find.text('STL 6°C · Clear'), findsOneWidget);
    expect(find.text('PHX 16°C · Partly cloudy'), findsOneWidget);
    expect(find.textContaining('Delay 0m'), findsNothing);
    expect(find.textContaining('Cause: None'), findsNothing);
    expect(find.textContaining('delayed'), findsNothing);
  });

  testWidgets('non-zero airport delay shows one row', (t) async {
    await pump(t, inFlight(phxDelaySecs: 1500));
    expect(find.textContaining('PHX delays ~25m'), findsOneWidget);
    expect(find.textContaining('Low ceilings'), findsOneWidget);
  });

  testWidgets('route history hidden at 0', (t) async {
    await pump(t, inFlight(), historyCount: 0);
    expect(find.text('My history on this route'), findsNothing);
  });

  testWidgets('route history shown at 2', (t) async {
    await pump(t, inFlight(), historyCount: 2);
    expect(find.text('My history on this route'), findsOneWidget);
    expect(find.text('2 flights'), findsOneWidget);
  });

  testWidgets('aircraft title from type name; photo and age slots', (t) async {
    await pump(t, inFlight(age: '0'));
    expect(find.text('Boeing 737 MAX 8'), findsOneWidget);
    expect(find.text('No photo yet'), findsOneWidget);
    expect(find.text('Unknown'), findsOneWidget);
    expect(find.textContaining('months'), findsNothing);
  });

  testWidgets('no FlightAware data still renders', (t) async {
    await pump(t, inFlight(fa: false), now: at(17, 0));
    expect(find.textContaining('In flight'), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('cancelled', (t) async {
    await pump(t, inFlight(cancelled: true));
    expect(find.text('Cancelled'), findsWidgets);
    expect(find.textContaining('ago'), findsNothing);
  });

  testWidgets('diverted shows the actual airport and the plan', (t) async {
    await pump(t, inFlight(diverted: true));
    expect(find.text('Diverted to TUS'), findsOneWidget);
    expect(find.text('planned PHX'), findsOneWidget);
  });
}
