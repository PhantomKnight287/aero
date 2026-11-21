import 'dart:io';
import 'package:aero/screens/home/widgets/flight_timetable.dart';
import 'package:aero/screens/home/widgets/timezone_shift.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:provider/provider.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/services/alerts_service.dart';
import 'package:aero/utils/error.dart';
import 'package:aero/formatters/time.dart';
import 'package:aero/screens/home/widgets/aircraft_section.dart';
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
  final AircraftHistoryEntity? aircraftHistory;
  final BuiltList<AircraftLegEntity>? recentLegs;
  final bool recentLegsLoading;
  final VoidCallback? onLoadRecentLegs;
  final OpenFlight? onOpenFlight;
  const FlightInfoWidget({
    this.aircraftHistory,
    this.recentLegs,
    this.recentLegsLoading = false,
    this.onLoadRecentLegs,
    this.onOpenFlight,
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
  final ScreenshotController _screenshotController = ScreenshotController();

  String _formatEnumName(String enumName) {
    return enumName
        .split('_')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  /// Opt this device into push alerts for the flight: request notification
  /// permission, then register the OneSignal subscription ID with the backend.
  Future<void> _setupFlightAlerts() async {
    try {
      final accepted = await OneSignal.Notifications.requestPermission(true);
      if (!accepted) {
        showErrorToast('Enable notifications to get flight alerts.');
        return;
      }

      final playerId = OneSignal.User.pushSubscription.id;
      if (playerId == null || playerId.isEmpty) {
        showErrorToast('Could not register this device. Please try again.');
        return;
      }

      await alertsService.subscribe(widget.info.id, playerId);
      showSuccessToast(
        description: "You'll be notified of changes to this flight.",
      );
    } catch (e) {
      showErrorToast(e);
    }
  }

  Future<void> _shareFlightCard() async {
    try {
      // Capture screenshot
      final imageBytes = await _screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
          context,
          MediaQuery(
            data: MediaQuery.of(context),
            child: ShareableFlightCard(
              info: widget.info,
              distanceUnit: context.read<UnitsNotifier>().distance,
              timeMode: context.read<UnitsNotifier>().time,
            ),
          ),
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: subtitle != null ? 4 : 0,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha:
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

  Widget _buildFlightStatusBanner(BuildContext context) {
    final fa = widget.info.flightAwareData;
    if (fa?.cancelled == true) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flight Cancelled',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Contact your airline',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
              ),
            ),
          ],
        ),
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
          if (DateTime.now().difference(widget.info.date).inDays > 7)
            _buildBanner(
              context,
              Colors.orange,
              Icons.history,
              'Flight data may be inaccurate',
              'This flight is more than 7 days old. Times and status may no longer be updated.',
            ),
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://www.flightaware.com/images/airline_logos/180px/${widget.info.airline.icao}.png",
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
                        value: 'get_alerts',
                        child: Row(
                          children: [
                            Icon(Icons.notifications_active),
                            SizedBox(width: 8),
                            Text('Get alerts'),
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
                          (departure.revisedTime ?? departure.scheduledTime)
                              .utc,
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
                          final number = strippedNumber.isNotEmpty
                              ? strippedNumber
                              : flightNumber;
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

                        final departureAirportCode =
                            departureAirport.iata.isNotEmpty
                                ? departureAirport.iata
                                : departureAirport.icao;
                        final arrivalAirportCode =
                            arrivalAirport.iata.isNotEmpty
                                ? arrivalAirport.iata
                                : arrivalAirport.icao;
                        final departureCity =
                            departureAirport.municipalityName.isNotEmpty
                                ? departureAirport.municipalityName
                                : departureAirport.name;
                        final arrivalCity =
                            arrivalAirport.municipalityName.isNotEmpty
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
                      if (value == "get_alerts") {
                        await _setupFlightAlerts();
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
          if (widget.info.flightAwareData?.cancelled != true)
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
              TimezoneShift(departure: departure, arrival: arrival),
              if (codeshares.isNotEmpty) ...[
                const Gap(8),
                _buildCodesharePill(context, codeshares),
              ],
            ],
          ),
          // Flight Timetable Section
          if (widget.info.flightAwareData != null) ...[
            const SizedBox(height: AeroSpace.sm),
            FlightTimetable(
              key: ValueKey('timetable-${widget.info.id}'),
              fa: widget.info.flightAwareData!,
              departureTz: departure.airport.timeZone,
              arrivalTz: arrival.airport.timeZone,
            ),
          ],
          // Airport Conditions Section
          _buildAirportConditionsSection(context),
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
          AircraftSection(
            info: widget.info,
            history: widget.aircraftHistory,
            recent: widget.recentLegs?.toList(),
            recentLoading: widget.recentLegsLoading,
            onLoadRecent: widget.onLoadRecentLegs,
            onOpenFlight: widget.onOpenFlight,
          ),
          // Jet2 Holiday Meme
          if (widget.info.airline.icao == 'EXS' &&
              widget.info.airline.iata == 'LS') ...[
            const Gap(16),
            _buildJet2Meme(context),
          ],
        ],
      ),
    );
  }

  Widget _buildJet2Meme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Center(
        child: Text(
          'Nothing beats a Jet2 holiday',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: isDark ? Colors.grey[700] : Colors.grey[500],
          ),
        ),
      ),
    );
  }

  Widget _buildAirportConditionsSection(BuildContext context) {
    final departure = widget.info.departure;
    final arrival = widget.info.arrival;
    final depConditions = departure.airport.conditions;
    final arrConditions = arrival.airport.conditions;

    final depHas = _hasConditions(depConditions);
    final arrHas = _hasConditions(arrConditions);
    if (!depHas && !arrHas) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        const Text(
          'Airport Conditions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Gap(4),
        if (depHas)
          _buildAirportConditionsCard(
            context,
            label: 'Departure — ${_airportCode(departure.airport)}',
            conditions: depConditions!,
          ),
        if (depHas && arrHas) const Gap(8),
        if (arrHas)
          _buildAirportConditionsCard(
            context,
            label: 'Arrival — ${_airportCode(arrival.airport)}',
            conditions: arrConditions!,
          ),
      ],
    );
  }

  bool _hasConditions(dynamic conditions) {
    if (conditions == null) return false;
    return conditions.delays != null ||
        conditions.forecast != null ||
        conditions.observation != null;
  }

  Widget _buildAirportConditionsCard(
    BuildContext context, {
    required String label,
    required AirportConditionsEntity conditions,
  }) {
    final theme = Theme.of(context);
    final delays = conditions.delays;
    final observation = conditions.observation;
    final forecast = conditions.forecast;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          if (delays != null) ...[
            const Gap(8),
            _buildDelayRow(context, delays),
          ],
          if (observation != null) ...[
            const Gap(8),
            _buildObservationRow(context, observation),
          ],
          if (forecast != null) ...[
            const Gap(8),
            _buildForecastRow(context, forecast),
          ],
        ],
      ),
    );
  }

  Color _delayColor(String? wireColor) {
    switch (wireColor) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.orange;
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatSecondsAsDuration(int seconds) {
    final mins = (seconds / 60).round();
    if (mins < 60) return '${mins}m';
    final hours = mins ~/ 60;
    final remainder = mins % 60;
    if (remainder == 0) return '${hours}h';
    return '${hours}h ${remainder}m';
  }

  Widget _buildDelayRow(BuildContext context, dynamic delays) {
    final theme = Theme.of(context);
    final color = _delayColor(delays.color?.name ?? delays.color?.toString());
    final delaySecs = (int.tryParse(delays.delaySecs.toString())) ?? 0;
    final duration = _formatSecondsAsDuration(delaySecs);
    final category = (delays.category as String?) ?? 'unknown';
    final reasons = (delays.reasons as Iterable?)
            ?.map((r) => r.reason?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        const <String>[];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.timer_outlined, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Delay',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      duration,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Cause: ${_formatEnumName(category)}',
                style: TextStyle(
                  fontSize: 12,
                  color:
                      theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                ),
              ),
              if (reasons.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    reasons.join(' • '),
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildObservationRow(
      BuildContext context, AirportWeatherObservationEntity observation) {
    final theme = Theme.of(context);
    final tempAir = int.tryParse(observation.tempAir.toString());
    final tempPerceived = int.tryParse(observation.tempPerceived.toString());
    final windFriendly = observation.windFriendly as String?;
    final cloudFriendly = observation.cloudFriendly?.toString() ?? '';
    final conditions = observation.conditions?.toString() ?? '';
    final visibility = int.tryParse(observation.visibility.toString());
    final visibilityUnits = observation.visibilityUnits?.toString() ?? '';

    final parts = <String>[];
    if (tempAir != null) {
      final tu = context.watch<UnitsNotifier>().temperature;
      parts.add(tempPerceived != null && tempPerceived != tempAir
          ? '${formatTemp(tempAir, tu)} (feels ${formatTemp(tempPerceived, tu)})'
          : formatTemp(tempAir, tu));
    }
    if (windFriendly != null && windFriendly.isNotEmpty)
      parts.add(windFriendly);
    if (cloudFriendly != null && cloudFriendly.isNotEmpty)
      parts.add(cloudFriendly);
    if (conditions != null && conditions.isNotEmpty) parts.add(conditions);
    if (visibility != null) {
      final unit = (visibilityUnits == null || visibilityUnits.isEmpty)
          ? ''
          : ' $visibilityUnits';
      parts.add('Visibility $visibility$unit');
    }

    if (parts.isEmpty) return const SizedBox.shrink();
    final weatherText = Text(
      parts.join(' • '),
      style: TextStyle(
        fontSize: 12,
        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Symbols.partly_cloudy_day,
            size: 18,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current weather',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              const SizedBox(height: 2),
              if (tempAir != null)
                // Leads with the temperature: tap switches °C/°F.
                UnitCycle(
                  dimension: UnitDimension.temperature,
                  builder: (_, __) => weatherText,
                )
              else
                weatherText,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForecastRow(BuildContext context, dynamic forecast) {
    final theme = Theme.of(context);
    final raw = (forecast.rawForecast as Iterable?)
        ?.map((e) => e.toString())
        .where((s) => s.isNotEmpty)
        .toList();
    final headline = (raw != null && raw.isNotEmpty) ? raw.first : null;

    if (headline == null) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Symbols.wb_twilight,
            size: 18,
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forecast (TAF)',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                headline,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color:
                      theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
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
          color: theme.dividerColor.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.18),
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
                    color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: theme.brightness == Brightness.dark ? 0.8 : 0.7),
                  ),
                ),
                Text(
                  "Same aircraft, different partner airline numbers.",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: theme.brightness == Brightness.dark ? 0.7 : 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _airportCode(RouteAirportEntity airport) {
    return airport.iata.isNotEmpty ? airport.iata : airport.icao;
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
