//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generic_error_entity.g.dart';

/// GenericErrorEntity
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class GenericErrorEntity implements Built<GenericErrorEntity, GenericErrorEntityBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  GenericErrorEntity._();

  factory GenericErrorEntity([void updates(GenericErrorEntityBuilder b)]) = _$GenericErrorEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenericErrorEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenericErrorEntity> get serializer => _$GenericErrorEntitySerializer();
}

class _$GenericErrorEntitySerializer implements PrimitiveSerializer<GenericErrorEntity> {
  @override
  final Iterable<Type> types = const [GenericErrorEntity, _$GenericErrorEntity];

  @override
  final String wireName = r'GenericErrorEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenericErrorEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GenericErrorEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenericErrorEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenericErrorEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenericErrorEntityBuilder();
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

