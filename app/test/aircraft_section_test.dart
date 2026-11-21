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
      ..destinationIata = 'DXB'
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
  testWidgets('late inbound gets a warning headline', (tester) async {
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b
          ..registration = 'A6-EOF'
          // Lands 06:15Z, our departure 06:40Z: 25 min turnaround (< 45).
          ..inbound.replace(leg('in', estimatedIn: '2026-11-15T06:15:00Z'))),
      ),
    );
    expect(find.text('Your aircraft'), findsOneWidget);
    expect(find.text('EK381 · UAE381'), findsOneWidget);
    expect(find.text('Only 25 min between its arrival and your departure'),
        findsOneWidget);
  });

  testWidgets('comfortable inbound has no warning', (tester) async {
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b
          ..registration = 'A6-EOF'
          ..inbound.replace(leg('in', actualIn: '2026-11-15T04:00:00Z'))),
      ),
    );
    expect(find.textContaining('min between'), findsNothing);
    expect(find.textContaining('after your scheduled departure'), findsNothing);
  });

  testWidgets('own flights: 5 shown, then show all', (tester) async {
    String? opened;
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b
          ..registration = 'A6-EOF'
          ..ownFlights.addAll([for (var i = 1; i <= 7; i++) own(i)])),
        onOpenFlight: (ident, _) => opened = ident,
      ),
    );
    expect(find.text("You've flown this tail (7)"), findsOneWidget);
    expect(find.textContaining('EK'), findsNWidgets(5));
    await tester.tap(find.text('Show all (7)'));
    await tester.pumpAndSettle();
    expect(find.textContaining('EK'), findsNWidgets(7));
    await tester.tap(find.text('EK3 · UAE3'));
    expect(opened, 'EK3');
  });

  testWidgets('recent flights button, then list', (tester) async {
    var loads = 0;
    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b..registration = 'A6-EOF'),
        onLoadRecent: () => loads++,
      ),
    );
    await tester.tap(find.text('Show recent flights of A6-EOF'));
    expect(loads, 1);

    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b..registration = 'A6-EOF'),
        recent: [leg('r1'), leg('r2')],
      ),
    );
    expect(find.text('Recent flights of A6-EOF'), findsOneWidget);
    expect(find.text('EK381 · UAE381'), findsNWidgets(2));

    await pump(
      tester,
      AircraftSection(
        info: flight,
        history: AircraftHistoryEntity((b) => b..registration = 'A6-EOF'),
        recent: const [],
      ),
    );
    expect(find.text('No recent flights found'), findsOneWidget);
  });
}
