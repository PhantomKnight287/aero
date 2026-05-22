import 'package:aero/constants/main.dart';

/// Flight push-alert endpoints. These aren't part of the generated OpenAPI
/// client, so they go through the shared authenticated Dio instance.
class AlertsService {
  Future<void> subscribe(String flightId, String playerId) async {
    await openapi.dio.post(
      '/v1/flight/$flightId/alerts',
      data: {'playerId': playerId},
    );
  }

  Future<void> unsubscribe(String flightId, String playerId) async {
    await openapi.dio.delete(
      '/v1/flight/$flightId/alerts',
      data: {'playerId': playerId},
    );
  }
}

final alertsService = AlertsService();
