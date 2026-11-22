//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/map_route_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/map_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'map_data_entity.g.dart';

/// MapDataEntity
///
/// Properties:
/// * [airports] 
/// * [routes] 
@BuiltValue()
abstract class MapDataEntity implements Built<MapDataEntity, MapDataEntityBuilder> {
  @BuiltValueField(wireName: r'airports')
  BuiltList<MapAirportEntity> get airports;

  @BuiltValueField(wireName: r'routes')
  BuiltList<MapRouteEntity> get routes;

  MapDataEntity._();

  factory MapDataEntity([void updates(MapDataEntityBuilder b)]) = _$MapDataEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MapDataEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MapDataEntity> get serializer => _$MapDataEntitySerializer();
}

class _$MapDataEntitySerializer implements PrimitiveSerializer<MapDataEntity> {
  @override
  final Iterable<Type> types = const [MapDataEntity, _$MapDataEntity];

  @override
  final String wireName = r'MapDataEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MapDataEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airports';
    yield serializers.serialize(
      object.airports,
      specifiedType: const FullType(BuiltList, [FullType(MapAirportEntity)]),
    );
    yield r'routes';
    yield serializers.serialize(
      object.routes,
      specifiedType: const FullType(BuiltList, [FullType(MapRouteEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MapDataEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MapDataEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MapAirportEntity)]),
          ) as BuiltList<MapAirportEntity>;
          result.airports.replace(valueDes);
          break;
        case r'routes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MapRouteEntity)]),
          ) as BuiltList<MapRouteEntity>;
          result.routes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MapDataEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MapDataEntityBuilder();
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


