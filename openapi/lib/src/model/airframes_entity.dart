//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/airframe_entity.dart';
import 'package:openapi/src/model/most_flown_tail_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airframes_entity.g.dart';

/// AirframesEntity
///
/// Properties:
/// * [medianAgeYears] 
/// * [oldest] 
/// * [newest] 
/// * [mostFlownTail] 
@BuiltValue()
abstract class AirframesEntity implements Built<AirframesEntity, AirframesEntityBuilder> {
  @BuiltValueField(wireName: r'medianAgeYears')
  num? get medianAgeYears;

  @BuiltValueField(wireName: r'oldest')
  AirframeEntity? get oldest;

  @BuiltValueField(wireName: r'newest')
  AirframeEntity? get newest;

  @BuiltValueField(wireName: r'mostFlownTail')
  MostFlownTailEntity? get mostFlownTail;

  AirframesEntity._();

  factory AirframesEntity([void updates(AirframesEntityBuilder b)]) = _$AirframesEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirframesEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirframesEntity> get serializer => _$AirframesEntitySerializer();
}

class _$AirframesEntitySerializer implements PrimitiveSerializer<AirframesEntity> {
  @override
  final Iterable<Type> types = const [AirframesEntity, _$AirframesEntity];

  @override
  final String wireName = r'AirframesEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirframesEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.medianAgeYears != null) {
      yield r'medianAgeYears';
      yield serializers.serialize(
        object.medianAgeYears,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.oldest != null) {
      yield r'oldest';
      yield serializers.serialize(
        object.oldest,
        specifiedType: const FullType.nullable(AirframeEntity),
      );
    }
    if (object.newest != null) {
      yield r'newest';
      yield serializers.serialize(
        object.newest,
        specifiedType: const FullType.nullable(AirframeEntity),
      );
    }
    if (object.mostFlownTail != null) {
      yield r'mostFlownTail';
      yield serializers.serialize(
        object.mostFlownTail,
        specifiedType: const FullType.nullable(MostFlownTailEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AirframesEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirframesEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'medianAgeYears':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.medianAgeYears = valueDes;
          break;
        case r'oldest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirframeEntity),
          ) as AirframeEntity?;
          if (valueDes == null) continue;
          result.oldest.replace(valueDes);
          break;
        case r'newest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AirframeEntity),
          ) as AirframeEntity?;
          if (valueDes == null) continue;
          result.newest.replace(valueDes);
          break;
        case r'mostFlownTail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MostFlownTailEntity),
          ) as MostFlownTailEntity?;
          if (valueDes == null) continue;
          result.mostFlownTail.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirframesEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirframesEntityBuilder();
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


