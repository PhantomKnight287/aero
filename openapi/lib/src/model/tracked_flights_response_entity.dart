//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/flight_response_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tracked_flights_response_entity.g.dart';

/// TrackedFlightsResponseEntity
///
/// Properties:
/// * [success] 
/// * [total] 
/// * [flights] 
@BuiltValue()
abstract class TrackedFlightsResponseEntity implements Built<TrackedFlightsResponseEntity, TrackedFlightsResponseEntityBuilder> {
  @BuiltValueField(wireName: r'success')
  bool get success;

  @BuiltValueField(wireName: r'total')
  num get total;

  @BuiltValueField(wireName: r'flights')
  BuiltList<FlightResponseEntity> get flights;

  TrackedFlightsResponseEntity._();

  factory TrackedFlightsResponseEntity([void updates(TrackedFlightsResponseEntityBuilder b)]) = _$TrackedFlightsResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TrackedFlightsResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TrackedFlightsResponseEntity> get serializer => _$TrackedFlightsResponseEntitySerializer();
}

class _$TrackedFlightsResponseEntitySerializer implements PrimitiveSerializer<TrackedFlightsResponseEntity> {
  @override
  final Iterable<Type> types = const [TrackedFlightsResponseEntity, _$TrackedFlightsResponseEntity];

  @override
  final String wireName = r'TrackedFlightsResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TrackedFlightsResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(bool),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(num),
    );
    yield r'flights';
    yield serializers.serialize(
      object.flights,
      specifiedType: const FullType(BuiltList, [FullType(FlightResponseEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TrackedFlightsResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TrackedFlightsResponseEntityBuilder result,
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
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.total = valueDes;
          break;
        case r'flights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FlightResponseEntity)]),
          ) as BuiltList<FlightResponseEntity>;
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
  TrackedFlightsResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TrackedFlightsResponseEntityBuilder();
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

