import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/main.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/passport_card.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

CountryEntity makeCountry(int i) => CountryEntity((b) => b
  ..isoCountry = ['IN', 'AE', 'US', 'TH', 'GB', 'JP'][i % 6]
  ..name = 'Country $i'
  ..flightCount = 1);

class FakeStats extends Fake implements ProfileStatsResponseEntity {
  FakeStats(int flights,
      {this.minutesLost = 0,
      this.basedOn = 0,
      int countryCount = 0,
      PassportEntity? passport,
      this.aircraftStats,
      List<num> years = const []})
      : passport = passport ?? makePassport(flights),
        availableYears = BuiltList.of(years),
        countries = BuiltList.of(List.generate(countryCount, makeCountry));
  final num minutesLost;
  final int basedOn;
  @override
  final PassportEntity passport;
  @override
  final BuiltList<CountryEntity> countries;
  @override
  final AircraftStatsEntity? aircraftStats;
  @override
  num? get year => null;
  @override
  final BuiltList<num> availableYears;
  @override
  DelaySummaryEntity get delays => DelaySummaryEntity((b) => b
    ..basedOn = basedOn
    ..arrivedCount = basedOn
    ..delayedCount = 0
    ..minutesLost = minutesLost
    ..avgDelayMinutes = 0);
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
        {num minutesLost = 0, int basedOn = 0, FakeStats? stats}) =>
    StatsController(
      fetchStats: (y) async =>
          stats ??
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
    expect(find.text('10 h'), findsOneWidget);
    expect(find.text('lost to delays'), findsOneWidget);
    expect(find.text('All delay stats'), findsNothing);
  });

  testWidgets('delay card shows minutes under an hour', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [flight], minutesLost: 42, basedOn: 3))));
    await t.pumpAndSettle();
    expect(find.text('42 m'), findsOneWidget);
    expect(find.text('lost to delays'), findsOneWidget);
  });

  testWidgets('delay card hidden when nothing was lost', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [flight], minutesLost: 0, basedOn: 3))));
    await t.pumpAndSettle();
    expect(find.textContaining('lost to delays'), findsNothing);
  });

  testWidgets('delay card hidden when the loss rounds to 0 m', (t) async {
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [flight], minutesLost: 0.4, basedOn: 3))));
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
    await t.ensureVisible(find.text('Dubai to Los Angeles'));
    await t.pumpAndSettle();
    await t.tap(find.text('Dubai to Los Angeles'));
    await t.pumpAndSettle();
    expect(result?.flightNo, 'EK215');
    expect(result?.faFlightId, 'UAE215-1');
    expect(result?.date, DateTime(2025, 3, 14));
  });

  testWidgets('passport fits 7-digit values at 360dp', (t) async {
    t.view.physicalSize = const Size(360, 2400);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    final big = makePassport(102).rebuild((b) => b
      ..totalDistanceKm = 4965000
      ..blockMinutes = 9999999
      ..totalAirports = 1234567
      ..totalAirlines = 1234567
      ..longHaul = 44
      ..totalCountries = 36);
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(102, [],
            stats: FakeStats(102, passport: big, countryCount: 36)))));
    await t.pumpAndSettle();
    expect(find.byType(PassportCard), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  Future<void> pumpCountries(WidgetTester t, int n) async {
    await t.pumpWidget(app(Scaffold(
        body: SingleChildScrollView(
            child: PassportCard(stats: FakeStats(5, countryCount: n))))));
  }

  testWidgets('flag row overflow label', (t) async {
    await pumpCountries(t, 36);
    expect(find.text('+25 · 36 countries'), findsOneWidget);
    await pumpCountries(t, 11);
    expect(find.text('11 countries'), findsOneWidget);
    expect(find.textContaining('+'), findsNothing);
  });

  test('passportMrz pads to 44 and never contains the user name', () {
    final s = FakeStats(102,
        years: [2025, 2024],
        passport: makePassport(102).rebuild((b) => b..totalCountries = 36));
    final (l1, l2) = passportMrz(s, now: DateTime(2026, 11, 22));
    expect(l1, startsWith('P<AERO<ALLTIME<<102<FLT<<36<CTRY<'));
    expect(l2, startsWith('FIRST<FLT<2024<<ISSUED<22NOV26<'));
    for (final l in [l1, l2]) {
      expect(l, hasLength(44));
      expect(l, matches(RegExp(r'^[A-Z0-9<]{44}$')));
      expect(l, isNot(contains('GURPAL')));
    }
  });

  testWidgets('aircraft photo is 16:9 cover', (t) async {
    final a = AircraftStatsEntity((b) => b
      ..mostFlownAircraftName = 'Boeing 777'
      ..mostFlownAircraftFlightCount = 12
      ..mostFlownAircraftImage = 'https://example.com/777.jpg'
      ..mostCommonTailNumber = 'A6-EOF'
      ..mostCommonTailNumberCount = 2);
    await t.pumpWidget(app(FlightStatsScreen(
        controller: controller(3, [], stats: FakeStats(3, aircraftStats: a)))));
    await t.pumpAndSettle();
    final img = t.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
    final built = img.imageBuilder!(t.element(find.byType(CachedNetworkImage)),
        const NetworkImage('https://example.com/777.jpg'));
    expect(built, isA<AspectRatio>());
    expect((built as AspectRatio).aspectRatio, 16 / 9);
    expect((built.child! as Image).fit, BoxFit.cover);
  });
}
