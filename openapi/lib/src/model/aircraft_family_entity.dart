//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_family_entity.g.dart';

/// AircraftFamilyEntity
///
/// Properties:
/// * [family] 
/// * [typeCodes] 
/// * [flightCount] 
/// * [firstFlown] - Departure-local date (YYYY-MM-DD)
@BuiltValue()
abstract class AircraftFamilyEntity implements Built<AircraftFamilyEntity, AircraftFamilyEntityBuilder> {
  @BuiltValueField(wireName: r'family')
  String get family;

  @BuiltValueField(wireName: r'typeCodes')
  BuiltList<String> get typeCodes;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  /// Departure-local date (YYYY-MM-DD)
  @BuiltValueField(wireName: r'firstFlown')
  String? get firstFlown;

  AircraftFamilyEntity._();

  factory AircraftFamilyEntity([void updates(AircraftFamilyEntityBuilder b)]) = _$AircraftFamilyEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftFamilyEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftFamilyEntity> get serializer => _$AircraftFamilyEntitySerializer();
}

class _$AircraftFamilyEntitySerializer implements PrimitiveSerializer<AircraftFamilyEntity> {
  @override
  final Iterable<Type> types = const [AircraftFamilyEntity, _$AircraftFamilyEntity];

  @override
  final String wireName = r'AircraftFamilyEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftFamilyEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'family';
    yield serializers.serialize(
      object.family,
      specifiedType: const FullType(String),
    );
    yield r'typeCodes';
    yield serializers.serialize(
      object.typeCodes,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
    if (object.firstFlown != null) {
      yield r'firstFlown';
      yield serializers.serialize(
        object.firstFlown,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftFamilyEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftFamilyEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'family':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.family = valueDes;
          break;
        case r'typeCodes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.typeCodes.replace(valueDes);
          break;
        case r'flightCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.flightCount = valueDes;
          break;
        case r'firstFlown':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstFlown = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftFamilyEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftFamilyEntityBuilder();
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


