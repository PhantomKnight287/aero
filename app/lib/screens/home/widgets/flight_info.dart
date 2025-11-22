import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/extensions/datetime.dart';
import 'package:aero/formatters/time.dart';
import 'package:aero/screens/home/widgets/flight_route_info.dart';
import 'package:aero/screens/home/widgets/shareable_flight_card.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class FlightInfoWidget extends StatefulWidget {
  final FlightResponseEntity info;
  final Function() onClose;
  final Function()? onRefreshTracking;
  final Function()? onRefreshFlightData;
  final Function()? onBookingDetails;
  final BuiltList<FlightPositionEntity> flightPositions;
  const FlightInfoWidget({
    super.key,
    required this.info,
    required this.onClose,
    this.onRefreshTracking,
    this.onRefreshFlightData,
    this.onBookingDetails,
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

  String _formatEnumName(String enumName) {
    return enumName
        .split('_')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
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

  Future<void> _shareFlightCard() async {
    try {
      // Capture screenshot
      final imageBytes = await _screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
          context,
          ShareableFlightCard(info: widget.info),
        ),
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

  Widget _buildBanner(
      BuildContext context, Color color, IconData icon, String title,
      [String? subtitle]) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
      ),
    );
  }

  Widget _buildFlightStatusBanner(BuildContext context) {
    final fa = widget.info.flightAwareData;
    if (fa?.cancelled == true) {
      return _buildBanner(
        context,
        Colors.red,
        Icons.cancel,
        'This flight has been cancelled',
      );
    }
    if (fa?.diverted == true) {
      return _buildBanner(
        context,
        Colors.amber,
        Icons.warning_amber_rounded,
        'This flight has been diverted',
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final arrival = widget.info.arrival;
    final departure = widget.info.departure;
    final codeshares = widget.info.flightAwareData?.codesharesIcao
            ?.where((code) => code.trim().isNotEmpty)
            .map((code) => code.trim())
            .toList(growable: false) ??
        const <String>[];
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
                        value: 'booking_details',
                        child: Row(
                          children: [
                            Icon(Icons.confirmation_number),
                            SizedBox(width: 8),
                            Text('Booking details'),
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
                        final airline = widget.info.airline;
                        final flightAwareData = widget.info.flightAwareData;
                        final departureAirport = departure.airport;
                        final arrivalAirport = widget.info.arrival.airport;
                        final departureDate = DateTime.parse(
                          (departure.revisedTime ?? departure.scheduledTime).utc,
                        );

                        final airlineIata = airline.iata ?? "";
                        final airlineIcao = airline.icao ?? "";
                        final flightNumberWithoutIata =
                            flightNumber.replaceFirst(airlineIata, '');
                        final flightNumberWithoutIcao =
                            flightNumber.replaceFirst(airlineIcao, '');

                        String? _fallbackIdent(
                          String? primary,
                          String carrier,
                          String strippedNumber,
                        ) {
                          if (primary != null && primary.isNotEmpty) {
                            return primary;
                          }
                          if (carrier.isEmpty) return null;
                          final number =
                              strippedNumber.isNotEmpty ? strippedNumber : flightNumber;
                          return "$carrier$number";
                        }

                        final identIata = _fallbackIdent(
                          flightAwareData?.identIata,
                          airlineIata,
                          flightNumberWithoutIata,
                        );

                        final identIcao = _fallbackIdent(
                          flightAwareData?.identIcao,
                          airlineIcao,
                          flightNumberWithoutIcao,
                        );

                        final departureAirportCode = departureAirport.iata.isNotEmpty
                            ? departureAirport.iata
                            : departureAirport.icao;
                        final arrivalAirportCode = arrivalAirport.iata.isNotEmpty
                            ? arrivalAirport.iata
                            : arrivalAirport.icao;
                        final departureCity = departureAirport.municipalityName.isNotEmpty
                            ? departureAirport.municipalityName
                            : departureAirport.name;
                        final arrivalCity = arrivalAirport.municipalityName.isNotEmpty
                            ? arrivalAirport.municipalityName
                            : arrivalAirport.name;

                        final payload = {
                          "flight": {
                            "id": widget.info.id,
                            "flightNo": flightNumber,
                            "identIata": identIata,
                            "identIcao": identIcao,
                            "date": departureDate.toIso8601String(),
                            "departureAirportIata": departureAirportCode,
                            "departureCity": departureCity,
                            "arrivalAirportIata": arrivalAirportCode,
                            "arrivalCity": arrivalCity,
                          },
                          "airline": {
                            "name": airline.name,
                            "iata": airline.iata,
                            "icao": airline.icao,
                            "image": airline.image,
                          },
                        };

                        await channel.invokeMethod("registerFlight", payload);
                        print(payload);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Flight sent to wearable'),
                          ),
                        );
                      }
                      if (value == "refresh_flight_data") {
                        widget.onRefreshFlightData?.call();
                      }
                      if (value == "share") {
                        _shareFlightCard();
                      }
                      if (value == "booking_details") {
                        widget.onBookingDetails?.call();
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
          if ((widget.info.flightAwareData?.cancelled == true) ||
              (widget.info.flightAwareData?.diverted == true)) ...[
            _buildFlightStatusBanner(context),
            Gap(8),
          ],
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
          Column(
            children: [
              _buildTimezonePill(
                context: context,
                arrival: arrival,
                departure: departure,
              ),
              if (codeshares.isNotEmpty) ...[
                const Gap(8),
                _buildCodesharePill(context, codeshares),
              ],
            ],
          ),
          // Booking Details Section
          if (widget.info.bookings != null &&
              widget.info.bookings!.isNotEmpty) ...[
            Gap(8),
            Text(
              "Booking Details",
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
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(
                  top: 0,
                  bottom: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    Builder(builder: (context) {
                      final booking = widget.info.bookings!.first;

                      // Extract string values from JsonObject
                      String? _extractString(dynamic jsonObject) {
                        if (jsonObject == null) return null;
                        if (jsonObject is String) return jsonObject;
                        try {
                          final value = (jsonObject as dynamic).value;
                          if (value is String) return value;
                          return value?.toString();
                        } catch (e) {
                          return jsonObject.toString();
                        }
                      }

                      final bookingCode = _extractString(booking.bookingCode);
                      final seatNumber = _extractString(booking.seatNumber);
                      final seatingClass = booking.seatingClass?.name;
                      final seatType = booking.seatType?.name;
                      final reason = booking.reason?.name;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (bookingCode != null && bookingCode.isNotEmpty)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.confirmation_number),
                              title: Text(
                                'Booking Code: $bookingCode',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (seatNumber != null && seatNumber.isNotEmpty)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.event_seat),
                              title: Text(
                                'Seat: $seatNumber${seatType != null ? ' (${_formatEnumName(seatType)})' : ''}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (seatingClass != null)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.airline_seat_recline_normal),
                              title: Text(
                                'Class: ${_formatEnumName(seatingClass)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (reason != null)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.flight_takeoff),
                              title: Text(
                                'Reason: ${_formatEnumName(reason)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
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

  Widget _buildTimezonePill({
    required BuildContext context,
    required RouteInfoEntity arrival,
    required RouteInfoEntity departure,
  }) {
    final arrivalTime = _resolveEventTime(arrival);
    if (arrivalTime == null) {
      return const SizedBox.shrink();
    }

    final use24Hrs = MediaQuery.of(context).alwaysUse24HourFormat;
    final arrivalTz = _sanitizeTimezone(arrival.airport.timeZone);
    final departureTz = _sanitizeTimezone(departure.airport.timeZone);
    final arrivalLocal =
        arrivalTime.toTimezoneString(arrivalTz, use24Hrs: use24Hrs);
    final arrivalInDeparture =
        arrivalTime.toTimezoneString(departureTz, use24Hrs: use24Hrs);
    final diff = getTimezoneDifference(arrivalTz, departureTz);

    final arrivalLabel = _formatAirportLabel(arrival.airport);
    final departureLabel = _formatAirportLabel(departure.airport);

    final diffTitle = _formatDiffTitle(diff);
    final subtitle = diff == 'same timezone'
        ? "$arrivalLocal arrival in $arrivalLabel also reads $arrivalLocal in $departureLabel"
        : "$arrivalLocal arrival in $arrivalLabel is $arrivalInDeparture ${_airportCity(departure.airport)} time";

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              MdiIcons.clockOutline,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  diffTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(
                        theme.brightness == Brightness.dark ? 0.8 : 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodesharePill(
    BuildContext context,
    List<String> codeshares,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withOpacity(0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.flight_takeoff,
              size: 18,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                const Text(
                  "Codeshare flight",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Also sold as ${codeshares.join(", ")}",
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(
                        theme.brightness == Brightness.dark ? 0.8 : 0.7),
                  ),
                ),
                Text(
                  "Same aircraft, different partner airline numbers.",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color?.withOpacity(
                        theme.brightness == Brightness.dark ? 0.7 : 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime? _resolveEventTime(RouteInfoEntity segment) {
    final candidate =
        segment.revisedTime ?? segment.predictedTime ?? segment.scheduledTime;
    try {
      return DateTime.parse(candidate.utc).toUtc();
    } catch (_) {
      return null;
    }
  }

  String _formatAirportLabel(RouteAirportEntity airport) {
    final code = _airportCode(airport);
    if (code.isEmpty) return airport.name;
    return "${airport.name} ($code)";
  }

  String _airportCode(RouteAirportEntity airport) {
    return airport.iata.isNotEmpty ? airport.iata : airport.icao;
  }

  String _sanitizeTimezone(String timezone) {
    return timezone.trim().isEmpty ? 'UTC' : timezone;
  }

  String _formatDiffTitle(String diff) {
    if (diff == 'same timezone') {
      return "No Timezone Change";
    }
    final sign = diff.startsWith('-') ? '-' : '+';
    final remainder = diff.substring(1).trim();
    final normalized = remainder
        .replaceAll('hrs', 'Hours')
        .replaceAll('hr', 'Hour')
        .replaceAll('mins', 'Minutes')
        .replaceAll('min', 'Minute');
    return "$sign$normalized Timezone Change";
  }

  String _airportCity(RouteAirportEntity airport) {
    return airport.municipalityName.isNotEmpty
        ? airport.municipalityName
        : airport.shortName ?? airport.name;
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

// ignore: unused_element
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
