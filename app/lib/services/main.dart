import 'package:aero/client/pocketbase.dart';
import 'package:aero/models/flight/flight.dart';
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class FlightDataService {
  static const String baseUrl = 'https://opensky-network.org/api';
  final Dio _dio;

  FlightDataService() : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    // Add interceptors for logging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<dynamic> getFlightInfoWithNumber(
    String iata,
    String icao, {
    DateTime? date,
  }) async {
    date = date ?? DateTime.now();
    try {
      final res = await pb.send(
        "/flight",
        query: {
          "iata": iata,
          "icao": icao,
          "date": "${date.year}-${date.month}-${date.day}",
        },
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<List<Flight>> getFlights(
    String from,
    String to,
    String date,
  ) async {
    try {
      final res = await pb.send(
        "/flights",
        query: {"from": from, "to": to, "date": date},
      );
      if (res['flights'] != null) {
        return (res['flights'] as List<dynamic>).map<Flight>((flight) => Flight.fromJson(flight)).toList();
      }
      return [];
    } catch (e, stack) {
      print(e);
      print(stack);
    }
    return [];
    // try {
    //   final response = await _dio.get(
    //     '/flights/$type',
    //     queryParameters: {
    //       'airport': icao,
    //       'begin': beginTime,
    //       'end': endTime,
    //     },
    //     options: Options(
    //       headers: {
    //         'Accept': 'application/json',
    //       },
    //     ),
    //   );

    //   if (response.statusCode == 200) {
    //     final List<dynamic> flightList = response.data;
    //     return flightList.map((flight) => Flight.fromJson(flight)).toList();
    //   } else {
    //     throw ApiException(
    //       message: 'Failed to load flight data',
    //       statusCode: response.statusCode,
    //     );
    //   }
    // } on DioException catch (e) {
    //   throw ApiException(
    //     message: _handleDioError(e),
    //     statusCode: e.response?.statusCode,
    //   );
    // } catch (e) {
    //   throw ApiException(message: 'Unexpected error: $e');
    // }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error (${error.response?.statusCode}): ${error.response?.statusMessage}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Network error occurred: ${error.message}';
    }
  }
}
