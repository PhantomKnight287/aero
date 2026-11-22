import 'package:aero/formatters/units.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  tearDown(() => Intl.defaultLocale = null);

  test('formats per locale', () {
    Intl.defaultLocale = 'en_IN';
    expect(formatCount(496500), '4,96,500');
    expect(formatDistance(384576, DistanceUnit.km), '3,84,576 km');
    Intl.defaultLocale = 'en_US';
    expect(formatCount(496500), '496,500');
    expect(formatDecimal(1234.56), '1,234.6');
    Intl.defaultLocale = 'de_DE';
    expect(formatCount(496500), '496.500');
    expect(formatDecimal(1234.56, digits: 2), '1.234,56');
  });

  test('en_IN decimals', () {
    Intl.defaultLocale = 'en_IN';
    expect(formatDecimal(123456.7), '1,23,456.7');
  });

  test('resolveLocale', () {
    expect(resolveLocale('en-IN'), 'en_IN');
    expect(resolveLocale('zz_ZZ'), 'en_US');
  });
}
