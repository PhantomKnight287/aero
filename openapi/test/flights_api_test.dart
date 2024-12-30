import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for FlightsApi
void main() {
  final instance = Openapi().getFlightsApi();

  group(FlightsApi, () {
    // Get airline
    //
    // Get airline with search query. This doesn't check if the number is correct
    //
    //Future<AirlineEntity> flightsControllerGetAirlineV1(GetAirlineDTO getAirlineDTO) async
    test('test flightsControllerGetAirlineV1', () async {
      // TODO
    });

    // Get flights between two airports
    //
    // Get all flights between two airports for a specific date
    //
    //Future<FlightsResponseEntity> flightsControllerGetFlightsV1(String from, String to, String date) async
    test('test flightsControllerGetFlightsV1', () async {
      // TODO
    });

  });
}
