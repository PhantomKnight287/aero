//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'most_flown_aircraft_entity.g.dart';

/// MostFlownAircraftEntity
///
/// Properties:
/// * [aircraftName] 
/// * [flightCount] 
@BuiltValue()
abstract class MostFlownAircraftEntity implements Built<MostFlownAircraftEntity, MostFlownAircraftEntityBuilder> {
  @BuiltValueField(wireName: r'aircraftName')
  String get aircraftName;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  MostFlownAircraftEntity._();

  factory MostFlownAircraftEntity([void updates(MostFlownAircraftEntityBuilder b)]) = _$MostFlownAircraftEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MostFlownAircraftEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MostFlownAircraftEntity> get serializer => _$MostFlownAircraftEntitySerializer();
}

class _$MostFlownAircraftEntitySerializer implements PrimitiveSerializer<MostFlownAircraftEntity> {
  @override
  final Iterable<Type> types = const [MostFlownAircraftEntity, _$MostFlownAircraftEntity];

  @override
  final String wireName = r'MostFlownAircraftEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MostFlownAircraftEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'aircraftName';
    yield serializers.serialize(
      object.aircraftName,
      specifiedType: const FullType(String),
    );
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MostFlownAircraftEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MostFlownAircraftEntityBuilder result,
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
        case r'flightCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.flightCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MostFlownAircraftEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MostFlownAircraftEntityBuilder();
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

