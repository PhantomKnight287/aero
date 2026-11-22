//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'year_count_entity.g.dart';

/// YearCountEntity
///
/// Properties:
/// * [year] 
/// * [count] 
@BuiltValue()
abstract class YearCountEntity implements Built<YearCountEntity, YearCountEntityBuilder> {
  @BuiltValueField(wireName: r'year')
  num get year;

  @BuiltValueField(wireName: r'count')
  num get count;

  YearCountEntity._();

  factory YearCountEntity([void updates(YearCountEntityBuilder b)]) = _$YearCountEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(YearCountEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<YearCountEntity> get serializer => _$YearCountEntitySerializer();
}

class _$YearCountEntitySerializer implements PrimitiveSerializer<YearCountEntity> {
  @override
  final Iterable<Type> types = const [YearCountEntity, _$YearCountEntity];

  @override
  final String wireName = r'YearCountEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    YearCountEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'year';
    yield serializers.serialize(
      object.year,
      specifiedType: const FullType(num),
    );
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    YearCountEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required YearCountEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.year = valueDes;
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
  YearCountEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = YearCountEntityBuilder();
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


