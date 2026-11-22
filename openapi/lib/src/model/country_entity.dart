//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'country_entity.g.dart';

/// CountryEntity
///
/// Properties:
/// * [isoCountry] 
/// * [name] 
/// * [flightCount] 
@BuiltValue()
abstract class CountryEntity implements Built<CountryEntity, CountryEntityBuilder> {
  @BuiltValueField(wireName: r'isoCountry')
  String get isoCountry;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  CountryEntity._();

  factory CountryEntity([void updates(CountryEntityBuilder b)]) = _$CountryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CountryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CountryEntity> get serializer => _$CountryEntitySerializer();
}

class _$CountryEntitySerializer implements PrimitiveSerializer<CountryEntity> {
  @override
  final Iterable<Type> types = const [CountryEntity, _$CountryEntity];

  @override
  final String wireName = r'CountryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CountryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'isoCountry';
    yield serializers.serialize(
      object.isoCountry,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
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
    CountryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CountryEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'isoCountry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.isoCountry = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
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
  CountryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CountryEntityBuilder();
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


