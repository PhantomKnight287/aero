import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';
import 'package:retry/retry.dart';

import 'package:aero/screens/home/service.dart';
import 'package:aero/services/main.dart';
import 'package:aero/utils/error.dart';

enum FlightPanelState {
  idle,
  loadingFlight,
  selectingFlight,
  showingFlight,
}

enum SearchState {
  idle,
  loading,
}

class HomeController extends ChangeNotifier {
  HomeController({
    HomeService? homeService,
    FlightDataService? flightDataService,
  })  : _service = homeService ?? HomeService(),
        _flightService = flightDataService ?? FlightDataService();

  final HomeService _service;
  final FlightDataService _flightService;

  final TextEditingController flightController = TextEditingController();
  Timer? _debounce;
  Timer? _trackPollingTimer;
  Timer? _countdownTimer;
  int _secondsUntilNextUpdate = 30;

  FlightPanelState panelState = FlightPanelState.idle;
  SearchState searchState = SearchState.idle;

  String? error;
  AirportEntity? departureAirport;
  AirportEntity? arrivalAirport;
  DateTime? selectedDate;
  BuiltList<FlightEntity> flights = BuiltList.from([]);
  List<Object> results = [];
  AirlineEntity? selectedAirline;
  String? selectedFlightNumber;
  FlightResponseEntity? flightInfo;
  List<LatLng> coordinates = [];
  List<LatLng> flightTrackPoints = [];
  FlightPositionEntity? currentPosition;
  BuiltList<FlightResponseEntity> trackedFlights = BuiltList.from([]);
  bool loadingTrackedFlights = false;
  bool isInAir = false;
  CancelToken? _cancelToken;
  BuiltList<FlightPositionEntity> flightPositions = BuiltList.from([]);
  FlightSearchResponseEntity? flightSearchResults;
  String? pendingIata;
  String? pendingIcao;
  DateTime? pendingDate;

  int get secondsUntilNextUpdate => _secondsUntilNextUpdate;
  bool get isTrackingActive =>
      _trackPollingTimer != null && _trackPollingTimer!.isActive;

  void initialize() {
    loadTrackedFlights();
  }

  @override
  void dispose() {
    _controllerCleanup();
    flightController.dispose();
    super.dispose();
  }

  void _controllerCleanup() {
    _debounce?.cancel();
    _trackPollingTimer?.cancel();
    _countdownTimer?.cancel();
  }

  void clearError() {
    if (error != null) {
      error = null;
      notifyListeners();
    }
  }

  void debounceSearch(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      search(query);
    });
  }

  Future<void> search(String query) async {
    if (query.isEmpty || query.length == 1) {
      results = [];
      notifyListeners();
      return;
    }

    if (_cancelToken != null) {
      _cancelToken!.cancel("User is searching for new results");
    }
    _cancelToken = CancelToken();

    searchState = SearchState.loading;
    results = [];
    notifyListeners();

    try {
      results = await _service.search(query, cancelToken: _cancelToken);
    } finally {
      searchState = SearchState.idle;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    results.clear();
    notifyListeners();
  }

  void selectAirport(AirportEntity airport) {
    if (departureAirport == null) {
      departureAirport = airport;
    } else {
      arrivalAirport = airport;
    }
    flightController.clear();
    clearSearchResults();
    notifyListeners();
  }

  void selectAirline(
    AirlineEntity airline, {
    String? currentInput,
  }) {
    selectedAirline = airline;
    error = null;
    final text = currentInput?.trim() ?? '';
    String? remainingText;
    final upperText = text.toUpperCase();
    final iata = airline.iata;
    final icao = airline.icao;

    if (iata.isNotEmpty && upperText.startsWith(iata.toUpperCase())) {
      remainingText = text.substring(iata.length).trim();
    } else if (icao.isNotEmpty && upperText.startsWith(icao.toUpperCase())) {
      remainingText = text.substring(icao.length).trim();
    } else if (text.isNotEmpty &&
        airline.name.isNotEmpty &&
        upperText.contains(airline.name.toUpperCase())) {
      final nameIndex = upperText.indexOf(airline.name.toUpperCase());
      if (nameIndex != -1) {
        remainingText =
            text.substring(nameIndex + airline.name.length).trim();
      }
    }

    if (remainingText != null &&
        remainingText.isNotEmpty &&
        RegExp(r'\d').hasMatch(remainingText)) {
      final match = RegExp(r'\d+').firstMatch(remainingText);
      if (match != null) {
        selectedFlightNumber = match.group(0);
        flightController.clear();
      }
    } else {
      flightController.clear();
    }
    clearSearchResults();
    notifyListeners();
  }

  void selectFlightNumber(String flightNumber) {
    selectedFlightNumber = flightNumber;
    error = null;
    flightController.clear();
    notifyListeners();
  }

  void clearAirline() {
    selectedAirline = null;
    error = null;
    notifyListeners();
  }

  void clearFlightNumber() {
    selectedFlightNumber = null;
    error = null;
    notifyListeners();
  }

  void clearAirports() {
    arrivalAirport = null;
    departureAirport = null;
    error = null;
    notifyListeners();
  }

  void clearDepartureAirport() {
    departureAirport = null;
    error = null;
    notifyListeners();
  }

  Future<void> loadTrackedFlights() async {
    loadingTrackedFlights = true;
    notifyListeners();
    try {
      trackedFlights = await _flightService.getTrackedFlights();
    } catch (_) {
      // ignore errors for now
    } finally {
      loadingTrackedFlights = false;
      notifyListeners();
    }
  }

  Future<void> loadFlightsForSelection(DateTime date) async {
    selectedDate = date;
    flights = BuiltList.from([]);
    panelState = FlightPanelState.loadingFlight;
    error = null;
    notifyListeners();
    try {
      if (departureAirport != null && arrivalAirport != null) {
        flights = await _flightService.getFlights(
          departureAirport!.iataCode ?? departureAirport!.ident,
          arrivalAirport!.iataCode ?? arrivalAirport!.ident,
          date.toIso8601String(),
        );
        panelState = FlightPanelState.idle;
      } else if (selectedAirline != null && selectedFlightNumber != null) {
        await loadFlightInfo(
          "${selectedAirline!.iata}$selectedFlightNumber",
          "${selectedAirline!.icao}$selectedFlightNumber",
          date,
        );
      }
    } catch (_) {
      selectedDate = null;
      panelState = FlightPanelState.idle;
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadFlightInfo(
    String iataCode,
    String icaoCode,
    DateTime date, {
    bool forceUpdate = false,
    String? faFlightId,
  }) async {
    error = null;
    panelState = FlightPanelState.loadingFlight;
    notifyListeners();

    try {
      if (faFlightId != null) {
        final info = await _flightService.getFlightInfoWithNumber(
          iataCode,
          icaoCode,
          date: date,
          forceUpdate: forceUpdate,
          faFlightId: faFlightId,
        );

        if (info == null) {
          error = 'No flight information found';
          panelState = FlightPanelState.idle;
          notifyListeners();
          return;
        }

        _processFlightInfo(info, iataCode, icaoCode, date);
        return;
      }

      final searchResults = await _flightService.searchFlights(
        iataCode,
        icaoCode,
        date: date,
      );

      if (searchResults == null || searchResults.count == 0) {
        error = 'No flights found';
        panelState = FlightPanelState.idle;
        notifyListeners();
        return;
      }

      if (searchResults.count > 1) {
        flightSearchResults = searchResults;
        panelState = FlightPanelState.selectingFlight;
        pendingIata = iataCode;
        pendingIcao = icaoCode;
        pendingDate = date;
        notifyListeners();
        return;
      }

      final singleFlight = searchResults.flights.first;
      final info = await _flightService.getFlightInfoWithNumber(
        iataCode,
        icaoCode,
        date: date,
        forceUpdate: forceUpdate,
        faFlightId: singleFlight.faFlightId,
      );

      if (info == null) {
        error = 'No flight information found';
        panelState = FlightPanelState.idle;
        notifyListeners();
        return;
      }

      _processFlightInfo(info, iataCode, icaoCode, date);
    } catch (e) {
      if (e is DioException) {
        error = getErrorMessage(e.response?.data);
      } else {
        error = 'Failed to load flight information: $e';
      }
      panelState = FlightPanelState.idle;
      notifyListeners();
    }
  }

  void handleFlightSelection(String faFlightId) {
    if (pendingIata == null || pendingIcao == null || pendingDate == null) {
      return;
    }
    loadFlightInfo(
      pendingIata!,
      pendingIcao!,
      pendingDate!,
      faFlightId: faFlightId,
    );
  }

  void closeFlightSelection() {
    panelState = FlightPanelState.idle;
    flightSearchResults = null;
    pendingIata = null;
    pendingIcao = null;
    pendingDate = null;
    selectedDate = null;
    notifyListeners();
  }

  Future<void> onAircraftSelected(
    FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner aircraft,
  ) async {
    panelState = FlightPanelState.loadingFlight;
    error = null;
    flightInfo = null;
    arrivalAirport = null;
    departureAirport = null;
    coordinates = [];
    flightTrackPoints = [];
    currentPosition = null;
    selectedDate = DateTime.now();
    selectedAirline = null;
    selectedFlightNumber = null;
    flights = BuiltList.from([]);
    notifyListeners();

    if (aircraft.identIata?.isNotEmpty == true ||
        aircraft.identIcao?.isNotEmpty == true) {
      final iata = aircraft.identIata ?? '';
      final icao = aircraft.identIcao ?? '';
      await loadFlightInfo(
        iata,
        icao,
        selectedDate!,
      );
    } else {
      error = 'No flight identifiers available';
      panelState = FlightPanelState.idle;
      notifyListeners();
    }
  }

  void refreshTracking() {
    if (flightInfo == null) return;
    stopTrackPolling();
    final flightNo = flightInfo!.flightNo;
    final date = flightInfo!.date.toLocal();
    startTrackPolling(flightNo, flightNo, date);
  }

  void clearFlightContext() {
    stopTrackPolling();
    flightInfo = null;
    panelState = FlightPanelState.idle;
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
    flightSearchResults = null;
    pendingIata = null;
    pendingIcao = null;
    pendingDate = null;
    results = [];
    flightController.clear();
    notifyListeners();
  }

  void stopTrackPolling() {
    _trackPollingTimer?.cancel();
    _trackPollingTimer = null;
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  void startTrackPolling(String iata, String icao, DateTime date) {
    stopTrackPolling();
    _secondsUntilNextUpdate = 30;
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_secondsUntilNextUpdate > 0) {
          _secondsUntilNextUpdate--;
        } else {
          _secondsUntilNextUpdate = 30;
        }
        notifyListeners();
      },
    );

    _trackPollingTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) async {
        try {
          _secondsUntilNextUpdate = 30;
          notifyListeners();
          final trackData = await retry(
            () => _flightService.getFlightTrack(
              iata,
              icao,
              date: date,
            ),
            maxAttempts: 3,
            delayFactor: const Duration(seconds: 2),
            maxDelay: const Duration(seconds: 10),
          );

          if (trackData != null && trackData.positions.isNotEmpty) {
            flightTrackPoints = trackData.positions
                .map(
                  (pos) => LatLng(
                    pos.latitude.toDouble(),
                    pos.longitude.toDouble(),
                  ),
                )
                .toList();
            flightPositions = trackData.positions;
            currentPosition = trackData.positions.last;
            _updateInAirStatus(currentPosition);
            notifyListeners();
            if (!isInAir) {
              stopTrackPolling();
            }
          }
        } catch (_) {
          // keep polling even if it fails
        }
      },
    );
  }

  void _processFlightInfo(
    FlightResponseEntity info,
    String iataCode,
    String icaoCode,
    DateTime date,
  ) {
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

    try {
      final trackData = _flightService.getFlightTrack(
        iataCode,
        icaoCode,
        date: date,
      );

      trackData.then((track) {
        if (track != null && track.positions.isNotEmpty) {
          flightTrackPoints = track.positions
              .map(
                (pos) => LatLng(
                  pos.latitude.toDouble(),
                  pos.longitude.toDouble(),
                ),
              )
              .toList();

          flightPositions = track.positions;
          currentPosition = track.positions.last;
          _updateInAirStatus(currentPosition);
          if (isInAir) {
            startTrackPolling(iataCode, icaoCode, date);
          }
          notifyListeners();
        }
      });
    } catch (_) {
      // ignore
    }

    flightInfo = info;
    panelState = FlightPanelState.showingFlight;
    notifyListeners();
  }

  void _updateInAirStatus([FlightPositionEntity? latestPosition]) {
    final pos = latestPosition ?? currentPosition;
    if (pos == null) {
      isInAir = false;
      return;
    }
    final ts = pos.timestamp;
    final notPast = !_isPastFlight(ts);
    final altitudeOk = (pos.altitude) > 0;
    final speedOk = (pos.groundspeed) > 30;
    isInAir = notPast && (altitudeOk || speedOk);
  }

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
}

