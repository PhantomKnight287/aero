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
import 'package:openapi/src/model/aircraft_history_entity.dart';
import 'package:openapi/src/model/aircraft_leg_entity.dart';
import 'package:openapi/src/model/aircraft_registration_entity.dart';
import 'package:openapi/src/model/aircraft_stats_entity.dart';
import 'package:openapi/src/model/aircraft_with_age.dart';
import 'package:openapi/src/model/airline_entity.dart';
import 'package:openapi/src/model/airline_info.dart';
import 'package:openapi/src/model/airport_conditions_entity.dart';
import 'package:openapi/src/model/airport_delay_reason_entity.dart';
import 'package:openapi/src/model/airport_delays_entity.dart';
import 'package:openapi/src/model/airport_details_entity.dart';
import 'package:openapi/src/model/airport_entity.dart';
import 'package:openapi/src/model/airport_info.dart';
import 'package:openapi/src/model/airport_type.dart';
import 'package:openapi/src/model/airport_weather_forecast_entity.dart';
import 'package:openapi/src/model/airport_weather_observation_entity.dart';
import 'package:openapi/src/model/continent_bucket.dart';
import 'package:openapi/src/model/continent_entity.dart';
import 'package:openapi/src/model/country_entity.dart';
import 'package:openapi/src/model/create_flight_booking_dto.dart';
import 'package:openapi/src/model/decoded_weather_entity.dart';
import 'package:openapi/src/model/delay_summary_entity.dart';
import 'package:openapi/src/model/extremes_entity.dart';
import 'package:openapi/src/model/fligh_type.dart';
import 'package:openapi/src/model/flight_aware_data_entity.dart';
import 'package:openapi/src/model/flight_booking_entity.dart';
import 'package:openapi/src/model/flight_candidate_entity.dart';
import 'package:openapi/src/model/flight_controller_delete_flight_booking_v1200_response.dart';
import 'package:openapi/src/model/flight_controller_delete_flight_v1200_response.dart';
import 'package:openapi/src/model/flight_entity.dart';
import 'package:openapi/src/model/flight_history_response_entity.dart';
import 'package:openapi/src/model/flight_position_entity.dart';
import 'package:openapi/src/model/flight_response_entity.dart';
import 'package:openapi/src/model/flight_search_response_entity.dart';
import 'package:openapi/src/model/flight_status.dart';
import 'package:openapi/src/model/flight_summary_airline_entity.dart';
import 'package:openapi/src/model/flight_summary_destination_entity.dart';
import 'package:openapi/src/model/flight_summary_entity.dart';
import 'package:openapi/src/model/flight_summary_origin_entity.dart';
import 'package:openapi/src/model/flight_track_response_entity.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_bounds.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_flights_inner.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_flights_inner_origin.dart';
import 'package:openapi/src/model/flights_per_entity.dart';
import 'package:openapi/src/model/flights_response_entity.dart';
import 'package:openapi/src/model/flights_route_entity.dart';
import 'package:openapi/src/model/generic_error_entity.dart';
import 'package:openapi/src/model/get_airline_dto.dart';
import 'package:openapi/src/model/location_entity.dart';
import 'package:openapi/src/model/login_dto.dart';
import 'package:openapi/src/model/login_entity.dart';
import 'package:openapi/src/model/map_airport_entity.dart';
import 'package:openapi/src/model/map_data_entity.dart';
import 'package:openapi/src/model/map_route_entity.dart';
import 'package:openapi/src/model/most_flown_aircraft_entity.dart';
import 'package:openapi/src/model/partial_airline_entity.dart';
import 'package:openapi/src/model/passport_entity.dart';
import 'package:openapi/src/model/profile_stats_response_entity.dart';
import 'package:openapi/src/model/records_entity.dart';
import 'package:openapi/src/model/register_dto.dart';
import 'package:openapi/src/model/register_entity.dart';
import 'package:openapi/src/model/route_airport_entity.dart';
import 'package:openapi/src/model/route_info_entity.dart';
import 'package:openapi/src/model/runway_use_entity.dart';
import 'package:openapi/src/model/runways_entity.dart';
import 'package:openapi/src/model/stats_airline_entity.dart';
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:openapi/src/model/stats_flight_summary_entity.dart';
import 'package:openapi/src/model/stats_record_entity.dart';
import 'package:openapi/src/model/stringified_great_circle_distance_entity.dart';
import 'package:openapi/src/model/taxi_airport_entity.dart';
import 'package:openapi/src/model/taxi_by_airport_entity.dart';
import 'package:openapi/src/model/time_entity.dart';
import 'package:openapi/src/model/top_airline_entity.dart';
import 'package:openapi/src/model/top_airport_entity.dart';
import 'package:openapi/src/model/top_route_entity.dart';
import 'package:openapi/src/model/tracked_flights_response_entity.dart';
import 'package:openapi/src/model/update_flight_booking_dto.dart';
import 'package:openapi/src/model/user_entity.dart';
import 'package:openapi/src/model/weather_forecast_cloud_entity.dart';
import 'package:openapi/src/model/weather_forecast_decoded_entity.dart';
import 'package:openapi/src/model/weather_forecast_line_entity.dart';
import 'package:openapi/src/model/weather_forecast_visibility_entity.dart';
import 'package:openapi/src/model/weather_forecast_winds_entity.dart';
import 'package:openapi/src/model/weather_forecast_windshear_entity.dart';
import 'package:openapi/src/model/weather_observation_cloud_entity.dart';
import 'package:openapi/src/model/year_count_entity.dart';

part 'serializers.g.dart';

@SerializersFor([
  AircraftEntity,
  AircraftFlightEntity,
  AircraftHistoryEntity,
  AircraftLegEntity,
  AircraftRegistrationEntity,
  AircraftStatsEntity,
  AircraftWithAge,
  AirlineEntity,
  AirlineInfo,
  AirportConditionsEntity,
  AirportDelayReasonEntity,
  AirportDelaysEntity,
  AirportDetailsEntity,
  AirportEntity,
  AirportInfo,
  AirportType,
  AirportWeatherForecastEntity,
  AirportWeatherObservationEntity,
  ContinentBucket,
  ContinentEntity,
  CountryEntity,
  CreateFlightBookingDTO,
  DecodedWeatherEntity,
  DelaySummaryEntity,
  ExtremesEntity,
  FlighType,
  FlightAwareDataEntity,
  FlightBookingEntity,
  FlightCandidateEntity,
  FlightControllerDeleteFlightBookingV1200Response,
  FlightControllerDeleteFlightV1200Response,
  FlightEntity,
  FlightHistoryResponseEntity,
  FlightPositionEntity,
  FlightResponseEntity,
  FlightSearchResponseEntity,
  FlightStatus,
  FlightSummaryAirlineEntity,
  FlightSummaryDestinationEntity,
  FlightSummaryEntity,
  FlightSummaryOriginEntity,
  FlightTrackResponseEntity,
  FlightsControllerGetFlightsInBoundsV1200Response,
  FlightsControllerGetFlightsInBoundsV1200ResponseBounds,
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner,
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin,
  FlightsPerEntity,
  FlightsResponseEntity,
  FlightsRouteEntity,
  GenericErrorEntity,
  GetAirlineDTO,
  LocationEntity,
  LoginDTO,
  LoginEntity,
  MapAirportEntity,
  MapDataEntity,
  MapRouteEntity,
  MostFlownAircraftEntity,
  PartialAirlineEntity,
  PassportEntity,
  ProfileStatsResponseEntity,
  RecordsEntity,
  RegisterDTO,
  RegisterEntity,
  RouteAirportEntity,
  RouteInfoEntity,
  RunwayUseEntity,
  RunwaysEntity,
  StatsAirlineEntity,
  StatsAirportEntity,
  StatsFlightSummaryEntity,
  StatsRecordEntity,
  StringifiedGreatCircleDistanceEntity,
  TaxiAirportEntity,
  TaxiByAirportEntity,
  TimeEntity,
  TopAirlineEntity,
  TopAirportEntity,
  TopRouteEntity,
  TrackedFlightsResponseEntity,
  UpdateFlightBookingDTO,
  UserEntity,
  WeatherForecastCloudEntity,
  WeatherForecastDecodedEntity,
  WeatherForecastLineEntity,
  WeatherForecastVisibilityEntity,
  WeatherForecastWindsEntity,
  WeatherForecastWindshearEntity,
  WeatherObservationCloudEntity,
  YearCountEntity,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TopAirlineEntity)]),
        () => ListBuilder<TopAirlineEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AircraftRegistrationEntity)]),
        () => ListBuilder<AircraftRegistrationEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(RunwayUseEntity)]),
        () => ListBuilder<RunwayUseEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AirportDelayReasonEntity)]),
        () => ListBuilder<AirportDelayReasonEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner)]),
        () => ListBuilder<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
        () => ListBuilder<StatsFlightSummaryEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AircraftLegEntity)]),
        () => ListBuilder<AircraftLegEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightPositionEntity)]),
        () => ListBuilder<FlightPositionEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TopAirportEntity)]),
        () => ListBuilder<TopAirportEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightCandidateEntity)]),
        () => ListBuilder<FlightCandidateEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(YearCountEntity)]),
        () => ListBuilder<YearCountEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AirportEntity)]),
        () => ListBuilder<AirportEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MapRouteEntity)]),
        () => ListBuilder<MapRouteEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightResponseEntity)]),
        () => ListBuilder<FlightResponseEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(num)]),
        () => ListBuilder<num>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MapAirportEntity)]),
        () => ListBuilder<MapAirportEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ContinentEntity)]),
        () => ListBuilder<ContinentEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightSummaryEntity)]),
        () => ListBuilder<FlightSummaryEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AirlineEntity)]),
        () => ListBuilder<AirlineEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(CountryEntity)]),
        () => ListBuilder<CountryEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightEntity)]),
        () => ListBuilder<FlightEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(WeatherObservationCloudEntity)]),
        () => ListBuilder<WeatherObservationCloudEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(WeatherForecastCloudEntity)]),
        () => ListBuilder<WeatherForecastCloudEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(WeatherForecastLineEntity)]),
        () => ListBuilder<WeatherForecastLineEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FlightBookingEntity)]),
        () => ListBuilder<FlightBookingEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaxiAirportEntity)]),
        () => ListBuilder<TaxiAirportEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TopRouteEntity)]),
        () => ListBuilder<TopRouteEntity>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
