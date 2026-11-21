//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_controller_delete_flight_v1200_response.g.dart';

/// FlightControllerDeleteFlightV1200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class FlightControllerDeleteFlightV1200Response implements Built<FlightControllerDeleteFlightV1200Response, FlightControllerDeleteFlightV1200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  FlightControllerDeleteFlightV1200Response._();

  factory FlightControllerDeleteFlightV1200Response([void updates(FlightControllerDeleteFlightV1200ResponseBuilder b)]) = _$FlightControllerDeleteFlightV1200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightControllerDeleteFlightV1200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightControllerDeleteFlightV1200Response> get serializer => _$FlightControllerDeleteFlightV1200ResponseSerializer();
}

class _$FlightControllerDeleteFlightV1200ResponseSerializer implements PrimitiveSerializer<FlightControllerDeleteFlightV1200Response> {
  @override
  final Iterable<Type> types = const [FlightControllerDeleteFlightV1200Response, _$FlightControllerDeleteFlightV1200Response];

  @override
  final String wireName = r'FlightControllerDeleteFlightV1200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightControllerDeleteFlightV1200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightControllerDeleteFlightV1200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightControllerDeleteFlightV1200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightControllerDeleteFlightV1200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightControllerDeleteFlightV1200ResponseBuilder();
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


