import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for AirportDetailsEntity
void main() {
  final instance = AirportDetailsEntityBuilder();
  // TODO add properties to the builder and call build()

  group(AirportDetailsEntity, () {
    // Airport identifier (ICAO)
    // String ident
    test('to test the property `ident`', () async {
      // TODO
    });

    // FlightAware airport delay information, if any
    // JsonObject delays
    test('to test the property `delays`', () async {
      // TODO
    });

    // Latest METAR observation (raw + decoded)
    // DecodedWeatherEntity metar
    test('to test the property `metar`', () async {
      // TODO
    });

    // TAF forecast (raw + decoded)
    // DecodedWeatherEntity taf
    test('to test the property `taf`', () async {
      // TODO
    });

  });
}
