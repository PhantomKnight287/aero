import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gap/gap.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/extensions/datetime.dart';
import 'package:plane_pal/extensions/duration.dart';
import 'package:plane_pal/formatters/time.dart';
import 'package:plane_pal/screens/home/widgets/flight_route_info.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plane_pal/utils/duration.dart';
import 'package:google_fonts/google_fonts.dart';

class FlightInfoWidget extends StatefulWidget {
  final FlightResponseEntity info;
  final Function() onClose;
  final Function()? onRefreshTracking;
  final Function()? onRefreshFlightData;
  final BuiltList<FlightPositionEntity> flightPositions;
  const FlightInfoWidget({
    super.key,
    required this.info,
    required this.onClose,
    this.onRefreshTracking,
    this.onRefreshFlightData,
    required this.flightPositions,
  });

  @override
  State<FlightInfoWidget> createState() => _FlightInfoWidgetState();
}

class _FlightInfoWidgetState extends State<FlightInfoWidget> {
  bool _showAircraftPayload = false;
  final ScreenshotController _screenshotController = ScreenshotController();

  String _formatKey(String key) {
    final withSpaces = key
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'(?<!^)([A-Z0-9])'), (m) => ' ${m.group(1)}');
    final parts = withSpaces.split(' ');
    return parts
        .map((w) => w.isEmpty
            ? w
            : '${w[0].toUpperCase()}${w.length > 1 ? w.substring(1) : ''}')
        .join(' ');
  }

  bool? _coerceToBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) {
      if (value == 1) return true;
      if (value == 0) return false;
      return null;
    }
    if (value is String) {
      final v = value.trim().toLowerCase();
      if (v == 'true' || v == 'yes' || v == 'y') return true;
      if (v == 'false' || v == 'no' || v == 'n') return false;
      if (v == '1') return true;
      if (v == '0') return false;
      return null;
    }
    return null;
  }

  String _formatPayloadValue(dynamic value) {
    if (value is String) {
      try {
        final parsed = DateTime.parse(value);
        return formatDate(parsed);
      } catch (_) {
        // not a parsable date string; fall through
      }
    }
    return "$value";
  }

  Widget _buildShareableCard() {
    final departure = widget.info.departure;
    final arrival = widget.info.arrival;
    final airline = widget.info.airline;

    final departureTime = DateTime.parse(
      (departure.revisedTime ?? departure.scheduledTime).utc,
    );
    final arrivalTime = DateTime.parse(
      (arrival.revisedTime ?? arrival.scheduledTime).utc,
    );
    final departureScheduled = DateTime.parse(departure.scheduledTime.utc);
    final arrivalScheduled = DateTime.parse(arrival.scheduledTime.utc);

    // Calculate delays
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
    } catch (e) {
      duration = arrivalTime.difference(departureTime);
    }

    return Container(
      width: 450,
      height: 600,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A), // Clean dark base
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
          // Content
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
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${widget.info.flightNo} ${widget.info.flightAwareData?.identIata != null ? "• ${widget.info.flightAwareData?.identIata}" : ''}",
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
                    // Distance info - simple and clean
                    if (widget.info.greatCircleDistance.km != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${double.parse(widget.info.greatCircleDistance.km!).toStringAsFixed(0)} km',
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            '${(double.parse(widget.info.greatCircleDistance.km!) * 0.621371).toStringAsFixed(0)} mi',
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
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(8),
                              const Icon(
                                Icons.flight_takeoff,
                                color: Colors.white,
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
                                  use24Hrs: false,
                                ),
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
                            gate: widget.info.flightAwareData?.gateOrigin ??
                                departure.gate,
                            baggage: null, // No baggage for departure
                            runway:
                                widget.info.flightAwareData?.actualRunwayOff,
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
                              const Icon(
                                Icons.flight_land,
                                color: Colors.white,
                                size: 24,
                              ),
                              const Gap(8),
                              Text(
                                arrival.airport.iata ?? 'N/A',
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                                  use24Hrs: false,
                                ),
                                style: TextStyle(
                                  fontFamily: "Geist",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
                            gate:
                                widget.info.flightAwareData?.gateDestination ??
                                    arrival.gate,
                            baggage:
                                widget.info.flightAwareData?.baggageClaim ??
                                    arrival.baggageBelt,
                            runway: widget.info.flightAwareData?.actualRunwayOn,
                            alignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Clean details section
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
                      widget.info.aircraft?.model
                              ?.split(' ')
                              .take(2)
                              .join(' ') ??
                          widget.info.aircraft?.registration ??
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
                    if (widget.info.aircraft?.registration != null)
                      Text(
                        widget.info.aircraft!.registration!,
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
              color: Colors.white,
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

    // Terminal
    if (terminal != null && terminal.isNotEmpty) {
      items.add(_buildShareableDetailRow(
        'Terminal',
        terminal,
        alignment: alignment,
      ));
    }

    // Gate
    if (gate != null && gate.isNotEmpty) {
      items.add(_buildShareableDetailRow(
        'Gate',
        gate,
        alignment: alignment,
      ));
    }

    // Baggage belt (only for arrival, if available)
    if (baggage != null && baggage.isNotEmpty) {
      items.add(_buildShareableDetailRow(
        'Baggage',
        baggage,
        alignment: alignment,
      ));
    }

    // Runway
    if (runway != null && runway.isNotEmpty) {
      items.add(_buildShareableDetailRow(
        'Runway',
        runway,
        alignment: alignment,
      ));
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
              color: Colors.white,
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

  Future<void> _shareFlightCard() async {
    try {
      // Capture screenshot
      final imageBytes = await _screenshotController.captureFromWidget(
        InheritedTheme.captureAll(context, _buildShareableCard()),
        pixelRatio: 2.0,
        delay: const Duration(milliseconds: 100),
      );

      if (imageBytes.isEmpty) {
        return;
      }

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/flight_card_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my flight!',
      );
    } catch (e) {
      // Handle error silently or show a snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share flight card: $e'),
          ),
        );
      }
    }
  }

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
                      ),
                      if (widget.info.flightAwareData?.identIata != null) ...[
                        Text(
                          " • ",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        Text(
                          widget.info.flightAwareData?.identIata ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.titleSmall?.color,
                            fontSize: 12,
                          ),
                        ),
                      ]
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
                      if (widget.onRefreshTracking != null)
                        PopupMenuItem(
                          value: 'refresh_tracking',
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                              ),
                              SizedBox(width: 8),
                              Text('Refresh tracking'),
                            ],
                          ),
                        ),
                      PopupMenuItem(
                        value: 'refresh_flight_data',
                        child: Row(
                          children: [
                            Icon(
                              Icons.refresh,
                            ),
                            SizedBox(width: 8),
                            Text('Refresh flight data'),
                          ],
                        ),
                      ),
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
                      if (value == "refresh_tracking") {
                        widget.onRefreshTracking?.call();
                      } else if (value == "send_to_wearable") {
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
                      if (value == "refresh_flight_data") {
                        widget.onRefreshFlightData?.call();
                      }
                      if (value == "share") {
                        _shareFlightCard();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTimeMessage(
                  DateTime.parse(
                    (departure.revisedTime ??
                            departure.predictedTime ??
                            departure.scheduledTime)
                        .utc,
                  ),
                  DateTime.parse(
                    (arrival.revisedTime ??
                            arrival.predictedTime ??
                            arrival.scheduledTime)
                        .utc,
                  ),
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          FlightRouteInfo(
            arrivalCode: arrival.airport.iata,
            arrivalDelay: _calculateDelay(arrival.revisedTime,
                arrival.predictedTime ?? arrival.scheduledTime),
            arrivalName: arrival.airport.name,
            arrivalSubtitle: "",
            arrivalTerminal: arrival.terminal,
            arrivalTime: DateTime.parse((arrival.revisedTime ??
                    arrival.predictedTime ??
                    arrival.scheduledTime)
                .utc),
            arrivalTimezone: arrival.airport.timeZone,
            departureCode: departure.airport.iata,
            departureDelay: _calculateDelay(departure.revisedTime,
                departure.predictedTime ?? departure.scheduledTime),
            departureName: departure.airport.name,
            departureSubtitle: "",
            departureTerminal: departure.terminal,
            departureTime: DateTime.parse((departure.revisedTime ??
                    departure.predictedTime ??
                    departure.scheduledTime)
                .utc),
            departureTimezone: departure.airport.timeZone,
            statusColor: Colors.green,
            use24Hrs: MediaQuery.of(context).alwaysUse24HourFormat,
            arrivalGate:
                widget.info.flightAwareData?.gateDestination ?? arrival.gate,
            departureGate:
                widget.info.flightAwareData?.gateOrigin ?? departure.gate,
            arrivalBaggage: widget.info.flightAwareData?.baggageClaim ??
                arrival.baggageBelt,
            distanceKm: widget.info.greatCircleDistance.km != null
                ? double.tryParse(widget.info.greatCircleDistance.km!)
                : null,
            flightAwareDataEntity: widget.info.flightAwareData,
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
              ).copyWith(
                top: 0,
                bottom: 0,
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
                  if (widget.info.flightAwareData?.codesharesIcao != null &&
                      widget.info.flightAwareData!.codesharesIcao!.isNotEmpty)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Could be known as ${widget.info.flightAwareData!.codesharesIcao!.join(", ")}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Icon(Icons.flight_takeoff),
                    )
                ],
              ),
            ),
          ),
          Gap(8),
          if (widget.info.aircraft?.model != null)
            Text(
              widget.info.aircraft!.model!,
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
                      runSpacing: 10,
                      children: [
                        if (widget.info.aircraft?.age != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(height: 8),
                              Builder(builder: (context) {
                                final payload =
                                    (widget.info.aircraft?.payload)?.asMap;
                                final entries = payload == null
                                    ? const <MapEntry<String, dynamic>>[]
                                    : payload.entries
                                        .where((e) =>
                                            e.value is String ||
                                            e.value is num ||
                                            e.value is bool)
                                        .where((e) =>
                                            e.key != 'id' &&
                                            e.key != 'numRegistrations')
                                        .toList();
                                if (entries.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _showAircraftPayload =
                                              !_showAircraftPayload;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _showAircraftPayload
                                                ? "Hide more info"
                                                : "Show more info",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                              _showAircraftPayload
                                                  ? Icons.expand_less
                                                  : Icons.expand_more,
                                              size: 18),
                                        ],
                                      ),
                                    ),
                                    if (_showAircraftPayload)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: entries.map((e) {
                                            final coerced =
                                                _coerceToBool(e.value);
                                            if (coerced != null) {
                                              final boolColor = coerced
                                                  ? Colors.green
                                                  : Colors.red;
                                              final label =
                                                  coerced ? 'Yes' : 'No';
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        _formatKey(e.key),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: boolColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          label,
                                                          style: TextStyle(
                                                            color: boolColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      _formatKey(e.key),
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Flexible(
                                                    child: Text(
                                                      _formatPayloadValue(
                                                          e.value),
                                                      textAlign:
                                                          TextAlign.right,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                  ],
                                );
                              }),
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
        DateTime.parse(scheduledTime.utc!),
        DateTime.parse(revisedTime.utc!),
      );
    }
    return null;
  }
}

Duration getDelay(DateTime scheduled, DateTime predicted) {
  // Positive duration => delayed; negative duration => early; zero => on time
  return predicted.difference(scheduled);
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

// Helper class for chart data
class _ChartPosition {
  final double altitude;
  final double speed;
  final DateTime timestamp;

  _ChartPosition({
    required this.altitude,
    required this.speed,
    required this.timestamp,
  });
}
