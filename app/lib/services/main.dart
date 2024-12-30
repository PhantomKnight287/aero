import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';
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
  final _flightApi = openapi.getFlightApi();
  final _flightsApi = openapi.getFlightsApi();

  FlightDataService() : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    // Add interceptors for logging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<FlightResponseEntity?> getFlightInfoWithNumber(
    String iata,
    String icao, {
    DateTime? date,
  }) async {
    date = date ?? DateTime.now();
    final res = await _flightApi.flightControllerGetFlightV1(
      iata: iata,
      icao: icao,
      date: "${date.year}-${date.month}-${date.year}",
    );
    return res.data;
  }

  Future<BuiltList<FlightEntity>> getFlights(
    String from,
    String to,
    String date,
  ) async {
    final res = await _flightsApi.flightsControllerGetFlightsV1(
      from: from,
      to: to,
      date: date,
    );
    return res.data!.flights;
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
}
