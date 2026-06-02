//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/decoded_weather_entity.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_details_entity.g.dart';

/// AirportDetailsEntity
///
/// Properties:
/// * [ident] - Airport identifier (ICAO)
/// * [delays] - FlightAware airport delay information, if any
/// * [metar] - Latest METAR observation (raw + decoded)
/// * [taf] - TAF forecast (raw + decoded)
@BuiltValue()
abstract class AirportDetailsEntity implements Built<AirportDetailsEntity, AirportDetailsEntityBuilder> {
  /// Airport identifier (ICAO)
  @BuiltValueField(wireName: r'ident')
  String get ident;

  /// FlightAware airport delay information, if any
  @BuiltValueField(wireName: r'delays')
  JsonObject? get delays;

  /// Latest METAR observation (raw + decoded)
  @BuiltValueField(wireName: r'metar')
  DecodedWeatherEntity? get metar;

  /// TAF forecast (raw + decoded)
  @BuiltValueField(wireName: r'taf')
  DecodedWeatherEntity? get taf;

  AirportDetailsEntity._();

  factory AirportDetailsEntity([void updates(AirportDetailsEntityBuilder b)]) = _$AirportDetailsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportDetailsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportDetailsEntity> get serializer => _$AirportDetailsEntitySerializer();
}

class _$AirportDetailsEntitySerializer implements PrimitiveSerializer<AirportDetailsEntity> {
  @override
  final Iterable<Type> types = const [AirportDetailsEntity, _$AirportDetailsEntity];

  @override
  final String wireName = r'AirportDetailsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportDetailsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'ident';
    yield serializers.serialize(
      object.ident,
      specifiedType: const FullType(String),
    );
    if (object.delays != null) {
      yield r'delays';
      yield serializers.serialize(
        object.delays,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.metar != null) {
      yield r'metar';
      yield serializers.serialize(
        object.metar,
        specifiedType: const FullType.nullable(DecodedWeatherEntity),
      );
    }
    if (object.taf != null) {
      yield r'taf';
      yield serializers.serialize(
        object.taf,
        specifiedType: const FullType.nullable(DecodedWeatherEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportDetailsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportDetailsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ident':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ident = valueDes;
          break;
        case r'delays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.delays = valueDes;
          break;
        case r'metar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DecodedWeatherEntity),
          ) as DecodedWeatherEntity?;
          if (valueDes == null) continue;
          result.metar.replace(valueDes);
          break;
        case r'taf':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DecodedWeatherEntity),
          ) as DecodedWeatherEntity?;
          if (valueDes == null) continue;
          result.taf.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportDetailsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportDetailsEntityBuilder();
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

