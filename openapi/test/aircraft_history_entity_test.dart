import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for AircraftHistoryEntity
void main() {
  final instance = AircraftHistoryEntityBuilder();
  // TODO add properties to the builder and call build()

  group(AircraftHistoryEntity, () {
    // String registration
    test('to test the property `registration`', () async {
      // TODO
    });

    // This airframe's previous leg (inbound to this flight)
    // AircraftLegEntity inbound
    test('to test the property `inbound`', () async {
      // TODO
    });

    // The user's other logged flights on the same registration
    // BuiltList<FlightSummaryEntity> ownFlights
    test('to test the property `ownFlights`', () async {
      // TODO
    });

  });
}
