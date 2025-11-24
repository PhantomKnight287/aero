import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/openapi.dart';

import 'package:aero/extensions/datetime.dart';
import 'package:aero/extensions/duration.dart';
import 'package:aero/formatters/time.dart';
import 'package:aero/utils/duration.dart';

class ShareableFlightCard extends StatelessWidget {
  const ShareableFlightCard({
    super.key,
    required this.info,
  });

  final FlightResponseEntity info;

  @override
  Widget build(BuildContext context) {
    final departure = info.departure;
    final arrival = info.arrival;
    final airline = info.airline;

    final departureTime = DateTime.parse(
      (departure.revisedTime ?? departure.scheduledTime).utc,
    );
    final arrivalTime = DateTime.parse(
      (arrival.revisedTime ?? arrival.scheduledTime).utc,
    );
    final departureScheduled = DateTime.parse(departure.scheduledTime.utc);
    final arrivalScheduled = DateTime.parse(arrival.scheduledTime.utc);

    final departureDelay = departure.revisedTime != null
        ? departureTime.difference(departureScheduled)
        : null;
    final arrivalDelay = arrival.revisedTime != null
        ? arrivalTime.difference(arrivalScheduled)
        : null;

    Duration duration;
    try {
      duration = calculateFlightDuration(
        departureTime: departureTime.toIso8601String(),
        departureTimezone: departure.airport.timeZone ?? 'UTC',
        arrivalTime: arrivalTime.toIso8601String(),
        arrivalTimezone: arrival.airport.timeZone ?? 'UTC',
      );
    } catch (_) {
      duration = arrivalTime.difference(departureTime);
    }

    return Container(
      width: 450,
      height: 600,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: SvgPicture.asset(
                'assets/background/world.svg',
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.03),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (airline.image != null)
                      SvgPicture.network(
                        airline.image!,
                        width: 32,
                        height: 32,
                      )
                    else if (airline.iata != null && airline.iata!.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl:
                            "https://airlabs.co/img/airline/m/${airline.iata}.png",
                        width: 32,
                        height: 32,
                        errorWidget: (context, url, error) =>
                            const SizedBox.shrink(),
                      ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            airline.name ?? 'Airline',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Text(
                            "${info.flightNo} ${info.flightAwareData?.identIata != null ? "• ${info.flightAwareData?.identIata}" : ''}",
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (info.greatCircleDistance.km != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${double.parse(info.greatCircleDistance.km!).toStringAsFixed(0)} km',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const Gap(2),
                          Text(
                            '${(double.parse(info.greatCircleDistance.km!) * 0.621371).toStringAsFixed(0)} mi',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departure',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 12,
                              color: Colors.grey[300],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                departure.airport.iata ?? 'N/A',
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              const Gap(8),
                              Icon(
                                Icons.flight_takeoff,
                                color: Colors.white.withOpacity(0.9),
                                size: 24,
                              ),
                            ],
                          ),
                          Text(
                            departure.airport.municipalityName ?? 'Unknown',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 14,
                              color: Colors.grey[300],
                            ),
                          ),
                          const Gap(4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                departureTime.toTimezoneString(
                                  departure.airport.timeZone ?? 'UTC',
                                  use24Hrs: MediaQuery.of(context)
                                      .alwaysUse24HourFormat,
                                ),
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              if (departureDelay != null &&
                                  departureDelay != Duration.zero)
                                Text(
                                  departureDelay.isNegative
                                      ? '${departureDelay.abs().toHumanReadable()} early'
                                      : '${departureDelay.toHumanReadable()} late',
                                  style: TextStyle(
                                    fontFamily: "Geist",
                                    fontSize: 11,
                                    color: departureDelay.isNegative
                                        ? Colors.green[300]
                                        : Colors.red[300],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                          _buildShareableAirportDetails(
                            terminal: departure.terminal,
                            gate: info.flightAwareData?.gateOrigin ??
                                departure.gate,
                            baggage: null,
                            runway: info.flightAwareData?.actualRunwayOff,
                            alignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Arrival',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 12,
                              color: Colors.grey[300],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.flight_land,
                                color: Colors.white.withOpacity(0.9),
                                size: 24,
                              ),
                              const Gap(8),
                              Text(
                                arrival.airport.iata ?? 'N/A',
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            arrival.airport.municipalityName ?? 'Unknown',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 14,
                              color: Colors.grey[300],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const Gap(4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                arrivalTime.toTimezoneString(
                                  arrival.airport.timeZone ?? 'UTC',
                                  use24Hrs: MediaQuery.of(context)
                                      .alwaysUse24HourFormat,
                                ),
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              if (arrivalDelay != null &&
                                  arrivalDelay != Duration.zero)
                                Text(
                                  arrivalDelay.isNegative
                                      ? '${arrivalDelay.abs().toHumanReadable()} early'
                                      : '${arrivalDelay.toHumanReadable()} late',
                                  style: TextStyle(
                                    fontFamily: "Geist",
                                    fontSize: 11,
                                    color: arrivalDelay.isNegative
                                        ? Colors.green[300]
                                        : Colors.red[300],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                          _buildShareableAirportDetails(
                            terminal: arrival.terminal,
                            gate: info.flightAwareData?.gateDestination ??
                                arrival.gate,
                            baggage: info.flightAwareData?.baggageClaim ??
                                arrival.baggageBelt,
                            runway: info.flightAwareData?.actualRunwayOn,
                            alignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildShareableDetailItem(
                      Icons.access_time,
                      'Duration',
                      duration.toHumanReadable(),
                    ),
                    _buildShareableDetailItem(
                      Icons.calendar_today,
                      'Date',
                      formatDayAndMonth(departureTime),
                    ),
                    _buildShareableDetailItem(
                      Icons.flight,
                      'Aircraft',
                      info.aircraft?.model?.split(' ').take(2).join(' ') ??
                          info.aircraft?.registration ??
                          'N/A',
                    ),
                  ],
                ),
                const Gap(16),
                Divider(
                  color: Colors.grey.shade700,
                  thickness: 0.5,
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Powered by Aero',
                      style: TextStyle(
                        fontFamily: "Geist",
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    if (info.aircraft?.registration != null)
                      Text(
                        info.aircraft!.registration!,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: Colors.grey[500],
                          letterSpacing: 1.2,
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

  Widget _buildShareableDetailItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 20,
          ),
          const Gap(6),
          Text(
            label,
            style: TextStyle(
              fontFamily: "Geist",
              fontSize: 11,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(2),
          Text(
            value,
            style: TextStyle(
              fontFamily: "Geist",
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildShareableAirportDetails({
    required String? terminal,
    required String? gate,
    required String? baggage,
    required String? runway,
    required CrossAxisAlignment alignment,
  }) {
    final items = <Widget>[];

    if (terminal != null && terminal.isNotEmpty) {
      items.add(
        _buildShareableDetailRow(
          'Terminal',
          terminal,
          alignment: alignment,
        ),
      );
    }

    if (gate != null && gate.isNotEmpty) {
      items.add(
        _buildShareableDetailRow(
          'Gate',
          gate,
          alignment: alignment,
        ),
      );
    }

    if (baggage != null && baggage.isNotEmpty) {
      items.add(
        _buildShareableDetailRow(
          'Baggage',
          baggage,
          alignment: alignment,
        ),
      );
    }

    if (runway != null && runway.isNotEmpty) {
      items.add(
        _buildShareableDetailRow(
          'Runway',
          runway,
          alignment: alignment,
        ),
      );
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: alignment,
      children: items,
    );
  }

  Widget _buildShareableDetailRow(
    String label,
    String value, {
    required CrossAxisAlignment alignment,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontFamily: "Geist",
              fontSize: 10,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: "Geist",
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
