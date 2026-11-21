import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/services/main.dart';
import 'package:aero/screens/home/widgets/flight_summary_card.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/error.dart';

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
    final booking = flight.bookings?.firstOrNull;
    final bookingLabel = booking == null
        ? null
        : [booking.bookingCode, booking.seatNumber]
            .whereType<String>()
            .where((s) => s.isNotEmpty)
            .join(' · ');
    final confirmed = await showAeroConfirm(
      context,
      title: 'Delete this flight?',
      message: 'It will be removed from your log and stats.',
      details: FlightSummaryCard(flight: flight),
      warning: booking == null
          ? null
          : 'Your booking${bookingLabel!.isEmpty ? '' : ' ($bookingLabel)'} will be deleted too.',
      confirmLabel: 'Delete flight',
      cancelLabel: 'Keep it',
      destructive: true,
    );
    if (!confirmed) return false;
    try {
      await onDelete(flight);
      return true;
    } on ApiException catch (e) {
      showErrorToast(e.message);
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
            style: AeroText.heading.copyWith(color: AeroColors.muted),
          ),
        ),
        ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 0.5,
              color: AeroColors.line,
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
                padding: const EdgeInsets.symmetric(horizontal: AeroSpace.xl),
                color: AeroColors.danger,
                child:
                    const Icon(Icons.delete_outline, color: AeroColors.onInk),
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
                      Padding(
                        padding: const EdgeInsets.all(AeroSpace.sm),
                        child: AirlineLogo(
                          svgUrl: flight.airline.image,
                          icao: flight.airline.icao,
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
                              style: AeroText.heading,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${flight.departure.airport.municipalityName} to ${flight.arrival.airport.municipalityName}",
                              style: AeroText.caption,
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
                            style: AeroText.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AeroColors.ink,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            flight.flightAwareData != null
                                ? "${flight.flightAwareData!.identIata} • ${flight.flightAwareData!.identIcao}"
                                : flight.flightNo,
                            style: AeroText.caption,
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
