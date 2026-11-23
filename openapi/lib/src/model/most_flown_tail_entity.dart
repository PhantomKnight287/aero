//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'most_flown_tail_entity.g.dart';

/// MostFlownTailEntity
///
/// Properties:
/// * [reg] 
/// * [typeName] 
/// * [count] 
@BuiltValue()
abstract class MostFlownTailEntity implements Built<MostFlownTailEntity, MostFlownTailEntityBuilder> {
  @BuiltValueField(wireName: r'reg')
  String get reg;

  @BuiltValueField(wireName: r'typeName')
  String? get typeName;

  @BuiltValueField(wireName: r'count')
  num get count;

  MostFlownTailEntity._();

  factory MostFlownTailEntity([void updates(MostFlownTailEntityBuilder b)]) = _$MostFlownTailEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MostFlownTailEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MostFlownTailEntity> get serializer => _$MostFlownTailEntitySerializer();
}

class _$MostFlownTailEntitySerializer implements PrimitiveSerializer<MostFlownTailEntity> {
  @override
  final Iterable<Type> types = const [MostFlownTailEntity, _$MostFlownTailEntity];

  @override
  final String wireName = r'MostFlownTailEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MostFlownTailEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reg';
    yield serializers.serialize(
      object.reg,
      specifiedType: const FullType(String),
    );
    if (object.typeName != null) {
      yield r'typeName';
      yield serializers.serialize(
        object.typeName,
        specifiedType: const FullType(String),
      );
    }
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MostFlownTailEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MostFlownTailEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reg = valueDes;
          break;
        case r'typeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typeName = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MostFlownTailEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MostFlownTailEntityBuilder();
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


