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
