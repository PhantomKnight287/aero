//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_entity.g.dart';

/// UserEntity
///
/// Properties:
/// * [name] 
/// * [id] 
@BuiltValue()
abstract class UserEntity implements Built<UserEntity, UserEntityBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'id')
  String get id;

  UserEntity._();

  factory UserEntity([void updates(UserEntityBuilder b)]) = _$UserEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserEntity> get serializer => _$UserEntitySerializer();
}

class _$UserEntitySerializer implements PrimitiveSerializer<UserEntity> {
  @override
  final Iterable<Type> types = const [UserEntity, _$UserEntity];

  @override
  final String wireName = r'UserEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserEntityBuilder();
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

