import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AirportsApi
void main() {
  final instance = Openapi().getAirportsApi();

  group(AirportsApi, () {
    // Get all airports
    //
    // Get all airports. We do not recommend using this route without any search query. This route has over 20k records
    //
    //Future<BuiltList<AirportEntity>> airportsControllerGetAirportsV1({ String search }) async
    test('test airportsControllerGetAirportsV1', () async {
      // TODO
    });

  });
}
