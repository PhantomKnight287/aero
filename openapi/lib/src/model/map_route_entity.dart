//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'map_route_entity.g.dart';

/// MapRouteEntity
///
/// Properties:
/// * [fromLat] 
/// * [fromLon] 
/// * [toLat] 
/// * [toLon] 
/// * [count] 
@BuiltValue()
abstract class MapRouteEntity implements Built<MapRouteEntity, MapRouteEntityBuilder> {
  @BuiltValueField(wireName: r'fromLat')
  num get fromLat;

  @BuiltValueField(wireName: r'fromLon')
  num get fromLon;

  @BuiltValueField(wireName: r'toLat')
  num get toLat;

  @BuiltValueField(wireName: r'toLon')
  num get toLon;

  @BuiltValueField(wireName: r'count')
  num get count;

  MapRouteEntity._();

  factory MapRouteEntity([void updates(MapRouteEntityBuilder b)]) = _$MapRouteEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MapRouteEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MapRouteEntity> get serializer => _$MapRouteEntitySerializer();
}

class _$MapRouteEntitySerializer implements PrimitiveSerializer<MapRouteEntity> {
  @override
  final Iterable<Type> types = const [MapRouteEntity, _$MapRouteEntity];

  @override
  final String wireName = r'MapRouteEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MapRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fromLat';
    yield serializers.serialize(
      object.fromLat,
      specifiedType: const FullType(num),
    );
    yield r'fromLon';
    yield serializers.serialize(
      object.fromLon,
      specifiedType: const FullType(num),
    );
    yield r'toLat';
    yield serializers.serialize(
      object.toLat,
      specifiedType: const FullType(num),
    );
    yield r'toLon';
    yield serializers.serialize(
      object.toLon,
      specifiedType: const FullType(num),
    );
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MapRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MapRouteEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fromLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.fromLat = valueDes;
          break;
        case r'fromLon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.fromLon = valueDes;
          break;
        case r'toLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.toLat = valueDes;
          break;
        case r'toLon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.toLon = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MapRouteEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MapRouteEntityBuilder();
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


