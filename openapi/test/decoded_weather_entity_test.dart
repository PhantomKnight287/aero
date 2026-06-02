import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for DecodedWeatherEntity
void main() {
  final instance = DecodedWeatherEntityBuilder();
  // TODO add properties to the builder and call build()

  group(DecodedWeatherEntity, () {
    // Raw aviation weather string (METAR/TAF)
    // JsonObject raw
    test('to test the property `raw`', () async {
      // TODO
    });

    // Structured/decoded representation of the raw string. Null when decoding failed or no raw string was available.
    // JsonObject decoded
    test('to test the property `decoded`', () async {
      // TODO
    });

  });
}
