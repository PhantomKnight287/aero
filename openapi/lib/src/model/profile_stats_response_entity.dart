//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/country_entity.dart';
import 'package:openapi/src/model/flights_per_entity.dart';
import 'package:openapi/src/model/runways_entity.dart';
import 'package:openapi/src/model/extremes_entity.dart';
import 'package:openapi/src/model/records_entity.dart';
import 'package:openapi/src/model/delay_summary_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/top_airport_entity.dart';
import 'package:openapi/src/model/top_airline_entity.dart';
import 'package:openapi/src/model/top_route_entity.dart';
import 'package:openapi/src/model/map_data_entity.dart';
import 'package:openapi/src/model/passport_entity.dart';
import 'package:openapi/src/model/aircraft_section_entity.dart';
import 'package:openapi/src/model/continent_entity.dart';
import 'package:openapi/src/model/taxi_by_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile_stats_response_entity.g.dart';

/// ProfileStatsResponseEntity
///
/// Properties:
/// * [availableYears] - Years with counted flights, descending
/// * [year] 
/// * [passport] 
/// * [flightsPer] 
/// * [records] 
/// * [topAirports] 
/// * [topAirlines] 
/// * [topRoutes] 
/// * [countries] 
/// * [continents] 
/// * [delays] 
/// * [runways] 
/// * [taxiByAirport] 
/// * [extremes] 
/// * [map] 
/// * [aircraft] 
@BuiltValue()
abstract class ProfileStatsResponseEntity implements Built<ProfileStatsResponseEntity, ProfileStatsResponseEntityBuilder> {
  /// Years with counted flights, descending
  @BuiltValueField(wireName: r'availableYears')
  BuiltList<num> get availableYears;

  @BuiltValueField(wireName: r'year')
  num? get year;

  @BuiltValueField(wireName: r'passport')
  PassportEntity get passport;

  @BuiltValueField(wireName: r'flightsPer')
  FlightsPerEntity get flightsPer;

  @BuiltValueField(wireName: r'records')
  RecordsEntity get records;

  @BuiltValueField(wireName: r'topAirports')
  BuiltList<TopAirportEntity> get topAirports;

  @BuiltValueField(wireName: r'topAirlines')
  BuiltList<TopAirlineEntity> get topAirlines;

  @BuiltValueField(wireName: r'topRoutes')
  BuiltList<TopRouteEntity> get topRoutes;

  @BuiltValueField(wireName: r'countries')
  BuiltList<CountryEntity> get countries;

  @BuiltValueField(wireName: r'continents')
  BuiltList<ContinentEntity> get continents;

  @BuiltValueField(wireName: r'delays')
  DelaySummaryEntity get delays;

  @BuiltValueField(wireName: r'runways')
  RunwaysEntity get runways;

  @BuiltValueField(wireName: r'taxiByAirport')
  TaxiByAirportEntity get taxiByAirport;

  @BuiltValueField(wireName: r'extremes')
  ExtremesEntity get extremes;

  @BuiltValueField(wireName: r'map')
  MapDataEntity get map;

  @BuiltValueField(wireName: r'aircraft')
  AircraftSectionEntity get aircraft;

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
    yield r'availableYears';
    yield serializers.serialize(
      object.availableYears,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
    if (object.year != null) {
      yield r'year';
      yield serializers.serialize(
        object.year,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'passport';
    yield serializers.serialize(
      object.passport,
      specifiedType: const FullType(PassportEntity),
    );
    yield r'flightsPer';
    yield serializers.serialize(
      object.flightsPer,
      specifiedType: const FullType(FlightsPerEntity),
    );
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(RecordsEntity),
    );
    yield r'topAirports';
    yield serializers.serialize(
      object.topAirports,
      specifiedType: const FullType(BuiltList, [FullType(TopAirportEntity)]),
    );
    yield r'topAirlines';
    yield serializers.serialize(
      object.topAirlines,
      specifiedType: const FullType(BuiltList, [FullType(TopAirlineEntity)]),
    );
    yield r'topRoutes';
    yield serializers.serialize(
      object.topRoutes,
      specifiedType: const FullType(BuiltList, [FullType(TopRouteEntity)]),
    );
    yield r'countries';
    yield serializers.serialize(
      object.countries,
      specifiedType: const FullType(BuiltList, [FullType(CountryEntity)]),
    );
    yield r'continents';
    yield serializers.serialize(
      object.continents,
      specifiedType: const FullType(BuiltList, [FullType(ContinentEntity)]),
    );
    yield r'delays';
    yield serializers.serialize(
      object.delays,
      specifiedType: const FullType(DelaySummaryEntity),
    );
    yield r'runways';
    yield serializers.serialize(
      object.runways,
      specifiedType: const FullType(RunwaysEntity),
    );
    yield r'taxiByAirport';
    yield serializers.serialize(
      object.taxiByAirport,
      specifiedType: const FullType(TaxiByAirportEntity),
    );
    yield r'extremes';
    yield serializers.serialize(
      object.extremes,
      specifiedType: const FullType(ExtremesEntity),
    );
    yield r'map';
    yield serializers.serialize(
      object.map,
      specifiedType: const FullType(MapDataEntity),
    );
    yield r'aircraft';
    yield serializers.serialize(
      object.aircraft,
      specifiedType: const FullType(AircraftSectionEntity),
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
        case r'availableYears':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.availableYears.replace(valueDes);
          break;
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.year = valueDes;
          break;
        case r'passport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PassportEntity),
          ) as PassportEntity;
          result.passport.replace(valueDes);
          break;
        case r'flightsPer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightsPerEntity),
          ) as FlightsPerEntity;
          result.flightsPer.replace(valueDes);
          break;
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecordsEntity),
          ) as RecordsEntity;
          result.records.replace(valueDes);
          break;
        case r'topAirports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TopAirportEntity)]),
          ) as BuiltList<TopAirportEntity>;
          result.topAirports.replace(valueDes);
          break;
        case r'topAirlines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TopAirlineEntity)]),
          ) as BuiltList<TopAirlineEntity>;
          result.topAirlines.replace(valueDes);
          break;
        case r'topRoutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TopRouteEntity)]),
          ) as BuiltList<TopRouteEntity>;
          result.topRoutes.replace(valueDes);
          break;
        case r'countries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CountryEntity)]),
          ) as BuiltList<CountryEntity>;
          result.countries.replace(valueDes);
          break;
        case r'continents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ContinentEntity)]),
          ) as BuiltList<ContinentEntity>;
          result.continents.replace(valueDes);
          break;
        case r'delays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DelaySummaryEntity),
          ) as DelaySummaryEntity;
          result.delays.replace(valueDes);
          break;
        case r'runways':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RunwaysEntity),
          ) as RunwaysEntity;
          result.runways.replace(valueDes);
          break;
        case r'taxiByAirport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaxiByAirportEntity),
          ) as TaxiByAirportEntity;
          result.taxiByAirport.replace(valueDes);
          break;
        case r'extremes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExtremesEntity),
          ) as ExtremesEntity;
          result.extremes.replace(valueDes);
          break;
        case r'map':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MapDataEntity),
          ) as MapDataEntity;
          result.map.replace(valueDes);
          break;
        case r'aircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AircraftSectionEntity),
          ) as AircraftSectionEntity;
          result.aircraft.replace(valueDes);
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


