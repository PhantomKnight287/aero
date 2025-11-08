import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/services/profile.dart';

class FlightStatsScreen extends StatefulWidget {
  const FlightStatsScreen({super.key});

  @override
  State<FlightStatsScreen> createState() => _FlightStatsScreenState();
}

class _FlightStatsScreenState extends State<FlightStatsScreen> {
  final ProfileService _profileService = ProfileService();
  ProfileStatsResponseEntity? _stats;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final stats = await _profileService.getProfileStats();
      setState(() {
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.surface,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
              )
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error loading stats',
                          style: TextStyle(color: colorScheme.error),
                        ),
                        const Gap(8),
                        ElevatedButton(
                          onPressed: _loadStats,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : _stats == null
                    ? Center(
                        child: Text(
                          'No stats available',
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Passport Stats Grid
                            _buildPassportGrid(_stats!.passport),
                            const Gap(40),

                            // Flight Distance Section
                            _buildFlightDistanceSection(),
                            const Gap(40),

                            // Flight Time Section
                            _buildFlightTimeSection(),
                            const Gap(40),

                            // Aircraft Stats
                            if (_stats!.aircraftStats != null)
                              _buildAircraftStatsSection(
                                  _stats!.aircraftStats!),
                            if (_stats!.aircraftStats != null) const Gap(40),

                            // Top Airlines
                            if (_stats!.airlines.isNotEmpty)
                              _buildTopAirlinesSection(
                                  _stats!.airlines.toList()),
                            if (_stats!.airlines.isNotEmpty) const Gap(40),

                            // Top Airports
                            if (_stats!.airports.isNotEmpty)
                              _buildTopAirportsSection(
                                  _stats!.airports.toList()),
                            if (_stats!.airports.isNotEmpty) const Gap(40),

                            // Top Routes
                            if (_stats!.topRoutes.isNotEmpty)
                              _buildTopRoutesSection(
                                  _stats!.topRoutes.toList()),
                            const Gap(20),
                          ],
                        ),
                      ),
      ),
    );
  }

  Widget _buildPassportGrid(PassportEntity passport) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MY STATS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
            letterSpacing: 0.5,
          ),
        ),
        const Gap(6),
        Text(
          'FLIGHT STATISTICS',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(20),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('FLIGHTS', '${passport.totalFlights}'),
            ),
            const Gap(12),
            Expanded(
              child: _buildStatCard(
                'FLIGHT TIME',
                '${(passport.totalDurationMinutes / 60).floor()}h ${((passport.totalDurationMinutes % 60) / 60 * 60).round()}m',
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'DISTANCE',
                '${passport.totalDistanceKm.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} km',
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildStatCard('AIRPORTS', '${passport.totalAirports}'),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('AIRLINES', '${passport.totalAirlines}'),
            ),
            const Gap(12),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              height: 1.2,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDistanceSection() {
    if (_stats == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final totalDistance = _stats!.passport.totalDistanceKm;
    final avgDistance = _stats!.passport.totalFlights > 0
        ? totalDistance / _stats!.passport.totalFlights
        : 0.0;

    // Calculate comparisons
    final earthCircumference = 40075.0; // km
    final moonDistance = 384400.0; // km
    final marsDistance = 54600000.0; // km (average distance to Mars)

    final aroundEarth = totalDistance / earthCircumference;
    final toMoon = totalDistance / moonDistance;
    final toMars = totalDistance / marsDistance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flight Distance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const Gap(16),
        Text(
          '${totalDistance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} km',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
            height: 1.2,
          ),
        ),
        const Gap(4),
        Text(
          '${(totalDistance * 0.621371).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi',
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(8),
        Text(
          'Average: ${avgDistance.toStringAsFixed(0)} km per flight',
          style: TextStyle(
            fontSize: 13,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(24),
        // Comparisons
        _buildComparisonBar(
          Icons.public,
          colorScheme.primary,
          'Around Earth',
          aroundEarth,
          '${aroundEarth.toStringAsFixed(1)}x',
        ),
        const Gap(12),
        _buildComparisonBar(
          Icons.nightlight_round,
          colorScheme.secondary,
          'To the Moon',
          toMoon,
          '${toMoon.toStringAsFixed(1)}x',
        ),
        const Gap(12),
        _buildComparisonBar(
          Icons.rocket_launch,
          colorScheme.tertiary,
          'To Mars',
          toMars,
          '${toMars.toStringAsFixed(2)}x',
        ),
        const Gap(24),
        // Shortest and Longest
        _buildFlightRecord(
          'Shortest flight',
          _stats!.shortestDistanceFlight,
          true,
        ),
        const Gap(16),
        _buildFlightRecord(
          'Longest flight',
          _stats!.longestDistanceFlight,
          true,
        ),
      ],
    );
  }

  Widget _buildComparisonBar(
    IconData icon,
    Color iconColor,
    String label,
    double value,
    String text,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use different max values based on the comparison type
    // For Mars, use a much smaller max value since distances are very small
    final maxValue = label == 'To Mars' ? 0.1 : 3.0; // Max value for scaling
    final normalizedValue = (value / maxValue).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const Gap(6),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: normalizedValue,
                          child: Container(
                            decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(12),
                    Text(
                      text,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightTimeSection() {
    if (_stats == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final totalMinutes = _stats!.passport.totalDurationMinutes;
    final hours = (totalMinutes / 60).floor();
    final minutes = (totalMinutes % 60).round();
    final days = (hours / 24).floor();
    final weeks = (days / 7).floor();
    final months = (days / 30).floor();
    final years = (days / 365).floor();

    final avgMinutes = _stats!.passport.totalFlights > 0
        ? totalMinutes / _stats!.passport.totalFlights
        : 0.0;
    final avgHours = (avgMinutes / 60).floor();
    final avgMins = (avgMinutes % 60).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flight Time',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const Gap(16),
        Text(
          '${hours}h ${minutes}m',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
            height: 1.2,
          ),
        ),
        const Gap(20),
        // Stats Grid
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildTimeStat('Days', days.toStringAsFixed(1)),
                  const Gap(12),
                  _buildTimeStat('Weeks', weeks.toStringAsFixed(1)),
                  const Gap(12),
                  _buildTimeStat('Months', months.toStringAsFixed(1)),
                ],
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                children: [
                  _buildTimeStat('Years', years.toStringAsFixed(2)),
                  const Gap(12),
                  _buildTimeStat('Avg. Flight', '${avgHours}h ${avgMins}m'),
                  const Gap(12),
                  _buildTimeStat('Total Hours', '${hours}h'),
                ],
              ),
            ),
          ],
        ),
        const Gap(24),
        // Shortest and Longest
        _buildFlightRecord(
          'Shortest flight',
          _stats!.shortestDurationFlight,
          false,
        ),
        const Gap(16),
        _buildFlightRecord(
          'Longest flight',
          _stats!.longestDurationFlight,
          false,
        ),
      ],
    );
  }

  Widget _buildTimeStat(String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightRecord(String title, dynamic flight, bool isDistance) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String value;
    String route;
    String flightInfo;

    if (isDistance && flight is FlightDistanceEntity) {
      value = '${flight.distanceKm.toStringAsFixed(0)} km';
      route =
          '${flight.flight.departureAirportName} → ${flight.flight.arrivalAirportName}';
      flightInfo = '${flight.flight.airline.name} ${flight.flight.flightNo}';
    } else if (!isDistance && flight is FlightDurationEntity) {
      final hours = (flight.durationMinutes / 60).floor();
      final minutes = (flight.durationMinutes % 60).round();
      value = '${hours}h ${minutes}m';
      route =
          '${flight.flight.departureAirportName} → ${flight.flight.arrivalAirportName}';
      flightInfo = '${flight.flight.airline.name} ${flight.flight.flightNo}';
    } else {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.flight,
              color: colorScheme.primary,
              size: 22,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const Gap(4),
                Text(
                  route,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  flightInfo,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const Gap(12),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAircraftStatsSection(AircraftStatsEntity aircraftStats) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Aircraft Stats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: () {
                _showAircraftStatsBottomSheet(aircraftStats);
              },
              child: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        // Most Flown Aircraft - Large image with overlay
        if (aircraftStats.mostFlownAircraftName.isNotEmpty)
          GestureDetector(
            onTap: () {
              _showAircraftStatsBottomSheet(aircraftStats);
            },
            child: _buildAircraftImageCard(
              aircraftStats.mostFlownAircraftName,
              aircraftStats.mostFlownAircraftFlightCount.toInt(),
              aircraftStats.mostFlownAircraftImage,
            ),
          ),
      ],
    );
  }

  Widget _buildAircraftImageCard(
    String aircraftName,
    int flightCount,
    String? imageUrl,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty)
              imageUrl.endsWith('.svg')
                  ? SvgPicture.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: Icon(
                            Icons.flight,
                            color: colorScheme.onSurfaceVariant,
                            size: 64,
                          ),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: Icon(
                            Icons.flight,
                            color: colorScheme.onSurfaceVariant,
                            size: 64,
                          ),
                        ),
                      ),
                    )
            else
              Container(
                color: colorScheme.surfaceVariant,
                child: Center(
                  child: Icon(
                    Icons.flight,
                    color: colorScheme.onSurfaceVariant,
                    size: 64,
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      aircraftName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          color: Colors.white.withOpacity(0.9),
                          size: 18,
                        ),
                        const Gap(6),
                        Text(
                          '$flightCount ${flightCount == 1 ? 'flight' : 'flights'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 16,
                    ),
                    const Gap(4),
                    Text(
                      'Tap for details',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAircraftStatsBottomSheet(AircraftStatsEntity aircraftStats) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aircraft Statistics',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: colorScheme.onSurface),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Most Common Tail Number
                    if (aircraftStats.mostCommonTailNumber.isNotEmpty) ...[
                      _buildTailNumberCard(
                        'Most Common Tail Number',
                        aircraftStats.mostCommonTailNumber,
                        aircraftStats.mostCommonTailNumberCount.toInt(),
                      ),
                      const Gap(16),
                    ],

                    // Median Age
                    if (aircraftStats.medianAge != null) ...[
                      _buildStatRow(
                        'Median Age',
                        '${aircraftStats.medianAge!.toStringAsFixed(1)} years',
                      ),
                      const Gap(16),
                    ],

                    // Youngest and Oldest Aircraft
                    if (aircraftStats.youngestAircraft != null ||
                        aircraftStats.oldestAircraft != null) ...[
                      Text(
                        'Aircraft Age Records',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const Gap(12),
                      if (aircraftStats.youngestAircraft != null &&
                          aircraftStats.oldestAircraft != null) ...[
                        _buildAircraftImageOverlayCard(
                          'Youngest',
                          aircraftStats.youngestAircraft!,
                        ),
                        const Gap(12),
                        _buildAircraftImageOverlayCard(
                          'Oldest',
                          aircraftStats.oldestAircraft!,
                        ),
                      ] else if (aircraftStats.youngestAircraft != null)
                        _buildAircraftImageOverlayCard(
                          'Youngest',
                          aircraftStats.youngestAircraft!,
                        )
                      else if (aircraftStats.oldestAircraft != null)
                        _buildAircraftImageOverlayCard(
                          'Oldest',
                          aircraftStats.oldestAircraft!,
                        ),
                      const Gap(16),
                    ],

                    // Bottom padding
                    const Gap(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTailNumberCard(String label, String tailNumber, int count) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.confirmation_number,
              color: colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(4),
                Text(
                  tailNumber,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(4),
                Text(
                  '$count flights',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAircraftImageOverlayCard(
      String label, AircraftWithAge aircraft) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Aircraft Image
            if (aircraft.image != null && aircraft.image!.isNotEmpty)
              aircraft.image!.endsWith('.svg')
                  ? SvgPicture.network(
                      aircraft.image!,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: Icon(
                            Icons.flight,
                            color: colorScheme.onSurfaceVariant,
                            size: 48,
                          ),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: aircraft.image!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: Icon(
                            Icons.flight,
                            color: colorScheme.onSurfaceVariant,
                            size: 48,
                          ),
                        ),
                      ),
                    )
            else
              Container(
                color: colorScheme.surfaceVariant,
                child: Center(
                  child: Icon(
                    Icons.flight,
                    color: colorScheme.onSurfaceVariant,
                    size: 48,
                  ),
                ),
              ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Label badge at top
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Overlay Text
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      aircraft.aircraftName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(6),
                    Row(
                      children: [
                        if (aircraft.age != null) ...[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white.withOpacity(0.9),
                            size: 16,
                          ),
                          const Gap(4),
                          Text(
                            '${aircraft.age!.toStringAsFixed(1)} years',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                              shadows: const [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                          const Gap(12),
                        ],
                        Icon(
                          Icons.confirmation_number,
                          color: Colors.white.withOpacity(0.9),
                          size: 16,
                        ),
                        const Gap(4),
                        Text(
                          aircraft.tailNumber,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAirlinesSection(List<AirlineStatsEntity> airlines) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Sort airlines by flight count
    List<AirlineStatsEntity> sortedAirlines = List.from(airlines);
    sortedAirlines.sort((a, b) => b.flightCount.compareTo(a.flightCount));

    final maxFlights = sortedAirlines.isNotEmpty
        ? sortedAirlines
            .map((a) => a.flightCount)
            .reduce((a, b) => a > b ? a : b)
        : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Airlines',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const Gap(4),
        Text(
          '${airlines.length} total airlines',
          style: TextStyle(
            fontSize: 13,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(16),
        // Airlines list with bars
        ...sortedAirlines.take(10).map((airline) {
          final normalizedValue = airline.flightCount / maxFlights;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Airline logo WITHOUT background - respecting brand guidelines
                SizedBox(
                  width: 24,
                  height: 24,
                  child: (airline.image != null && airline.image!.isNotEmpty)
                      ? (airline.image!.endsWith('.svg')
                          ? SvgPicture.network(
                              airline.image!,
                              fit: BoxFit.contain,
                              placeholderBuilder: (context) => Icon(
                                Icons.flight,
                                color: colorScheme.onSurfaceVariant,
                                size: 24,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: airline.image!,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) {
                                if (airline.airlineIata.isNotEmpty) {
                                  return CachedNetworkImage(
                                    imageUrl:
                                        "https://airlabs.co/img/airline/m/${airline.airlineIata}.png",
                                    fit: BoxFit.contain,
                                    errorWidget: (context, url, error) => Icon(
                                        Icons.flight,
                                        color: colorScheme.onSurfaceVariant,
                                        size: 24),
                                  );
                                }
                                return Icon(Icons.flight,
                                    color: colorScheme.onSurfaceVariant,
                                    size: 24);
                              },
                            ))
                      : (airline.airlineIata.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl:
                                  "https://airlabs.co/img/airline/m/${airline.airlineIata}.png",
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                Icons.flight,
                                color: colorScheme.onSurfaceVariant,
                                size: 24,
                              ),
                            )
                          : Icon(Icons.flight,
                              color: colorScheme.onSurfaceVariant, size: 24)),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        airline.airlineName,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: normalizedValue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            '${airline.flightCount}',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTopAirportsSection(List<AirportStatsEntity> airports) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final maxCount = airports.isNotEmpty
        ? airports.map((a) => a.departureCount).reduce((a, b) => a > b ? a : b)
        : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Airports',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const Gap(4),
        Text(
          '${airports.length} total airports',
          style: TextStyle(
            fontSize: 13,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(16),
        ...airports.take(10).map((airport) {
          final normalizedValue = airport.departureCount / maxCount;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      airport.airportCode,
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        airport.airportName,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: normalizedValue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            '${airport.departureCount}',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTopRoutesSection(List<TopRouteEntity> routes) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final maxCount = routes.isNotEmpty
        ? routes.map((r) => r.flightCount).reduce((a, b) => a > b ? a : b)
        : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Routes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const Gap(4),
        Text(
          '${routes.length} total routes',
          style: TextStyle(
            fontSize: 13,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(16),
        ...routes.take(10).map((route) {
          final normalizedValue = route.flightCount / maxCount;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.route,
                    color: colorScheme.onSecondaryContainer,
                    size: 20,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${route.origin} → ${route.destination}',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: normalizedValue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            '${route.flightCount}',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
