//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_entity.g.dart';

/// AircraftEntity
///
/// Properties:
/// * [modeS] 
/// * [registration] 
/// * [model] 
/// * [image] 
/// * [aircraftId] 
/// * [age] 
/// * [firstFlightDate] 
/// * [deliveryDate] 
/// * [isFreighter] 
/// * [attribution] 
@BuiltValue()
abstract class AircraftEntity implements Built<AircraftEntity, AircraftEntityBuilder> {
  @BuiltValueField(wireName: r'modeS')
  String? get modeS;

  @BuiltValueField(wireName: r'registration')
  String get registration;

  @BuiltValueField(wireName: r'model')
  String get model;

  @BuiltValueField(wireName: r'image')
  String? get image;

  @BuiltValueField(wireName: r'aircraft_id')
  String? get aircraftId;

  @BuiltValueField(wireName: r'age')
  String? get age;

  @BuiltValueField(wireName: r'firstFlightDate')
  String? get firstFlightDate;

  @BuiltValueField(wireName: r'deliveryDate')
  String? get deliveryDate;

  @BuiltValueField(wireName: r'isFreighter')
  bool? get isFreighter;

  @BuiltValueField(wireName: r'attribution')
  String? get attribution;

  AircraftEntity._();

  factory AircraftEntity([void updates(AircraftEntityBuilder b)]) = _$AircraftEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftEntity> get serializer => _$AircraftEntitySerializer();
}

class _$AircraftEntitySerializer implements PrimitiveSerializer<AircraftEntity> {
  @override
  final Iterable<Type> types = const [AircraftEntity, _$AircraftEntity];

  @override
  final String wireName = r'AircraftEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.modeS != null) {
      yield r'modeS';
      yield serializers.serialize(
        object.modeS,
        specifiedType: const FullType(String),
      );
    }
    yield r'registration';
    yield serializers.serialize(
      object.registration,
      specifiedType: const FullType(String),
    );
    yield r'model';
    yield serializers.serialize(
      object.model,
      specifiedType: const FullType(String),
    );
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
    if (object.aircraftId != null) {
      yield r'aircraft_id';
      yield serializers.serialize(
        object.aircraftId,
        specifiedType: const FullType(String),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType(String),
      );
    }
    if (object.firstFlightDate != null) {
      yield r'firstFlightDate';
      yield serializers.serialize(
        object.firstFlightDate,
        specifiedType: const FullType(String),
      );
    }
    if (object.deliveryDate != null) {
      yield r'deliveryDate';
      yield serializers.serialize(
        object.deliveryDate,
        specifiedType: const FullType(String),
      );
    }
    if (object.isFreighter != null) {
      yield r'isFreighter';
      yield serializers.serialize(
        object.isFreighter,
        specifiedType: const FullType(bool),
      );
    }
    if (object.attribution != null) {
      yield r'attribution';
      yield serializers.serialize(
        object.attribution,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'modeS':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.modeS = valueDes;
          break;
        case r'registration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.registration = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.model = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        case r'aircraft_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.aircraftId = valueDes;
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.age = valueDes;
          break;
        case r'firstFlightDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstFlightDate = valueDes;
          break;
        case r'deliveryDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deliveryDate = valueDes;
          break;
        case r'isFreighter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFreighter = valueDes;
          break;
        case r'attribution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.attribution = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftEntityBuilder();
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

