//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_controller_get_flights_in_bounds_v1200_response_flights_inner_origin.g.dart';

/// FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin
///
/// Properties:
/// * [code] 
/// * [codeIcao] 
/// * [codeIata] 
/// * [name] 
/// * [city] 
/// * [timezone] 
@BuiltValue()
abstract class FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin implements Built<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin, FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder> {
  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'codeIcao')
  String? get codeIcao;

  @BuiltValueField(wireName: r'codeIata')
  String? get codeIata;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'timezone')
  String? get timezone;

  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin._();

  factory FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin([void updates(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder b)]) = _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin> get serializer => _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginSerializer();
}

class _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginSerializer implements PrimitiveSerializer<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin> {
  @override
  final Iterable<Type> types = const [FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin, _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin];

  @override
  final String wireName = r'FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.codeIcao != null) {
      yield r'codeIcao';
      yield serializers.serialize(
        object.codeIcao,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.codeIata != null) {
      yield r'codeIata';
      yield serializers.serialize(
        object.codeIata,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.timezone != null) {
      yield r'timezone';
      yield serializers.serialize(
        object.timezone,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'codeIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.codeIcao = valueDes;
          break;
        case r'codeIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.codeIata = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'timezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.timezone = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder();
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

