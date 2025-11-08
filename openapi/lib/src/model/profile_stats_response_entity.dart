//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_duration_entity.dart';
import 'package:openapi/src/model/airline_stats_entity.dart';
import 'package:openapi/src/model/flight_distance_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/airport_stats_entity.dart';
import 'package:openapi/src/model/aircraft_stats_entity.dart';
import 'package:openapi/src/model/top_route_entity.dart';
import 'package:openapi/src/model/most_flown_aircraft_entity.dart';
import 'package:openapi/src/model/passport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile_stats_response_entity.g.dart';

/// ProfileStatsResponseEntity
///
/// Properties:
/// * [mostFlownAircraft] 
/// * [aircraftStats] 
/// * [passport] 
/// * [shortestDistanceFlight] 
/// * [longestDistanceFlight] 
/// * [shortestDurationFlight] 
/// * [longestDurationFlight] 
/// * [airlines] 
/// * [airports] 
/// * [topRoutes] 
@BuiltValue()
abstract class ProfileStatsResponseEntity implements Built<ProfileStatsResponseEntity, ProfileStatsResponseEntityBuilder> {
  @BuiltValueField(wireName: r'mostFlownAircraft')
  MostFlownAircraftEntity get mostFlownAircraft;

  @BuiltValueField(wireName: r'aircraftStats')
  AircraftStatsEntity? get aircraftStats;

  @BuiltValueField(wireName: r'passport')
  PassportEntity get passport;

  @BuiltValueField(wireName: r'shortestDistanceFlight')
  FlightDistanceEntity get shortestDistanceFlight;

  @BuiltValueField(wireName: r'longestDistanceFlight')
  FlightDistanceEntity get longestDistanceFlight;

  @BuiltValueField(wireName: r'shortestDurationFlight')
  FlightDurationEntity get shortestDurationFlight;

  @BuiltValueField(wireName: r'longestDurationFlight')
  FlightDurationEntity get longestDurationFlight;

  @BuiltValueField(wireName: r'airlines')
  BuiltList<AirlineStatsEntity> get airlines;

  @BuiltValueField(wireName: r'airports')
  BuiltList<AirportStatsEntity> get airports;

  @BuiltValueField(wireName: r'topRoutes')
  BuiltList<TopRouteEntity> get topRoutes;

  ProfileStatsResponseEntity._();

  factory ProfileStatsResponseEntity([void updates(ProfileStatsResponseEntityBuilder b)]) = _$ProfileStatsResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProfileStatsResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProfileStatsResponseEntity> get serializer => _$ProfileStatsResponseEntitySerializer();
}

class _$ProfileStatsResponseEntitySerializer implements PrimitiveSerializer<ProfileStatsResponseEntity> {
  @override
  final Iterable<Type> types = const [ProfileStatsResponseEntity, _$ProfileStatsResponseEntity];

  @override
  final String wireName = r'ProfileStatsResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProfileStatsResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mostFlownAircraft';
    yield serializers.serialize(
      object.mostFlownAircraft,
      specifiedType: const FullType(MostFlownAircraftEntity),
    );
    if (object.aircraftStats != null) {
      yield r'aircraftStats';
      yield serializers.serialize(
        object.aircraftStats,
        specifiedType: const FullType(AircraftStatsEntity),
      );
    }
    yield r'passport';
    yield serializers.serialize(
      object.passport,
      specifiedType: const FullType(PassportEntity),
    );
    yield r'shortestDistanceFlight';
    yield serializers.serialize(
      object.shortestDistanceFlight,
      specifiedType: const FullType(FlightDistanceEntity),
    );
    yield r'longestDistanceFlight';
    yield serializers.serialize(
      object.longestDistanceFlight,
      specifiedType: const FullType(FlightDistanceEntity),
    );
    yield r'shortestDurationFlight';
    yield serializers.serialize(
      object.shortestDurationFlight,
      specifiedType: const FullType(FlightDurationEntity),
    );
    yield r'longestDurationFlight';
    yield serializers.serialize(
      object.longestDurationFlight,
      specifiedType: const FullType(FlightDurationEntity),
    );
    yield r'airlines';
    yield serializers.serialize(
      object.airlines,
      specifiedType: const FullType(BuiltList, [FullType(AirlineStatsEntity)]),
    );
    yield r'airports';
    yield serializers.serialize(
      object.airports,
      specifiedType: const FullType(BuiltList, [FullType(AirportStatsEntity)]),
    );
    yield r'topRoutes';
    yield serializers.serialize(
      object.topRoutes,
      specifiedType: const FullType(BuiltList, [FullType(TopRouteEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProfileStatsResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProfileStatsResponseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mostFlownAircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MostFlownAircraftEntity),
          ) as MostFlownAircraftEntity;
          result.mostFlownAircraft.replace(valueDes);
          break;
        case r'aircraftStats':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AircraftStatsEntity),
          ) as AircraftStatsEntity;
          result.aircraftStats.replace(valueDes);
          break;
        case r'passport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PassportEntity),
          ) as PassportEntity;
          result.passport.replace(valueDes);
          break;
        case r'shortestDistanceFlight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightDistanceEntity),
          ) as FlightDistanceEntity;
          result.shortestDistanceFlight.replace(valueDes);
          break;
        case r'longestDistanceFlight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightDistanceEntity),
          ) as FlightDistanceEntity;
          result.longestDistanceFlight.replace(valueDes);
          break;
        case r'shortestDurationFlight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightDurationEntity),
          ) as FlightDurationEntity;
          result.shortestDurationFlight.replace(valueDes);
          break;
        case r'longestDurationFlight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightDurationEntity),
          ) as FlightDurationEntity;
          result.longestDurationFlight.replace(valueDes);
          break;
        case r'airlines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AirlineStatsEntity)]),
          ) as BuiltList<AirlineStatsEntity>;
          result.airlines.replace(valueDes);
          break;
        case r'airports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AirportStatsEntity)]),
          ) as BuiltList<AirportStatsEntity>;
          result.airports.replace(valueDes);
          break;
        case r'topRoutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TopRouteEntity)]),
          ) as BuiltList<TopRouteEntity>;
          result.topRoutes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProfileStatsResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProfileStatsResponseEntityBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

