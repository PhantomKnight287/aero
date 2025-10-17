import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

/// Calculates the duration of a flight between two timezones
///
/// Parameters:
/// - departureTime: Departure time string (supports ISO 8601 or custom format)
/// - departureTimezone: IANA timezone for departure (e.g., "America/Chicago")
/// - arrivalTime: Arrival time string
/// - arrivalTimezone: IANA timezone for arrival (e.g., "America/Los_Angeles")
/// - dateFormat: Optional custom format for parsing times
///
/// Returns Duration representing the flight time
Duration calculateFlightDuration({
  required String departureTime,
  required String departureTimezone,
  required String arrivalTime,
  required String arrivalTimezone,
  String? dateFormat,
}) {
  // Initialize timezone database
  try {
    tz.initializeTimeZones();
  } catch (e) {
    throw TimeZoneInitException('Failed to initialize timezone database: $e');
  }
  try {
    // Parse times using appropriate method
    final parsedDeparture = _parseDateTime(departureTime, dateFormat);
    final parsedArrival = _parseDateTime(arrivalTime, dateFormat);

    // Get timezone locations
    final departureLocation = tz.getLocation(departureTimezone);
    final arrivalLocation = tz.getLocation(arrivalTimezone);

    // Convert to TZDateTime for each timezone
    final tzDeparture = tz.TZDateTime.from(parsedDeparture, departureLocation);
    final tzArrival = tz.TZDateTime.from(parsedArrival, arrivalLocation);

    // Calculate duration
    final duration = tzArrival.difference(tzDeparture);


    return duration;
  } on tz.LocationNotFoundException catch (e) {
    throw TimeZoneNotFoundException('Invalid timezone identifier provided: $e');
  } catch (e) {
    rethrow; // Preserve specific exception types
  }
}

/// Helper function to parse datetime strings in various formats
DateTime _parseDateTime(String dateStr, String? format) {
  try {
    // First try parsing as ISO 8601
    return DateTime.parse(dateStr);
  } catch (_) {
    // If ISO parsing fails and format is provided, try using the format
    if (format != null) {
      try {
        return DateFormat(format).parse(dateStr);
      } catch (e) {
        throw DateParseException('Could not parse "$dateStr" using format "$format". '
            'Please check the time format and try again.');
      }
    }

    // If no format provided, try common formats
    final commonFormats = [
      "yyyy-MM-dd HH:mm",
      "yyyy-MM-dd hh:mm a",
      "MM/dd/yyyy HH:mm",
      "dd-MM-yyyy HH:mm",
    ];

    for (final fmt in commonFormats) {
      try {
        return DateFormat(fmt).parse(dateStr);
      } catch (_) {
        continue;
      }
    }

    throw DateParseException('Could not parse "$dateStr". Please provide times in ISO 8601 format '
        '(e.g., "2024-12-28T10:07:00Z") or specify a custom format.');
  }
}

/// Custom exception for invalid flight times
class FlightTimeException implements Exception {
  final String message;
  FlightTimeException(this.message);

  @override
  String toString() => message;
}

/// Other exception classes
class DateParseException implements Exception {
  final String message;
  DateParseException(this.message);

  @override
  String toString() => message;
}

class TimeZoneInitException implements Exception {
  final String message;
  TimeZoneInitException(this.message);

  @override
  String toString() => message;
}

class TimeZoneNotFoundException implements Exception {
  final String message;
  TimeZoneNotFoundException(this.message);

  @override
  String toString() => message;
}
