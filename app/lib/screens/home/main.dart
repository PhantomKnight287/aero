import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/formatters/time.dart';
import 'package:plane_pal/notifiers/user.dart';
import 'package:plane_pal/screens/home/service.dart';
import 'package:plane_pal/screens/home/widgets/flight_info.dart';
import 'package:plane_pal/screens/home/widgets/flight_map.dart';
import 'package:plane_pal/screens/home/widgets/flight_search_bar.dart';
import 'package:plane_pal/screens/home/widgets/selected_filters.dart';
import 'package:plane_pal/services/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token={accessToken}',
      userAgentPackageName: 'com.phantomknight287.planepal',
      tileProvider: CancellableNetworkTileProvider(),
      additionalOptions: const {
        'accessToken': MAPBOX_API_KEY,
      },
      tileSize: 512,
      zoomOffset: -1,
    );

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
    super.initState();
  }

  Future<List<Object>> _search(String query) async {
    if (query.isEmpty || query.length == 1) return [];
    return _service.search(query);
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
    super.dispose();
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

          // Animate map to show the flight route
          _mapController.animateTo(
            dest: LatLng(
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
              onAircraftSelected: _onAircraftSelected,
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
                              onClose: () {
                                setState(() {
                                  _flightInfo = null;
                                  arrivalAirport = null;
                                  departureAirport = null;
                                  coordinates = [];
                                  selectedDate = null;
                                  selectedAirline = null;
                                  selectedFlightNumber = null;
                                  flights = BuiltList.from([]);
                                  error = null;
                                  isLoading = false;
                                  loading = false;
                                  _flightController.clear();
                                });
                              })
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Search",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Builder(
                                        builder: (
                                          context,
                                        ) {
                                          final user =
                                              Provider.of<UserNotifier>(
                                            context,
                                          );
                                          return GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context)
                                                  .push("/profile");
                                            },
                                            child: Hero(
                                              tag: "avatar",
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  "https://api.dicebear.com/9.x/initials/png?seed=${user.user?.name}",
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
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
                                  ListView.builder(
                                    itemBuilder: (context, index) {
                                      final date = DateTime.now();
                                      if (index == 0) {
                                        return ListTile(
                                          title: Text(
                                            "Today",
                                          ),
                                          leading: Icon(
                                            Icons.calendar_month,
                                          ),
                                          subtitle: Text(
                                            formatDayAndMonth(date),
                                          ),
                                          onTap: () async {
                                            loading = true;
                                            selectedDate = date;
                                            flights = BuiltList.from([]);
                                            setState(() {});
                                            try {
                                              if (arrivalAirport != null &&
                                                  departureAirport != null) {
                                                flights = await _flightService
                                                    .getFlights(
                                                  departureAirport!.iataCode ??
                                                      departureAirport!.ident,
                                                  arrivalAirport!.iataCode ??
                                                      arrivalAirport!.ident,
                                                  date.toIso8601String(),
                                                );
                                              } else {
                                                final info = await _flightService
                                                    .getFlightInfoWithNumber(
                                                  "${selectedAirline!.iata}$selectedFlightNumber",
                                                  "${selectedAirline!.icao}$selectedFlightNumber",
                                                  date: date,
                                                );
                                                if (info == null) {
                                                  setState(() {
                                                    selectedDate = null;
                                                  });
                                                } else {
                                                  coordinates = [
                                                    LatLng(
                                                      info.departure.airport
                                                          .location.lat
                                                          .toDouble(),
                                                      info.departure.airport
                                                          .location.lon
                                                          .toDouble(),
                                                    ),
                                                    LatLng(
                                                      info.arrival.airport
                                                          .location.lat
                                                          .toDouble(),
                                                      info.arrival.airport
                                                          .location.lon
                                                          .toDouble(),
                                                    ),
                                                  ];
                                                  _mapController.animateTo(
                                                    dest: coordinates[1],
                                                  );
                                                  setState(() {
                                                    _flightInfo = info;
                                                  });
                                                }
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
                                        );
                                      } else {
                                        final tmrh = DateTime(
                                          date.year,
                                          date.month,
                                          date.day + 1,
                                        );
                                        return ListTile(
                                          title: Text(
                                            "Tomorrow",
                                          ),
                                          leading: Icon(
                                            MdiIcons.calendarArrowRight,
                                          ),
                                          subtitle: Text(
                                            formatDayAndMonth(tmrh),
                                          ),
                                          onTap: () async {
                                            loading = true;
                                            selectedDate = tmrh;
                                            flights = BuiltList.from([]);
                                            setState(() {});
                                            flights =
                                                await _flightService.getFlights(
                                              departureAirport!.iataCode ??
                                                  departureAirport!.ident,
                                              arrivalAirport!.iataCode ??
                                                  arrivalAirport!.ident,
                                              tmrh.toIso8601String(),
                                            );
                                            setState(() {
                                              loading = false;
                                            });
                                          },
                                        );
                                      }
                                    },
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: 2,
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
                                if (results.isEmpty && loading)
                                  Skeletonizer(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        final item = index == 0
                                            ? AirportEntity((b) {
                                                b
                                                  ..id = ""
                                                  ..ident = "VIDP"
                                                  ..isoCountry = "IN"
                                                  ..lat = '0'
                                                  ..long = '0'
                                                  ..name =
                                                      "Indira Gandhi International Airport"
                                                  ..type =
                                                      AirportType.largeAirport
                                                  ..continent = "IDK"
                                                  ..isoRegion = "DEL"
                                                  ..build();
                                              })
                                            : AirlineEntity((b) {
                                                b
                                                  ..id = ""
                                                  ..iata = "IC"
                                                  ..icao = "ICE"
                                                  ..name = "Air India"
                                                  ..build();
                                              });
                                        if (index == 0) {
                                          final airport = item as AirportEntity;
                                          return ListTile(
                                            title: Text(airport.name),
                                            leading: Container(
                                              width: 30,
                                              height: 30,
                                              color: Colors.green,
                                            ),
                                          );
                                        } else {
                                          final airline = item as AirlineEntity;
                                          return ListTile(
                                            title: Text(airline.name),
                                            leading: Container(
                                              width: 24,
                                              height: 18,
                                              color: Colors.green,
                                            ),
                                          );
                                        }
                                      },
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: 2,
                                    ),
                                  ),
                                if (selectedAirline == null)
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final _item = results[index];
                                      final runtimeType =
                                          _item.runtimeType.toString();
                                      if (runtimeType == '_\$AirportEntity') {
                                        final airport = _item as AirportEntity;
                                        return ListTile(
                                          title: Text(
                                            airport.name,
                                          ),
                                          subtitle: Text(
                                            "${airport.iataCode != null && airport.iataCode!.isNotEmpty ? "${airport.iataCode} • " : ""}${airport.isoCountry} • ${airport.ident}",
                                          ),
                                          leading: CachedNetworkImage(
                                            imageUrl:
                                                "https://flagcdn.com/h40/${airport.isoCountry.toLowerCase()}.jpg",
                                            width: 30,
                                            height: 30,
                                            errorWidget: (context, url, error) {
                                              return SizedBox(
                                                height: 0,
                                                width: 0,
                                              );
                                            },
                                          ),
                                          onTap: () async {
                                            if (departureAirport == null) {
                                              departureAirport = airport;
                                            } else {
                                              arrivalAirport = airport;
                                            }
                                            _flightController.clear();
                                            results.clear();
                                            setState(() {});
                                          },
                                        );
                                      } else {
                                        final airline = _item as AirlineEntity;
                                        return ListTile(
                                          title: Text(airline.name),
                                          subtitle: Text(
                                              "${airline.iata} • ${airline.icao}"),
                                          leading: airline.image != null &&
                                                  airline.image!.isNotEmpty
                                              ? SvgPicture.network(
                                                  airline.image!,
                                                  width: 24,
                                                  height: 18,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      "https://airlabs.co/img/airline/m/${airline.iata}.png",
                                                  width: 24,
                                                  height: 18,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return SizedBox(
                                                      height: 0,
                                                      width: 0,
                                                    );
                                                  },
                                                ),
                                          onTap: () {
                                            selectedAirline = airline;
                                            final text = _flightController.text;

                                            if (!((text
                                                        .replaceFirst(
                                                            airline.iata, "")
                                                        .length ==
                                                    text.length) ||
                                                (text
                                                        .replaceFirst(
                                                            airline.icao, "")
                                                        .length ==
                                                    text.length))) {
                                              _flightController.text =
                                                  _flightController.text
                                                      .replaceFirst(
                                                          airline.icao, '');
                                            } else {
                                              _flightController.clear();
                                            }

                                            results.clear();
                                            setState(() {});
                                          },
                                        );
                                      }
                                    },
                                    itemCount: results.length,
                                    physics: NeverScrollableScrollPhysics(),
                                  ),
                                ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  itemBuilder: (context, index) {
                                    final flight = flights[index];
                                    final arrivalTime = DateTime.parse(
                                        flight.arrival.scheduledTime!);
                                    final departureTime = DateTime.parse(
                                        flight.departure.scheduledTime!);
                                    final currentTime = DateTime.now();
                                    return Padding(
                                      padding: const EdgeInsets.all(
                                        4.0,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 8,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.yellow.withValues(
                                                alpha: .25,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(
                                              2,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                MdiIcons.airplane,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            spacing: 4,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 4,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        "https://airlabs.co/img/airline/m/${flight.airline.iataCode}.png",
                                                    width: 15,
                                                    height: 15,
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return SizedBox(
                                                        height: 0,
                                                        width: 0,
                                                      );
                                                    },
                                                  ),
                                                  Text(
                                                    flight.flight.iataNumber,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    flight.airline.name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "${flight.departure.iataCode} ",
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text: formatTime(
                                                            departureTime,
                                                            use24HourFormat:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .alwaysUse24HourFormat,
                                                          ),
                                                          style: TextStyle(
                                                            color: currentTime
                                                                    .isAfter(
                                                                        departureTime)
                                                                ? Colors.red
                                                                : Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "   ${flight.arrival.iataCode} ",
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text: formatTime(
                                                            arrivalTime,
                                                            use24HourFormat:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .alwaysUse24HourFormat,
                                                          ),
                                                          style: TextStyle(
                                                            color: currentTime
                                                                    .isAfter(
                                                                        arrivalTime)
                                                                ? Colors.red
                                                                : Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: flights.length,
                                  physics: NeverScrollableScrollPhysics(),
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

Widget getAirportIcon(AirportType type) {
  if (type == AirportType.balloonport) {
    return SvgPicture.asset(
      "assets/svgs/balloon.svg",
      width: 40,
      height: 40,
    );
  } else if (type == AirportType.heliport) {
    return SvgPicture.asset(
      "assets/svgs/helicopter.svg",
      width: 40,
      height: 40,
    );
  } else if (type == AirportType.largeAirport ||
      type == AirportType.mediumAirport) {
    return SvgPicture.asset(
      "assets/svgs/big-medium-plane.svg",
      width: 40,
      height: 40,
    );
  } else if (type == AirportType.seaplaneBase) {
    return SvgPicture.asset(
      "assets/svgs/sea-plane.svg",
      width: 40,
      height: 40,
    );
  } else if (type == AirportType.smallAirport) {
    return SvgPicture.asset(
      "assets/svgs/small-plane.svg",
      width: 40,
      height: 40,
    );
  }
  return SvgPicture.asset(
    "assets/svgs/small-plane.svg",
    width: 40,
    height: 40,
  );
}
