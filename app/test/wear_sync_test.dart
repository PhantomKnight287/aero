import 'package:aero/formatters/units.dart';
import 'package:aero/services/wear_payload.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flight_detail_test.dart' show inFlight;
import 'flight_status_test.dart' show at, flight;

/// Runs the job against fakes and records what it fetched and sent.
Future<(List<String>, int)> run(
  FlightResponseEntity Function() current, {
  required DateTime now,
  int watches = 1,
}) async {
  final fetched = <String>[];
  var sent = 0;
  await WearSync.run(
    fetch: (k) async {
      fetched.add(k['iata'] as String);
      return current();
    },
    send: (_) async {
      sent++;
      return watches;
    },
    distanceUnit: DistanceUnit.km,
    now: now,
  );
  return (fetched, sent);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('in flight: fetched, sent and kept for the next run', () async {
    await WearSent.add(inFlight());
    final (fetched, sent) = await run(inFlight, now: at(18, 26));
    expect(fetched, hasLength(1));
    expect(sent, 1);
    expect(await WearSent.has(inFlight().id), isTrue);
  });

  test('landed: sent one last time, then never fetched again', () async {
    final landed = flight(
        actualOut: at(15, 42), actualOff: at(15, 52), actualOn: at(19, 0));
    await WearSent.add(landed);
    final (first, sent) = await run(() => landed, now: at(19, 12));
    expect(first, hasLength(1));
    expect(sent, 1);
    expect(await WearSent.has(landed.id), isFalse);
    final (second, _) = await run(() => landed, now: at(19, 30));
    expect(second, isEmpty);
  });

  test('cancelled is settled too', () async {
    final c = inFlight(cancelled: true);
    await WearSent.add(c);
    await run(() => c, now: at(18, 26));
    expect(await WearSent.has(c.id), isFalse);
  });

  test('more than 12 h before departure: not fetched yet, kept', () async {
    await WearSent.add(inFlight());
    final (fetched, _) =
        await run(inFlight, now: at(15, 0).subtract(const Duration(hours: 14)));
    expect(fetched, isEmpty);
    expect(await WearSent.has(inFlight().id), isTrue);
  });

  test('no watch in reach: kept, retried next run', () async {
    final landed = flight(actualOn: at(19, 0), actualOff: at(15, 52));
    await WearSent.add(landed);
    await run(() => landed, now: at(19, 12), watches: 0);
    expect(await WearSent.has(landed.id), isTrue);
  });

  test('older than two days: dropped without a fetch', () async {
    await WearSent.add(inFlight());
    final (fetched, _) =
        await run(inFlight, now: at(18, 0).add(const Duration(days: 3)));
    expect(fetched, isEmpty);
    expect(await WearSent.has(inFlight().id), isFalse);
  });
}
