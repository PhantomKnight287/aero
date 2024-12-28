import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

/// Calculates the duration between two dates in different timezones
///
/// Parameters:
/// - date1: First date string (supports multiple formats including ISO 8601)
/// - timezone1: IANA timezone for first date
/// - date2: Second date string
/// - timezone2: IANA timezone for second date
/// - format: Optional custom format for non-ISO dates
Duration calculateTimezoneDifference({
  required String date1,
  required String timezone1,
  required String date2,
  required String timezone2,
  String? format,
}) {
  // Initialize timezone database
  try {
    tz.initializeTimeZones();
  } catch (e) {
    throw TimeZoneInitException('Failed to initialize timezone database: $e');
  }

  try {
    // Parse dates using appropriate method
    final parsedDate1 = _parseDateTime(date1, format);
    final parsedDate2 = _parseDateTime(date2, format);

    // Get timezone locations
    final location1 = tz.getLocation(timezone1);
    final location2 = tz.getLocation(timezone2);

    // Convert to TZDateTime for each timezone
    final tzDateTime1 = tz.TZDateTime.from(parsedDate1, location1);
    final tzDateTime2 = tz.TZDateTime.from(parsedDate2, location2);

    // Calculate difference
    return tzDateTime2.difference(tzDateTime1);
  } on tz.LocationNotFoundException catch (e) {
    throw TimeZoneNotFoundException('Invalid timezone identifier: $e');
  } catch (e) {
    throw Exception('Error calculating timezone difference: $e');
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
            'Error: $e');
      }
    }

    // If no format provided, try common formats
    final commonFormats = [
      "yyyy-MM-dd HH:mm",
      "yyyy-MM-dd hh:mm a",
      "MM/dd/yyyy HH:mm",
      "dd-MM-yyyy HH:mm",
      "yyyy/MM/dd HH:mm",
    ];

    for (final fmt in commonFormats) {
      try {
        return DateFormat(fmt).parse(dateStr);
      } catch (_) {
        continue;
      }
    }

    throw DateParseException('Could not parse "$dateStr". Supported formats include ISO 8601 '
        'or specify a custom format.');
  }
}

/// Custom exception classes (same as before)
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

// Example usage with different date formats
void main() {
  try {
    // Example 1: Using ISO 8601 format
    final duration1 = calculateTimezoneDifference(date1: "2024-12-28T10:07:00Z", timezone1: "America/Chicago", date2: "2024-12-28T12:42:00Z", timezone2: "America/Los_Angeles");
    print('Duration 1: ${duration1.inHours}h ${duration1.inMinutes % 60}m');

    // Example 2: Using custom format
    final duration2 = calculateTimezoneDifference(date1: "28-12-2024 10:07", timezone1: "Europe/London", date2: "28-12-2024 15:42", timezone2: "Asia/Tokyo", format: "dd-MM-yyyy HH:mm");
    print('Duration 2: ${duration2.inHours}h ${duration2.inMinutes % 60}m');

    // Example 3: Using common format without specifying format string
    final duration3 = calculateTimezoneDifference(date1: "2024-12-28 10:07", timezone1: "America/New_York", date2: "2024-12-28 12:42", timezone2: "America/Los_Angeles");
    print('Duration 3: ${duration3.inHours}h ${duration3.inMinutes % 60}m');
  } on DateParseException catch (e) {
    print('Date parsing error: $e');
  } on TimeZoneNotFoundException catch (e) {
    print('Timezone error: $e');
  } on TimeZoneInitException catch (e) {
    print('Initialization error: $e');
  } catch (e) {
    print('Unexpected error: $e');
  }
}
