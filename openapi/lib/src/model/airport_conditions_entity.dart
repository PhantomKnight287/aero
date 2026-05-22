//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/airport_delays_entity.dart';
import 'package:openapi/src/model/airport_weather_forecast_entity.dart';
import 'package:openapi/src/model/airport_weather_observation_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_conditions_entity.g.dart';

/// AirportConditionsEntity
///
/// Properties:
/// * [delays] 
/// * [forecast] 
/// * [observation] 
@BuiltValue()
abstract class AirportConditionsEntity implements Built<AirportConditionsEntity, AirportConditionsEntityBuilder> {
  @BuiltValueField(wireName: r'delays')
  AirportDelaysEntity? get delays;

  @BuiltValueField(wireName: r'forecast')
  AirportWeatherForecastEntity? get forecast;

  @BuiltValueField(wireName: r'observation')
  AirportWeatherObservationEntity? get observation;

  AirportConditionsEntity._();

  factory AirportConditionsEntity([void updates(AirportConditionsEntityBuilder b)]) = _$AirportConditionsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportConditionsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportConditionsEntity> get serializer => _$AirportConditionsEntitySerializer();
}

class _$AirportConditionsEntitySerializer implements PrimitiveSerializer<AirportConditionsEntity> {
  @override
  final Iterable<Type> types = const [AirportConditionsEntity, _$AirportConditionsEntity];

  @override
  final String wireName = r'AirportConditionsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportConditionsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.delays != null) {
      yield r'delays';
      yield serializers.serialize(
        object.delays,
        specifiedType: const FullType.nullable(AirportDelaysEntity),
      );
    }
    if (object.forecast != null) {
      yield r'forecast';
      yield serializers.serialize(
        object.forecast,
        specifiedType: const FullType.nullable(AirportWeatherForecastEntity),
      );
    }
    if (object.observation != null) {
      yield r'observation';
      yield serializers.serialize(
        object.observation,
        specifiedType: const FullType.nullable(AirportWeatherObservationEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportConditionsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportConditionsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'delays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirportDelaysEntity),
          ) as AirportDelaysEntity?;
          if (valueDes == null) continue;
          result.delays.replace(valueDes);
          break;
        case r'forecast':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirportWeatherForecastEntity),
          ) as AirportWeatherForecastEntity?;
          if (valueDes == null) continue;
          result.forecast.replace(valueDes);
          break;
        case r'observation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirportWeatherObservationEntity),
          ) as AirportWeatherObservationEntity?;
          if (valueDes == null) continue;
          result.observation.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportConditionsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportConditionsEntityBuilder();
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

