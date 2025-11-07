//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_distance_entity.g.dart';

/// FlightDistanceEntity
///
/// Properties:
/// * [flight] 
/// * [distanceKm] - Distance in kilometers
@BuiltValue()
abstract class FlightDistanceEntity implements Built<FlightDistanceEntity, FlightDistanceEntityBuilder> {
  @BuiltValueField(wireName: r'flight')
  FlightSummaryEntity get flight;

  /// Distance in kilometers
  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  FlightDistanceEntity._();

  factory FlightDistanceEntity([void updates(FlightDistanceEntityBuilder b)]) = _$FlightDistanceEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightDistanceEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightDistanceEntity> get serializer => _$FlightDistanceEntitySerializer();
}

class _$FlightDistanceEntitySerializer implements PrimitiveSerializer<FlightDistanceEntity> {
  @override
  final Iterable<Type> types = const [FlightDistanceEntity, _$FlightDistanceEntity];

  @override
  final String wireName = r'FlightDistanceEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightDistanceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flight';
    yield serializers.serialize(
      object.flight,
      specifiedType: const FullType(FlightSummaryEntity),
    );
    yield r'distanceKm';
    yield serializers.serialize(
      object.distanceKm,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightDistanceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightDistanceEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightSummaryEntity),
          ) as FlightSummaryEntity;
          result.flight.replace(valueDes);
          break;
        case r'distanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.distanceKm = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightDistanceEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightDistanceEntityBuilder();
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

