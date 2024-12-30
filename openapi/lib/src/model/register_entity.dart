//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_entity.g.dart';

/// RegisterEntity
///
/// Properties:
/// * [token] - JWT token which will be used for all other requests
/// * [user] 
@BuiltValue()
abstract class RegisterEntity implements Built<RegisterEntity, RegisterEntityBuilder> {
  /// JWT token which will be used for all other requests
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'user')
  UserEntity get user;

  RegisterEntity._();

  factory RegisterEntity([void updates(RegisterEntityBuilder b)]) = _$RegisterEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterEntity> get serializer => _$RegisterEntitySerializer();
}

class _$RegisterEntitySerializer implements PrimitiveSerializer<RegisterEntity> {
  @override
  final Iterable<Type> types = const [RegisterEntity, _$RegisterEntity];

  @override
  final String wireName = r'RegisterEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(UserEntity),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserEntity),
          ) as UserEntity;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegisterEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterEntityBuilder();
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

