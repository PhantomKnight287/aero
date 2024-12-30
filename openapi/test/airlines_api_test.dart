import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AirlinesApi
void main() {
  final instance = Openapi().getAirlinesApi();

  group(AirlinesApi, () {
    // Get airlines
    //
    // Get airlines.  Has over 800 records, only has commerical airlines.
    //
    //Future<BuiltList<AirlineEntity>> airlinesControllerGetAirlinesV1({ String search }) async
    test('test airlinesControllerGetAirlinesV1', () async {
      // TODO
    });

  });
}
