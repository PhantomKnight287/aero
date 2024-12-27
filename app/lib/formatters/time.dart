import 'package:intl/intl.dart';

String formatTime(
  DateTime date, {
  bool use24HourFormat = true,
}) {
  return DateFormat(use24HourFormat ? "HH:mm" : "h:mm a", Intl.systemLocale).format(date);
}

String formatDayAndMonth(
  DateTime date,
) {
  return DateFormat(
    "E, MMM d",
    Intl.systemLocale,
  ).format(date);
}

String getTimeMessage(DateTime targetTime) {
  final now = DateTime.now();
  final difference = targetTime.difference(now);
  final minutes = difference.inMinutes;

  if (difference.isNegative) {
    // Past time
    if (minutes.abs() < 1) {
      return 'Just arrived';
    } else if (minutes.abs() < 60) {
      return 'Arrived ${minutes.abs()} minutes ago';
    } else if (minutes.abs() < 1440) {
      // Less than 24 hours
      final hours = (minutes.abs() / 60).floor();
      return 'Arrived $hours hours ago';
    } else {
      final days = (minutes.abs() / 1440).floor();
      return 'Arrived $days days ago';
    }
  } else {
    // Future time
    if (minutes < 1) {
      return 'Arriving now';
    } else if (minutes < 60) {
      return 'Arrives in $minutes minutes';
    } else if (minutes < 1440) {
      // Less than 24 hours
      final hours = (minutes / 60).floor();
      return 'Arrives in $hours hours';
    } else {
      final days = (minutes / 1440).floor();
      return 'Arrives in $days days';
    }
  }
}
