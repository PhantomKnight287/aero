import 'package:aero/formatters/units.dart';
import 'package:aero/services/wear_payload.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import 'flight_detail_test.dart' show inFlight;

void main() {
  test('watch payload carries raw times, zones and the inbound leg', () {
    final history = AircraftHistoryEntity((b) => b
      ..registration = 'N8872Q'
      ..inbound.replace(AircraftLegEntity((l) => l
        ..faFlightId = 'in'
        ..ident = 'SWA2210'
        ..identIata = 'WN2210'
        ..status = 'Arrived'
        ..originIata = 'MDW'
        ..destinationIata = 'STL'
        ..scheduledIn = '2026-11-23T14:30:00Z'
        ..actualIn = '2026-11-23T15:01:00Z'
        ..arrivalDelay = 1860
        ..cancelled = false)));
    final p = wearPayload(inFlight(),
        history: history, distanceUnit: DistanceUnit.km);
    final f = p['flight'] as Map;
    final dep = f['dep'] as Map, arr = f['arr'] as Map;

    expect(p['v'], 2);
    // v1 keys stay for older watch builds.
    expect(f['departureAirportIata'], 'STL');
    // Gate out 15:42 beats the 15:35 schedule; arrival is FlightAware's estimate.
    expect(dep['best'], '2026-11-23T15:42:00.000Z');
    expect(dep['sched'], '2026-11-23T15:35:00.000Z');
    expect(arr['best'], '2026-11-23T19:06:00.000Z');
    expect(dep['gate'], 'E4');
    expect(dep['tz'], isNotNull);
    expect(f['off'], '2026-11-23T15:52:00.000Z');
    expect(f['in'], isNull);
    expect(f['cancelled'], false);
    expect(f['aircraft'], 'Boeing 737 MAX 8');
    expect(f['distance'], endsWith(' km'));
    final inbound = f['inbound'] as Map;
    expect(inbound['ident'], 'WN2210');
    expect(inbound['arrived'], true);
    expect(inbound['delayMin'], 31);
  });
}
