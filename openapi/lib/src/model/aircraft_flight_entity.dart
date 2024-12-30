//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_flight_entity.g.dart';

/// AircraftFlightEntity
///
/// Properties:
/// * [iataNumber] 
/// * [icaoNumber] 
/// * [number] 
@BuiltValue()
abstract class AircraftFlightEntity implements Built<AircraftFlightEntity, AircraftFlightEntityBuilder> {
  @BuiltValueField(wireName: r'iataNumber')
  String get iataNumber;

  @BuiltValueField(wireName: r'icaoNumber')
  String get icaoNumber;

  @BuiltValueField(wireName: r'number')
  String get number;

  AircraftFlightEntity._();

  factory AircraftFlightEntity([void updates(AircraftFlightEntityBuilder b)]) = _$AircraftFlightEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftFlightEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftFlightEntity> get serializer => _$AircraftFlightEntitySerializer();
}

class _$AircraftFlightEntitySerializer implements PrimitiveSerializer<AircraftFlightEntity> {
  @override
  final Iterable<Type> types = const [AircraftFlightEntity, _$AircraftFlightEntity];

  @override
  final String wireName = r'AircraftFlightEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftFlightEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'iataNumber';
    yield serializers.serialize(
      object.iataNumber,
      specifiedType: const FullType(String),
    );
    yield r'icaoNumber';
    yield serializers.serialize(
      object.icaoNumber,
      specifiedType: const FullType(String),
    );
    yield r'number';
    yield serializers.serialize(
      object.number,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftFlightEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftFlightEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'iataNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iataNumber = valueDes;
          break;
        case r'icaoNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icaoNumber = valueDes;
          break;
        case r'number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.number = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftFlightEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftFlightEntityBuilder();
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

