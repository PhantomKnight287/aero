import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for CreateFlightBookingDTO
void main() {
  final instance = CreateFlightBookingDTOBuilder();
  // TODO add properties to the builder and call build()

  group(CreateFlightBookingDTO, () {
    // Flight ID to associate the booking with
    // String flightId
    test('to test the property `flightId`', () async {
      // TODO
    });

    // Booking code/confirmation code (e.g., \"ABC123\")
    // String bookingCode
    test('to test the property `bookingCode`', () async {
      // TODO
    });

    // Seat number (e.g., \"12A\", \"1F\")
    // String seatNumber
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
    // String reason (default value: 'personal')
    test('to test the property `reason`', () async {
      // TODO
    });

    // Additional notes about the booking
    // String notes
    test('to test the property `notes`', () async {
      // TODO
    });

  });
}
