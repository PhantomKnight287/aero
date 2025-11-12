import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/utils/error.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class BookingService {
  final Dio _dio;
  final _flightApi = openapi.getFlightApi();

  BookingService() : _dio = Dio() {
    // Add interceptors for logging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<FlightBookingEntity> createFlightBooking(
    CreateFlightBookingDTO createBookingDto,
  ) async {
    try {
      final response = await _flightApi.flightControllerCreateFlightBookingV1(
        createFlightBookingDTO: createBookingDto,
      );
      return response.data!;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to create flight booking: $e',
      );
    }
  }

  Future<FlightBookingEntity> updateFlightBooking(
    String bookingId,
    UpdateFlightBookingDTO updateBookingDto,
  ) async {
    try {
      final response = await _flightApi.flightControllerUpdateFlightBookingV1(
        bookingId: bookingId,
        updateFlightBookingDTO: updateBookingDto,
      );
      return response.data!;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to update flight booking: $e',
      );
    }
  }

  Future<void> deleteFlightBooking(String bookingId) async {
    try {
      await _flightApi.flightControllerDeleteFlightBookingV1(
        bookingId: bookingId,
      );
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to delete flight booking: $e',
      );
    }
  }

  Future<FlightBookingEntity> getFlightBooking(String bookingId) async {
    try {
      final response = await _flightApi.flightControllerGetFlightBookingV1(
        bookingId: bookingId,
      );
      return response.data!;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to get flight booking: $e',
      );
    }
  }

  Future<BuiltList<FlightBookingEntity>> getFlightBookingsByFlightId(
    String flightId,
  ) async {
    try {
      final response =
          await _flightApi.flightControllerGetFlightBookingsByFlightIdV1(
        flightId: flightId,
      );
      return response.data!;
    } catch (e) {
      if (e is DioException) {
        throw ApiException(message: getErrorMessage(e.response?.data));
      }
      throw ApiException(
        message: 'Failed to get flight bookings: $e',
      );
    }
  }
}

