//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_with_age.g.dart';

/// AircraftWithAge
///
/// Properties:
/// * [aircraftName] 
/// * [tailNumber] 
/// * [age] 
/// * [image] 
@BuiltValue()
abstract class AircraftWithAge implements Built<AircraftWithAge, AircraftWithAgeBuilder> {
  @BuiltValueField(wireName: r'aircraftName')
  String get aircraftName;

  @BuiltValueField(wireName: r'tailNumber')
  String get tailNumber;

  @BuiltValueField(wireName: r'age')
  num? get age;

  @BuiltValueField(wireName: r'image')
  String? get image;

  AircraftWithAge._();

  factory AircraftWithAge([void updates(AircraftWithAgeBuilder b)]) = _$AircraftWithAge;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftWithAgeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftWithAge> get serializer => _$AircraftWithAgeSerializer();
}

class _$AircraftWithAgeSerializer implements PrimitiveSerializer<AircraftWithAge> {
  @override
  final Iterable<Type> types = const [AircraftWithAge, _$AircraftWithAge];

  @override
  final String wireName = r'AircraftWithAge';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftWithAge object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'aircraftName';
    yield serializers.serialize(
      object.aircraftName,
      specifiedType: const FullType(String),
    );
    yield r'tailNumber';
    yield serializers.serialize(
      object.tailNumber,
      specifiedType: const FullType(String),
    );
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType(num),
      );
    }
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftWithAge object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftWithAgeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'aircraftName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.aircraftName = valueDes;
          break;
        case r'tailNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tailNumber = valueDes;
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.age = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftWithAge deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftWithAgeBuilder();
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

