import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:intl/intl.dart';
import 'package:plane_pal/formatters/time.dart';

class FlightSelectionList extends StatelessWidget {
  final BuiltList<FlightCandidateEntity> flights;
  final Function(String faFlightId) onFlightSelected;

  const FlightSelectionList({
    super.key,
    required this.flights,
    required this.onFlightSelected,
  });

  String _formatRoute(FlightCandidateEntity flight) {
    final originCode = flight.origin.codeIata ?? flight.origin.code;
    final destCode = flight.destination.codeIata ?? flight.destination.code;
    return '$originCode → $destCode';
  }

  String _formatAirportName(FlightCandidateEntity flight, bool isOrigin) {
    if (isOrigin) {
      final origin = flight.origin;
      if (origin.name != null && origin.name!.isNotEmpty) {
        if (origin.city != null && origin.city!.isNotEmpty) {
          return '${origin.name}, ${origin.city}';
        }
        return origin.name!;
      }
      return origin.codeIata ?? origin.code;
    } else {
      final destination = flight.destination;
      if (destination.name != null && destination.name!.isNotEmpty) {
        if (destination.city != null && destination.city!.isNotEmpty) {
          return '${destination.name}, ${destination.city}';
        }
        return destination.name!;
      }
      return destination.codeIata ?? destination.code;
    }
  }

  String? _formatDepartureTime(FlightCandidateEntity flight) {
    final scheduledTime = flight.scheduledOut ?? flight.scheduledOff;
    if (scheduledTime == null) return null;
    try {
      return formatTime(scheduledTime);
    } catch (e) {
      return DateFormat('HH:mm').format(scheduledTime);
    }
  }

  Color _getStatusColor(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains('on time') || lowerStatus.contains('scheduled')) {
      return Colors.green;
    } else if (lowerStatus.contains('delayed') || lowerStatus.contains('late')) {
      return Colors.orange;
    } else if (lowerStatus.contains('cancelled') || lowerStatus.contains('canceled')) {
      return Colors.red;
    } else if (lowerStatus.contains('departed') || lowerStatus.contains('in flight')) {
      return Colors.blue;
    } else if (lowerStatus.contains('arrived') || lowerStatus.contains('landed')) {
      return Colors.grey;
    }
    return Colors.grey;
  }

  Widget _buildAirlineImage(FlightSummaryAirlineEntity airline) {
    // Prefer database image (which may have secondary CDN URL)
    if (airline.image != null && airline.image!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: airline.image!,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) {
          // Fallback to primary CDN if database image fails
          return _buildFallbackAirlineImage(airline);
        },
      );
    }

    // Fallback to primary CDN
    return _buildFallbackAirlineImage(airline);
  }

  Widget _buildFallbackAirlineImage(FlightSummaryAirlineEntity airline) {
    if (airline.iata != null && airline.iata!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: "https://airlabs.co/img/airline/m/${airline.iata}.png",
        fit: BoxFit.contain,
        errorWidget: (context, url, error) {
          return Icon(
            MdiIcons.airplane,
            size: 24,
            color: Colors.grey,
          );
        },
      );
    }

    return Icon(
      MdiIcons.airplane,
      size: 24,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (flights.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Found ${flights.length} ${flights.length == 1 ? 'flight' : 'flights'}. Which one is yours?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.withOpacity(0.2),
            );
          },
          itemBuilder: (context, index) {
            final flight = flights[index];
            final departureTime = _formatDepartureTime(flight);
            final statusColor = _getStatusColor(flight.status);

            return InkWell(
              onTap: () => onFlightSelected(flight.faFlightId),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Airline logo
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: _buildAirlineImage(flight.airline),
                    ),
                    SizedBox(width: 12),
                    // Flight details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Airline name and flight number
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  flight.airline.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (departureTime != null) ...[
                                SizedBox(width: 8),
                                Text(
                                  departureTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 4),
                          // Route
                          Text(
                            _formatRoute(flight),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[900],
                            ),
                          ),
                          SizedBox(height: 2),
                          // Airport names
                          Text(
                            '${_formatAirportName(flight, true)} → ${_formatAirportName(flight, false)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          // Status
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  flight.status,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Arrow indicator
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: flights.length,
        ),
      ],
    );
  }
}

