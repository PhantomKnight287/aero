import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthenticationApi
void main() {
  final instance = Openapi().getAuthenticationApi();

  group(AuthenticationApi, () {
    // Get current user
    //
    // Get current user
    //
    //Future<UserEntity> authControllerGetCurrentUserV1() async
    test('test authControllerGetCurrentUserV1', () async {
      // TODO
    });

    // Login
    //
    // Login
    //
    //Future<LoginEntity> authControllerLoginV1(LoginDTO loginDTO) async
    test('test authControllerLoginV1', () async {
      // TODO
    });

    // Register
    //
    // Create a new user
    //
    //Future<RegisterEntity> authControllerRegisterV1(RegisterDTO registerDTO) async
    test('test authControllerRegisterV1', () async {
      // TODO
    });

  });
}
