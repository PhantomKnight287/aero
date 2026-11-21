import 'package:aero/formatters/units.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('distance', () {
    expect(formatDistance(6819.4, DistanceUnit.km), '6,819 km');
    expect(formatDistance(6819.4, DistanceUnit.mi), '4,237 mi');
    expect(formatDistance(6819.4, DistanceUnit.nm), '3,682 nm');
  });

  test('speed', () {
    expect(formatSpeed(558, SpeedUnit.kt), '558 kt');
    expect(formatSpeed(558, SpeedUnit.kmh), '1,033 km/h');
    expect(formatSpeed(558, SpeedUnit.mph), '642 mph');
  });

  test('altitude and elevation', () {
    expect(formatAltitude(39000, AltitudeUnit.ft), '39,000 ft');
    expect(formatAltitude(39000, AltitudeUnit.fl), 'FL390');
    expect(formatAltitude(39000, AltitudeUnit.m), '11,887 m');
    expect(formatAltitude(800, AltitudeUnit.fl), '800 ft');
    expect(formatElevation(62, AltitudeUnit.fl), '62 ft');
    expect(formatElevation(62, AltitudeUnit.m), '19 m');
  });

  test('temperature', () {
    expect(formatTemp(21, TempUnit.c), '21°C');
    expect(formatTemp(21, TempUnit.f), '70°F');
  });

  test('time modes', () {
    final t = DateTime.utc(2026, 11, 15, 6, 40);
    expect(
        formatClock(t,
            airportTz: 'Asia/Dubai', mode: TimeMode.airport, use24: true),
        '10:40');
    expect(
        formatClock(t,
            airportTz: 'Asia/Dubai', mode: TimeMode.airport, use24: false),
        '10:40 AM');
    expect(
        formatClock(t,
            airportTz: 'Asia/Dubai', mode: TimeMode.utc, use24: false),
        '06:40Z');
    expect(
        formatClock(t,
            airportTz: 'Not/AZone', mode: TimeMode.airport, use24: true),
        '06:40Z');
    expect(formatClock(t, airportTz: null, mode: TimeMode.airport, use24: true),
        '06:40Z');
  });

  test('cycling and labels', () {
    expect(nextOf(AltitudeUnit.values, AltitudeUnit.ft), AltitudeUnit.m);
    expect(nextOf(AltitudeUnit.values, AltitudeUnit.fl), AltitudeUnit.ft);
    expect(unitLabel(SpeedUnit.kmh), 'km/h');
    expect(unitLabel(AltitudeUnit.fl), 'FL');
    expect(unitLabel(TimeMode.utc), 'UTC');
  });

  test('12h clock keeps the leading zero like before (09:05 AM)', () {
    expect(
        formatClock(DateTime.utc(2026, 11, 15, 5, 5),
            airportTz: 'Asia/Dubai', mode: TimeMode.airport, use24: false),
        '09:05 AM');
  });

  test('date + clock follows the same zone, empty tz falls back to Z', () {
    final t = DateTime.utc(2026, 11, 15, 6, 40);
    expect(
        formatDateClock(t,
            airportTz: 'Asia/Dubai', mode: TimeMode.airport, use24: true),
        'Nov 15, 10:40');
    expect(
        formatDateClock(t, airportTz: '', mode: TimeMode.airport, use24: true),
        'Nov 15, 06:40Z');
    expect(
        formatDateClock(DateTime.utc(2026, 11, 15, 22),
            airportTz: 'Asia/Dubai', mode: TimeMode.airport, use24: true),
        'Nov 16, 2:00');
    expect(
        formatDateClock(DateTime.utc(2026, 11, 15, 22),
            airportTz: 'Asia/Dubai', mode: TimeMode.utc, use24: false),
        'Nov 15, 22:00Z');
  });
}
