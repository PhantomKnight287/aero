import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ProfileApi
void main() {
  final instance = Openapi().getProfileApi();

  group(ProfileApi, () {
    // Get profile stats
    //
    // Returns comprehensive statistics about tracked flights including passport data, aircraft stats, airlines, airports, and routes
    //
    //Future<ProfileStatsResponseEntity> profileControllerGetProfileStatsV1() async
    test('test profileControllerGetProfileStatsV1', () async {
      // TODO
    });

  });
}
