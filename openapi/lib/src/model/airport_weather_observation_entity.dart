//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/weather_observation_cloud_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_weather_observation_entity.g.dart';

/// AirportWeatherObservationEntity
///
/// Properties:
/// * [airportCode] 
/// * [cloudFriendly] 
/// * [clouds] 
/// * [conditions] 
/// * [pressure] 
/// * [pressureUnits] 
/// * [rawData] 
/// * [tempAir] 
/// * [tempDewpoint] 
/// * [tempPerceived] 
/// * [relativeHumidity] 
/// * [time] 
/// * [visibility] 
/// * [visibilityUnits] 
/// * [windDirection] 
/// * [windFriendly] 
/// * [windSpeed] 
/// * [windSpeedGust] 
/// * [windUnits] 
@BuiltValue()
abstract class AirportWeatherObservationEntity implements Built<AirportWeatherObservationEntity, AirportWeatherObservationEntityBuilder> {
  @BuiltValueField(wireName: r'airport_code')
  String get airportCode;

  @BuiltValueField(wireName: r'cloud_friendly')
  JsonObject? get cloudFriendly;

  @BuiltValueField(wireName: r'clouds')
  BuiltList<WeatherObservationCloudEntity>? get clouds;

  @BuiltValueField(wireName: r'conditions')
  JsonObject? get conditions;

  @BuiltValueField(wireName: r'pressure')
  JsonObject? get pressure;

  @BuiltValueField(wireName: r'pressure_units')
  AirportWeatherObservationEntityPressureUnitsEnum? get pressureUnits;
  // enum pressureUnitsEnum {  ,  mb,  in Hg,  };

  @BuiltValueField(wireName: r'raw_data')
  String get rawData;

  @BuiltValueField(wireName: r'temp_air')
  JsonObject? get tempAir;

  @BuiltValueField(wireName: r'temp_dewpoint')
  JsonObject? get tempDewpoint;

  @BuiltValueField(wireName: r'temp_perceived')
  JsonObject? get tempPerceived;

  @BuiltValueField(wireName: r'relative_humidity')
  JsonObject? get relativeHumidity;

  @BuiltValueField(wireName: r'time')
  String get time;

  @BuiltValueField(wireName: r'visibility')
  JsonObject? get visibility;

  @BuiltValueField(wireName: r'visibility_units')
  AirportWeatherObservationEntityVisibilityUnitsEnum? get visibilityUnits;
  // enum visibilityUnitsEnum {  ,  meters,  SM,  };

  @BuiltValueField(wireName: r'wind_direction')
  num get windDirection;

  @BuiltValueField(wireName: r'wind_friendly')
  String get windFriendly;

  @BuiltValueField(wireName: r'wind_speed')
  num get windSpeed;

  @BuiltValueField(wireName: r'wind_speed_gust')
  num get windSpeedGust;

  @BuiltValueField(wireName: r'wind_units')
  AirportWeatherObservationEntityWindUnitsEnum get windUnits;
  // enum windUnitsEnum {  MPS,  KT,  };

  AirportWeatherObservationEntity._();

  factory AirportWeatherObservationEntity([void updates(AirportWeatherObservationEntityBuilder b)]) = _$AirportWeatherObservationEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportWeatherObservationEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportWeatherObservationEntity> get serializer => _$AirportWeatherObservationEntitySerializer();
}

class _$AirportWeatherObservationEntitySerializer implements PrimitiveSerializer<AirportWeatherObservationEntity> {
  @override
  final Iterable<Type> types = const [AirportWeatherObservationEntity, _$AirportWeatherObservationEntity];

  @override
  final String wireName = r'AirportWeatherObservationEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportWeatherObservationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport_code';
    yield serializers.serialize(
      object.airportCode,
      specifiedType: const FullType(String),
    );
    if (object.cloudFriendly != null) {
      yield r'cloud_friendly';
      yield serializers.serialize(
        object.cloudFriendly,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.clouds != null) {
      yield r'clouds';
      yield serializers.serialize(
        object.clouds,
        specifiedType: const FullType(BuiltList, [FullType(WeatherObservationCloudEntity)]),
      );
    }
    if (object.conditions != null) {
      yield r'conditions';
      yield serializers.serialize(
        object.conditions,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.pressure != null) {
      yield r'pressure';
      yield serializers.serialize(
        object.pressure,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.pressureUnits != null) {
      yield r'pressure_units';
      yield serializers.serialize(
        object.pressureUnits,
        specifiedType: const FullType.nullable(AirportWeatherObservationEntityPressureUnitsEnum),
      );
    }
    yield r'raw_data';
    yield serializers.serialize(
      object.rawData,
      specifiedType: const FullType(String),
    );
    if (object.tempAir != null) {
      yield r'temp_air';
      yield serializers.serialize(
        object.tempAir,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.tempDewpoint != null) {
      yield r'temp_dewpoint';
      yield serializers.serialize(
        object.tempDewpoint,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.tempPerceived != null) {
      yield r'temp_perceived';
      yield serializers.serialize(
        object.tempPerceived,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.relativeHumidity != null) {
      yield r'relative_humidity';
      yield serializers.serialize(
        object.relativeHumidity,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    yield r'time';
    yield serializers.serialize(
      object.time,
      specifiedType: const FullType(String),
    );
    if (object.visibility != null) {
      yield r'visibility';
      yield serializers.serialize(
        object.visibility,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.visibilityUnits != null) {
      yield r'visibility_units';
      yield serializers.serialize(
        object.visibilityUnits,
        specifiedType: const FullType.nullable(AirportWeatherObservationEntityVisibilityUnitsEnum),
      );
    }
    yield r'wind_direction';
    yield serializers.serialize(
      object.windDirection,
      specifiedType: const FullType(num),
    );
    yield r'wind_friendly';
    yield serializers.serialize(
      object.windFriendly,
      specifiedType: const FullType(String),
    );
    yield r'wind_speed';
    yield serializers.serialize(
      object.windSpeed,
      specifiedType: const FullType(num),
    );
    yield r'wind_speed_gust';
    yield serializers.serialize(
      object.windSpeedGust,
      specifiedType: const FullType(num),
    );
    yield r'wind_units';
    yield serializers.serialize(
      object.windUnits,
      specifiedType: const FullType(AirportWeatherObservationEntityWindUnitsEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportWeatherObservationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportWeatherObservationEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airport_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airportCode = valueDes;
          break;
        case r'cloud_friendly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.cloudFriendly = valueDes;
          break;
        case r'clouds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(WeatherObservationCloudEntity)]),
          ) as BuiltList<WeatherObservationCloudEntity>?;
          if (valueDes == null) continue;
          result.clouds.replace(valueDes);
          break;
        case r'conditions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.conditions = valueDes;
          break;
        case r'pressure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.pressure = valueDes;
          break;
        case r'pressure_units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirportWeatherObservationEntityPressureUnitsEnum),
          ) as AirportWeatherObservationEntityPressureUnitsEnum?;
          if (valueDes == null) continue;
          result.pressureUnits = valueDes;
          break;
        case r'raw_data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rawData = valueDes;
          break;
        case r'temp_air':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.tempAir = valueDes;
          break;
        case r'temp_dewpoint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.tempDewpoint = valueDes;
          break;
        case r'temp_perceived':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.tempPerceived = valueDes;
          break;
        case r'relative_humidity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.relativeHumidity = valueDes;
          break;
        case r'time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.time = valueDes;
          break;
        case r'visibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.visibility = valueDes;
          break;
        case r'visibility_units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirportWeatherObservationEntityVisibilityUnitsEnum),
          ) as AirportWeatherObservationEntityVisibilityUnitsEnum?;
          if (valueDes == null) continue;
          result.visibilityUnits = valueDes;
          break;
        case r'wind_direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.windDirection = valueDes;
          break;
        case r'wind_friendly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.windFriendly = valueDes;
          break;
        case r'wind_speed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.windSpeed = valueDes;
          break;
        case r'wind_speed_gust':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.windSpeedGust = valueDes;
          break;
        case r'wind_units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirportWeatherObservationEntityWindUnitsEnum),
          ) as AirportWeatherObservationEntityWindUnitsEnum;
          result.windUnits = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportWeatherObservationEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportWeatherObservationEntityBuilder();
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


class AirportWeatherObservationEntityPressureUnitsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'')
  static const AirportWeatherObservationEntityPressureUnitsEnum empty = _$airportWeatherObservationEntityPressureUnitsEnum_empty;
  @BuiltValueEnumConst(wireName: r'mb')
  static const AirportWeatherObservationEntityPressureUnitsEnum mb = _$airportWeatherObservationEntityPressureUnitsEnum_mb;
  @BuiltValueEnumConst(wireName: r'in Hg')
  static const AirportWeatherObservationEntityPressureUnitsEnum inHg = _$airportWeatherObservationEntityPressureUnitsEnum_inHg;

  static Serializer<AirportWeatherObservationEntityPressureUnitsEnum> get serializer => _$airportWeatherObservationEntityPressureUnitsEnumSerializer;

  const AirportWeatherObservationEntityPressureUnitsEnum._(String name): super(name);

  static BuiltSet<AirportWeatherObservationEntityPressureUnitsEnum> get values => _$airportWeatherObservationEntityPressureUnitsEnumValues;
  static AirportWeatherObservationEntityPressureUnitsEnum valueOf(String name) => _$airportWeatherObservationEntityPressureUnitsEnumValueOf(name);
}

class AirportWeatherObservationEntityVisibilityUnitsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'')
  static const AirportWeatherObservationEntityVisibilityUnitsEnum empty = _$airportWeatherObservationEntityVisibilityUnitsEnum_empty;
  @BuiltValueEnumConst(wireName: r'meters')
  static const AirportWeatherObservationEntityVisibilityUnitsEnum meters = _$airportWeatherObservationEntityVisibilityUnitsEnum_meters;
  @BuiltValueEnumConst(wireName: r'SM')
  static const AirportWeatherObservationEntityVisibilityUnitsEnum SM = _$airportWeatherObservationEntityVisibilityUnitsEnum_SM;

  static Serializer<AirportWeatherObservationEntityVisibilityUnitsEnum> get serializer => _$airportWeatherObservationEntityVisibilityUnitsEnumSerializer;

  const AirportWeatherObservationEntityVisibilityUnitsEnum._(String name): super(name);

  static BuiltSet<AirportWeatherObservationEntityVisibilityUnitsEnum> get values => _$airportWeatherObservationEntityVisibilityUnitsEnumValues;
  static AirportWeatherObservationEntityVisibilityUnitsEnum valueOf(String name) => _$airportWeatherObservationEntityVisibilityUnitsEnumValueOf(name);
}

class AirportWeatherObservationEntityWindUnitsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MPS')
  static const AirportWeatherObservationEntityWindUnitsEnum MPS = _$airportWeatherObservationEntityWindUnitsEnum_MPS;
  @BuiltValueEnumConst(wireName: r'KT')
  static const AirportWeatherObservationEntityWindUnitsEnum KT = _$airportWeatherObservationEntityWindUnitsEnum_KT;

  static Serializer<AirportWeatherObservationEntityWindUnitsEnum> get serializer => _$airportWeatherObservationEntityWindUnitsEnumSerializer;

  const AirportWeatherObservationEntityWindUnitsEnum._(String name): super(name);

  static BuiltSet<AirportWeatherObservationEntityWindUnitsEnum> get values => _$airportWeatherObservationEntityWindUnitsEnumValues;
  static AirportWeatherObservationEntityWindUnitsEnum valueOf(String name) => _$airportWeatherObservationEntityWindUnitsEnumValueOf(name);
}

