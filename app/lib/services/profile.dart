import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/services/main.dart';
import 'package:aero/utils/error.dart';

class ProfileService {
  final Dio _dio;
  final _profileApi = openapi.getProfileApi();
  final _flightApi = openapi.getFlightApi();

  ProfileService() : _dio = Dio() {
    // Add interceptors for logging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<ProfileStatsResponseEntity?> getProfileStats({int? year}) async {
    try {
      final response =
          await _profileApi.profileControllerGetProfileStatsV1(year: year);
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

  Future<FlightHistoryResponseEntity?> getFlightHistory(
      {String? cursor, int? year}) async {
    try {
      final response = await _flightApi.flightControllerGetFlightHistoryV1(
          cursor: cursor, year: year);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(message: 'Failed to fetch flight history: $e');
    }
  }

  /// The user's flights from [dep] to [arr] (IATA or ICAO), minus [exclude].
  Future<RouteHistoryEntity?> getRouteHistory(
      {required String dep, required String arr, String? exclude}) async {
    try {
      final response = await _flightApi.flightControllerGetRouteHistoryV1(
          dep: dep, arr: arr, exclude: exclude);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(message: 'Failed to fetch route history: $e');
    }
  }
}
