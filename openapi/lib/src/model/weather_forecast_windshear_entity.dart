//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_forecast_windshear_entity.g.dart';

/// WeatherForecastWindshearEntity
///
/// Properties:
/// * [symbol] 
/// * [height] 
/// * [direction] 
/// * [speed] 
/// * [units] 
@BuiltValue()
abstract class WeatherForecastWindshearEntity implements Built<WeatherForecastWindshearEntity, WeatherForecastWindshearEntityBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'height')
  String get height;

  @BuiltValueField(wireName: r'direction')
  String get direction;

  @BuiltValueField(wireName: r'speed')
  String get speed;

  @BuiltValueField(wireName: r'units')
  JsonObject? get units;

  WeatherForecastWindshearEntity._();

  factory WeatherForecastWindshearEntity([void updates(WeatherForecastWindshearEntityBuilder b)]) = _$WeatherForecastWindshearEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherForecastWindshearEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherForecastWindshearEntity> get serializer => _$WeatherForecastWindshearEntitySerializer();
}

class _$WeatherForecastWindshearEntitySerializer implements PrimitiveSerializer<WeatherForecastWindshearEntity> {
  @override
  final Iterable<Type> types = const [WeatherForecastWindshearEntity, _$WeatherForecastWindshearEntity];

  @override
  final String wireName = r'WeatherForecastWindshearEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherForecastWindshearEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'height';
    yield serializers.serialize(
      object.height,
      specifiedType: const FullType(String),
    );
    yield r'direction';
    yield serializers.serialize(
      object.direction,
      specifiedType: const FullType(String),
    );
    yield r'speed';
    yield serializers.serialize(
      object.speed,
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
    WeatherForecastWindshearEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherForecastWindshearEntityBuilder result,
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
        case r'height':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.height = valueDes;
          break;
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.direction = valueDes;
          break;
        case r'speed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.speed = valueDes;
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
  WeatherForecastWindshearEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherForecastWindshearEntityBuilder();
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


