// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:built_collection/built_collection.dart';

class HomeService {
  final _airportsApi = openapi.getAirportsApi();
  final _airlinesApi = openapi.getAirlinesApi();

  Future<BuiltList<AirlineEntity>> searchAirlines(String query,
      {CancelToken? cancelToken}) async {
    if (query.isEmpty) return BuiltList.from([]);
    try {
      final res = await _airlinesApi.airlinesControllerGetAirlinesV1(
        search: query,
        cancelToken: cancelToken,
      );
      return res.data!;
    } catch (e) {
      return BuiltList.from([]);
    }
  }

  Future<BuiltList<AirportEntity>> searchAirports(String query,
      {CancelToken? cancelToken}) async {
    if (query.isEmpty) return BuiltList.from([]);
    try {
      final res = await _airportsApi.airportsControllerGetAirportsV1(
          search: query, cancelToken: cancelToken);
      return res.data!;
    } catch (e) {
      return BuiltList.from([]);
    }
  }

  Future<List<Object>> search(
    String query, {
    CancelToken? cancelToken,
  }) async {
    final results = await Future.wait([
      searchAirlines(query.trim(), cancelToken: cancelToken),
      searchAirports(query.trim(), cancelToken: cancelToken),
    ]);

    final airlines = results[0];
    final airports = results[1];

    return [
      ...airlines,
      ...airports,
    ];
  }
}
