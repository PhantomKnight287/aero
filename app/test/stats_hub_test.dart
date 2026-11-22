import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/main.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

PassportEntity makePassport(int flights) => PassportEntity((b) => b
  ..totalFlights = flights
  ..totalDistanceKm = flights * 1000
  ..blockMinutes = flights * 120
  ..airMinutes = 0
  ..airBasedOn = 0
  ..taxiMinutes = 0
  ..taxiBasedOn = 0
  ..totalAirports = 0
  ..totalAirlines = 0
  ..totalCountries = 0
  ..domestic = 0
  ..international = 0
  ..longHaul = 0);

class FakeStats extends Fake implements ProfileStatsResponseEntity {
  FakeStats(int flights, {this.minutesLost = 0, this.basedOn = 0})
      : passport = makePassport(flights);
  final int minutesLost;
  final int basedOn;
  @override
  final PassportEntity passport;
  @override
  num? get year => null;
  @override
  BuiltList<num> get availableYears => BuiltList<num>();
  @override
  DelaySummaryEntity get delays => DelaySummaryEntity((b) => b
    ..basedOn = basedOn
    ..arrivedCount = basedOn
    ..delayedCount = 0
    ..minutesLost = minutesLost
    ..avgDelayMinutes = 0);
  @override
  AircraftStatsEntity? get aircraftStats => null;
}

final flight = StatsFlightSummaryEntity((b) => b
  ..id = 'f1'
  ..flightNo = 'EK215'
  ..identIata = 'EK215'
  ..identIcao = 'UAE215'
  ..faFlightId = 'UAE215-1'
  ..date = '2025-03-14T08:00:00.000Z'
  ..localDate = '2025-03-14'
  ..airline.name = 'Emirates'
  ..airline.iata = 'EK'
  ..airline.icao = 'UAE'
  ..departure.name = 'Dubai Intl'
  ..departure.city = 'Dubai'
  ..departure.iata = 'DXB'
  ..arrival.name = 'Los Angeles Intl'
  ..arrival.city = 'Los Angeles'
  ..arrival.iata = 'LAX');

StatsController controller(int flights, List<StatsFlightSummaryEntity> items,
        {int minutesLost = 0, int basedOn = 0}) =>
    StatsController(
      fetchStats: (y) async =>
          FakeStats(flights, minutesLost: minutesLost, basedOn: basedOn),
      fetchHistory: (cur, y) async => FlightHistoryResponseEntity((b) => b
        ..items = ListBuilder<StatsFlightSummaryEntity>(items)
        ..yearCounts = ListBuilder<YearCountEntity>(items.isEmpty
            ? const <YearCountEntity>[]
            : [
                YearCountEntity((c) => c
                  ..year = 2025
                  ..count = 21)
              ])),
    );

Widget app(Widget home) => ChangeNotifierProvider(
    create: (_) => UnitsNotifier(), child: MaterialApp(home: home));

void main() {
  testWidgets('hub renders empty stats', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(controller: controller(0, []))));
    await t.pumpAndSettle();
    expect(find.text('Passport'), findsOneWidget);
    expect(find.text('No flights yet'), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('hub hides delay CTA in part 1', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [flight], minutesLost: 600, basedOn: 3))));
    await t.pumpAndSettle();
    expect(find.text('All flight stats'), findsOneWidget);
    expect(find.text('hours lost to delays'), findsOneWidget);
    expect(find.text('All delay stats'), findsNothing);
  });

  testWidgets('delay card shows minutes under an hour', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [flight], minutesLost: 42, basedOn: 3))));
    await t.pumpAndSettle();
    expect(find.text('42'), findsOneWidget);
    expect(find.text('minutes lost to delays'), findsOneWidget);
  });

  testWidgets('delay card hidden when nothing was lost', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [flight], minutesLost: 0, basedOn: 3))));
    await t.pumpAndSettle();
    expect(find.textContaining('lost to delays'), findsNothing);
  });

  testWidgets('tapping a flight with no parseable date does nothing',
      (t) async {
    final bad = flight.rebuild((b) => b
      ..localDate = 'garbage'
      ..date = 'garbage');
    await t
        .pumpWidget(app(FlightStatsScreen(controller: controller(1, [bad]))));
    await t.pumpAndSettle();
    await t.scrollUntilVisible(find.text('Dubai to Los Angeles'), 200,
        scrollable: find.byType(Scrollable).first);
    await t.tap(find.text('Dubai to Los Angeles'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });

  testWidgets('tapping a past flight pops an OpenFlightRequest', (t) async {
    OpenFlightRequest? result;
    final router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => TextButton(
          onPressed: () async {
            result = await context.push<OpenFlightRequest>('/hub');
          },
          child: const Text('open'),
        ),
      ),
      GoRoute(
        path: '/hub',
        builder: (_, __) =>
            FlightStatsScreen(controller: controller(1, [flight])),
      ),
    ]);
    await t.pumpWidget(ChangeNotifierProvider(
        create: (_) => UnitsNotifier(),
        child: MaterialApp.router(routerConfig: router)));
    await t.tap(find.text('open'));
    await t.pumpAndSettle();
    expect(find.text('2025'), findsOneWidget);
    expect(find.text('21 flights'), findsOneWidget);
    await t.scrollUntilVisible(find.text('Dubai to Los Angeles'), 200,
        scrollable: find.byType(Scrollable).first);
    await t.tap(find.text('Dubai to Los Angeles'));
    await t.pumpAndSettle();
    expect(result?.flightNo, 'EK215');
    expect(result?.faFlightId, 'UAE215-1');
    expect(result?.date, DateTime(2025, 3, 14));
  });
}
