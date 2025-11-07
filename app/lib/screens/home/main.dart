import 'dart:async';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/screens/home/service.dart';
import 'package:plane_pal/screens/home/widgets/animated_flight_info_bar.dart';
import 'package:plane_pal/screens/home/widgets/date_selection_list.dart';
import 'package:plane_pal/screens/home/widgets/flight_info.dart';
import 'package:plane_pal/screens/home/widgets/flight_map.dart';
import 'package:plane_pal/screens/home/widgets/flight_search_bar.dart';
import 'package:plane_pal/screens/home/widgets/flights_list.dart';
import 'package:plane_pal/screens/home/widgets/refresh_countdown_timer.dart';
import 'package:plane_pal/screens/home/widgets/search_header.dart';
import 'package:plane_pal/screens/home/widgets/search_results_list.dart';
import 'package:plane_pal/screens/home/widgets/selected_filters.dart';
import 'package:plane_pal/screens/home/widgets/tracked_flights_list.dart';
import 'package:plane_pal/services/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:gap/gap.dart';
import 'package:retry/retry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final _service = HomeService();
  late final _mapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );
  final TextEditingController _flightController = TextEditingController();
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  Timer? _debounce;
  Timer? _trackPollingTimer;
  Timer? _countdownTimer;
  int _secondsUntilNextUpdate = 30;
  bool loading = false;
  final FlightDataService _flightService = FlightDataService();
  bool isLoading = false;
  String? error;
  AirportEntity? departureAirport;
  AirportEntity? arrivalAirport;
  DateTime? selectedDate;
  BuiltList<FlightEntity> flights = BuiltList.from([]);
  List<Object> results = [];
  AirlineEntity? selectedAirline;
  String? selectedFlightNumber;
  FlightResponseEntity? _flightInfo;
  List<LatLng> coordinates = [];
  List<LatLng> flightTrackPoints = [];
  FlightPositionEntity? currentPosition;
  BuiltList<FlightResponseEntity> trackedFlights = BuiltList.from([]);
  bool loadingTrackedFlights = false;
  bool _isInAir = false;
  CancelToken? _cancelToken;

  bool _isPastFlight(dynamic positionTimestamp) {
    if (positionTimestamp == null) return false;
    DateTime? ts;
    if (positionTimestamp is DateTime) {
      ts = positionTimestamp.toUtc();
    } else if (positionTimestamp is String) {
      ts = DateTime.tryParse(positionTimestamp)?.toUtc();
    }
    if (ts == null) return false;
    final nowUtc = DateTime.now().toUtc();
    return nowUtc.difference(ts).inHours > 2;
  }

  void _updateInAirStatus([FlightPositionEntity? latestPosition]) {
    final pos = latestPosition ?? currentPosition;
    if (pos == null) {
      _isInAir = false;
      return;
    }
    final ts = pos.timestamp;
    final notPast = !_isPastFlight(ts);
    final altitudeOk = (pos.altitude) > 0;
    final speedOk = (pos.groundspeed) > 30;
    _isInAir = notPast && (altitudeOk || speedOk);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    _loadTrackedFlights();
    super.initState();
  }

  Future<void> _loadTrackedFlights() async {
    setState(() {
      loadingTrackedFlights = true;
    });
    try {
      final flights = await _flightService.getTrackedFlights();
      setState(() {
        trackedFlights = flights;
        loadingTrackedFlights = false;
      });
    } catch (e, stack) {
      print('Failed to load tracked flights: $e');
      print(stack);
      setState(() {
        loadingTrackedFlights = false;
      });
    }
  }

  Future<List<Object>> _search(String query) async {
    if (query.isEmpty || query.length == 1) return [];
    if (_cancelToken != null) {
      _cancelToken!.cancel("User is searching for new results");
    }
    _cancelToken = CancelToken();
    return _service.search(query, cancelToken: _cancelToken);
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0) {
      _controller.animateTo(
        0.75,
        duration: Duration(
          milliseconds: 150,
        ),
        curve: Curves.easeInOut,
      );
    } else {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _debounce?.cancel();
    _trackPollingTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startTrackPolling(String iata, String icao, DateTime date) {
    // Cancel existing timers if any
    _trackPollingTimer?.cancel();
    _countdownTimer?.cancel();

    // Reset countdown
    setState(() {
      _secondsUntilNextUpdate = 30;
    });

    // Start countdown timer that updates every second
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (_secondsUntilNextUpdate > 0) {
            _secondsUntilNextUpdate--;
          } else {
            _secondsUntilNextUpdate = 30;
          }
        });
      },
    );

    // Start polling every 30 seconds
    _trackPollingTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) async {
        try {
          setState(() {
            _secondsUntilNextUpdate = 30; // Reset countdown on each poll
          });

          // Retry up to 3 times with exponential backoff
          final trackData = await retry(
            () => _flightService.getFlightTrack(
              iata,
              icao,
              date: date,
            ),
            maxAttempts: 3,
            delayFactor: const Duration(seconds: 2),
            maxDelay: const Duration(seconds: 10),
            onRetry: (e) {
              print('Retrying flight track fetch after error: $e');
            },
          );

          if (trackData != null && trackData.positions.isNotEmpty) {
            setState(() {
              flightTrackPoints = trackData.positions
                  .map((pos) => LatLng(
                        pos.latitude.toDouble(),
                        pos.longitude.toDouble(),
                      ))
                  .toList();

              // Update the latest position
              currentPosition = trackData.positions.last;
              _updateInAirStatus(currentPosition);
            });
            // Stop polling if no longer airborne or if flight is past
            if (!_isInAir) {
              _stopTrackPolling();
            }
          }
        } catch (e) {
          print('Failed to poll flight track after 3 retries: $e');
          // Continue polling even if all retries fail
        }
      },
    );
  }

  void _stopTrackPolling() {
    _trackPollingTimer?.cancel();
    _trackPollingTimer = null;
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  Future<void> _loadFlightInfo(
    String iataCode,
    String icaoCode,
    DateTime date, {
    bool forceUpdate = false,
  }) async {
    loading = true;
    setState(() {});

    try {
      final info = await _flightService.getFlightInfoWithNumber(
        iataCode,
        icaoCode,
        date: date,
        forceUpdate: forceUpdate,
      );

      if (info == null) {
        setState(() {
          error = 'No flight information found';
          loading = false;
        });
        return;
      }

      coordinates = [
        LatLng(
          info.departure.airport.location.lat.toDouble(),
          info.departure.airport.location.lon.toDouble(),
        ),
        LatLng(
          info.arrival.airport.location.lat.toDouble(),
          info.arrival.airport.location.lon.toDouble(),
        ),
      ];

      // Fetch flight track data
      try {
        final trackData = await _flightService.getFlightTrack(
          iataCode,
          icaoCode,
          date: date,
        );

        if (trackData != null && trackData.positions.isNotEmpty) {
          flightTrackPoints = trackData.positions
              .map((pos) => LatLng(
                    pos.latitude.toDouble(),
                    pos.longitude.toDouble(),
                  ))
              .toList();

          currentPosition = trackData.positions.last;
          _updateInAirStatus(currentPosition);

          // Start polling for updates only if airborne
          if (_isInAir) {
            _startTrackPolling(iataCode, icaoCode, date);
          }
        }
      } catch (e, stack) {
        print(e);
        print(stack);
        print('Failed to fetch flight track: $e');
      }

      // Animate map to current position or destination
      _mapController.animateTo(
        dest: currentPosition != null
            ? LatLng(
                currentPosition!.latitude.toDouble(),
                currentPosition!.longitude.toDouble(),
              )
            : coordinates[1],
      );

      setState(() {
        _flightInfo = info;
      });

      // Expand the bottom sheet
      _controller.animateTo(
        0.75,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (e, stack) {
      print('Error loading flight: $e');
      print(stack);
      setState(() {
        error = 'Failed to load flight information: $e';
        selectedDate=null;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _onAircraftSelected(
      FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner
          aircraft) async {
    try {
      setState(() {
        loading = true;
        isLoading = true;
        error = null;
        _flightInfo = null;
        arrivalAirport = null;
        departureAirport = null;
        coordinates = [];
        flightTrackPoints = [];
        currentPosition = null;
        selectedDate = DateTime.now(); // Set to today
        selectedAirline = null;
        selectedFlightNumber = null;
        flights = BuiltList.from([]);
      });

      // Use ident_icao and ident_iata directly to get flight information
      if (aircraft.identIata?.isNotEmpty == true ||
          aircraft.identIcao?.isNotEmpty == true) {
        final iata = aircraft.identIata ?? '';
        final icao = aircraft.identIcao ?? '';

        // Get flight information using the flight identifiers
        final info = await _flightService.getFlightInfoWithNumber(
          iata,
          icao,
          date: selectedDate!,
        );

        if (info != null) {
          coordinates = [
            LatLng(
              info.departure.airport.location.lat.toDouble(),
              info.departure.airport.location.lon.toDouble(),
            ),
            LatLng(
              info.arrival.airport.location.lat.toDouble(),
              info.arrival.airport.location.lon.toDouble(),
            ),
          ];

          // Fetch flight track data
          try {
            final trackData = await _flightService.getFlightTrack(
              iata,
              icao,
              date: selectedDate!,
            );

            if (trackData != null && trackData.positions.isNotEmpty) {
              flightTrackPoints = trackData.positions
                  .map((pos) => LatLng(
                        pos.latitude.toDouble(),
                        pos.longitude.toDouble(),
                      ))
                  .toList();

              // Get the latest position (last in the list)
              currentPosition = trackData.positions.last;
              _updateInAirStatus(currentPosition);

              // Start polling for updates only if airborne
              if (_isInAir) {
                _startTrackPolling(iata, icao, selectedDate!);
              }
            }
          } catch (e) {
            print('Failed to fetch flight track: $e');
            // Continue without track data
          }

          // Animate map to show the current flight location or route midpoint
          _mapController.animateTo(
            dest: currentPosition != null
                ? LatLng(
                    currentPosition!.latitude.toDouble(),
                    currentPosition!.longitude.toDouble(),
                  )
                : LatLng(
                    (info.departure.airport.location.lat.toDouble() +
                            info.arrival.airport.location.lat.toDouble()) /
                        2,
                    (info.departure.airport.location.lon.toDouble() +
                            info.arrival.airport.location.lon.toDouble()) /
                        2,
                  ),
          );

          setState(() {
            _flightInfo = info;
            departureAirport = AirportEntity((b) => b
              ..ident = info.departure.airport.iata
              ..iataCode = info.departure.airport.iata
              ..name = info.departure.airport.name
              ..lat = info.departure.airport.location.lat.toString()
              ..long = info.departure.airport.location.lon.toString()
              ..isoCountry = info.departure.airport.countryCode
              ..type = AirportType.largeAirport
              ..build());

            arrivalAirport = AirportEntity((b) => b
              ..ident = info.arrival.airport.iata
              ..iataCode = info.arrival.airport.iata
              ..name = info.arrival.airport.name
              ..lat = info.arrival.airport.location.lat.toString()
              ..long = info.arrival.airport.location.lon.toString()
              ..isoCountry = info.arrival.airport.countryCode
              ..type = AirportType.largeAirport
              ..build());
          });

          // Expand the bottom sheet to show flight details
          _controller.animateTo(
            0.75,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          setState(() {
            error =
                'No flight information found for ${aircraft.identIata ?? aircraft.identIcao ?? "unknown flight"}';
          });
        }
      } else {
        setState(() {
          error = 'No flight identifiers available';
        });
      }
    } catch (e, stack) {
      print('Error handling aircraft selection: $e');
      print(stack);
      setState(() {
        error = 'Failed to load flight information: $e';
      });
    } finally {
      setState(() {
        loading = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.20,
            child: FlightMap(
              mapController: _mapController,
              arrivalAirport: arrivalAirport,
              departureAirport: departureAirport,
              coordinates: coordinates,
              flightTrackPoints: flightTrackPoints,
              currentHeading: currentPosition?.heading?.toDouble(),
              onAircraftSelected: _onAircraftSelected,
              isFlightInAir: _isInAir,
            ),
          ),
          // Countdown timer at top right
          if (_trackPollingTimer != null && _trackPollingTimer!.isActive)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 10,
              child: RefreshCountdownTimer(
                secondsRemaining: _secondsUntilNextUpdate,
              ),
            ),

          if (_isInAir && currentPosition != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              child: Center(
                child: AnimatedFlightInfoBar(
                  altitude: (currentPosition!.altitude * 100).toInt(),
                  speed: currentPosition!.groundspeed.toInt(),
                  heading: currentPosition!.heading?.toInt(),
                ),
              ),
            ),

          DraggableScrollableSheet(
            initialChildSize: .25,
            controller: _controller,
            minChildSize: .25,
            builder: (BuildContext context, myscrollController) {
              return SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    controller: myscrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: _flightInfo != null
                          ? FlightInfoWidget(
                              info: _flightInfo!,
                              onRefreshFlightData: () {
                                _loadFlightInfo(
                                  _flightInfo!.flightNo,
                                  _flightInfo!.flightNo,
                                  _flightInfo!.date.toLocal(),
                                  forceUpdate: true,
                                );
                              },
                              onClose: () {
                                _stopTrackPolling();
                                setState(() {
                                  _flightInfo = null;
                                  arrivalAirport = null;
                                  departureAirport = null;
                                  coordinates = [];
                                  flightTrackPoints = [];
                                  currentPosition = null;
                                  selectedDate = null;
                                  selectedAirline = null;
                                  selectedFlightNumber = null;
                                  flights = BuiltList.from([]);
                                  error = null;
                                  isLoading = false;
                                  loading = false;
                                  _flightController.clear();
                                });
                              },
                              onRefreshTracking: () {
                                _stopTrackPolling();

                                final flightNo = _flightInfo!.flightNo;
                                final date = _flightInfo!.date.toLocal();

                                _startTrackPolling(
                                  flightNo,
                                  flightNo,
                                  date,
                                );

                                // Show a snackbar to confirm
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Tracking refreshed'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SearchHeader(),
                                Row(
                                  children: [
                                    SelectedFilters(
                                      onAirlineClear: () {
                                        selectedAirline = null;
                                        setState(() {});
                                      },
                                      onFlightNumberClear: () {
                                        selectedFlightNumber = null;
                                        setState(() {});
                                      },
                                      onAirportsClear: () {
                                        arrivalAirport = null;
                                        departureAirport = null;
                                        setState(() {});
                                      },
                                      onDepartureAirportClear: () {
                                        departureAirport = null;
                                        setState(() {});
                                      },
                                      selectedAirline: selectedAirline,
                                      arrivalAirport: arrivalAirport,
                                      departureAirport: departureAirport,
                                      selectedFlightNumber:
                                          selectedFlightNumber,
                                    ),
                                    Expanded(
                                      child: FlightSearchBar(
                                        searchController: _flightController,
                                        isSearchEnabled: !(arrivalAirport !=
                                                    null &&
                                                departureAirport != null) &&
                                            !(selectedAirline != null &&
                                                selectedFlightNumber != null),
                                        hintText: selectedFlightNumber != null
                                            ? "Select date"
                                            : selectedAirline != null &&
                                                    arrivalAirport == null &&
                                                    departureAirport == null
                                                ? "Flight No"
                                                : departureAirport == null
                                                    ? "Search airline, flight or airport"
                                                    : arrivalAirport == null
                                                        ? "Search arrival airport"
                                                        : "Select date",
                                        onSearchChanged: (p0) async {
                                          if (arrivalAirport != null &&
                                              departureAirport != null) return;
                                          if (_debounce?.isActive ?? false) {
                                            _debounce?.cancel();
                                          }
                                          if (selectedAirline != null) {
                                            setState(() {});
                                            return null;
                                          }
                                          _debounce = Timer(
                                              const Duration(
                                                milliseconds: 300,
                                              ), () async {
                                            loading = true;
                                            results = [];
                                            setState(() {});
                                            results = await _search(p0);
                                            loading = false;
                                            setState(() {});
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(16),
                                if (arrivalAirport == null &&
                                    departureAirport == null &&
                                    selectedAirline != null &&
                                    selectedFlightNumber == null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "Tip: For flight numbers like 6E1045, just enter 1045",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                if (((arrivalAirport != null &&
                                            departureAirport != null) ||
                                        (selectedAirline != null &&
                                            selectedFlightNumber != null)) &&
                                    selectedDate == null)
                                  DateSelectionList(
                                    onDateSelected: (date) async {
                                      loading = true;
                                      selectedDate = date;
                                      flights = BuiltList.from([]);
                                      setState(() {});
                                      try {
                                        if (arrivalAirport != null &&
                                            departureAirport != null) {
                                          flights =
                                              await _flightService.getFlights(
                                            departureAirport!.iataCode ??
                                                departureAirport!.ident,
                                            arrivalAirport!.iataCode ??
                                                arrivalAirport!.ident,
                                            date.toIso8601String(),
                                          );
                                        } else {
                                          await _loadFlightInfo(
                                            "${selectedAirline!.iata}$selectedFlightNumber",
                                            "${selectedAirline!.icao}$selectedFlightNumber",
                                            date,
                                          );
                                        }
                                      } catch (e, stack) {
                                        print(e);
                                        print(stack);
                                        setState(() {
                                          selectedDate = null;
                                        });
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                  ),
                                if (selectedAirline != null &&
                                    _flightController.text.isNotEmpty &&
                                    selectedFlightNumber == null)
                                  ListTile(
                                    title: Text(
                                      selectedAirline!.name,
                                    ),
                                    subtitle: Text(
                                      "${selectedAirline!.iata}${_flightController.text.toUpperCase()} / ${selectedAirline!.icao}${_flightController.text.toUpperCase()}",
                                    ),
                                    leading: selectedAirline!.image != null &&
                                            selectedAirline!.image!.isNotEmpty
                                        ? SvgPicture.network(
                                            selectedAirline!.image!,
                                            width: 24,
                                            height: 18,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "https://airlabs.co/img/airline/m/${selectedAirline!.iata}.png",
                                            width: 24,
                                            height: 18,
                                            errorWidget: (context, url, error) {
                                              return SizedBox(
                                                height: 0,
                                                width: 0,
                                              );
                                            },
                                          ),
                                    onTap: () {
                                      selectedFlightNumber =
                                          _flightController.text;
                                      FocusScope.of(context).unfocus();
                                      _flightController.clear();
                                      setState(() {});
                                    },
                                  ),
                                SearchResultsList(
                                  results: results,
                                  loading: loading,
                                  selectedAirline: selectedAirline,
                                  selectedFlightNumber: selectedFlightNumber,
                                  flightController: _flightController,
                                  onAirportSelected: (airport) {
                                    if (departureAirport == null) {
                                      departureAirport = airport;
                                    } else {
                                      arrivalAirport = airport;
                                    }
                                    
                                    _flightController.clear();
                                    results.clear();
                                    setState(() {});
                                  },
                                  onAirlineSelected: (airline) {
                                    selectedAirline = airline;
                                    final text = _flightController.text;

                                    if (!((text
                                                .replaceFirst(airline.iata, "")
                                                .length ==
                                            text.length) ||
                                        (text
                                                .replaceFirst(airline.icao, "")
                                                .length ==
                                            text.length))) {
                                      _flightController.text = _flightController
                                          .text
                                          .replaceFirst(airline.icao, '');
                                    } else {
                                      _flightController.clear();
                                    }

                                    results.clear();
                                    setState(() {});
                                  },
                                  onFlightNumberSelected: (flightNumber) {
                                    selectedFlightNumber = flightNumber;
                                    FocusScope.of(context).unfocus();
                                    _flightController.clear();
                                    setState(() {});
                                  },
                                ),
                                if (selectedAirline == null &&
                                    arrivalAirport == null &&
                                    departureAirport == null &&
                                    selectedFlightNumber == null &&
                                    results.isEmpty &&
                                    !loading &&
                                    trackedFlights.isNotEmpty)
                                  TrackedFlightsList(
                                    trackedFlights: trackedFlights,
                                    onFlightTap: _loadFlightInfo,
                                  ),
                                FlightsList(
                                  flights: flights,
                                  selectedDate: selectedDate,
                                  onFlightTap: _loadFlightInfo,
                                ),
                              ],
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
}
