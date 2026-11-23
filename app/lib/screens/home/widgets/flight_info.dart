import 'dart:io';

import 'package:aero/constants/main.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/home/widgets/aircraft_section.dart';
import 'package:aero/screens/home/widgets/flight_profile.dart';
import 'package:aero/screens/home/widgets/flight_timetable.dart';
import 'package:aero/screens/home/widgets/shareable_flight_card.dart';
import 'package:aero/services/alerts_service.dart';
import 'package:aero/services/profile.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/error.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'flight_detail/booking_airline.dart';
import 'flight_detail/flight_status.dart';
import 'flight_detail/good_to_know.dart';
import 'flight_detail/header.dart';
import 'flight_detail/route_block.dart';
import 'flight_detail/route_history.dart';

/// Flight detail sheet, in Flighty's order: header, status, route block,
/// good to know, timetable, profile, aircraft, route history, booking,
/// airline.
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
  final ValueChanged<LatLng?>? onScrub;
  final ValueChanged<RouteAirportEntity>? onAirportTap;

  /// Defaults to [ProfileService.getRouteHistory].
  final Future<RouteHistoryEntity?> Function()? loadRouteHistory;

  /// Fixed clock for tests.
  final DateTime? now;

  const FlightInfoWidget({
    super.key,
    required this.info,
    required this.onClose,
    required this.flightPositions,
    this.onRefreshTracking,
    this.onRefreshFlightData,
    this.onBookingDetails,
    this.aircraftHistory,
    this.recentLegs,
    this.recentLegsLoading = false,
    this.onLoadRecentLegs,
    this.onOpenFlight,
    this.onScrub,
    this.onAirportTap,
    this.loadRouteHistory,
    this.now,
  });

  @override
  State<FlightInfoWidget> createState() => _FlightInfoWidgetState();
}

class _FlightInfoWidgetState extends State<FlightInfoWidget> {
  final _screenshotController = ScreenshotController();

  FlightResponseEntity get _info => widget.info;

  static String _code(RouteAirportEntity a) =>
      a.icao.isNotEmpty ? a.icao : a.iata;

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
      await alertsService.subscribe(_info.id, playerId);
      showSuccessToast(
          description: "You'll be notified of changes to this flight.");
    } catch (e) {
      showErrorToast(e);
    }
  }

  Future<void> _shareFlightCard() async {
    try {
      final units = context.read<UnitsNotifier>();
      final imageBytes = await _screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
          context,
          MediaQuery(
            data: MediaQuery.of(context),
            child: ShareableFlightCard(
              info: _info,
              distanceUnit: units.distance,
              timeMode: units.time,
            ),
          ),
        ),
        pixelRatio: 2.0,
        delay: const Duration(milliseconds: 100),
      );
      if (imageBytes.isEmpty) return;
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/flight_card_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);
      await Share.shareXFiles([XFile(file.path)], text: 'Check out my flight!');
    } catch (e) {
      showErrorToast('Failed to share flight card: $e');
    }
  }

  Future<void> _sendToWearable() async {
    final departure = _info.departure;
    final flightNumber = _info.flightNo;
    final airline = _info.airline;
    final fa = _info.flightAwareData;
    final depAirport = departure.airport;
    final arrAirport = _info.arrival.airport;
    final departureDate =
        DateTime.parse((departure.revisedTime ?? departure.scheduledTime).utc);
    final airlineIata = airline.iata ?? '';
    final airlineIcao = airline.icao ?? '';

    String? fallbackIdent(String? primary, String carrier, String stripped) {
      if (primary != null && primary.isNotEmpty) return primary;
      if (carrier.isEmpty) return null;
      return '$carrier${stripped.isNotEmpty ? stripped : flightNumber}';
    }

    String code(RouteAirportEntity a) => a.iata.isNotEmpty ? a.iata : a.icao;
    String city(RouteAirportEntity a) =>
        a.municipalityName.isNotEmpty ? a.municipalityName : a.name;

    final payload = {
      'flight': {
        'id': _info.id,
        'flightNo': flightNumber,
        'identIata': fallbackIdent(fa?.identIata, airlineIata,
            flightNumber.replaceFirst(airlineIata, '')),
        'identIcao': fallbackIdent(fa?.identIcao, airlineIcao,
            flightNumber.replaceFirst(airlineIcao, '')),
        'date': departureDate.toIso8601String(),
        'departureAirportIata': code(depAirport),
        'departureCity': city(depAirport),
        'arrivalAirportIata': code(arrAirport),
        'arrivalCity': city(arrAirport),
      },
      'airline': {
        'name': airline.name,
        'iata': airline.iata,
        'icao': airline.icao,
        'image': airline.image,
      },
    };
    try {
      await const MethodChannel(METHOD_CHANNEL)
          .invokeMethod('registerFlight', payload);
      showSuccessToast(description: 'Flight sent to wearable');
    } catch (e) {
      showErrorToast(e);
    }
  }

  List<FlightAction> get _actions => [
        if (widget.onRefreshTracking != null)
          FlightAction(
              Icons.refresh, 'Refresh tracking', widget.onRefreshTracking!),
        FlightAction(Icons.sync, 'Refresh flight data',
            () => widget.onRefreshFlightData?.call()),
        FlightAction(Icons.watch_outlined, 'Send to wearable', _sendToWearable),
        FlightAction(Icons.notifications_active_outlined, 'Get alerts',
            _setupFlightAlerts),
        FlightAction(Icons.confirmation_number_outlined, 'Booking details',
            () => widget.onBookingDetails?.call()),
        FlightAction(Icons.ios_share, 'Share', _shareFlightCard),
      ];

  Future<RouteHistoryEntity?> _loadHistory() =>
      ProfileService().getRouteHistory(
        dep: _code(_info.departure.airport),
        arr: _code(_info.arrival.airport),
        exclude: _info.id,
      );

  @override
  Widget build(BuildContext context) {
    final now = widget.now ?? DateTime.now();
    final status = flightStatus(_info, now);
    final dep = _info.departure.airport;
    final arr = _info.arrival.airport;
    final booking =
        _info.bookings?.isNotEmpty == true ? _info.bookings!.first : null;

    final sections = <Widget>[
      FlightHeader(
        info: _info,
        status: status,
        now: now,
        actions: _actions,
        onClose: widget.onClose,
      ),
      RouteBlock(
        info: _info,
        status: status,
        onAirportTap: widget.onAirportTap,
      ),
      GoodToKnow(info: _info, onAirportTap: widget.onAirportTap),
      if (_info.flightAwareData != null)
        FlightTimetable(
          key: ValueKey('timetable-${_info.id}'),
          fa: _info.flightAwareData!,
          departureTz: dep.timeZone,
          arrivalTz: arr.timeZone,
          callSign: _info.callSign,
        ),
      if (widget.flightPositions.length >= 20)
        FlightProfile(
          key: ValueKey('profile-${_info.id}'),
          positions: widget.flightPositions,
          departureTz: dep.timeZone,
          onScrub: (p) => widget.onScrub
              ?.call(p?.lat == null ? null : LatLng(p!.lat!, p.lon!)),
        ),
      AircraftSection(
        info: _info,
        history: widget.aircraftHistory,
        recent: widget.recentLegs?.toList(),
        recentLoading: widget.recentLegsLoading,
        onLoadRecent: widget.onLoadRecentLegs,
        onOpenFlight: widget.onOpenFlight,
      ),
      RouteHistorySection(
        key: ValueKey('history-${_info.id}'),
        route:
            '${dep.iata.isNotEmpty ? dep.iata : dep.icao} → ${arr.iata.isNotEmpty ? arr.iata : arr.icao}',
        load: widget.loadRouteHistory ?? _loadHistory,
        onOpenFlight: widget.onOpenFlight,
      ),
      if (booking != null) BookingSection(booking: booking),
      if (_info.airline.icao == 'EXS' && _info.airline.iata == 'LS')
        Center(
            child: Text('Nothing beats a Jet2 holiday', style: AeroText.micro)),
    ];

    return Padding(
      padding: const EdgeInsets.all(AeroSpace.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < sections.length; i++) ...[
            if (i > 0) SizedBox(height: i == 1 ? AeroSpace.lg : AeroSpace.xl),
            sections[i],
          ],
        ],
      ),
    );
  }
}
