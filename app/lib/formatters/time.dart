import 'package:aero/constants/main.dart';
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

String getTimeMessage(DateTime departureTime, DateTime arrivalTime) {
  // Use UTC time for accurate comparisons since flight times are in UTC
  final now = DateTime.now().toUtc();

  // Check if flight hasn't departed yet
  if (now.isBefore(departureTime)) {
    final difference = departureTime.difference(now);
    final minutes = difference.inMinutes;
    
    if (minutes < 1) {
      return 'Departing now';
    } else if (minutes < 60) {
      return 'Departs in $minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    } else if (minutes < 1440) {
      final hours = (minutes / 60).floor();
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return 'Departs in $hours ${hours == 1 ? 'hour' : 'hours'}';
      }
      return 'Departs in $hours ${hours == 1 ? 'hr' : 'hrs'} $remainingMinutes ${remainingMinutes == 1 ? 'min' : 'mins'}';
    } else {
      final days = (minutes / 1440).floor();
      return 'Departs in $days ${days == 1 ? 'day' : 'days'}';
    }
  }
  
  // Flight has departed - check if it has landed
  if (now.isAfter(arrivalTime)) {
    final difference = now.difference(arrivalTime);
    final minutes = difference.inMinutes;
    
    if (minutes < 1) {
      return 'Just landed';
    } else if (minutes < 60) {
      return 'Landed $minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (minutes < 1440) {
      final hours = (minutes / 60).floor();
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return 'Landed $hours ${hours == 1 ? 'hour' : 'hours'} ago';
      }
      return 'Landed $hours ${hours == 1 ? 'hr' : 'hrs'} $remainingMinutes ${remainingMinutes == 1 ? 'min' : 'mins'} ago';
    } else {
      final days = (minutes / 1440).floor();
      return 'Landed $days ${days == 1 ? 'day' : 'days'} ago';
    }
  }
  
  // Flight is in the air
  final difference = arrivalTime.difference(now);
  final minutes = difference.inMinutes;
  
  if (minutes < 1) {
    return 'Landing now';
  } else if (minutes < 60) {
    return 'In flight, lands in $minutes ${minutes == 1 ? 'minute' : 'minutes'}';
  } else if (minutes < 1440) {
    final hours = (minutes / 60).floor();
    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) {
      return 'In flight, lands in $hours ${hours == 1 ? 'hour' : 'hours'}';
    }
    return 'In flight, lands in $hours ${hours == 1 ? 'hr' : 'hrs'} $remainingMinutes ${remainingMinutes == 1 ? 'min' : 'mins'}';
  } else {
    final days = (minutes / 1440).floor();
    return 'In flight, lands in $days ${days == 1 ? 'day' : 'days'}';
  }
}

/// "11 years and 2 months" from fractional years.
String formatAge(double age) {
  if (age == 0) return '0 months';

  final years = age.floor();
  final months = ((age - years) * 12).round();

  final List<String> parts = [];

  if (years > 0) {
    parts.add('$years ${years == 1 ? 'year' : 'years'}');
  }

  if (months > 0) {
    parts.add('$months ${months == 1 ? 'month' : 'months'}');
  }

  return parts.join(' and ');
}

String formatDate(DateTime date) {
  return '${MONTHS[date.month - 1]} ${date.day}, ${date.year}';
}

/// Long totals: >= 1 day -> '17d 11h' (rounded to nearest hour), else '7h 34m'.
String formatLongDuration(int minutes) {
  if (minutes >= 1440) {
    final totalHours = (minutes / 60).round();
    return '${totalHours ~/ 24}d ${totalHours % 24}h';
  }
  return '${minutes ~/ 60}h ${minutes % 60}m';
}
