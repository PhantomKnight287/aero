//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'great_circle_distance_entity.g.dart';

/// GreatCircleDistanceEntity
///
/// Properties:
/// * [meter] 
/// * [km] 
/// * [mile] 
/// * [nm] 
/// * [feet] 
@BuiltValue()
abstract class GreatCircleDistanceEntity implements Built<GreatCircleDistanceEntity, GreatCircleDistanceEntityBuilder> {
  @BuiltValueField(wireName: r'meter')
  num get meter;

  @BuiltValueField(wireName: r'km')
  num get km;

  @BuiltValueField(wireName: r'mile')
  num get mile;

  @BuiltValueField(wireName: r'nm')
  num get nm;

  @BuiltValueField(wireName: r'feet')
  num get feet;

  GreatCircleDistanceEntity._();

  factory GreatCircleDistanceEntity([void updates(GreatCircleDistanceEntityBuilder b)]) = _$GreatCircleDistanceEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GreatCircleDistanceEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GreatCircleDistanceEntity> get serializer => _$GreatCircleDistanceEntitySerializer();
}

class _$GreatCircleDistanceEntitySerializer implements PrimitiveSerializer<GreatCircleDistanceEntity> {
  @override
  final Iterable<Type> types = const [GreatCircleDistanceEntity, _$GreatCircleDistanceEntity];

  @override
  final String wireName = r'GreatCircleDistanceEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GreatCircleDistanceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'meter';
    yield serializers.serialize(
      object.meter,
      specifiedType: const FullType(num),
    );
    yield r'km';
    yield serializers.serialize(
      object.km,
      specifiedType: const FullType(num),
    );
    yield r'mile';
    yield serializers.serialize(
      object.mile,
      specifiedType: const FullType(num),
    );
    yield r'nm';
    yield serializers.serialize(
      object.nm,
      specifiedType: const FullType(num),
    );
    yield r'feet';
    yield serializers.serialize(
      object.feet,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GreatCircleDistanceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GreatCircleDistanceEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'meter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.meter = valueDes;
          break;
        case r'km':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.km = valueDes;
          break;
        case r'mile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.mile = valueDes;
          break;
        case r'nm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.nm = valueDes;
          break;
        case r'feet':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.feet = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GreatCircleDistanceEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GreatCircleDistanceEntityBuilder();
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

