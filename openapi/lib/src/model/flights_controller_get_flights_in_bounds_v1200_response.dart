//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_bounds.dart';
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_flights_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_controller_get_flights_in_bounds_v1200_response.g.dart';

/// FlightsControllerGetFlightsInBoundsV1200Response
///
/// Properties:
/// * [success] 
/// * [timestamp] 
/// * [bounds] 
/// * [totalAircraft] 
/// * [airborneAircraft] 
/// * [flights] 
@BuiltValue()
abstract class FlightsControllerGetFlightsInBoundsV1200Response implements Built<FlightsControllerGetFlightsInBoundsV1200Response, FlightsControllerGetFlightsInBoundsV1200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  @BuiltValueField(wireName: r'bounds')
  FlightsControllerGetFlightsInBoundsV1200ResponseBounds? get bounds;

  @BuiltValueField(wireName: r'totalAircraft')
  num? get totalAircraft;

  @BuiltValueField(wireName: r'airborneAircraft')
  num? get airborneAircraft;

  @BuiltValueField(wireName: r'flights')
  BuiltList<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>? get flights;

  FlightsControllerGetFlightsInBoundsV1200Response._();

  factory FlightsControllerGetFlightsInBoundsV1200Response([void updates(FlightsControllerGetFlightsInBoundsV1200ResponseBuilder b)]) = _$FlightsControllerGetFlightsInBoundsV1200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsControllerGetFlightsInBoundsV1200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsControllerGetFlightsInBoundsV1200Response> get serializer => _$FlightsControllerGetFlightsInBoundsV1200ResponseSerializer();
}

class _$FlightsControllerGetFlightsInBoundsV1200ResponseSerializer implements PrimitiveSerializer<FlightsControllerGetFlightsInBoundsV1200Response> {
  @override
  final Iterable<Type> types = const [FlightsControllerGetFlightsInBoundsV1200Response, _$FlightsControllerGetFlightsInBoundsV1200Response];

  @override
  final String wireName = r'FlightsControllerGetFlightsInBoundsV1200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.bounds != null) {
      yield r'bounds';
      yield serializers.serialize(
        object.bounds,
        specifiedType: const FullType(FlightsControllerGetFlightsInBoundsV1200ResponseBounds),
      );
    }
    if (object.totalAircraft != null) {
      yield r'totalAircraft';
      yield serializers.serialize(
        object.totalAircraft,
        specifiedType: const FullType(num),
      );
    }
    if (object.airborneAircraft != null) {
      yield r'airborneAircraft';
      yield serializers.serialize(
        object.airborneAircraft,
        specifiedType: const FullType(num),
      );
    }
    if (object.flights != null) {
      yield r'flights';
      yield serializers.serialize(
        object.flights,
        specifiedType: const FullType(BuiltList, [FullType(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsControllerGetFlightsInBoundsV1200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        case r'bounds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightsControllerGetFlightsInBoundsV1200ResponseBounds),
          ) as FlightsControllerGetFlightsInBoundsV1200ResponseBounds;
          result.bounds.replace(valueDes);
          break;
        case r'totalAircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalAircraft = valueDes;
          break;
        case r'airborneAircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.airborneAircraft = valueDes;
          break;
        case r'flights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner)]),
          ) as BuiltList<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>;
          result.flights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsControllerGetFlightsInBoundsV1200ResponseBuilder();
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

