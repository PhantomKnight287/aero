//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airline_entity.g.dart';

/// AirlineEntity
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [icao] 
/// * [iata] 
/// * [image] 
@BuiltValue()
abstract class AirlineEntity implements Built<AirlineEntity, AirlineEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'icao')
  String get icao;

  @BuiltValueField(wireName: r'iata')
  String get iata;

  @BuiltValueField(wireName: r'image')
  String? get image;

  AirlineEntity._();

  factory AirlineEntity([void updates(AirlineEntityBuilder b)]) = _$AirlineEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirlineEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirlineEntity> get serializer => _$AirlineEntitySerializer();
}

class _$AirlineEntitySerializer implements PrimitiveSerializer<AirlineEntity> {
  @override
  final Iterable<Type> types = const [AirlineEntity, _$AirlineEntity];

  @override
  final String wireName = r'AirlineEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'icao';
    yield serializers.serialize(
      object.icao,
      specifiedType: const FullType(String),
    );
    yield r'iata';
    yield serializers.serialize(
      object.iata,
      specifiedType: const FullType(String),
    );
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
    AirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirlineEntityBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'icao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icao = valueDes;
          break;
        case r'iata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iata = valueDes;
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
  AirlineEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirlineEntityBuilder();
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

