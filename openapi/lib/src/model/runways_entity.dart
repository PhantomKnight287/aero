//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/runway_use_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'runways_entity.g.dart';

/// RunwaysEntity
///
/// Properties:
/// * [basedOn] 
/// * [items] 
@BuiltValue()
abstract class RunwaysEntity implements Built<RunwaysEntity, RunwaysEntityBuilder> {
  @BuiltValueField(wireName: r'basedOn')
  num get basedOn;

  @BuiltValueField(wireName: r'items')
  BuiltList<RunwayUseEntity> get items;

  RunwaysEntity._();

  factory RunwaysEntity([void updates(RunwaysEntityBuilder b)]) = _$RunwaysEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RunwaysEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RunwaysEntity> get serializer => _$RunwaysEntitySerializer();
}

class _$RunwaysEntitySerializer implements PrimitiveSerializer<RunwaysEntity> {
  @override
  final Iterable<Type> types = const [RunwaysEntity, _$RunwaysEntity];

  @override
  final String wireName = r'RunwaysEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RunwaysEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'basedOn';
    yield serializers.serialize(
      object.basedOn,
      specifiedType: const FullType(num),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(RunwayUseEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RunwaysEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RunwaysEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'basedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.basedOn = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RunwayUseEntity)]),
          ) as BuiltList<RunwayUseEntity>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RunwaysEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RunwaysEntityBuilder();
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


