//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/weather_forecast_line_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_forecast_decoded_entity.g.dart';

/// WeatherForecastDecodedEntity
///
/// Properties:
/// * [start] 
/// * [end] 
/// * [lines] 
@BuiltValue()
abstract class WeatherForecastDecodedEntity implements Built<WeatherForecastDecodedEntity, WeatherForecastDecodedEntityBuilder> {
  @BuiltValueField(wireName: r'start')
  String get start;

  @BuiltValueField(wireName: r'end')
  String get end;

  @BuiltValueField(wireName: r'lines')
  BuiltList<WeatherForecastLineEntity>? get lines;

  WeatherForecastDecodedEntity._();

  factory WeatherForecastDecodedEntity([void updates(WeatherForecastDecodedEntityBuilder b)]) = _$WeatherForecastDecodedEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherForecastDecodedEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherForecastDecodedEntity> get serializer => _$WeatherForecastDecodedEntitySerializer();
}

class _$WeatherForecastDecodedEntitySerializer implements PrimitiveSerializer<WeatherForecastDecodedEntity> {
  @override
  final Iterable<Type> types = const [WeatherForecastDecodedEntity, _$WeatherForecastDecodedEntity];

  @override
  final String wireName = r'WeatherForecastDecodedEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherForecastDecodedEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'start';
    yield serializers.serialize(
      object.start,
      specifiedType: const FullType(String),
    );
    yield r'end';
    yield serializers.serialize(
      object.end,
      specifiedType: const FullType(String),
    );
    if (object.lines != null) {
      yield r'lines';
      yield serializers.serialize(
        object.lines,
        specifiedType: const FullType(BuiltList, [FullType(WeatherForecastLineEntity)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeatherForecastDecodedEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherForecastDecodedEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(String),
          ) as String;
          result.end = valueDes;
          break;
        case r'lines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WeatherForecastLineEntity)]),
          ) as BuiltList<WeatherForecastLineEntity>;
          result.lines.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeatherForecastDecodedEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherForecastDecodedEntityBuilder();
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

