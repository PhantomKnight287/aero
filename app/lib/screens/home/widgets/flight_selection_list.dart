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
  final VoidCallback onClose;

  const FlightSelectionList({
    super.key,
    required this.flights,
    required this.onFlightSelected,
    required this.onClose,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Your Flight',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'We found ${flights.length} ${flights.length == 1 ? 'flight' : 'flights'} matching your search',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: onClose,
                tooltip: 'Cancel',
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(),
              ),
            ],
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

            return InkWell(
              onTap: () => onFlightSelected(flight.faFlightId),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.all(8),
                      child: _buildAirlineImage(flight.airline),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  flight.airline.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  flight.ident,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                _formatRoute(flight),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${_formatAirportName(flight, true)} → ${_formatAirportName(flight, false)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (departureTime != null) ...[
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Departs at $departureTime',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                      size: 24,
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
