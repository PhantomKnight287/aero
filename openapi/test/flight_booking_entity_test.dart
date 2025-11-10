import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for FlightBookingEntity
void main() {
  final instance = FlightBookingEntityBuilder();
  // TODO add properties to the builder and call build()

  group(FlightBookingEntity, () {
    // Unique booking identifier
    // String id
    test('to test the property `id`', () async {
      // TODO
    });

    // Booking code/confirmation code (e.g., \"ABC123\")
    // JsonObject bookingCode
    test('to test the property `bookingCode`', () async {
      // TODO
    });

    // Seat number (e.g., \"12A\", \"1F\")
    // JsonObject seatNumber
    test('to test the property `seatNumber`', () async {
      // TODO
    });

    // Type of seat position
    // String seatType
    test('to test the property `seatType`', () async {
      // TODO
    });

    // Class of service
    // String seatingClass
    test('to test the property `seatingClass`', () async {
      // TODO
    });

    // Reason for the flight
    // String reason
    test('to test the property `reason`', () async {
      // TODO
    });

    // Additional notes about the booking
    // JsonObject notes
    test('to test the property `notes`', () async {
      // TODO
    });

    // Flight ID associated with this booking
    // String flightId
    test('to test the property `flightId`', () async {
      // TODO
    });

    // User ID who owns this booking
    // String userId
    test('to test the property `userId`', () async {
      // TODO
    });

    // Date and time when the booking was created
    // DateTime createdAt
    test('to test the property `createdAt`', () async {
      // TODO
    });

    // Date and time when the booking was last updated
    // DateTime updatedAt
    test('to test the property `updatedAt`', () async {
      // TODO
    });

  });
}
