//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_controller_get_flights_in_bounds_v1200_response_bounds.g.dart';

/// FlightsControllerGetFlightsInBoundsV1200ResponseBounds
///
/// Properties:
/// * [minLat] 
/// * [maxLat] 
/// * [minLng] 
/// * [maxLng] 
@BuiltValue()
abstract class FlightsControllerGetFlightsInBoundsV1200ResponseBounds implements Built<FlightsControllerGetFlightsInBoundsV1200ResponseBounds, FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder> {
  @BuiltValueField(wireName: r'minLat')
  num? get minLat;

  @BuiltValueField(wireName: r'maxLat')
  num? get maxLat;

  @BuiltValueField(wireName: r'minLng')
  num? get minLng;

  @BuiltValueField(wireName: r'maxLng')
  num? get maxLng;

  FlightsControllerGetFlightsInBoundsV1200ResponseBounds._();

  factory FlightsControllerGetFlightsInBoundsV1200ResponseBounds([void updates(FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder b)]) = _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsControllerGetFlightsInBoundsV1200ResponseBounds> get serializer => _$FlightsControllerGetFlightsInBoundsV1200ResponseBoundsSerializer();
}

class _$FlightsControllerGetFlightsInBoundsV1200ResponseBoundsSerializer implements PrimitiveSerializer<FlightsControllerGetFlightsInBoundsV1200ResponseBounds> {
  @override
  final Iterable<Type> types = const [FlightsControllerGetFlightsInBoundsV1200ResponseBounds, _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds];

  @override
  final String wireName = r'FlightsControllerGetFlightsInBoundsV1200ResponseBounds';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200ResponseBounds object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.minLat != null) {
      yield r'minLat';
      yield serializers.serialize(
        object.minLat,
        specifiedType: const FullType(num),
      );
    }
    if (object.maxLat != null) {
      yield r'maxLat';
      yield serializers.serialize(
        object.maxLat,
        specifiedType: const FullType(num),
      );
    }
    if (object.minLng != null) {
      yield r'minLng';
      yield serializers.serialize(
        object.minLng,
        specifiedType: const FullType(num),
      );
    }
    if (object.maxLng != null) {
      yield r'maxLng';
      yield serializers.serialize(
        object.maxLng,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200ResponseBounds object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'minLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minLat = valueDes;
          break;
        case r'maxLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.maxLat = valueDes;
          break;
        case r'minLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minLng = valueDes;
          break;
        case r'maxLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.maxLng = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseBounds deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder();
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

