import 'dart:async';

import 'package:aero/client/pocketbase.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/models/airline/airline.dart';
import 'package:aero/models/flight/flight.dart';
import 'package:aero/screens/home/service.dart';
import 'package:aero/services/main.dart';
import 'package:aero/widgets/input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.phantomknight287.aero',
      tileProvider: CancellableNetworkTileProvider(),
    );

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
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
  final DraggableScrollableController _controller = DraggableScrollableController();
  Timer? _debounce;
  bool loading = false;
  final FlightDataService _flightService = FlightDataService();
  bool isLoading = false;
  String? error;
  Airport? departureAirport;
  Airport? arrivalAirport;
  DateTime? selectedDate;
  List<Flight> flights = [];
  List<Object> results = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.20,
            child: FlutterMap(
              mapController: _mapController.mapController,
              options: MapOptions(
                initialCenter: const LatLng(51.5, -0.09),
                initialZoom: 5,
                cameraConstraint: CameraConstraint.contain(
                  bounds: LatLngBounds(
                    const LatLng(-90, -180),
                    const LatLng(90, 180),
                  ),
                ),
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    if (arrivalAirport != null)
                      Marker(
                        point: LatLng(arrivalAirport!.lat, arrivalAirport!.long),
                        width: 10,
                        height: 10,
                        child: FlutterLogo(),
                      ),
                    if (departureAirport != null)
                      Marker(
                        point: LatLng(departureAirport!.lat, departureAirport!.long),
                        width: 10,
                        height: 10,
                        child: FlutterLogo(),
                      )
                  ],
                ),
                if (arrivalAirport != null && departureAirport != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [
                          LatLng(
                            arrivalAirport!.lat,
                            arrivalAirport!.long,
                          ),
                          LatLng(
                            departureAirport!.lat,
                            departureAirport!.long,
                          ),
                        ],
                        color: Colors.blue,
                        strokeWidth: 3,
                        pattern: StrokePattern.dotted(),
                      ),
                    ],
                  ),
              ],
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Search airports",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              if (arrivalAirport != null)
                                GestureDetector(
                                  onTap: () {
                                    arrivalAirport = null;
                                    departureAirport = null;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      arrivalAirport!.iata_code ?? arrivalAirport!.ident,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              if (departureAirport != null)
                                GestureDetector(
                                  onTap: () {
                                    departureAirport = null;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      departureAirport!.iata_code ?? departureAirport!.ident,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: InputField(
                                  hintText: arrivalAirport == null
                                      ? "Search arrival airport"
                                      : departureAirport == null
                                          ? "Search departure airport"
                                          : "Choose a date",
                                  keyboardType: TextInputType.text,
                                  prefixIcon: Icon(Icons.search),
                                  controller: _flightController,
                                  onChanged: (p0) async {
                                    if (arrivalAirport != null && departureAirport != null) return;
                                    if (_debounce?.isActive ?? false) {
                                      _debounce?.cancel();
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
                              )
                            ],
                          ),
                          Gap(16),
                          if (results.isEmpty && loading)
                            Skeletonizer(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  final item = index == 0
                                      ? Airport(
                                          id: "",
                                          ident: "VIDP",
                                          iso_country: "IN",
                                          lat: 0,
                                          long: 0,
                                          name: "Indira Gandhi Internation Airport",
                                          type: AirportType.large_airport,
                                        )
                                      : Airline(
                                          id: "",
                                          iata: "IC",
                                          icao: "ICE",
                                          name: "Air India",
                                        );
                                  if (index == 0) {
                                    final airport = item as Airport;
                                    return ListTile(
                                      title: Text(airport.name),
                                      leading: Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.green,
                                      ),
                                    );
                                  } else {
                                    final airline = item as Airline;
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
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final _item = results[index];
                              final runtimeType = _item.runtimeType.toString();
                              if (runtimeType == "Airport") {
                                final airport = _item as Airport;
                                return ListTile(
                                  title: Text(airport.name),
                                  leading: CachedNetworkImage(
                                    imageUrl: "https://flagcdn.com/24x18/${airport.iso_country.toLowerCase()}.png",
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
                                    FocusScope.of(context).unfocus();
                                    await _controller.animateTo(
                                      .25,
                                      duration: Duration(
                                        milliseconds: 150,
                                      ),
                                      curve: Curves.bounceIn,
                                    );
                                    setState(() {});
                                    _mapController.animateTo(
                                      dest: LatLng(airport.lat, airport.long),
                                      zoom: 12,
                                    );
                                    if (arrivalAirport != null) {
                                      departureAirport = airport;
                                    }
                                    if (arrivalAirport == null) {
                                      arrivalAirport = airport;
                                    }
                                    _flightController.clear();
                                    setState(() {});
                                  },
                                );
                              } else {
                                final airline = _item as Airline;
                                return ListTile(
                                  title: Text(airline.name),
                                  leading: airline.image != null && airline.image!.isNotEmpty
                                      ? SvgPicture.network(
                                          "$POCKETBASE_URL/api/files/airlines/${airline.id}/${airline.image}",
                                          width: 24,
                                          height: 18,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: "https://airlabs.co/img/airline/m/${airline.iata}.png",
                                          width: 24,
                                          height: 18,
                                          errorWidget: (context, url, error) {
                                            return SizedBox(
                                              height: 0,
                                              width: 0,
                                            );
                                          },
                                        ),
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
                              final arrivalTime = DateTime.parse(flight.arrival['scheduledTime']!);
                              final departureTime = DateTime.parse(flight.departure['scheduledTime']!);

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(
                                        alpha: .25,
                                      ),
                                      borderRadius: BorderRadius.circular(
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
                                  Gap(
                                    8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: "https://airlabs.co/img/airline/m/${flight.airline['iataCode']}.png",
                                            width: 15,
                                            height: 15,
                                            errorWidget: (context, url, error) {
                                              return SizedBox(
                                                height: 0,
                                                width: 0,
                                              );
                                            },
                                          ),
                                          Gap(
                                            2,
                                          ),
                                          Text(
                                            flight.flight['iataNumber']!,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // Text(
                                          //   flight.departure['iataCode']!,
                                          //   style: TextStyle(
                                          //     color: Colors.green,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                          // Text(" to "),
                                          // Text(
                                          //   flight.arrival['iataCode']!,
                                          //   style: TextStyle(
                                          //     color: Colors.green,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // )
                                          Text(
                                            flight.airline['name']!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Arrival: ${arrivalTime.hour}:${arrivalTime.minute}",
                                          ),
                                          Text("   "),
                                          Text(
                                            "Departure: ${departureTime.hour}:${arrivalTime.hour}",
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              );
                              return ListTile(
                                title: Text(
                                  flight.flight['iataNumber']!,
                                ),
                                subtitle: Text(
                                  flight.airline['name']!,
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: "https://airlabs.co/img/airline/m/${flight.airline['iataCode']}.png",
                                  width: 20,
                                  height: 20,
                                  errorWidget: (context, url, error) {
                                    return SizedBox(
                                      height: 20,
                                      width: 20,
                                    );
                                  },
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
  } else if (type == AirportType.large_airport || type == AirportType.medium_airport) {
    return SvgPicture.asset(
      "assets/svgs/big-medium-plane.svg",
      width: 40,
      height: 40,
    );
  } else if (type == AirportType.seaplane_base) {
    return SvgPicture.asset(
      "assets/svgs/sea-plane.svg",
      width: 40,
      height: 40,
    );
  } else if (type == AirportType.small_airport) {
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
