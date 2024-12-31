import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class FlightInfoWidget extends StatefulWidget {
  final FlightResponseEntity info;
  final Function() onClose;
  const FlightInfoWidget({
    super.key,
    required this.info,
    required this.onClose,
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
        spacing: 4,
        children: [
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://airlabs.co/img/airline/m/${widget.info.airline.iata}.png",
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
                        "${departure.airport.municipalityName} to ${widget.info.arrival.airport.municipalityName}",
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
                          DateTime.parse(
                              (departure.revisedTime ?? departure.scheduledTime)
                                  .utc),
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
              Row(
                spacing: 4,
                children: [
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    color: Colors.white,
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
                    ],
                    onSelected: (value) async {
                      if (value == "send_to_wearable") {
                        final channel = MethodChannel(METHOD_CHANNEL);
                        final flightNumber = widget.info.flightNo;
                        final flightNumberWithoutIata = flightNumber
                            .replaceFirst(widget.info.airline.iata ?? "", '');
                        final flightNumberWithoutIcao = flightNumber
                            .replaceFirst(widget.info.airline.icao ?? "", '');

                        await channel.invokeMethod("registerFlight", {
                          "id": widget.info.id,
                          "date": DateTime.parse((departure.revisedTime ??
                                      departure.scheduledTime)
                                  .utc)
                              .toIso8601String(),
                          "flightIata": (flightNumberWithoutIcao ==
                                  flightNumberWithoutIata)
                              ? "${widget.info.airline.iata}$flightNumber"
                              : flightNumber,
                          "flightIcao": (flightNumberWithoutIcao ==
                                  flightNumberWithoutIata)
                              ? "${widget.info.airline.icao}$flightNumber"
                              : flightNumber,
                          "origin": departure.airport.municipalityName,
                          "destination":
                              widget.info.arrival.airport.municipalityName,
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 24,
                    child: IconButton(
                      onPressed: widget.onClose,
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                getTimeMessage(DateTime.parse(
                    (widget.info.arrival.revisedTime ??
                            widget.info.arrival.predictedTime)!
                        .utc)),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Center(
                child: Text(
                  "Total ${calculateFlightDuration(
                    departureTime:
                        (departure.revisedTime ?? departure.scheduledTime).utc,
                    departureTimezone: departure.airport.timeZone,
                    arrivalTime: (widget.info.arrival.revisedTime ??
                            widget.info.arrival.predictedTime)!
                        .utc,
                    arrivalTimezone: widget.info.arrival.airport.timeZone,
                  ).toHumanReadable()} • ${formatDistance(double.parse(widget.info.greatCircleDistance.km), Localizations.localeOf(context).toString())}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          FlightRouteInfo(
            arrivalCode: arrival.airport.iata,
            arrivalDelay:
                _calculateDelay(arrival.revisedTime, arrival.scheduledTime),
            arrivalName: arrival.airport.name,
            arrivalSubtitle: "",
            arrivalTerminal: arrival.terminal,
            arrivalTime: DateTime.parse(
                (arrival.revisedTime ?? arrival.predictedTime)!.utc),
            arrivalTimezone: arrival.airport.timeZone,
            departureCode: departure.airport.iata,
            departureDelay:
                _calculateDelay(departure.revisedTime, departure.scheduledTime),
            departureName: departure.airport.name,
            departureSubtitle: "",
            departureTerminal: departure.terminal,
            departureTime: DateTime.parse(
                (departure.revisedTime ?? departure.scheduledTime).utc),
            departureTimezone: departure.airport.timeZone,
            statusColor: Colors.green,
            use24Hrs: MediaQuery.of(context).alwaysUse24HourFormat,
            arrivalGate: arrival.gate,
            departureGate: departure.gate,
          ),
          Gap(8),
          Text(
            "Worth Noting",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      MdiIcons.clock,
                    ),
                    title: Builder(builder: (context) {
                      final diff = getTimezoneDifference(
                        widget.info.arrival.airport.timeZone,
                        departure.airport.timeZone,
                      );
                      return Text(
                        diff == "same timezone"
                            ? "No timezone difference"
                            : "Timezone difference of $diff",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Gap(8),
          if (widget.info.aircraft?.registration != null)
            Text(
              widget.info.aircraft!.model,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (widget.info.aircraft?.registration != null)
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
                    if (widget.info.aircraft!.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.info.aircraft!.image!,
                        ),
                      ),
                    Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        if (widget.info.aircraft?.age != null)
                          Column(
                            children: [
                              Text(
                                "Age",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .grey[700], // Adjust color as needed
                                ),
                              ),
                              Text(
                                formatAge(
                                  double.parse(
                                    widget.info.aircraft!.age!,
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Adjust color as needed
                                ),
                              ),
                            ],
                          ),
                        if (widget.info.aircraft?.deliveryDate != null)
                          Column(
                            children: [
                              Text(
                                "Delivery Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .grey[700], // Adjust color as needed
                                ),
                              ),
                              Text(
                                formatDate(DateTime.parse(
                                    widget.info.aircraft!.deliveryDate!)),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Adjust color as needed
                                ),
                              ),
                            ],
                          ),
                        if (widget.info.aircraft?.registration != null)
                          Column(
                            children: [
                              Text(
                                "Registration",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .grey[700], // Adjust color as needed
                                ),
                              ),
                              Text(
                                widget.info.aircraft!.registration!,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Adjust color as needed
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
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

DateTime convertToArrivalTimeZone(
  DateTime departureTime,
  String departureTimeZone,
  String arrivalTimeZone,
) {
  try {
    tz.initializeTimeZones();
  } catch (e) {
    print(e);
  }
  // Initialize time zone locations
  final departureLocation = tz.getLocation(departureTimeZone);
  final arrivalLocation = tz.getLocation(arrivalTimeZone);

  // Convert departure time to TZDateTime in the departure location
  final departureTZTime = tz.TZDateTime.from(departureTime, departureLocation);

  // Convert the departure TZDateTime to the arrival time zone
  final arrivalTZTime = tz.TZDateTime.from(departureTZTime, arrivalLocation);

  return arrivalTZTime.toLocal();
}

String formatAge(double age) {
  if (age == 0) return '0 months';

  final years = age.floor();
  final months = ((age - years) * 12).round();

  final List<String> parts = [];

  if (years > 0) {
    parts.add('$years ${years == 1 ? 'year' : 'years'}');
  }

  if (months > 0) {
    parts.add('$months ${months == 1 ? 'month' : 'months'}');
  }

  return parts.join(' and ');
}

String formatDate(DateTime date) {
  return '${MONTHS[date.month - 1]} ${date.day}, ${date.year}';
}
