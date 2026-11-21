import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/services/main.dart';

class TrackedFlightsList extends StatelessWidget {
  final BuiltList<FlightResponseEntity> trackedFlights;
  final Function(String iata, String icao, DateTime date, bool forceUpdate)
      onFlightTap;
  final Future<void> Function(FlightResponseEntity flight) onDelete;

  const TrackedFlightsList({
    super.key,
    required this.trackedFlights,
    required this.onFlightTap,
    required this.onDelete,
  });

  Future<bool> _confirmDelete(
    BuildContext context,
    FlightResponseEntity flight,
  ) async {
    final hasBooking = flight.bookings?.isNotEmpty == true;
    final date = DateFormat('dd MMM yyyy').format(flight.date.toLocal());
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete flight?'),
        content: Text(
          'Removes ${flight.flightNo} on $date from your log and stats.'
          '${hasBooking ? ' Its booking will be deleted too.' : ''}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return false;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await onDelete(flight);
      return true;
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (trackedFlights.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Text(
            "Recently Tracked",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.withOpacity(0.2),
            );
          },
          itemBuilder: (context, index) {
            final flight = trackedFlights[index];
            // Convert UTC date to device's local time
            final localDate = flight.date.toLocal();
            return Dismissible(
              key: ValueKey(flight.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) => _confirmDelete(context, flight),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete_outline, color: Colors.white),
              ),
              child: InkWell(
                onTap: () => onFlightTap(
                  flight.flightNo,
                  flight.flightNo,
                  localDate,
                  true,
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
                        child: flight.airline.image != null
                            ? SvgPicture.network(
                                flight.airline.image!,
                                width: 24,
                                height: 18,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    "https://www.flightaware.com/images/airline_logos/180px/${flight.airline.icao}.png",
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) {
                                  return Icon(
                                    Icons.airplanemode_active,
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
                              "${flight.departure.airport.iata} → ${flight.arrival.airport.iata}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${flight.departure.airport.municipalityName} to ${flight.arrival.airport.municipalityName}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy').format(localDate),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            flight.flightAwareData != null
                                ? "${flight.flightAwareData!.identIata} • ${flight.flightAwareData!.identIcao}"
                                : flight.flightNo,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: trackedFlights.length,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
