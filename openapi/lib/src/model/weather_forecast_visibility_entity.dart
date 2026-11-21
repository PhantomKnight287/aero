//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_forecast_visibility_entity.g.dart';

/// WeatherForecastVisibilityEntity
///
/// Properties:
/// * [symbol] 
/// * [visibility] 
/// * [units] 
@BuiltValue()
abstract class WeatherForecastVisibilityEntity implements Built<WeatherForecastVisibilityEntity, WeatherForecastVisibilityEntityBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'visibility')
  String get visibility;

  @BuiltValueField(wireName: r'units')
  JsonObject? get units;

  WeatherForecastVisibilityEntity._();

  factory WeatherForecastVisibilityEntity([void updates(WeatherForecastVisibilityEntityBuilder b)]) = _$WeatherForecastVisibilityEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherForecastVisibilityEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherForecastVisibilityEntity> get serializer => _$WeatherForecastVisibilityEntitySerializer();
}

class _$WeatherForecastVisibilityEntitySerializer implements PrimitiveSerializer<WeatherForecastVisibilityEntity> {
  @override
  final Iterable<Type> types = const [WeatherForecastVisibilityEntity, _$WeatherForecastVisibilityEntity];

  @override
  final String wireName = r'WeatherForecastVisibilityEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherForecastVisibilityEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'visibility';
    yield serializers.serialize(
      object.visibility,
      specifiedType: const FullType(String),
    );
    if (object.units != null) {
      yield r'units';
      yield serializers.serialize(
        object.units,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeatherForecastVisibilityEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherForecastVisibilityEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'visibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.visibility = valueDes;
          break;
        case r'units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.units = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeatherForecastVisibilityEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherForecastVisibilityEntityBuilder();
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


