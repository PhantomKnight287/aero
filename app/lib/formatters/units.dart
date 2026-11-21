import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Unit preferences and the only place unit conversion happens.
/// API values come in as km, knots, feet and °C.

enum DistanceUnit { km, mi, nm }

enum SpeedUnit { kt, kmh, mph }

enum AltitudeUnit { ft, m, fl }

enum TempUnit { c, f }

enum TimeMode { airport, device, utc }

enum UnitDimension { distance, speed, altitude, temperature, time }

/// Next value in [values] after [current], wrapping around.
T nextOf<T extends Enum>(List<T> values, T current) =>
    values[(current.index + 1) % values.length];

String unitLabel(Enum unit) => switch (unit) {
      DistanceUnit.km => 'km',
      DistanceUnit.mi => 'mi',
      DistanceUnit.nm => 'nm',
      SpeedUnit.kt => 'kt',
      SpeedUnit.kmh => 'km/h',
      SpeedUnit.mph => 'mph',
      AltitudeUnit.ft => 'ft',
      AltitudeUnit.m => 'm',
      AltitudeUnit.fl => 'FL',
      TempUnit.c => '°C',
      TempUnit.f => '°F',
      TimeMode.airport => 'airport time',
      TimeMode.device => 'your time',
      TimeMode.utc => 'UTC',
      _ => unit.name,
    };

String dimensionLabel(UnitDimension d) => switch (d) {
      UnitDimension.distance => 'Distance',
      UnitDimension.speed => 'Speed',
      UnitDimension.altitude => 'Altitude',
      UnitDimension.temperature => 'Temperature',
      UnitDimension.time => 'Times',
    };

num convertDistance(num km, DistanceUnit u) => switch (u) {
      DistanceUnit.km => km,
      DistanceUnit.mi => km * 0.621371,
      DistanceUnit.nm => km * 0.539957,
    };

num convertSpeed(num kt, SpeedUnit u) => switch (u) {
      SpeedUnit.kt => kt,
      SpeedUnit.kmh => kt * 1.852,
      SpeedUnit.mph => kt * 1.15078,
    };

/// FL is hundreds of feet.
num convertAltitude(num ft, AltitudeUnit u) => switch (u) {
      AltitudeUnit.ft => ft,
      AltitudeUnit.m => ft * 0.3048,
      AltitudeUnit.fl => ft / 100,
    };

num convertTemp(num c, TempUnit u) => switch (u) {
      TempUnit.c => c,
      TempUnit.f => c * 9 / 5 + 32,
    };

final _grouped = NumberFormat.decimalPattern('en_US');
String _n(num v) => _grouped.format(v.round());

String formatDistance(num km, DistanceUnit u) =>
    '${_n(convertDistance(km, u))} ${unitLabel(u)}';

String formatSpeed(num kt, SpeedUnit u) =>
    '${_n(convertSpeed(kt, u))} ${unitLabel(u)}';

/// FL below 1,000 ft makes no sense (ground/approach), so show feet there.
bool showsFlightLevel(num ft, AltitudeUnit u) =>
    u == AltitudeUnit.fl && ft >= 1000;

String formatAltitude(num ft, AltitudeUnit u) {
  if (u == AltitudeUnit.fl) {
    return showsFlightLevel(ft, u)
        ? 'FL${(ft / 100).round().toString().padLeft(3, '0')}'
        : formatAltitude(ft, AltitudeUnit.ft);
  }
  return '${_n(convertAltitude(ft, u))} ${unitLabel(u)}';
}

/// Ground elevation: FL isn't meaningful, so FL falls back to feet.
String formatElevation(num ft, AltitudeUnit u) =>
    formatAltitude(ft, u == AltitudeUnit.fl ? AltitudeUnit.ft : u);

String formatTemp(num c, TempUnit u) =>
    '${convertTemp(c, u).round()}${unitLabel(u)}';

bool _tzReady = false;

/// [airport]: in the airport's zone (falls back to UTC if unknown);
/// [device]: phone's zone; [utc]: always 24h with a Z suffix.
String formatTime(
  DateTime utc, {
  required String? airportTz,
  required TimeMode mode,
  required bool use24,
}) {
  final pattern = use24 ? 'H:mm' : 'h:mm a';
  final asUtc = '${DateFormat('HH:mm').format(utc.toUtc())}Z';
  switch (mode) {
    case TimeMode.utc:
      return asUtc;
    case TimeMode.device:
      return DateFormat(pattern).format(utc.toLocal());
    case TimeMode.airport:
      if (airportTz == null || airportTz.isEmpty) return asUtc;
      try {
        if (!_tzReady) {
          tzdata.initializeTimeZones();
          _tzReady = true;
        }
        final local = tz.TZDateTime.from(utc, tz.getLocation(airportTz));
        return DateFormat(pattern).format(local);
      } catch (_) {
        return asUtc;
      }
  }
}
