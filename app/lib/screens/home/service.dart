// ignore_for_file: non_constant_identifier_names

import 'package:aero/client/pocketbase.dart';
import 'package:aero/models/airline/airline.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

enum AirportType {
  small_airport,
  seaplane_base,
  medium_airport,
  large_airport,
  heliport,
  closed,
  balloonport,
}

@JsonSerializable()
class Airport {
  final String id;
  final String ident;
  final AirportType type;
  final String name;
  final String? elevation;
  final String? continent;
  final String iso_country;
  final String? iso_region;
  final String? municipality;
  final String? gps_code;
  final String? iata_code;
  final String? local_code;
  final double lat;
  final double long;

  Airport({
    required this.id,
    required this.ident,
    required this.type,
    required this.name,
    this.elevation,
    this.continent,
    required this.iso_country,
    this.iso_region,
    this.municipality,
    this.gps_code,
    this.iata_code,
    this.local_code,
    required this.lat,
    required this.long,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);

  static String createTableScript() {
    return '''
    CREATE TABLE IF NOT EXISTS airports (
      id TEXT PRIMARY KEY,
      ident TEXT NOT NULL,
      type TEXT NOT NULL,
      name TEXT NOT NULL,
      elevation TEXT,
      continent TEXT,
      iso_country TEXT,
      iso_region TEXT,
      municipality TEXT,
      gps_code TEXT,
      iata_code TEXT,
      local_code TEXT,
      lat REAL NOT NULL,
      long REAL NOT NULL
    );
    ''';
  }
}

class HomeService {
  Future<List<Airport>> getAirports() async {
    final response = await pb.collection("airports").getList(
          perPage: 3000,
          page: 1,
          filter: "type != 'closed' && iata_code != null",
        );
    return response.items.map((json) => Airport.fromJson(json.data)).toList();
  }

  Future<List<Airline>> searchAirlines(String query) async {
    final response = await pb.collection("airlines").getList(
          perPage: 3000,
          page: 1,
          filter: "name ~ '%$query%'",
        );
    return response.items.map((json) => Airline.fromJson(json.data)).toList();
  }

  Future<List<Airport>> searchAirports(String query) async {
    final response = await pb.collection("airports").getList(
      perPage: 20,
      page: 1,
      query: {
        "filter": "(ident ~ '%$query%' || name ~ '%$query%' || iata_code ~ '%$query%') && type != 'closed' && iata_code != null",
      },
    );
    return response.items.map((json) => Airport.fromJson(json.data)).toList();
  }

  Future<List<Object>> search(String query) async {
    final airlines = await searchAirlines(query.trim());
    final airports = await searchAirports(query.trim());
    return [
      ...airports,
      ...airlines,
    ];
  }
}
