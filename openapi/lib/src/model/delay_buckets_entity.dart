//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delay_buckets_entity.g.dart';

/// DelayBucketsEntity
///
/// Properties:
/// * [early] 
/// * [onTime] 
/// * [late15] 
/// * [late30] 
/// * [late45] 
/// * [cancelled] 
/// * [diverted] 
/// * [total] 
@BuiltValue()
abstract class DelayBucketsEntity implements Built<DelayBucketsEntity, DelayBucketsEntityBuilder> {
  @BuiltValueField(wireName: r'early')
  num get early;

  @BuiltValueField(wireName: r'onTime')
  num get onTime;

  @BuiltValueField(wireName: r'late15')
  num get late15;

  @BuiltValueField(wireName: r'late30')
  num get late30;

  @BuiltValueField(wireName: r'late45')
  num get late45;

  @BuiltValueField(wireName: r'cancelled')
  num get cancelled;

  @BuiltValueField(wireName: r'diverted')
  num get diverted;

  @BuiltValueField(wireName: r'total')
  num get total;

  DelayBucketsEntity._();

  factory DelayBucketsEntity([void updates(DelayBucketsEntityBuilder b)]) = _$DelayBucketsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DelayBucketsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DelayBucketsEntity> get serializer => _$DelayBucketsEntitySerializer();
}

class _$DelayBucketsEntitySerializer implements PrimitiveSerializer<DelayBucketsEntity> {
  @override
  final Iterable<Type> types = const [DelayBucketsEntity, _$DelayBucketsEntity];

  @override
  final String wireName = r'DelayBucketsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DelayBucketsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'early';
    yield serializers.serialize(
      object.early,
      specifiedType: const FullType(num),
    );
    yield r'onTime';
    yield serializers.serialize(
      object.onTime,
      specifiedType: const FullType(num),
    );
    yield r'late15';
    yield serializers.serialize(
      object.late15,
      specifiedType: const FullType(num),
    );
    yield r'late30';
    yield serializers.serialize(
      object.late30,
      specifiedType: const FullType(num),
    );
    yield r'late45';
    yield serializers.serialize(
      object.late45,
      specifiedType: const FullType(num),
    );
    yield r'cancelled';
    yield serializers.serialize(
      object.cancelled,
      specifiedType: const FullType(num),
    );
    yield r'diverted';
    yield serializers.serialize(
      object.diverted,
      specifiedType: const FullType(num),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DelayBucketsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DelayBucketsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'early':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.early = valueDes;
          break;
        case r'onTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.onTime = valueDes;
          break;
        case r'late15':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.late15 = valueDes;
          break;
        case r'late30':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.late30 = valueDes;
          break;
        case r'late45':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.late45 = valueDes;
          break;
        case r'cancelled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.cancelled = valueDes;
          break;
        case r'diverted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.diverted = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DelayBucketsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DelayBucketsEntityBuilder();
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


