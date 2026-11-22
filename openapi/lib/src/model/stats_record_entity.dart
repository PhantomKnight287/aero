//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stats_record_entity.g.dart';

/// StatsRecordEntity
///
/// Properties:
/// * [flight] 
/// * [value] 
@BuiltValue()
abstract class StatsRecordEntity implements Built<StatsRecordEntity, StatsRecordEntityBuilder> {
  @BuiltValueField(wireName: r'flight')
  StatsFlightSummaryEntity get flight;

  @BuiltValueField(wireName: r'value')
  num get value;

  StatsRecordEntity._();

  factory StatsRecordEntity([void updates(StatsRecordEntityBuilder b)]) = _$StatsRecordEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatsRecordEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatsRecordEntity> get serializer => _$StatsRecordEntitySerializer();
}

class _$StatsRecordEntitySerializer implements PrimitiveSerializer<StatsRecordEntity> {
  @override
  final Iterable<Type> types = const [StatsRecordEntity, _$StatsRecordEntity];

  @override
  final String wireName = r'StatsRecordEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatsRecordEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flight';
    yield serializers.serialize(
      object.flight,
      specifiedType: const FullType(StatsFlightSummaryEntity),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StatsRecordEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatsRecordEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsFlightSummaryEntity),
          ) as StatsFlightSummaryEntity;
          result.flight.replace(valueDes);
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatsRecordEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatsRecordEntityBuilder();
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


