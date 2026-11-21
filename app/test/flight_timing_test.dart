import 'package:aero/utils/flight_timing.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime t(int h, int m) => DateTime.utc(2026, 11, 15, h, m);

void main() {
  test('all actual times: taxi, air, block and schedule delta', () {
    final timing = computeTiming(
      scheduledOut: t(6, 36),
      actualOut: t(6, 40),
      scheduledOff: t(6, 50),
      actualOff: t(6, 54),
      scheduledOn: t(13, 55),
      actualOn: t(14, 2),
      scheduledIn: t(14, 3),
      actualIn: t(14, 9),
    );
    expect(timing.taxiOut!.duration, const Duration(minutes: 14));
    expect(timing.taxiOut!.estimated, isFalse);
    expect(timing.air!.duration, const Duration(hours: 7, minutes: 8));
    expect(timing.scheduledAir, const Duration(hours: 7, minutes: 5));
    expect(timing.taxiIn!.duration, const Duration(minutes: 7));
    expect(timing.block!.duration, const Duration(hours: 7, minutes: 29));
    expect(timing.scheduledBlock, const Duration(hours: 7, minutes: 27));
    expect(timing.blockVsSchedule, const Duration(minutes: 2));
  });

  test('in flight: estimates fill gaps and are flagged', () {
    final timing = computeTiming(
      scheduledOut: t(6, 36),
      actualOut: t(6, 40),
      actualOff: t(6, 54),
      estimatedOn: t(14, 0),
      estimatedIn: t(14, 8),
      scheduledIn: t(14, 3),
    );
    expect(timing.taxiOut!.estimated, isFalse);
    expect(timing.air!.estimated, isTrue);
    expect(timing.air!.duration, const Duration(hours: 7, minutes: 6));
    expect(timing.block!.estimated, isTrue);
  });

  test('missing or reversed endpoints give null, never negative', () {
    final timing = computeTiming(actualOut: t(6, 40), actualOff: t(6, 30));
    expect(timing.taxiOut, isNull);
    expect(timing.air, isNull);
    expect(timing.block, isNull);
    expect(timing.blockVsSchedule, isNull);
  });

  test('duration text', () {
    expect(formatDurationShort(const Duration(minutes: 14)), '14 min');
    expect(formatDurationShort(const Duration(hours: 7, minutes: 8)),
        '7 h 08 min');
    expect(formatDurationShort(const Duration(hours: 2)), '2 h');
  });

  group('zone shift', () {
    test('uses the offset on the flight date, not today', () {
      // London is UTC+1 in July (BST), so LHR -> DXB is +3 h then, +4 h in
      // January.
      final summer = zoneShift(
          DateTime.utc(2026, 7, 1, 12), 'Europe/London', 'Asia/Dubai')!;
      final winter = zoneShift(
          DateTime.utc(2026, 1, 1, 12), 'Europe/London', 'Asia/Dubai')!;
      expect(summer.change, const Duration(hours: 3));
      expect(summer.originDst, isTrue);
      expect(winter.change, const Duration(hours: 4));
      expect(winter.originDst, isFalse);
      expect(summer.destinationDst, isFalse);
    });

    test('half-hour zones and going back', () {
      final s =
          zoneShift(DateTime.utc(2026, 1, 1), 'Asia/Kolkata', 'Asia/Dubai')!;
      expect(s.change, const Duration(hours: -1, minutes: -30));
      expect(describeShift(s.change), 'Clocks go back 1 h 30 min');
      expect(describeShift(const Duration(hours: 4)), 'Clocks go forward 4 h');
      expect(describeShift(Duration.zero), 'No time zone change');
    });

    test('unknown or empty zones give null instead of throwing', () {
      expect(zoneShift(DateTime.utc(2026), 'Not/AZone', 'Asia/Dubai'), isNull);
      expect(zoneShift(DateTime.utc(2026), '', 'Asia/Dubai'), isNull);
      expect(zoneShift(DateTime.utc(2026), null, 'Asia/Dubai'), isNull);
    });
  });
}
