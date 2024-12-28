extension DurationFormatter on Duration {
  String toHumanReadable() {
    if (inSeconds == 0) {
      return 'now';
    }

    if (inSeconds < 60) {
      return '${inSeconds}s';
    }

    if (inMinutes < 60) {
      final minutes = inMinutes;
      final seconds = inSeconds % 60;
      if (seconds == 0) {
        return '${minutes}m';
      }
      return '${minutes}m ${seconds}s';
    }

    if (inHours < 24) {
      final hours = inHours;
      final minutes = inMinutes % 60;
      if (minutes == 0) {
        return '${hours}h';
      }
      return '${hours}h ${minutes}m';
    }

    final days = inDays;
    final hours = inHours % 24;
    if (hours == 0) {
      return '${days}d';
    }
    return '${days}d ${hours}h';
  }

  String toRelativeTime() {
    final now = DateTime.now();
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
