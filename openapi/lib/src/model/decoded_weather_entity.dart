//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'decoded_weather_entity.g.dart';

/// DecodedWeatherEntity
///
/// Properties:
/// * [raw] - Raw aviation weather string (METAR/TAF)
/// * [decoded] - Structured/decoded representation of the raw string. Null when decoding failed or no raw string was available.
@BuiltValue()
abstract class DecodedWeatherEntity implements Built<DecodedWeatherEntity, DecodedWeatherEntityBuilder> {
  /// Raw aviation weather string (METAR/TAF)
  @BuiltValueField(wireName: r'raw')
  String? get raw;

  /// Structured/decoded representation of the raw string. Null when decoding failed or no raw string was available.
  @BuiltValueField(wireName: r'decoded')
  JsonObject? get decoded;

  DecodedWeatherEntity._();

  factory DecodedWeatherEntity([void updates(DecodedWeatherEntityBuilder b)]) = _$DecodedWeatherEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DecodedWeatherEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DecodedWeatherEntity> get serializer => _$DecodedWeatherEntitySerializer();
}

class _$DecodedWeatherEntitySerializer implements PrimitiveSerializer<DecodedWeatherEntity> {
  @override
  final Iterable<Type> types = const [DecodedWeatherEntity, _$DecodedWeatherEntity];

  @override
  final String wireName = r'DecodedWeatherEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DecodedWeatherEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.raw != null) {
      yield r'raw';
      yield serializers.serialize(
        object.raw,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.decoded != null) {
      yield r'decoded';
      yield serializers.serialize(
        object.decoded,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DecodedWeatherEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DecodedWeatherEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.raw = valueDes;
          break;
        case r'decoded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.decoded = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DecodedWeatherEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DecodedWeatherEntityBuilder();
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


