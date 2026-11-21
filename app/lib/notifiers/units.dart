import 'package:aero/formatters/units.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global unit preferences. Keys: `units.<dimension>` holding the enum
/// `.name`; `units.hintShown` once the tap-to-cycle toast has been seen.
/// Read by the widget isolate too (see WidgetUpdateService).
class UnitsNotifier extends ChangeNotifier {
  static const hintKey = 'units.hintShown';
  static String keyFor(UnitDimension d) => 'units.${d.name}';

  final _units = <UnitDimension, Enum>{
    UnitDimension.distance: DistanceUnit.km,
    UnitDimension.speed: SpeedUnit.kt,
    UnitDimension.altitude: AltitudeUnit.ft,
    UnitDimension.temperature: TempUnit.c,
    UnitDimension.time: TimeMode.airport,
  };
  bool _hintShown = false;

  DistanceUnit get distance => _units[UnitDimension.distance] as DistanceUnit;
  SpeedUnit get speed => _units[UnitDimension.speed] as SpeedUnit;
  AltitudeUnit get altitude => _units[UnitDimension.altitude] as AltitudeUnit;
  TempUnit get temperature => _units[UnitDimension.temperature] as TempUnit;
  TimeMode get time => _units[UnitDimension.time] as TimeMode;
  bool get hintShown => _hintShown;

  Enum unitOf(UnitDimension d) => _units[d]!;

  static List<Enum> valuesOf(UnitDimension d) => switch (d) {
        UnitDimension.distance => DistanceUnit.values,
        UnitDimension.speed => SpeedUnit.values,
        UnitDimension.altitude => AltitudeUnit.values,
        UnitDimension.temperature => TempUnit.values,
        UnitDimension.time => TimeMode.values,
      };

  /// Reads a stored unit; unknown or missing names give the default.
  static Enum? parse(UnitDimension d, String? name) =>
      valuesOf(d).where((v) => v.name == name).firstOrNull;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    for (final d in UnitDimension.values) {
      final stored = parse(d, prefs.getString(keyFor(d)));
      if (stored != null) _units[d] = stored;
    }
    _hintShown = prefs.getBool(hintKey) ?? false;
    notifyListeners();
  }

  Future<void> set(UnitDimension d, Enum unit) async {
    assert(valuesOf(d).contains(unit));
    _units[d] = unit;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyFor(d), unit.name);
  }

  /// Advances [d] to its next unit (wrapping) and returns it.
  Future<Enum> cycle(UnitDimension d) async {
    final values = valuesOf(d);
    final next = values[(values.indexOf(_units[d]!) + 1) % values.length];
    await set(d, next);
    return next;
  }

  Future<void> markHintShown() async {
    _hintShown = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hintKey, true);
  }
}
