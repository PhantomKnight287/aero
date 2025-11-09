import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

extension DateTimeTimezoneFormatter on DateTime {
  /// Converts DateTime to a specified timezone and returns formatted time string
  ///
  /// Parameters:
  /// - timezone: IANA timezone identifier (e.g., "America/New_York", "Asia/Tokyo")
  /// - format: Optional custom format string. Defaults to "h:mm a" (e.g., "10:30 AM")
  ///
  /// Returns formatted time string in the specified timezone
  /// Throws [TimeZoneInitException] if timezones are not initialized
  /// Throws [TimeZoneNotFoundException] if timezone is invalid
  String toTimezoneString(String timezone, {String? format, bool? use24Hrs}) {
    // Ensure timezone database is initialized
    try {
      tz.initializeTimeZones();
    } catch (e) {
      throw TimeZoneInitException('Failed to initialize timezone database: $e');
    }

    try {
      // Get timezone location
      final location = tz.getLocation(timezone);
      // Convert DateTime to TZDateTime
      final tzDateTime = tz.TZDateTime.from(this, location);

      // Create formatter with specified or default format
      final formatter = DateFormat(format ?? (use24Hrs == true ? "H:mm" : 'hh:mm a'));

      return formatter.format(tzDateTime);
    } on tz.LocationNotFoundException catch (e) {
      throw TimeZoneNotFoundException('Invalid timezone identifier: $timezone');
    } catch (e) {
      throw Exception('Error converting time to timezone $timezone: $e');
    }
  }
}

String getTimezoneDifference(String timezone1, String timezone2) {
  try {
    tz.initializeTimeZones();
  } catch (e) {
    throw TimeZoneInitException('Failed to initialize timezone database: $e');
  }

  // Create DateTime objects in both timezones
  final location1 = tz.getLocation(timezone1);
  final location2 = tz.getLocation(timezone2);

  // Get the offset from UTC for each timezone
  final offset1 = location1.currentTimeZone.offset ~/ 1000;
  final offset2 = location2.currentTimeZone.offset ~/ 1000;

  // Calculate difference in minutes
  final differenceInMinutes = (offset1 - offset2) ~/ 60;

  // Handle case where difference is 0
  if (differenceInMinutes == 0) {
    return 'same timezone';
  }

  // Calculate hours and remaining minutes
  final hours = differenceInMinutes ~/ 60;
  final minutes = differenceInMinutes.abs() % 60;

  // Determine the sign
  final isPositive = differenceInMinutes > 0;
  final sign = isPositive ? '+' : '-';

  // Build the string
  final StringBuffer result = StringBuffer();
  result.write(sign);

  if (hours != 0) {
    result.write('${hours.abs()} hr');
    if (hours.abs() != 1) result.write('s');
  }

  // Add minutes part if there are minutes
  if (minutes != 0) {
    if (hours != 0) result.write(' ');
    result.write('$minutes min');
    if (minutes != 1) result.write('s');
  }

  return result.toString();
}

class TimeZoneInitException implements Exception {
  final String message;
  TimeZoneInitException(this.message);

  @override
  String toString() => message;
}

/// Custom exception for invalid timezone identifiers
class TimeZoneNotFoundException implements Exception {
  final String message;
  TimeZoneNotFoundException(this.message);

  @override
  String toString() => message;
}
