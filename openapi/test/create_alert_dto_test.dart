import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for CreateAlertDto
void main() {
  final instance = CreateAlertDtoBuilder();
  // TODO add properties to the builder and call build()

  group(CreateAlertDto, () {
    // Flight identifier. Accepts the internal flight id, the FlightAware fa_flight_id, or the flightAwareData id — resolved the same way as flight.service resolveFaFlight.
    // String flightId
    test('to test the property `flightId`', () async {
      // TODO
    });

    // OneSignal subscription (player) id to push notifications to.
    // String playerId
    test('to test the property `playerId`', () async {
      // TODO
    });

  });
}
