//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stringified_great_circle_distance_entity.g.dart';

/// StringifiedGreatCircleDistanceEntity
///
/// Properties:
/// * [meter] 
/// * [km] 
/// * [mile] 
/// * [nm] 
/// * [feet] 
@BuiltValue()
abstract class StringifiedGreatCircleDistanceEntity implements Built<StringifiedGreatCircleDistanceEntity, StringifiedGreatCircleDistanceEntityBuilder> {
  @BuiltValueField(wireName: r'meter')
  String get meter;

  @BuiltValueField(wireName: r'km')
  String get km;

  @BuiltValueField(wireName: r'mile')
  String get mile;

  @BuiltValueField(wireName: r'nm')
  String get nm;

  @BuiltValueField(wireName: r'feet')
  String get feet;

  StringifiedGreatCircleDistanceEntity._();

  factory StringifiedGreatCircleDistanceEntity([void updates(StringifiedGreatCircleDistanceEntityBuilder b)]) = _$StringifiedGreatCircleDistanceEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StringifiedGreatCircleDistanceEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StringifiedGreatCircleDistanceEntity> get serializer => _$StringifiedGreatCircleDistanceEntitySerializer();
}

class _$StringifiedGreatCircleDistanceEntitySerializer implements PrimitiveSerializer<StringifiedGreatCircleDistanceEntity> {
  @override
  final Iterable<Type> types = const [StringifiedGreatCircleDistanceEntity, _$StringifiedGreatCircleDistanceEntity];

  @override
  final String wireName = r'StringifiedGreatCircleDistanceEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StringifiedGreatCircleDistanceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'meter';
    yield serializers.serialize(
      object.meter,
      specifiedType: const FullType(String),
    );
    yield r'km';
    yield serializers.serialize(
      object.km,
      specifiedType: const FullType(String),
    );
    yield r'mile';
    yield serializers.serialize(
      object.mile,
      specifiedType: const FullType(String),
    );
    yield r'nm';
    yield serializers.serialize(
      object.nm,
      specifiedType: const FullType(String),
    );
    yield r'feet';
    yield serializers.serialize(
      object.feet,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StringifiedGreatCircleDistanceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StringifiedGreatCircleDistanceEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'meter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.meter = valueDes;
          break;
        case r'km':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.km = valueDes;
          break;
        case r'mile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mile = valueDes;
          break;
        case r'nm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nm = valueDes;
          break;
        case r'feet':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  StringifiedGreatCircleDistanceEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StringifiedGreatCircleDistanceEntityBuilder();
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

