//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delay_summary_entity.g.dart';

/// DelaySummaryEntity
///
/// Properties:
/// * [basedOn] 
/// * [arrivedCount] 
/// * [delayedCount] 
/// * [minutesLost] 
/// * [avgDelayMinutes] 
@BuiltValue()
abstract class DelaySummaryEntity implements Built<DelaySummaryEntity, DelaySummaryEntityBuilder> {
  @BuiltValueField(wireName: r'basedOn')
  num get basedOn;

  @BuiltValueField(wireName: r'arrivedCount')
  num get arrivedCount;

  @BuiltValueField(wireName: r'delayedCount')
  num get delayedCount;

  @BuiltValueField(wireName: r'minutesLost')
  num get minutesLost;

  @BuiltValueField(wireName: r'avgDelayMinutes')
  num get avgDelayMinutes;

  DelaySummaryEntity._();

  factory DelaySummaryEntity([void updates(DelaySummaryEntityBuilder b)]) = _$DelaySummaryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DelaySummaryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DelaySummaryEntity> get serializer => _$DelaySummaryEntitySerializer();
}

class _$DelaySummaryEntitySerializer implements PrimitiveSerializer<DelaySummaryEntity> {
  @override
  final Iterable<Type> types = const [DelaySummaryEntity, _$DelaySummaryEntity];

  @override
  final String wireName = r'DelaySummaryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DelaySummaryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'basedOn';
    yield serializers.serialize(
      object.basedOn,
      specifiedType: const FullType(num),
    );
    yield r'arrivedCount';
    yield serializers.serialize(
      object.arrivedCount,
      specifiedType: const FullType(num),
    );
    yield r'delayedCount';
    yield serializers.serialize(
      object.delayedCount,
      specifiedType: const FullType(num),
    );
    yield r'minutesLost';
    yield serializers.serialize(
      object.minutesLost,
      specifiedType: const FullType(num),
    );
    yield r'avgDelayMinutes';
    yield serializers.serialize(
      object.avgDelayMinutes,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DelaySummaryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DelaySummaryEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'basedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.basedOn = valueDes;
          break;
        case r'arrivedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.arrivedCount = valueDes;
          break;
        case r'delayedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.delayedCount = valueDes;
          break;
        case r'minutesLost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minutesLost = valueDes;
          break;
        case r'avgDelayMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.avgDelayMinutes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DelaySummaryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DelaySummaryEntityBuilder();
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


