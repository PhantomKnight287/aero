import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for FlightPositionEntity
void main() {
  final instance = FlightPositionEntityBuilder();
  // TODO add properties to the builder and call build()

  group(FlightPositionEntity, () {
    // FlightAware flight ID for this position
    // String faFlightId
    test('to test the property `faFlightId`', () async {
      // TODO
    });

    // Aircraft altitude in hundreds of feet
    // num altitude
    test('to test the property `altitude`', () async {
      // TODO
    });

    // Altitude change indicator
    // String altitudeChange
    test('to test the property `altitudeChange`', () async {
      // TODO
    });

    // Groundspeed in knots
    // num groundspeed
    test('to test the property `groundspeed`', () async {
      // TODO
    });

    // Aircraft heading in degrees (0-360)
    // num heading
    test('to test the property `heading`', () async {
      // TODO
    });

    // Latitude position
    // num latitude
    test('to test the property `latitude`', () async {
      // TODO
    });

    // Longitude position
    // num longitude
    test('to test the property `longitude`', () async {
      // TODO
    });

    // Time that position was received
    // String timestamp
    test('to test the property `timestamp`', () async {
      // TODO
    });

    // Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
    // String updateType
    test('to test the property `updateType`', () async {
      // TODO
    });

  });
}
