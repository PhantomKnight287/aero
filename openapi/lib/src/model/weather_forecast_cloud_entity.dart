//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weather_forecast_cloud_entity.g.dart';

/// WeatherForecastCloudEntity
///
/// Properties:
/// * [symbol] 
/// * [coverage] 
/// * [altitude] 
/// * [special] 
@BuiltValue()
abstract class WeatherForecastCloudEntity implements Built<WeatherForecastCloudEntity, WeatherForecastCloudEntityBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'coverage')
  WeatherForecastCloudEntityCoverageEnum? get coverage;
  // enum coverageEnum {  ,  sky_clear,  few,  scattered,  broken,  overcast,  };

  @BuiltValueField(wireName: r'altitude')
  JsonObject? get altitude;

  @BuiltValueField(wireName: r'special')
  JsonObject? get special;

  WeatherForecastCloudEntity._();

  factory WeatherForecastCloudEntity([void updates(WeatherForecastCloudEntityBuilder b)]) = _$WeatherForecastCloudEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WeatherForecastCloudEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WeatherForecastCloudEntity> get serializer => _$WeatherForecastCloudEntitySerializer();
}

class _$WeatherForecastCloudEntitySerializer implements PrimitiveSerializer<WeatherForecastCloudEntity> {
  @override
  final Iterable<Type> types = const [WeatherForecastCloudEntity, _$WeatherForecastCloudEntity];

  @override
  final String wireName = r'WeatherForecastCloudEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WeatherForecastCloudEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    if (object.coverage != null) {
      yield r'coverage';
      yield serializers.serialize(
        object.coverage,
        specifiedType: const FullType.nullable(WeatherForecastCloudEntityCoverageEnum),
      );
    }
    if (object.altitude != null) {
      yield r'altitude';
      yield serializers.serialize(
        object.altitude,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.special != null) {
      yield r'special';
      yield serializers.serialize(
        object.special,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WeatherForecastCloudEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WeatherForecastCloudEntityBuilder result,
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
        case r'coverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WeatherForecastCloudEntityCoverageEnum),
          ) as WeatherForecastCloudEntityCoverageEnum?;
          if (valueDes == null) continue;
          result.coverage = valueDes;
          break;
        case r'altitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.altitude = valueDes;
          break;
        case r'special':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.special = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WeatherForecastCloudEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WeatherForecastCloudEntityBuilder();
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


class WeatherForecastCloudEntityCoverageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'')
  static const WeatherForecastCloudEntityCoverageEnum empty = _$weatherForecastCloudEntityCoverageEnum_empty;
  @BuiltValueEnumConst(wireName: r'sky_clear')
  static const WeatherForecastCloudEntityCoverageEnum skyClear = _$weatherForecastCloudEntityCoverageEnum_skyClear;
  @BuiltValueEnumConst(wireName: r'few')
  static const WeatherForecastCloudEntityCoverageEnum few = _$weatherForecastCloudEntityCoverageEnum_few;
  @BuiltValueEnumConst(wireName: r'scattered')
  static const WeatherForecastCloudEntityCoverageEnum scattered = _$weatherForecastCloudEntityCoverageEnum_scattered;
  @BuiltValueEnumConst(wireName: r'broken')
  static const WeatherForecastCloudEntityCoverageEnum broken = _$weatherForecastCloudEntityCoverageEnum_broken;
  @BuiltValueEnumConst(wireName: r'overcast')
  static const WeatherForecastCloudEntityCoverageEnum overcast = _$weatherForecastCloudEntityCoverageEnum_overcast;

  static Serializer<WeatherForecastCloudEntityCoverageEnum> get serializer => _$weatherForecastCloudEntityCoverageEnumSerializer;

  const WeatherForecastCloudEntityCoverageEnum._(String name): super(name);

  static BuiltSet<WeatherForecastCloudEntityCoverageEnum> get values => _$weatherForecastCloudEntityCoverageEnumValues;
  static WeatherForecastCloudEntityCoverageEnum valueOf(String name) => _$weatherForecastCloudEntityCoverageEnumValueOf(name);
}

