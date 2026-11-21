//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/weather_forecast_cloud_entity.dart';
import 'package:openapi/src/model/weather_forecast_visibility_entity.dart';
import 'package:openapi/src/model/weather_forecast_windshear_entity.dart';
import 'package:openapi/src/model/weather_forecast_winds_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_forecast_line_entity.g.dart';

/// WeatherForecastLineEntity
///
/// Properties:
/// * [type] 
/// * [start] 
/// * [end] 
/// * [turbulenceLayers] 
/// * [icingLayers] 
/// * [barometricPressure] 
/// * [significantWeather] 
/// * [winds] 
/// * [windshear] 
/// * [visibility] 
/// * [clouds] 
@BuiltValue()
abstract class WeatherForecastLineEntity implements Built<WeatherForecastLineEntity, WeatherForecastLineEntityBuilder> {
  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'start')
  String get start;

  @BuiltValueField(wireName: r'end')
  JsonObject? get end;

  @BuiltValueField(wireName: r'turbulence_layers')
  JsonObject? get turbulenceLayers;

  @BuiltValueField(wireName: r'icing_layers')
  JsonObject? get icingLayers;

  @BuiltValueField(wireName: r'barometric_pressure')
  JsonObject? get barometricPressure;

  @BuiltValueField(wireName: r'significant_weather')
  JsonObject? get significantWeather;

  @BuiltValueField(wireName: r'winds')
  WeatherForecastWindsEntity? get winds;

  @BuiltValueField(wireName: r'windshear')
  WeatherForecastWindshearEntity? get windshear;

  @BuiltValueField(wireName: r'visibility')
  WeatherForecastVisibilityEntity? get visibility;

  @BuiltValueField(wireName: r'clouds')
  BuiltList<WeatherForecastCloudEntity>? get clouds;

  WeatherForecastLineEntity._();

  factory WeatherForecastLineEntity([void updates(WeatherForecastLineEntityBuilder b)]) = _$WeatherForecastLineEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherForecastLineEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherForecastLineEntity> get serializer => _$WeatherForecastLineEntitySerializer();
}

class _$WeatherForecastLineEntitySerializer implements PrimitiveSerializer<WeatherForecastLineEntity> {
  @override
  final Iterable<Type> types = const [WeatherForecastLineEntity, _$WeatherForecastLineEntity];

  @override
  final String wireName = r'WeatherForecastLineEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherForecastLineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'start';
    yield serializers.serialize(
      object.start,
      specifiedType: const FullType(String),
    );
    if (object.end != null) {
      yield r'end';
      yield serializers.serialize(
        object.end,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.turbulenceLayers != null) {
      yield r'turbulence_layers';
      yield serializers.serialize(
        object.turbulenceLayers,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.icingLayers != null) {
      yield r'icing_layers';
      yield serializers.serialize(
        object.icingLayers,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.barometricPressure != null) {
      yield r'barometric_pressure';
      yield serializers.serialize(
        object.barometricPressure,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.significantWeather != null) {
      yield r'significant_weather';
      yield serializers.serialize(
        object.significantWeather,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.winds != null) {
      yield r'winds';
      yield serializers.serialize(
        object.winds,
        specifiedType: const FullType(WeatherForecastWindsEntity),
      );
    }
    if (object.windshear != null) {
      yield r'windshear';
      yield serializers.serialize(
        object.windshear,
        specifiedType: const FullType(WeatherForecastWindshearEntity),
      );
    }
    if (object.visibility != null) {
      yield r'visibility';
      yield serializers.serialize(
        object.visibility,
        specifiedType: const FullType(WeatherForecastVisibilityEntity),
      );
    }
    if (object.clouds != null) {
      yield r'clouds';
      yield serializers.serialize(
        object.clouds,
        specifiedType: const FullType(BuiltList, [FullType(WeatherForecastCloudEntity)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeatherForecastLineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherForecastLineEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.start = valueDes;
          break;
        case r'end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.end = valueDes;
          break;
        case r'turbulence_layers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.turbulenceLayers = valueDes;
          break;
        case r'icing_layers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.icingLayers = valueDes;
          break;
        case r'barometric_pressure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.barometricPressure = valueDes;
          break;
        case r'significant_weather':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.significantWeather = valueDes;
          break;
        case r'winds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WeatherForecastWindsEntity),
          ) as WeatherForecastWindsEntity?;
          if (valueDes == null) continue;
          result.winds.replace(valueDes);
          break;
        case r'windshear':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WeatherForecastWindshearEntity),
          ) as WeatherForecastWindshearEntity?;
          if (valueDes == null) continue;
          result.windshear.replace(valueDes);
          break;
        case r'visibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WeatherForecastVisibilityEntity),
          ) as WeatherForecastVisibilityEntity?;
          if (valueDes == null) continue;
          result.visibility.replace(valueDes);
          break;
        case r'clouds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(WeatherForecastCloudEntity)]),
          ) as BuiltList<WeatherForecastCloudEntity>?;
          if (valueDes == null) continue;
          result.clouds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeatherForecastLineEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherForecastLineEntityBuilder();
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


