// ignore_for_file: non_constant_identifier_names

import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:built_collection/built_collection.dart';

class HomeService {
  final _airportsApi = openapi.getAirportsApi();
  final _airlinesApi = openapi.getAirlinesApi();

  Future<BuiltList<AirlineEntity>> searchAirlines(String query) async {
    if (query.isEmpty) return BuiltList.from([]);
    final res = await _airlinesApi.airlinesControllerGetAirlinesV1(search: query);
    return res.data!;
  }

  Future<BuiltList<AirportEntity>> searchAirports(String query) async {
    if (query.isEmpty) return BuiltList.from([]);
    final res = await _airportsApi.airportsControllerGetAirportsV1(search: query);
    return res.data!;
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
