//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'time_entity.g.dart';

/// TimeEntity
///
/// Properties:
/// * [utc] 
/// * [local] 
@BuiltValue()
abstract class TimeEntity implements Built<TimeEntity, TimeEntityBuilder> {
  @BuiltValueField(wireName: r'utc')
  String get utc;

  @BuiltValueField(wireName: r'local')
  String get local;

  TimeEntity._();

  factory TimeEntity([void updates(TimeEntityBuilder b)]) = _$TimeEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TimeEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TimeEntity> get serializer => _$TimeEntitySerializer();
}

class _$TimeEntitySerializer implements PrimitiveSerializer<TimeEntity> {
  @override
  final Iterable<Type> types = const [TimeEntity, _$TimeEntity];

  @override
  final String wireName = r'TimeEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TimeEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'utc';
    yield serializers.serialize(
      object.utc,
      specifiedType: const FullType(String),
    );
    yield r'local';
    yield serializers.serialize(
      object.local,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TimeEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TimeEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'utc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.utc = valueDes;
          break;
        case r'local':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.local = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TimeEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TimeEntityBuilder();
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

