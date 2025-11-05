import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:dio/dio.dart';
import 'package:plane_pal/utils/error.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class FlightDataService {
  final Dio _dio;
  final _flightApi = openapi.getFlightApi();
  final _flightsApi = openapi.getFlightsApi();

  FlightDataService() : _dio = Dio() {
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
    final timezone = date.timeZoneName;
    final res = await _flightApi.flightControllerGetFlightV1(
      iata: iata,
      icao: icao,
      date:
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      timezone: timezone,
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
  }

  Future<FlightsControllerGetFlightsInBoundsV1200Response> getFlightsInBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) async {
    try {
      final response = await _flightsApi.flightsControllerGetFlightsInBoundsV1(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
      );

      final data = response.data!;
      return data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to fetch flights in bounds: $e',
      );
    }
  }

  Future<FlightResponseEntity?> getFlightInfo(String icao24) async {
    try {
      final response = await _flightApi.flightControllerGetFlightV1(
        iata: '', // Empty since we're using ICAO24
        icao: icao24,
        date:
            "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
        timezone: DateTime.now().timeZoneName,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to fetch flight information: $e',
      );
    }
  }

  Future<FlightTrackResponseEntity?> getFlightTrack(
    String iata,
    String icao, {
    DateTime? date,
  }) async {
    try {
      date = date ?? DateTime.now();
      final response = await _flightApi.flightControllerGetFlightTrackV1(
        iata: iata,
        icao: icao,
        date:
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        timezone: DateTime.now().timeZoneName,
      );
      return response.data;
    } catch (e, stack) {
      print(e);
      print(stack);
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to fetch flight track: $e',
      );
    }
  }

  Future<BuiltList<FlightResponseEntity>> getTrackedFlights() async {
    try {
      final response = await _flightsApi.flightsControllerGetTrackedFlightsV1();
      return response.data!.flights;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to fetch tracked flights: $e',
      );
    }
  }
}
