import 'package:aero/utils/aircraft_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('hex address blocks (real aircraft from the log)', () {
    expect(countryFromHex('89639F')?.iso2, 'AE');
    expect(countryFromHex('8005F0')?.iso2, 'IN');
    expect(countryFromHex('885170')?.iso2, 'TH');
    expect(countryFromHex('A31A7B')?.iso2, 'US');
    expect(countryFromHex('400F3C')?.iso2, 'GB');
    expect(countryFromHex('4ca1f2')?.iso2, 'IE'); // lowercase ok
    expect(countryFromHex('896000')?.name, 'United Arab Emirates');
    expect(countryFromHex('601839')?.iso2, 'TM');
  });

  test('bad hex gives null', () {
    expect(countryFromHex('ZZZ'), isNull);
    expect(countryFromHex(''), isNull);
    expect(countryFromHex(null), isNull);
    expect(countryFromHex('FFFFFF'), isNull); // unallocated
  });

  test('registration prefixes', () {
    expect(countryFromRegistration('JA381A')?.iso2, 'JP');
    expect(countryFromRegistration('EI-IKH')?.iso2, 'IE');
    expect(countryFromRegistration('VT-ALP')?.iso2, 'IN');
    expect(countryFromRegistration('A6-EPO')?.iso2, 'AE');
    expect(countryFromRegistration('N29989')?.iso2, 'US');
    expect(countryFromRegistration('HL7619')?.iso2, 'KR');
    expect(countryFromRegistration('9V-SKA')?.iso2, 'SG');
    expect(countryFromRegistration('B-HKF')?.iso2, 'HK');
    expect(countryFromRegistration('B-18918')?.iso2, 'TW');
    expect(countryFromRegistration('B-1234')?.iso2, 'CN');
    expect(countryFromRegistration('XX-123'), isNull);
    expect(countryFromRegistration(null), isNull);
  });

  test('hex first, prefix as fallback', () {
    expect(registryCountry(hex: '8005F0', reg: 'A6-EPO')?.iso2, 'IN');
    expect(registryCountry(hex: null, reg: 'A6-EPO')?.iso2, 'AE');
    expect(registryCountry(hex: 'ZZZ', reg: 'XX-1'), isNull);
  });

  test('flag emoji', () {
    expect(flagEmoji('AE'), '🇦🇪');
    expect(flagEmoji('in'), '🇮🇳');
  });
}
