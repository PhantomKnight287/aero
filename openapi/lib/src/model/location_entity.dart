//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'location_entity.g.dart';

/// LocationEntity
///
/// Properties:
/// * [lat] 
/// * [lon] 
@BuiltValue()
abstract class LocationEntity implements Built<LocationEntity, LocationEntityBuilder> {
  @BuiltValueField(wireName: r'lat')
  num get lat;

  @BuiltValueField(wireName: r'lon')
  num get lon;

  LocationEntity._();

  factory LocationEntity([void updates(LocationEntityBuilder b)]) = _$LocationEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LocationEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LocationEntity> get serializer => _$LocationEntitySerializer();
}

class _$LocationEntitySerializer implements PrimitiveSerializer<LocationEntity> {
  @override
  final Iterable<Type> types = const [LocationEntity, _$LocationEntity];

  @override
  final String wireName = r'LocationEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LocationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'lat';
    yield serializers.serialize(
      object.lat,
      specifiedType: const FullType(num),
    );
    yield r'lon';
    yield serializers.serialize(
      object.lon,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LocationEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LocationEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.lat = valueDes;
          break;
        case r'lon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.lon = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LocationEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LocationEntityBuilder();
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

