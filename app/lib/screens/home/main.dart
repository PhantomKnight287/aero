import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/screens/home/home_controller.dart';
import 'package:aero/screens/home/widgets/animated_flight_info_bar.dart';
import 'package:aero/screens/home/widgets/date_selection_list.dart';
import 'package:aero/screens/home/widgets/booking_details_sheet.dart';
import 'package:aero/screens/home/widgets/flight_info.dart';
import 'package:aero/screens/home/widgets/flight_map.dart';
import 'package:aero/screens/home/widgets/flight_search_bar.dart';
import 'package:aero/screens/home/widgets/flight_selection_list.dart';
import 'package:aero/screens/home/widgets/flights_list.dart';
import 'package:aero/screens/home/widgets/refresh_countdown_timer.dart';
import 'package:aero/screens/home/widgets/search_header.dart';
import 'package:aero/screens/home/widgets/search_results_list.dart';
import 'package:aero/screens/home/widgets/selected_filters.dart';
import 'package:aero/screens/home/widgets/tracked_flights_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final HomeController _homeController;
  late final AnimatedMapController _mapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );
  final DraggableScrollableController _bottomSheetController =
      DraggableScrollableController();
  LatLng? _lastAnimatedPosition;
  FlightResponseEntity? _lastFlightInfo;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController();
    _homeController.addListener(_handleControllerUpdate);
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    _homeController.initialize();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0) {
      _bottomSheetController.animateTo(
        0.75,
        duration: const Duration(
          milliseconds: 150,
        ),
        curve: Curves.easeInOut,
      );
    } else {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bottomSheetController.dispose();
    _homeController.removeListener(_handleControllerUpdate);
    _homeController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _handleControllerUpdate() {
    final hasNewFlight =
        _homeController.flightInfo?.id != _lastFlightInfo?.id &&
            _homeController.flightInfo != null;
    setState(() {});
    _maybeAnimateMap(hasNewFlight);
    if (hasNewFlight) {
      _expandBottomSheet();
      _lastFlightInfo = _homeController.flightInfo;
    }
  }

  void _expandBottomSheet() {
    _bottomSheetController.animateTo(
      0.75,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _maybeAnimateMap(bool flightChanged) {
    final position = _homeController.currentPosition;
    if (position != null) {
      final target = LatLng(
        position.latitude.toDouble(),
        position.longitude.toDouble(),
      );
      final shouldAnimate = _lastAnimatedPosition == null ||
          _lastAnimatedPosition!.latitude != target.latitude ||
          _lastAnimatedPosition!.longitude != target.longitude;
      if (shouldAnimate) {
        _mapController.animateTo(dest: target);
        _lastAnimatedPosition = target;
      }
      return;
    }

    if (flightChanged &&
        _homeController.coordinates.length == 2 &&
        _homeController.coordinates[1] != _lastAnimatedPosition) {
      final destination = _homeController.coordinates[1];
      _mapController.animateTo(dest: destination);
      _lastAnimatedPosition = destination;
    }
  }

  void _showBookingDetailsSheet() {
    final info = _homeController.flightInfo;
    if (info == null) return;

    // Get the first booking if it exists
    final existingBooking = info.bookings != null && info.bookings!.isNotEmpty
        ? info.bookings!.first
        : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookingDetailsSheet(
        flightId: info.id,
        existingBooking: existingBooking,
        onSaved: () {
          // Refresh flight data to get updated booking
          _homeController.loadFlightInfo(
            info.flightNo,
            info.flightNo,
            info.date.toLocal(),
            forceUpdate: true,
          );
        },
        onDeleted: () {
          // Refresh flight data after deletion
          _homeController.loadFlightInfo(
            info.flightNo,
            info.flightNo,
            info.date.toLocal(),
            forceUpdate: true,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _homeController;
    final isSelectingFlight =
        controller.panelState == FlightPanelState.selectingFlight &&
            controller.flightSearchResults != null;
    final isShowingFlight =
        controller.panelState == FlightPanelState.showingFlight &&
            controller.flightInfo != null;
    final isLoadingFlight =
        controller.panelState == FlightPanelState.loadingFlight;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.20,
            child: FlightMap(
              mapController: _mapController,
              arrivalAirport: controller.arrivalAirport,
              departureAirport: controller.departureAirport,
              coordinates: controller.coordinates,
              flightTrackPoints: controller.flightTrackPoints,
              currentHeading: controller.currentPosition?.heading?.toDouble(),
              onAircraftSelected: controller.onAircraftSelected,
              isFlightInAir: controller.isInAir,
            ),
          ),
          if (controller.isTrackingActive)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 10,
              child: RefreshCountdownTimer(
                secondsRemaining: controller.secondsUntilNextUpdate,
              ),
            ),
          if (controller.isInAir && controller.currentPosition != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              child: Center(
                child: AnimatedFlightInfoBar(
                  altitude:
                      (controller.currentPosition!.altitude * 100).toInt(),
                  speed: controller.currentPosition!.groundspeed.toInt(),
                  heading: controller.currentPosition!.heading?.toInt(),
                ),
              ),
            ),
          DraggableScrollableSheet(
            initialChildSize: .25,
            controller: _bottomSheetController,
            minChildSize: .25,
            builder: (context, scrollController) {
              return SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isSelectingFlight
                          ? _buildFlightSelection(controller)
                          : isShowingFlight
                              ? _buildFlightInfoCard(controller, context)
                              : isLoadingFlight
                                  ? _buildFlightInfoSkeleton()
                                  : _buildSearchContent(
                                      controller,
                                      context,
                                    ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFlightSelection(HomeController controller) {
    return FlightSelectionList(
      flights: controller.flightSearchResults!.flights,
      onFlightSelected: controller.handleFlightSelection,
      onClose: controller.closeFlightSelection,
    );
  }

  Widget _buildFlightInfoCard(
    HomeController controller,
    BuildContext context,
  ) {
    final info = controller.flightInfo!;
    return FlightInfoWidget(
      info: info,
      flightPositions: controller.flightPositions,
      onRefreshFlightData: () {
        controller.loadFlightInfo(
          info.flightNo,
          info.flightNo,
          info.date.toLocal(),
          forceUpdate: true,
        );
      },
      onClose: controller.clearFlightContext,
      onRefreshTracking: () {
        controller.refreshTracking();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tracking refreshed'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      onBookingDetails: _showBookingDetailsSheet,
    );
  }

  Widget _buildSearchContent(
    HomeController controller,
    BuildContext context,
  ) {
    final selectedAirline = controller.selectedAirline;
    final selectedFlightNumber = controller.selectedFlightNumber;
    final departureAirport = controller.departureAirport;
    final arrivalAirport = controller.arrivalAirport;
    final selectedDate = controller.selectedDate;
    final error = controller.error;
    final searchEnabled =
        !(departureAirport != null && arrivalAirport != null) &&
            !(selectedAirline != null && selectedFlightNumber != null);
    final showDateSelector =
        ((departureAirport != null && arrivalAirport != null) ||
                (selectedAirline != null && selectedFlightNumber != null)) &&
            (selectedDate == null || error != null);
    final flightController = controller.flightController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchHeader(),
        Row(
          children: [
            SelectedFilters(
              onAirlineClear: controller.clearAirline,
              onFlightNumberClear: controller.clearFlightNumber,
              onAirportsClear: controller.clearAirports,
              onDepartureAirportClear: controller.clearDepartureAirport,
              selectedAirline: selectedAirline,
              arrivalAirport: arrivalAirport,
              departureAirport: departureAirport,
              selectedFlightNumber: selectedFlightNumber,
            ),
            Expanded(
              child: FlightSearchBar(
                searchController: flightController,
                isSearchEnabled: searchEnabled,
                hintText: _buildSearchHint(controller),
                onSearchChanged: (value) {
                  if (departureAirport != null && arrivalAirport != null) {
                    return;
                  }
                  controller.clearError();
                  controller.debounceSearch(value);
                },
              ),
            ),
          ],
        ),
        const Gap(16),
        if (arrivalAirport == null &&
            departureAirport == null &&
            selectedAirline != null &&
            selectedFlightNumber == null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Tip: For flight numbers like 6E1045, just enter 1045",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        if (error != null) _buildErrorBanner(error),
        if (showDateSelector)
          DateSelectionList(
            onDateSelected: (date) => controller.loadFlightsForSelection(date),
          ),
        if (selectedAirline != null &&
            flightController.text.isNotEmpty &&
            selectedFlightNumber == null)
          ListTile(
            title: Text(selectedAirline.name),
            subtitle: Text(
              "${selectedAirline.iata}${flightController.text.toUpperCase()} / ${selectedAirline.icao}${flightController.text.toUpperCase()}",
            ),
            leading: selectedAirline.image != null &&
                    selectedAirline.image!.isNotEmpty
                ? SvgPicture.network(
                    selectedAirline.image!,
                    width: 24,
                    height: 18,
                  )
                : CachedNetworkImage(
                    imageUrl:
                        "https://www.flightaware.com/images/airline_logos/180px/${selectedAirline.icao}.png",
                    width: 24,
                    height: 18,
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
            onTap: () {
              controller.selectFlightNumber(flightController.text);
              FocusScope.of(context).unfocus();
            },
          ),
        SearchResultsList(
          results: controller.results,
          loading: controller.searchState == SearchState.loading,
          selectedAirline: selectedAirline,
          selectedFlightNumber: selectedFlightNumber,
          flightController: flightController,
          onAirportSelected: (airport) {
            controller.selectAirport(airport);
          },
          onAirlineSelected: (airline) {
            controller.selectAirline(
              airline,
              currentInput: flightController.text,
            );
          },
          onFlightNumberSelected: (flightNumber) {
            controller.selectFlightNumber(flightNumber);
            FocusScope.of(context).unfocus();
          },
        ),
        if (selectedAirline == null &&
            arrivalAirport == null &&
            departureAirport == null &&
            selectedFlightNumber == null &&
            controller.results.isEmpty &&
            controller.searchState == SearchState.idle &&
            !controller.loadingTrackedFlights &&
            controller.trackedFlights.isNotEmpty)
          TrackedFlightsList(
            trackedFlights: controller.trackedFlights,
            onFlightTap: (iata, icao, date, forceUpdate) =>
                controller.loadFlightInfo(
              iata,
              icao,
              date,
              forceUpdate: forceUpdate,
            ),
          ),
        FlightsList(
          flights: controller.flights,
          selectedDate: controller.selectedDate,
          onFlightTap: controller.loadFlightInfo,
        ),
      ],
    );
  }

  Widget _buildErrorBanner(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(12.0).copyWith(bottom: 0, top: 0),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.red[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 14,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
                color: Colors.red[900],
              ),
              onPressed: () {
                _homeController.clearError();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  String _buildSearchHint(HomeController controller) {
    if (controller.selectedFlightNumber != null) {
      return "Select date";
    }
    if (controller.selectedAirline != null &&
        controller.arrivalAirport == null &&
        controller.departureAirport == null) {
      return "Flight No";
    }
    if (controller.departureAirport == null) {
      return "Search airline, flight or airport";
    }
    if (controller.arrivalAirport == null) {
      return "Search arrival airport";
    }
    return "Select date";
  }

  Widget _buildFlightInfoSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          // Header skeleton
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(4),
                  Container(
                    width: 150,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          Divider(),
          // Time message skeleton
          Container(
            width: 180,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          // Route info skeleton
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(8),
                          Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(4),
                          Container(
                            width: 100,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(4),
                          Container(
                            width: 70,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(8),
                          Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(4),
                          Container(
                            width: 100,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Gap(4),
                          Container(
                            width: 70,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          // "Worth Noting" section skeleton
          Container(
            width: 100,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
