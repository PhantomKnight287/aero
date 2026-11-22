import 'package:aero/formatters/units.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  tearDown(() => Intl.defaultLocale = null);

  test('initLocale loads date symbols for the device locale', () async {
    await initLocale('en-IN');
    expect(Intl.defaultLocale, 'en_IN');
    expect(DateFormat('d MMM y').format(DateTime(2026, 11, 22)), '22 Nov 2026');
    expect(formatCount(496500), '4,96,500');
  });

  test('initLocale falls back to en_US for unknown locales', () async {
    await initLocale('zz_ZZ');
    expect(Intl.defaultLocale, 'en_US');
    expect(DateFormat('d MMM y').format(DateTime(2026, 11, 22)), '22 Nov 2026');
  });
}
