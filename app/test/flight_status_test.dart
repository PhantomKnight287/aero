import 'package:aero/screens/home/widgets/flight_detail/flight_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

RouteInfoEntity side(String iata, String tz, String scheduledUtc,
        {String? revisedUtc}) =>
    RouteInfoEntity((b) {
      b
        ..scheduledTime.utc = scheduledUtc
        ..scheduledTime.local = scheduledUtc
        ..airport.iata = iata
        ..airport.icao = 'K$iata'
        ..airport.name = '$iata Intl'
        ..airport.timeZone = tz
        ..airport.countryCode = 'US'
        ..airport.municipalityName = iata
        ..airport.location.lat = 0
        ..airport.location.lon = 0;
      if (revisedUtc != null) {
        b
          ..revisedTime.utc = revisedUtc
          ..revisedTime.local = revisedUtc;
      }
    });

/// STL 15:35Z -> PHX 18:40Z (09:35 CST -> 11:40 MST).
FlightResponseEntity flight({
  bool fa = true,
  DateTime? actualOut,
  DateTime? actualOff,
  DateTime? actualOn,
  DateTime? actualIn,
  DateTime? estimatedIn,
  bool cancelled = false,
  bool diverted = false,
  String? destinationIata,
  String? depRevised,
  String? arrRevised,
}) =>
    FlightResponseEntity((b) {
      b
        ..id = 'f1'
        ..flightNo = 'WN4187'
        ..callSign = 'SWA4187'
        ..cargo = false
        ..date = DateTime.utc(2026, 11, 23)
        ..airline.name = 'Southwest'
        ..airline.iata = 'WN'
        ..airline.icao = 'SWA'
        ..greatCircleDistance.km = '2428'
        ..departure.replace(side(
            'STL', 'America/Chicago', '2026-11-23T15:35:00Z',
            revisedUtc: depRevised))
        ..arrival.replace(side('PHX', 'America/Phoenix', '2026-11-23T18:40:00Z',
            revisedUtc: arrRevised));
      if (fa) {
        b.flightAwareData
          ..id = 'fa'
          ..ident = 'SWA4187'
          ..status = 'x'
          ..foresightPredictionsAvailable = false
          ..blocked = false
          ..diverted = diverted
          ..cancelled = cancelled
          ..positionOnly = false
          ..createdAt = DateTime.utc(2026)
          ..updatedAt = DateTime.utc(2026)
          ..scheduledOut = DateTime.utc(2026, 11, 23, 15, 35)
          ..scheduledOff = DateTime.utc(2026, 11, 23, 15, 45)
          ..scheduledOn = DateTime.utc(2026, 11, 23, 18, 34)
          ..scheduledIn = DateTime.utc(2026, 11, 23, 18, 40)
          ..actualOut = actualOut
          ..actualOff = actualOff
          ..actualOn = actualOn
          ..actualIn = actualIn
          ..estimatedIn = estimatedIn
          ..destinationCodeIata = destinationIata;
      }
    });

DateTime at(int h, int m) => DateTime.utc(2026, 11, 23, h, m);

void main() {
  group('phase and band text', () {
    test('scheduled', () {
      final s = flightStatus(flight(), at(12, 23));
      expect(s.phase, FlightPhase.scheduled);
      expect(s.bandText(at(12, 23)), 'Departs in 3h 12m');
    });
    test('boarding soon', () {
      expect(flightStatus(flight(), at(15, 5)).bandText(at(15, 5)),
          'Boarding soon');
    });
    test('taxiing', () {
      final s = flightStatus(flight(actualOut: at(15, 42)), at(15, 45));
      expect(s.phase, FlightPhase.taxiingOut);
      expect(s.bandText(at(15, 45)), 'Taxiing');
    });
    test('in flight', () {
      final f = flight(
          actualOut: at(15, 42), actualOff: at(15, 52), estimatedIn: at(19, 6));
      expect(flightStatus(f, at(18, 26)).bandText(at(18, 26)),
          'In flight · lands in 40m');
    });
    test('landed', () {
      final f = flight(
          actualOut: at(15, 42), actualOff: at(15, 52), actualOn: at(19, 0));
      expect(
          flightStatus(f, at(19, 12)).bandText(at(19, 12)), 'Landed 12m ago');
    });
    test('arrived', () {
      final f = flight(
          actualOut: at(15, 42),
          actualOff: at(15, 52),
          actualOn: at(19, 0),
          actualIn: at(19, 6));
      final s = flightStatus(f, at(20, 0));
      expect(s.phase, FlightPhase.arrived);
      expect(s.bandText(at(20, 0)), 'Arrived at gate');
    });
    test('cancelled', () {
      final s = flightStatus(flight(cancelled: true), at(12, 0));
      expect(s.phase, FlightPhase.cancelled);
      expect(s.overall, Punctuality.cancelled);
      expect(s.bandText(at(12, 0)), 'Cancelled');
      expect(s.sideLine(true, at(12, 0)), isNot(contains('ago')));
    });
    test('diverted', () {
      final s = flightStatus(
          flight(diverted: true, destinationIata: 'TUS'), at(19, 0));
      expect(s.phase, FlightPhase.diverted);
      expect(s.divertedToIata, 'TUS');
      expect(s.bandText(at(19, 0)), 'Diverted to TUS');
    });
    test('diverted to the planned code is not a diversion target', () {
      final s = flightStatus(
          flight(diverted: true, destinationIata: 'PHX'), at(19, 0));
      expect(s.divertedToIata, isNull);
      expect(s.bandText(at(19, 0)), 'Diverted');
    });
  });

  test('late cutoff is more than 15 minutes', () {
    expect(flightStatus(flight(estimatedIn: at(18, 55)), at(12, 0)).overall,
        Punctuality.onTime);
    expect(flightStatus(flight(estimatedIn: at(18, 56)), at(12, 0)).overall,
        Punctuality.late);
  });

  test('gate time beats runway time', () {
    final s = flightStatus(
        flight(actualOut: at(15, 42), actualOff: at(15, 52)), at(16, 0));
    expect(s.departure.best, at(15, 42));
    expect(s.departure.isActual, isTrue);
    expect(s.departure.delayMinutes, 7);
    expect(s.sideLine(true, at(17, 52)), '7m late · departed 2h 10m ago');
  });

  test('early arrival line', () {
    final s = flightStatus(
        flight(
            actualOut: at(15, 35),
            actualOff: at(15, 45),
            estimatedIn: at(18, 37)),
        at(14, 24));
    expect(s.sideLine(false, at(14, 24)), '3m early · arrives in 4h 13m');
    expect(s.arrival.punctuality, Punctuality.early);
  });

  test('no FlightAware data uses stored times', () {
    final s = flightStatus(
        flight(fa: false, arrRevised: '2026-11-23T19:06:00Z'), at(17, 0));
    expect(s.phase, FlightPhase.inFlight);
    expect(s.departure.isActual, isFalse);
    expect(s.arrival.best, at(19, 6));
    expect(s.arrival.delayMinutes, 26);
    expect(s.overall, Punctuality.late);
  });

  test('no FlightAware data after arrival is arrived', () {
    expect(
        flightStatus(flight(fa: false), at(22, 0)).phase, FlightPhase.arrived);
  });

  test('stale FlightAware snapshot without actuals falls back to the clock',
      () {
    expect(flightStatus(flight(), DateTime.utc(2026, 11, 25)).phase,
        FlightPhase.arrived);
    expect(flightStatus(flight(), at(17, 0)).phase, FlightPhase.inFlight);
  });
}
