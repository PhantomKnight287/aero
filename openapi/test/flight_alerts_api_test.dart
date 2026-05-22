import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for FlightAlertsApi
void main() {
  final instance = Openapi().getFlightAlertsApi();

  group(FlightAlertsApi, () {
    // Subscribe to push alerts for a flight
    //
    // Registers a OneSignal subscription (player) ID to receive push notifications when this flight changes (status, gate, terminal, delays, baggage claim, airport delays).
    //
    //Future flightAlertsControllerSubscribeV1(String id, FlightAlertDTO flightAlertDTO) async
    test('test flightAlertsControllerSubscribeV1', () async {
      // TODO
    });

    // Unsubscribe from push alerts for a flight
    //
    // Removes a OneSignal subscription (player) ID from a flight’s alert list. Tracking stops once no devices remain.
    //
    //Future flightAlertsControllerUnsubscribeV1(String id, FlightAlertDTO flightAlertDTO) async
    test('test flightAlertsControllerUnsubscribeV1', () async {
      // TODO
    });

  });
}
