//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_duration_entity.g.dart';

/// FlightDurationEntity
///
/// Properties:
/// * [flight] 
/// * [durationMinutes] - Duration in minutes
@BuiltValue()
abstract class FlightDurationEntity implements Built<FlightDurationEntity, FlightDurationEntityBuilder> {
  @BuiltValueField(wireName: r'flight')
  FlightSummaryEntity get flight;

  /// Duration in minutes
  @BuiltValueField(wireName: r'durationMinutes')
  num get durationMinutes;

  FlightDurationEntity._();

  factory FlightDurationEntity([void updates(FlightDurationEntityBuilder b)]) = _$FlightDurationEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightDurationEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightDurationEntity> get serializer => _$FlightDurationEntitySerializer();
}

class _$FlightDurationEntitySerializer implements PrimitiveSerializer<FlightDurationEntity> {
  @override
  final Iterable<Type> types = const [FlightDurationEntity, _$FlightDurationEntity];

  @override
  final String wireName = r'FlightDurationEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightDurationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flight';
    yield serializers.serialize(
      object.flight,
      specifiedType: const FullType(FlightSummaryEntity),
    );
    yield r'durationMinutes';
    yield serializers.serialize(
      object.durationMinutes,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightDurationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightDurationEntityBuilder result,
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
        case r'durationMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.durationMinutes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightDurationEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightDurationEntityBuilder();
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

