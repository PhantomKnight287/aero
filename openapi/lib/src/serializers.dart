//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/aircraft_entity.dart';
import 'package:openapi/src/model/aircraft_flight_entity.dart';
import 'package:openapi/src/model/airline_entity.dart';
import 'package:openapi/src/model/airline_info.dart';
import 'package:openapi/src/model/airline_stats_entity.dart';
import 'package:openapi/src/model/airport_entity.dart';
import 'package:openapi/src/model/airport_info.dart';
import 'package:openapi/src/model/airport_stats_entity.dart';
import 'package:openapi/src/model/airport_type.dart';
import 'package:openapi/src/model/fligh_type.dart';
import 'package:openapi/src/model/flight_aware_data_entity.dart';
import 'package:openapi/src/model/flight_distance_entity.dart';
import 'package:openapi/src/model/flight_duration_entity.dart';
import 'package:openapi/src/model/flight_entity.dart';
import 'package:openapi/src/model/flight_position_entity.dart';
import 'package:openapi/src/model/flight_response_entity.dart';
import 'package:openapi/src/model/flight_status.dart';
import 'package:openapi/src/model/flight_summary_airline_entity.dart';
import 'package:openapi/src/model/flight_summary_entity.dart';
import 'package:openapi/src/model/flight_track_response_entity.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_bounds.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_flights_inner.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_flights_inner_origin.dart';
import 'package:openapi/src/model/flights_response_entity.dart';
import 'package:openapi/src/model/flights_route_entity.dart';
import 'package:openapi/src/model/generic_error_entity.dart';
import 'package:openapi/src/model/get_airline_dto.dart';
import 'package:openapi/src/model/location_entity.dart';
import 'package:openapi/src/model/login_dto.dart';
import 'package:openapi/src/model/login_entity.dart';
import 'package:openapi/src/model/most_flown_aircraft_entity.dart';
import 'package:openapi/src/model/partial_airline_entity.dart';
import 'package:openapi/src/model/passport_entity.dart';
import 'package:openapi/src/model/profile_stats_response_entity.dart';
import 'package:openapi/src/model/register_dto.dart';
import 'package:openapi/src/model/register_entity.dart';
import 'package:openapi/src/model/route_airport_entity.dart';
import 'package:openapi/src/model/route_info_entity.dart';
import 'package:openapi/src/model/stringified_great_circle_distance_entity.dart';
import 'package:openapi/src/model/time_entity.dart';
import 'package:openapi/src/model/top_route_entity.dart';
import 'package:openapi/src/model/tracked_flights_response_entity.dart';
import 'package:openapi/src/model/user_entity.dart';

part 'serializers.g.dart';

@SerializersFor([
  AircraftEntity,
  AircraftFlightEntity,
  AirlineEntity,
  AirlineInfo,
  AirlineStatsEntity,
  AirportEntity,
  AirportInfo,
  AirportStatsEntity,
  AirportType,
  FlighType,
  FlightAwareDataEntity,
  FlightDistanceEntity,
  FlightDurationEntity,
  FlightEntity,
  FlightPositionEntity,
  FlightResponseEntity,
  FlightStatus,
  FlightSummaryAirlineEntity,
  FlightSummaryEntity,
  FlightTrackResponseEntity,
  FlightsControllerGetFlightsInBoundsV1200Response,
  FlightsControllerGetFlightsInBoundsV1200ResponseBounds,
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner,
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin,
  FlightsResponseEntity,
  FlightsRouteEntity,
  GenericErrorEntity,
  GetAirlineDTO,
  LocationEntity,
  LoginDTO,
  LoginEntity,
  MostFlownAircraftEntity,
  PartialAirlineEntity,
  PassportEntity,
  ProfileStatsResponseEntity,
  RegisterDTO,
  RegisterEntity,
  RouteAirportEntity,
  RouteInfoEntity,
  StringifiedGreatCircleDistanceEntity,
  TimeEntity,
  TopRouteEntity,
  TrackedFlightsResponseEntity,
  UserEntity,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AirlineEntity)]),
        () => ListBuilder<AirlineEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AirportEntity)]),
        () => ListBuilder<AirportEntity>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
