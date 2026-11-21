import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('defaults match today when nothing is stored', () async {
    SharedPreferences.setMockInitialValues({});
    final u = UnitsNotifier();
    await u.load();
    expect(u.distance, DistanceUnit.km);
    expect(u.speed, SpeedUnit.kt);
    expect(u.altitude, AltitudeUnit.ft);
    expect(u.temperature, TempUnit.c);
    expect(u.time, TimeMode.airport);
    expect(u.hintShown, isFalse);
  });

  test('unknown stored names fall back to defaults', () async {
    SharedPreferences.setMockInitialValues({'units.altitude': 'bogus'});
    final u = UnitsNotifier();
    await u.load();
    expect(u.altitude, AltitudeUnit.ft);
  });

  test('cycle advances, wraps and persists', () async {
    SharedPreferences.setMockInitialValues({});
    final u = UnitsNotifier();
    await u.load();
    expect(await u.cycle(UnitDimension.altitude), AltitudeUnit.m);
    expect(await u.cycle(UnitDimension.altitude), AltitudeUnit.fl);
    final reloaded = UnitsNotifier();
    await reloaded.load();
    expect(reloaded.altitude, AltitudeUnit.fl);
    expect(await u.cycle(UnitDimension.altitude), AltitudeUnit.ft);
  });

  test('set and hint flag persist', () async {
    SharedPreferences.setMockInitialValues({});
    final u = UnitsNotifier();
    await u.load();
    await u.set(UnitDimension.time, TimeMode.utc);
    await u.markHintShown();
    final reloaded = UnitsNotifier();
    await reloaded.load();
    expect(reloaded.time, TimeMode.utc);
    expect(reloaded.hintShown, isTrue);
  });
}
