import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AlertsApi
void main() {
  final instance = Openapi().getAlertsApi();

  group(AlertsApi, () {
    // Subscribe to flight alerts
    //
    // Register a OneSignal player for push notifications about a flight. Seeds the initial flight + airport state in Redis and wakes the alerts worker.
    //
    //Future alertsControllerSubscribeV1(CreateAlertDto createAlertDto) async
    test('test alertsControllerSubscribeV1', () async {
      // TODO
    });

  });
}
