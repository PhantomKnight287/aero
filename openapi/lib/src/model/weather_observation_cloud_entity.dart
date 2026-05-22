//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_observation_cloud_entity.g.dart';

/// WeatherObservationCloudEntity
///
/// Properties:
/// * [altitude] 
/// * [symbol] 
/// * [type] 
@BuiltValue()
abstract class WeatherObservationCloudEntity implements Built<WeatherObservationCloudEntity, WeatherObservationCloudEntityBuilder> {
  @BuiltValueField(wireName: r'altitude')
  JsonObject? get altitude;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'type')
  String get type;

  WeatherObservationCloudEntity._();

  factory WeatherObservationCloudEntity([void updates(WeatherObservationCloudEntityBuilder b)]) = _$WeatherObservationCloudEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherObservationCloudEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherObservationCloudEntity> get serializer => _$WeatherObservationCloudEntitySerializer();
}

class _$WeatherObservationCloudEntitySerializer implements PrimitiveSerializer<WeatherObservationCloudEntity> {
  @override
  final Iterable<Type> types = const [WeatherObservationCloudEntity, _$WeatherObservationCloudEntity];

  @override
  final String wireName = r'WeatherObservationCloudEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherObservationCloudEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.altitude != null) {
      yield r'altitude';
      yield serializers.serialize(
        object.altitude,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WeatherObservationCloudEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherObservationCloudEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'altitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.altitude = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeatherObservationCloudEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherObservationCloudEntityBuilder();
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

