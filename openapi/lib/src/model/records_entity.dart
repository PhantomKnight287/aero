//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_record_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'records_entity.g.dart';

/// RecordsEntity
///
/// Properties:
/// * [shortestDistance] 
/// * [longestDistance] 
/// * [shortestDuration] 
/// * [longestDuration] 
@BuiltValue()
abstract class RecordsEntity implements Built<RecordsEntity, RecordsEntityBuilder> {
  @BuiltValueField(wireName: r'shortestDistance')
  StatsRecordEntity? get shortestDistance;

  @BuiltValueField(wireName: r'longestDistance')
  StatsRecordEntity? get longestDistance;

  @BuiltValueField(wireName: r'shortestDuration')
  StatsRecordEntity? get shortestDuration;

  @BuiltValueField(wireName: r'longestDuration')
  StatsRecordEntity? get longestDuration;

  RecordsEntity._();

  factory RecordsEntity([void updates(RecordsEntityBuilder b)]) = _$RecordsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecordsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecordsEntity> get serializer => _$RecordsEntitySerializer();
}

class _$RecordsEntitySerializer implements PrimitiveSerializer<RecordsEntity> {
  @override
  final Iterable<Type> types = const [RecordsEntity, _$RecordsEntity];

  @override
  final String wireName = r'RecordsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecordsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.shortestDistance != null) {
      yield r'shortestDistance';
      yield serializers.serialize(
        object.shortestDistance,
        specifiedType: const FullType.nullable(StatsRecordEntity),
      );
    }
    if (object.longestDistance != null) {
      yield r'longestDistance';
      yield serializers.serialize(
        object.longestDistance,
        specifiedType: const FullType.nullable(StatsRecordEntity),
      );
    }
    if (object.shortestDuration != null) {
      yield r'shortestDuration';
      yield serializers.serialize(
        object.shortestDuration,
        specifiedType: const FullType.nullable(StatsRecordEntity),
      );
    }
    if (object.longestDuration != null) {
      yield r'longestDuration';
      yield serializers.serialize(
        object.longestDuration,
        specifiedType: const FullType.nullable(StatsRecordEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecordsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecordsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'shortestDistance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsRecordEntity),
          ) as StatsRecordEntity?;
          if (valueDes == null) continue;
          result.shortestDistance.replace(valueDes);
          break;
        case r'longestDistance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsRecordEntity),
          ) as StatsRecordEntity?;
          if (valueDes == null) continue;
          result.longestDistance.replace(valueDes);
          break;
        case r'shortestDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsRecordEntity),
          ) as StatsRecordEntity?;
          if (valueDes == null) continue;
          result.shortestDuration.replace(valueDes);
          break;
        case r'longestDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsRecordEntity),
          ) as StatsRecordEntity?;
          if (valueDes == null) continue;
          result.longestDuration.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecordsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecordsEntityBuilder();
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


