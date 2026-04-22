//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_registration_entity.g.dart';

/// AircraftRegistrationEntity
///
/// Properties:
/// * [id] 
/// * [reg] 
/// * [active] 
/// * [hexIcao] 
/// * [airlineName] 
/// * [registrationDate] 
@BuiltValue()
abstract class AircraftRegistrationEntity implements Built<AircraftRegistrationEntity, AircraftRegistrationEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'reg')
  String get reg;

  @BuiltValueField(wireName: r'active')
  bool get active;

  @BuiltValueField(wireName: r'hexIcao')
  String? get hexIcao;

  @BuiltValueField(wireName: r'airlineName')
  String? get airlineName;

  @BuiltValueField(wireName: r'registrationDate')
  String? get registrationDate;

  AircraftRegistrationEntity._();

  factory AircraftRegistrationEntity([void updates(AircraftRegistrationEntityBuilder b)]) = _$AircraftRegistrationEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftRegistrationEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftRegistrationEntity> get serializer => _$AircraftRegistrationEntitySerializer();
}

class _$AircraftRegistrationEntitySerializer implements PrimitiveSerializer<AircraftRegistrationEntity> {
  @override
  final Iterable<Type> types = const [AircraftRegistrationEntity, _$AircraftRegistrationEntity];

  @override
  final String wireName = r'AircraftRegistrationEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftRegistrationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'reg';
    yield serializers.serialize(
      object.reg,
      specifiedType: const FullType(String),
    );
    yield r'active';
    yield serializers.serialize(
      object.active,
      specifiedType: const FullType(bool),
    );
    if (object.hexIcao != null) {
      yield r'hexIcao';
      yield serializers.serialize(
        object.hexIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.airlineName != null) {
      yield r'airlineName';
      yield serializers.serialize(
        object.airlineName,
        specifiedType: const FullType(String),
      );
    }
    if (object.registrationDate != null) {
      yield r'registrationDate';
      yield serializers.serialize(
        object.registrationDate,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftRegistrationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftRegistrationEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'reg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reg = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.active = valueDes;
          break;
        case r'hexIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.hexIcao = valueDes;
          break;
        case r'airlineName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airlineName = valueDes;
          break;
        case r'registrationDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.registrationDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftRegistrationEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftRegistrationEntityBuilder();
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

