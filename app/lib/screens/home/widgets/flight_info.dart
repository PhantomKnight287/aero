import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plane_pal/formatters/time.dart';
import 'package:plane_pal/models/flight_info/flight_info.dart';

class FlightInfoWidget extends StatefulWidget {
  final FlightInfo info;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          spacing: 8,
          children: [
            CachedNetworkImage(
              imageUrl: "https://airlabs.co/img/airline/m/${widget.info.airline!.iata!}.png",
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
              children: [
                Row(
                  children: [
                    Text(
                      formatDayAndMonth(
                        DateTime.parse(widget.info.departure!.revisedTime!.utc!),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(" • "),
                    Text(
                      widget.info.flightNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${widget.info!.departure!.airport!.municipalityName} to ${widget.info!.arrival!.airport!.municipalityName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.close,
            ),
          ],
        ),
        Divider(),
        Text(
          getTimeMessage(DateTime.parse(widget.info!.arrival!.revisedTime!.utc!)),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
