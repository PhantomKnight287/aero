//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_forecast_winds_entity.g.dart';

/// WeatherForecastWindsEntity
///
/// Properties:
/// * [symbol] 
/// * [direction] 
/// * [speed] 
/// * [units] 
/// * [peakGusts] 
@BuiltValue()
abstract class WeatherForecastWindsEntity implements Built<WeatherForecastWindsEntity, WeatherForecastWindsEntityBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'direction')
  String get direction;

  @BuiltValueField(wireName: r'speed')
  num get speed;

  @BuiltValueField(wireName: r'units')
  JsonObject? get units;

  @BuiltValueField(wireName: r'peak_gusts')
  JsonObject? get peakGusts;

  WeatherForecastWindsEntity._();

  factory WeatherForecastWindsEntity([void updates(WeatherForecastWindsEntityBuilder b)]) = _$WeatherForecastWindsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherForecastWindsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherForecastWindsEntity> get serializer => _$WeatherForecastWindsEntitySerializer();
}

class _$WeatherForecastWindsEntitySerializer implements PrimitiveSerializer<WeatherForecastWindsEntity> {
  @override
  final Iterable<Type> types = const [WeatherForecastWindsEntity, _$WeatherForecastWindsEntity];

  @override
  final String wireName = r'WeatherForecastWindsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherForecastWindsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
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
      specifiedType: const FullType(num),
    );
    if (object.units != null) {
      yield r'units';
      yield serializers.serialize(
        object.units,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.peakGusts != null) {
      yield r'peak_gusts';
      yield serializers.serialize(
        object.peakGusts,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeatherForecastWindsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherForecastWindsEntityBuilder result,
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
            specifiedType: const FullType(num),
          ) as num;
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
        case r'peak_gusts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.peakGusts = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeatherForecastWindsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherForecastWindsEntityBuilder();
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


