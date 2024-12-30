import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/extensions/datetime.dart';
import 'package:plane_pal/extensions/duration.dart';
import 'package:plane_pal/formatters/time.dart';
import 'package:plane_pal/screens/home/widgets/flight_route_info.dart';
import 'package:plane_pal/utils/duration.dart';
import 'package:plane_pal/utils/distance.dart';

class FlightInfoWidget extends StatefulWidget {
  final FlightResponseEntity info;
  const FlightInfoWidget({
    super.key,
    required this.info,
  });

  @override
  State<FlightInfoWidget> createState() => _FlightInfoWidgetState();
}

class _FlightInfoWidgetState extends State<FlightInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final arrival = widget.info.arrival;
    final departure = widget.info.departure;
    return Padding(
      padding: const EdgeInsets.all(
        4.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: "https://airlabs.co/img/airline/m/${widget.info.airline.iata}.png",
                width: 30,
                height: 30,
                errorWidget: (context, url, error) {
                  return SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
              ),
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.info.departure.airport.municipalityName} to ${widget.info.arrival.airport.municipalityName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        formatDayAndMonth(
                          DateTime.parse(widget.info.departure.revisedTime!.utc),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleSmall?.color,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        " • ",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 12,
                            ),
                      ),
                      Text(
                        widget.info.flightNo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleSmall?.color,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(spacing: 4, children: [
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'send_to_wearable',
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch,
                          ),
                          SizedBox(width: 8),
                          Text('Send to wearable'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text('Share'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'copy',
                      child: Row(
                        children: [
                          Icon(Icons.copy),
                          SizedBox(width: 8),
                          Text('Copy Details'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {},
                ),
                Icon(
                  Icons.close,
                ),
              ])
            ],
          ),
          Divider(),
          Text(
            getTimeMessage(DateTime.parse((widget.info.arrival.revisedTime ?? widget.info.arrival.predictedTime)!.utc)),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          FlightRouteInfo(
            arrivalCode: arrival.airport.iata,
            arrivalDelay: _calculateDelay(arrival.revisedTime, arrival.scheduledTime),
            arrivalName: arrival.airport.name,
            arrivalSubtitle: "",
            arrivalTerminal: arrival.terminal,
            arrivalTime: DateTime.parse((arrival.revisedTime ?? arrival.predictedTime)!.utc),
            arrivalTimezone: arrival.airport.timeZone,
            departureCode: departure.airport.iata,
            departureDelay: _calculateDelay(departure.revisedTime, departure.scheduledTime),
            departureName: departure.airport.name,
            departureSubtitle: "",
            departureTerminal: departure.terminal,
            departureTime: DateTime.parse((departure.revisedTime ?? departure.scheduledTime).utc),
            departureTimezone: departure.airport.timeZone,
            statusColor: Colors.green,
            use24Hrs: MediaQuery.of(context).alwaysUse24HourFormat,
          ),
          Center(
            child: Text(
              "Total ${calculateFlightDuration(
                departureTime: (widget.info.departure.revisedTime ?? widget.info.departure.scheduledTime).utc,
                departureTimezone: widget.info.departure.airport.timeZone,
                arrivalTime: (widget.info.arrival.revisedTime ?? widget.info.arrival.predictedTime)!.utc,
                arrivalTimezone: widget.info.arrival.airport.timeZone,
              ).toHumanReadable()}  • ${formatDistance(widget.info.greatCircleDistance.km.toDouble(), Localizations.localeOf(context).toString())}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Gap(8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(
                    "Worth Noting",
                    style: TextStyle(
                      fontFamily: "CalSans",
                      fontSize: 16,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      MdiIcons.clock,
                    ),
                    title: Builder(builder: (context) {
                      final diff = getTimezoneDifference(
                        widget.info.departure.airport.timeZone,
                        widget.info.arrival.airport.timeZone,
                      );
                      return Text(
                        diff == "same timezone" ? "No timezone difference" : "$diff Timezone Difference",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          Gap(8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(
                    widget.info.aircraft.model,
                    style: TextStyle(
                      fontFamily: "CalSans",
                      fontSize: 16,
                    ),
                  ),
                  if (widget.info.image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "$POCKETBASE_URL/api/files/flight/${widget.info.id}/${widget.info.image}",
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Duration? _calculateDelay(dynamic revisedTime, dynamic scheduledTime) {
    if (revisedTime != null && scheduledTime != null) {
      return getDelay(
        DateTime.parse(revisedTime.utc!),
        DateTime.parse(scheduledTime.utc!),
      );
    }
    return null;
  }
}

Duration? getDelay(DateTime scheduled, DateTime predicted) {
  if (predicted.isAfter(scheduled)) {
    final delay = predicted.difference(scheduled);
    return delay;
  }
  return null;
}
