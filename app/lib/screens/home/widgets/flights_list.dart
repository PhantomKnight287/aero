import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/formatters/time.dart';

class FlightsList extends StatelessWidget {
  final BuiltList<FlightEntity> flights;
  final DateTime? selectedDate;
  final Function(String iata, String icao, DateTime date) onFlightTap;

  const FlightsList({
    super.key,
    required this.flights,
    required this.selectedDate,
    required this.onFlightTap,
  });

  @override
  Widget build(BuildContext context) {
    if (flights.isEmpty || selectedDate == null) {
      return SizedBox.shrink();
    }

    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          thickness: 0.5,
          color: Colors.grey.withOpacity(0.2),
        );
      },
      itemBuilder: (context, index) {
        final flight = flights[index];
        final arrivalTime = DateTime.parse(flight.arrival.scheduledTime!);
        final departureTime = DateTime.parse(flight.departure.scheduledTime!);
        final currentTime = DateTime.now();
        return InkWell(
          onTap: () => onFlightTap(
            flight.flight.iataNumber,
            flight.flight.icaoNumber,
            selectedDate!,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://airlabs.co/img/airline/m/${flight.airline.iataCode}.png",
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) {
                      return Icon(
                        MdiIcons.airplane,
                        size: 24,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        flight.airline.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${flight.flight.iataNumber} • ${flight.flight.icaoNumber}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${flight.departure.iataCode} ",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          formatTime(
                            departureTime,
                            use24HourFormat: MediaQuery.of(context)
                                .alwaysUse24HourFormat,
                          ),
                          style: TextStyle(
                            fontSize: 13,
                            color: currentTime.isAfter(departureTime)
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${flight.arrival.iataCode} ",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          formatTime(
                            arrivalTime,
                            use24HourFormat:
                                MediaQuery.of(context).alwaysUse24HourFormat,
                          ),
                          style: TextStyle(
                            fontSize: 13,
                            color: currentTime.isAfter(arrivalTime)
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: flights.length,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

