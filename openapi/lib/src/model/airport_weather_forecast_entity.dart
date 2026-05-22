//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/weather_forecast_decoded_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_weather_forecast_entity.g.dart';

/// AirportWeatherForecastEntity
///
/// Properties:
/// * [airportCode] 
/// * [rawForecast] 
/// * [time] 
/// * [decodedForecast] 
@BuiltValue()
abstract class AirportWeatherForecastEntity implements Built<AirportWeatherForecastEntity, AirportWeatherForecastEntityBuilder> {
  @BuiltValueField(wireName: r'airport_code')
  String get airportCode;

  @BuiltValueField(wireName: r'raw_forecast')
  BuiltList<String> get rawForecast;

  @BuiltValueField(wireName: r'time')
  String get time;

  @BuiltValueField(wireName: r'decoded_forecast')
  WeatherForecastDecodedEntity? get decodedForecast;

  AirportWeatherForecastEntity._();

  factory AirportWeatherForecastEntity([void updates(AirportWeatherForecastEntityBuilder b)]) = _$AirportWeatherForecastEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportWeatherForecastEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportWeatherForecastEntity> get serializer => _$AirportWeatherForecastEntitySerializer();
}

class _$AirportWeatherForecastEntitySerializer implements PrimitiveSerializer<AirportWeatherForecastEntity> {
  @override
  final Iterable<Type> types = const [AirportWeatherForecastEntity, _$AirportWeatherForecastEntity];

  @override
  final String wireName = r'AirportWeatherForecastEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportWeatherForecastEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport_code';
    yield serializers.serialize(
      object.airportCode,
      specifiedType: const FullType(String),
    );
    yield r'raw_forecast';
    yield serializers.serialize(
      object.rawForecast,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'time';
    yield serializers.serialize(
      object.time,
      specifiedType: const FullType(String),
    );
    if (object.decodedForecast != null) {
      yield r'decoded_forecast';
      yield serializers.serialize(
        object.decodedForecast,
        specifiedType: const FullType(WeatherForecastDecodedEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportWeatherForecastEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportWeatherForecastEntityBuilder result,
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
        case r'raw_forecast':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.rawForecast.replace(valueDes);
          break;
        case r'time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.time = valueDes;
          break;
        case r'decoded_forecast':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WeatherForecastDecodedEntity),
          ) as WeatherForecastDecodedEntity;
          result.decodedForecast.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportWeatherForecastEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportWeatherForecastEntityBuilder();
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

