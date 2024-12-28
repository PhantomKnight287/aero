String formatDistance(double kilometers, String locale) {
  // Use miles for US, UK, and Myanmar
  final useMiles = ['en_US', 'en_GB', 'my_MM'].contains(locale);

  if (useMiles) {
    final miles = kilometers * 0.621371;
    return '${miles.round()} mi';
  }

  return '${kilometers.round()} km';
}
