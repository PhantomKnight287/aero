extension DurationFormatter on Duration {
  String toHumanReadable() {
    if (inSeconds == 0) {
      return '';
    }

    final absSeconds = inSeconds.abs();
    if (absSeconds < 60) {
      return '${absSeconds}s';
    }

    final absMinutes = inMinutes.abs();
    if (absMinutes < 60) {
      final minutes = absMinutes;
      final seconds = absSeconds % 60;
      if (seconds == 0) {
        return '${minutes}m';
      }
      return '${minutes}m ${seconds}s';
    }

    final absHours = inHours.abs();
    if (absHours < 24) {
      final hours = absHours;
      final minutes = (absMinutes % 60);
      if (minutes == 0) {
        return '${hours}h';
      }
      return '${hours}h ${minutes}m';
    }

    final days = inDays.abs();
    final hours = (absHours % 24);
    if (hours == 0) {
      return '${days}d';
    }
    return '${days}d ${hours}h';
  }

  String toRelativeTime() {
    final difference = this;

    if (difference.inSeconds.abs() < 60) {
      return 'just now';
    }

    if (difference.inMinutes.abs() < 60) {
      final minutes = difference.inMinutes.abs();
      return difference.isNegative ? '${minutes}m ago' : 'in ${minutes}m';
    }

    if (difference.inHours.abs() < 24) {
      final hours = difference.inHours.abs();
      final minutes = (difference.inMinutes.abs() % 60);
      final timeString = minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
      return difference.isNegative ? '${timeString} ago' : 'in ${timeString}';
    }

    final days = difference.inDays.abs();
    final hours = (difference.inHours.abs() % 24);
    final timeString = hours > 0 ? '${days}d ${hours}h' : '${days}d';
    return difference.isNegative ? '${timeString} ago' : 'in ${timeString}';
  }
}
