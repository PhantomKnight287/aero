import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/services/main.dart';
import 'package:aero/utils/error.dart';

class ProfileService {
  final Dio _dio;
  final _profileApi = openapi.getProfileApi();

  ProfileService() : _dio = Dio() {
    // Add interceptors for logging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<ProfileStatsResponseEntity?> getProfileStats() async {
    try {
      final response = await _profileApi.profileControllerGetProfileStatsV1();
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to fetch profile stats: $e',
      );
    }
  }
}

