//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/aircraft_family_entity.dart';
import 'package:openapi/src/model/airframes_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/aircraft_type_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_section_entity.g.dart';

/// AircraftSectionEntity
///
/// Properties:
/// * [basedOn] 
/// * [types] 
/// * [families] 
/// * [airframes] 
@BuiltValue()
abstract class AircraftSectionEntity implements Built<AircraftSectionEntity, AircraftSectionEntityBuilder> {
  @BuiltValueField(wireName: r'basedOn')
  num get basedOn;

  @BuiltValueField(wireName: r'types')
  BuiltList<AircraftTypeEntity> get types;

  @BuiltValueField(wireName: r'families')
  BuiltList<AircraftFamilyEntity> get families;

  @BuiltValueField(wireName: r'airframes')
  AirframesEntity get airframes;

  AircraftSectionEntity._();

  factory AircraftSectionEntity([void updates(AircraftSectionEntityBuilder b)]) = _$AircraftSectionEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftSectionEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftSectionEntity> get serializer => _$AircraftSectionEntitySerializer();
}

class _$AircraftSectionEntitySerializer implements PrimitiveSerializer<AircraftSectionEntity> {
  @override
  final Iterable<Type> types = const [AircraftSectionEntity, _$AircraftSectionEntity];

  @override
  final String wireName = r'AircraftSectionEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftSectionEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'basedOn';
    yield serializers.serialize(
      object.basedOn,
      specifiedType: const FullType(num),
    );
    yield r'types';
    yield serializers.serialize(
      object.types,
      specifiedType: const FullType(BuiltList, [FullType(AircraftTypeEntity)]),
    );
    yield r'families';
    yield serializers.serialize(
      object.families,
      specifiedType: const FullType(BuiltList, [FullType(AircraftFamilyEntity)]),
    );
    yield r'airframes';
    yield serializers.serialize(
      object.airframes,
      specifiedType: const FullType(AirframesEntity),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftSectionEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftSectionEntityBuilder result,
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
        case r'types':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AircraftTypeEntity)]),
          ) as BuiltList<AircraftTypeEntity>;
          result.types.replace(valueDes);
          break;
        case r'families':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AircraftFamilyEntity)]),
          ) as BuiltList<AircraftFamilyEntity>;
          result.families.replace(valueDes);
          break;
        case r'airframes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirframesEntity),
          ) as AirframesEntity;
          result.airframes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftSectionEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftSectionEntityBuilder();
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


