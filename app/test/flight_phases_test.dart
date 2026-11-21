import 'package:aero/utils/flight_phases.dart';
import 'package:flutter_test/flutter_test.dart';

final t0 = DateTime.utc(2026, 11, 15, 6, 0);

/// One point per minute: climb 20 min to 39,000, cruise to minute 140,
/// step climb to 41,000 over 4 min, cruise to minute 200, descend 25 min.
List<ProfilePoint> stepClimbFlight({double noise = 0}) {
  final pts = <ProfilePoint>[];
  for (var m = 0; m <= 225; m++) {
    double alt;
    if (m <= 20) {
      alt = 39000 * m / 20;
    } else if (m < 140) {
      alt = 39000;
    } else if (m <= 144) {
      alt = 39000 + 2000 * (m - 140) / 4;
    } else if (m <= 200) {
      alt = 41000;
    } else {
      alt = 41000 * (225 - m) / 25;
    }
    // Deterministic jitter, like ADS-B altitude noise.
    final jitter = noise * ((m % 3) - 1);
    final gs = m == 170 ? 623.0 : (m > 20 && m < 200 ? 500.0 : 250.0);
    pts.add(ProfilePoint(t0.add(Duration(minutes: m)), alt + jitter, gs,
        heading: 85, lat: 25 + m / 100, lon: 55 + m / 100));
  }
  return pts;
}

void main() {
  test('finds top of climb, step climb, top of descent, max speed', () {
    final p = detectPhases(stepClimbFlight(noise: 100));
    expect(p, isNotNull);
    expect(p!.topOfClimb.time, t0.add(const Duration(minutes: 20)));
    expect(p.topOfDescent.time, t0.add(const Duration(minutes: 200)));
    expect(p.steps, hasLength(1));
    expect(p.steps.single.fromFt, 39000);
    expect(p.steps.single.toFt, 41000);
    expect(p.steps.single.point.time, t0.add(const Duration(minutes: 144)));
    expect(p.cruiseLevelsFt, [39000, 41000]);
    expect(p.maxSpeed.groundSpeedKt, 623);
    expect(p.averageCruiseSpeedKt, closeTo(500, 2));
  });

  test('a low cruise is still a cruise (FL350 then step to FL410)', () {
    final pts = [
      for (var m = 0; m <= 200; m++)
        ProfilePoint(
          t0.add(Duration(minutes: m)),
          m <= 20
              ? 35000 * m / 20
              : m < 100
                  ? 35000
                  : m <= 110
                      ? 35000 + 6000 * (m - 100) / 10
                      : m <= 180
                          ? 41000
                          : 41000 * (200 - m) / 20,
          480,
        ),
    ];
    final p = detectPhases(pts)!;
    expect(p.topOfClimb.time, t0.add(const Duration(minutes: 20)));
    expect(p.cruiseLevelsFt, [35000, 41000]);
  });

  test('too few points or never airborne gives null', () {
    expect(detectPhases(stepClimbFlight().take(10).toList()), isNull);
    expect(
      detectPhases([
        for (var m = 0; m < 60; m++)
          ProfilePoint(t0.add(Duration(minutes: m)), 0, 15),
      ]),
      isNull,
    );
  });

  test('no level segment falls back to the highest point', () {
    final pts = [
      for (var m = 0; m <= 40; m++)
        ProfilePoint(t0.add(Duration(minutes: m)),
            m <= 20 ? 1000.0 * m : 1000.0 * (40 - m), 300),
    ];
    final p = detectPhases(pts)!;
    expect(p.topOfClimb.time, t0.add(const Duration(minutes: 20)));
    expect(p.topOfDescent.time, t0.add(const Duration(minutes: 20)));
    expect(p.steps, isEmpty);
  });

  test('downsample keeps ends and event points', () {
    final pts = stepClimbFlight();
    final p = detectPhases(pts)!;
    final small = downsample(pts, 50, keep: p.eventPoints);
    expect(small.length, lessThanOrEqualTo(50 + p.eventPoints.length + 2));
    expect(small.first, pts.first);
    expect(small.last, pts.last);
    for (final e in p.eventPoints) {
      expect(small, contains(e));
    }
  });
}
