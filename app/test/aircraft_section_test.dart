import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/home/widgets/aircraft_section.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

RouteInfoEntity _seg(String iata, String utc) => RouteInfoEntity((b) => b
  ..scheduledTime.utc = utc
  ..scheduledTime.local = utc
  ..airport.iata = iata
  ..airport.icao = 'X'
  ..airport.name = iata
  ..airport.timeZone = 'UTC'
  ..airport.countryCode = 'XX'
  ..airport.municipalityName = iata
  ..airport.location.lat = 0
  ..airport.location.lon = 0);

// Our flight departs DXB 06:40Z.
final flight = FlightResponseEntity((b) => b
  ..id = 'f1'
  ..flightNo = 'EK380'
  ..callSign = 'UAE380'
  ..cargo = false
  ..date = DateTime.utc(2026, 11, 15)
  ..airline.name = 'Emirates'
  ..greatCircleDistance.km = '6819'
  ..aircraft.model = 'Airbus A380-800'
  ..aircraft.registration = 'A6-EOF'
  ..departure.replace(_seg('DXB', '2026-11-15T06:40:00Z'))
  ..arrival.replace(_seg('HKG', '2026-11-15T14:15:00Z')));

AircraftLegEntity leg(String id, {String? estimatedIn, String? actualIn}) =>
    AircraftLegEntity((b) => b
      ..faFlightId = id
      ..ident = 'UAE381'
      ..identIata = 'EK381'
      ..identIcao = 'UAE381'
      ..status = 'En Route'
      ..originIata = 'HKG'
      ..originIcao = 'VHHH'
      ..originCity = 'Hong Kong'
      ..originTimezone = 'Asia/Hong_Kong'
      ..destinationIata = 'DXB'
      ..destinationIcao = 'OMDB'
      ..destinationCity = 'Dubai'
      ..destinationTimezone = 'Asia/Dubai'
      ..scheduledOut = '2026-11-15T01:00:00Z'
      ..scheduledIn = '2026-11-15T05:40:00Z'
      ..estimatedIn = estimatedIn
      ..actualIn = actualIn
      ..arrivalDelay = 2100
      ..cancelled = false);

FlightSummaryEntity own(int i) => FlightSummaryEntity((b) => b
  ..id = 'o$i'
  ..flightNo = 'EK$i'
  ..callSign = 'UAE$i'
  ..airline.name = 'Emirates'
  ..airline.iata = 'EK'
  ..departureAirportCode = 'DXB'
  ..departureAirportName = 'Dubai'
  ..arrivalAirportCode = 'LHR'
  ..arrivalAirportName = 'Heathrow'
  ..date = DateTime.utc(2025, 1, i).toIso8601String());

Future<void> pump(WidgetTester tester, Widget child) async {
  SharedPreferences.setMockInitialValues({});
  final units = UnitsNotifier();
  await units.load();
  await tester.pumpWidget(ChangeNotifierProvider.value(
    value: units,
    child: MaterialApp(home: Scaffold(body: ListView(children: [child]))),
  ));
}

void main() {
  final history = AircraftHistoryEntity((b) => b
    ..registration = 'A6-EOF'
    ..inbound.replace(leg('in', estimatedIn: '2026-11-15T06:15:00Z')));

  testWidgets('late inbound: tight turnaround chip and sentence',
      (tester) async {
    await pump(tester, AircraftSection(info: flight, history: history));
    expect(find.text('TIGHT TURNAROUND'), findsOneWidget);
    expect(find.text('Only 25 min between its arrival and your departure'),
        findsOneWidget);
    expect(find.text('This flight'), findsOneWidget);
    expect(find.text('Hong Kong → Dubai'), findsOneWidget);
    expect(find.text('HKG VHHH → DXB OMDB'), findsOneWidget);
  });

  testWidgets('arrived inbound: summary sentence', (tester) async {
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b
          ..registration = 'A6-EOF'
          ..inbound.replace(leg('in', actualIn: '2026-11-15T04:00:00Z'))),
      ),
    );
    expect(find.text('ARRIVED'), findsOneWidget);
    expect(
        find.text('The inbound aircraft arrived 35 min late'), findsOneWidget);
    expect(find.textContaining('min between'), findsNothing);
  });

  testWidgets('tapping a leg opens that exact flight', (tester) async {
    String? openedFa;
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: history,
        onOpenFlight: (ident, date, {faFlightId}) => openedFa = faFlightId,
      ),
    );
    // 01:00Z departure is 09:00 in Hong Kong, dated in Hong Kong.
    expect(find.text('EK381 · UAE381'), findsOneWidget);
    expect(find.text('Dep Nov 15, 09:00 AM'), findsOneWidget);
    await tester.tap(find.text('Hong Kong → Dubai'));
    expect(openedFa, 'in');
  });

  testWidgets('show earlier flights extends the chain with older legs only',
      (tester) async {
    var loads = 0;
    await pump(
        tester,
        AircraftSection(
            info: flight, history: history, onLoadRecent: () => loads++));
    await tester.tap(find.text('Show earlier flights'));
    expect(loads, 1);

    AircraftLegEntity at(String id, String out) => leg(id).rebuild((b) => b
      ..scheduledOut = out
      ..originCity = 'Frankfurt'
      ..destinationCity = 'Hong Kong');
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: history,
        recent: [
          at('future', '2026-11-16T01:00:00Z'), // after ours: excluded
          at('in', '2026-11-15T01:00:00Z'), // the inbound itself: excluded
          at('older', '2026-11-14T10:00:00Z'),
        ],
      ),
    );
    expect(find.text('Frankfurt → Hong Kong'), findsOneWidget);
    expect(find.text('Show earlier flights'), findsNothing);

    await pump(tester,
        AircraftSection(info: flight, history: history, recent: const []));
    expect(find.text('No earlier flights found'), findsOneWidget);
  });

  testWidgets('own flights: one row, sheet with the full list', (tester) async {
    String? opened;
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: history.rebuild(
            (b) => b..ownFlights.addAll([for (var i = 1; i <= 7; i++) own(i)])),
        onOpenFlight: (ident, _, {faFlightId}) => opened = ident,
      ),
    );
    expect(find.text('You have 7 flights on A6-EOF'), findsOneWidget);
    await tester.tap(find.text('You have 7 flights on A6-EOF'));
    await tester.pumpAndSettle();
    expect(find.text('Your history on A6-EOF'), findsOneWidget);
    expect(find.text('DXB → LHR'), findsNWidgets(7));
    await tester.tap(find.text('EK3 · UAE3'));
    await tester.pumpAndSettle();
    expect(opened, 'EK3');
    expect(find.text('Your history on A6-EOF'), findsNothing); // sheet closed
  });

  testWidgets('history still shows when aircraft details are missing',
      (tester) async {
    await pump(
      tester,
      AircraftSection(
        info: flight.rebuild((b) => b..aircraft = null),
        history: history,
      ),
    );
    expect(find.text('This flight'), findsOneWidget);
    expect(find.text('Show earlier flights'), findsOneWidget);
  });

  testWidgets('tappable things show an affordance before being touched',
      (tester) async {
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: history.rebuild((b) => b..ownFlights.add(own(1))),
        onLoadRecent: () {},
        onOpenFlight: (_, __, {faFlightId}) {},
      ),
    );
    // Earlier flights: a button with an icon, not bare text.
    expect(find.byKey(const ValueKey('show-earlier')), findsOneWidget);
    expect(find.byIcon(Icons.history), findsOneWidget);
    // Own flights row carries a verb.
    expect(find.text('View'), findsOneWidget);
    // Tappable leg rows get a chevron.
    expect(find.byKey(const ValueKey('leg-chevron-in')), findsOneWidget);
  });
}
