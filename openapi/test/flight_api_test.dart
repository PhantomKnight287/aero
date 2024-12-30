import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for FlightApi
void main() {
  final instance = Openapi().getFlightApi();

  group(FlightApi, () {
    // Get flight details
    //
    // Get detailed information about a specific flight including real-time tracking data
    //
    //Future<FlightResponseEntity> flightControllerGetFlightV1(String iata, String icao, { String searchedDate, String date }) async
    test('test flightControllerGetFlightV1', () async {
      // TODO
    });

  });
}
