//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'partial_airline_entity.g.dart';

/// PartialAirlineEntity
///
/// Properties:
/// * [name] 
/// * [iata] 
/// * [icao] 
/// * [image] 
@BuiltValue()
abstract class PartialAirlineEntity implements Built<PartialAirlineEntity, PartialAirlineEntityBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'iata')
  String? get iata;

  @BuiltValueField(wireName: r'icao')
  String? get icao;

  @BuiltValueField(wireName: r'image')
  String? get image;

  PartialAirlineEntity._();

  factory PartialAirlineEntity([void updates(PartialAirlineEntityBuilder b)]) = _$PartialAirlineEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PartialAirlineEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PartialAirlineEntity> get serializer => _$PartialAirlineEntitySerializer();
}

class _$PartialAirlineEntitySerializer implements PrimitiveSerializer<PartialAirlineEntity> {
  @override
  final Iterable<Type> types = const [PartialAirlineEntity, _$PartialAirlineEntity];

  @override
  final String wireName = r'PartialAirlineEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PartialAirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.iata != null) {
      yield r'iata';
      yield serializers.serialize(
        object.iata,
        specifiedType: const FullType(String),
      );
    }
    if (object.icao != null) {
      yield r'icao';
      yield serializers.serialize(
        object.icao,
        specifiedType: const FullType(String),
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
    PartialAirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PartialAirlineEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'iata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iata = valueDes;
          break;
        case r'icao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icao = valueDes;
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
  PartialAirlineEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PartialAirlineEntityBuilder();
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

