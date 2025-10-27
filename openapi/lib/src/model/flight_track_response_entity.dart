//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/flight_position_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_track_response_entity.g.dart';

/// FlightTrackResponseEntity
///
/// Properties:
/// * [actualDistance] - Distance flown in miles as of the latest position point
/// * [positions] - Array of flight positions
@BuiltValue()
abstract class FlightTrackResponseEntity implements Built<FlightTrackResponseEntity, FlightTrackResponseEntityBuilder> {
  /// Distance flown in miles as of the latest position point
  @BuiltValueField(wireName: r'actual_distance')
  num? get actualDistance;

  /// Array of flight positions
  @BuiltValueField(wireName: r'positions')
  BuiltList<FlightPositionEntity> get positions;

  FlightTrackResponseEntity._();

  factory FlightTrackResponseEntity([void updates(FlightTrackResponseEntityBuilder b)]) = _$FlightTrackResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightTrackResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightTrackResponseEntity> get serializer => _$FlightTrackResponseEntitySerializer();
}

class _$FlightTrackResponseEntitySerializer implements PrimitiveSerializer<FlightTrackResponseEntity> {
  @override
  final Iterable<Type> types = const [FlightTrackResponseEntity, _$FlightTrackResponseEntity];

  @override
  final String wireName = r'FlightTrackResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightTrackResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.actualDistance != null) {
      yield r'actual_distance';
      yield serializers.serialize(
        object.actualDistance,
        specifiedType: const FullType(num),
      );
    }
    yield r'positions';
    yield serializers.serialize(
      object.positions,
      specifiedType: const FullType(BuiltList, [FullType(FlightPositionEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightTrackResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightTrackResponseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'actual_distance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.actualDistance = valueDes;
          break;
        case r'positions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FlightPositionEntity)]),
          ) as BuiltList<FlightPositionEntity>;
          result.positions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightTrackResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightTrackResponseEntityBuilder();
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

