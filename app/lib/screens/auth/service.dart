import 'package:dio/dio.dart';
import 'package:error_or/error_or.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';

class AuthService {
  final _authApi = openapi.getAuthenticationApi();

  Future<ErrorOr<Response<LoginEntity>?>> login(LoginDTO body) async {
    try {
      final response = ErrorOr.value(await _authApi.authControllerLoginV1(loginDTO: body));
      return response;
    } catch (e) {
      return ErrorOr.error(e);
    }
  }

  Future<RegisterEntity?> register(RegisterDTO body) async {
    return (await _authApi.authControllerRegisterV1(
      registerDTO: body,
    ))
        .data;
  }
}

final authService = AuthService();
