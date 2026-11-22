//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'map_airport_entity.g.dart';

/// MapAirportEntity
///
/// Properties:
/// * [iata] 
/// * [icao] 
/// * [lat] 
/// * [lon] 
@BuiltValue()
abstract class MapAirportEntity implements Built<MapAirportEntity, MapAirportEntityBuilder> {
  @BuiltValueField(wireName: r'iata')
  String? get iata;

  @BuiltValueField(wireName: r'icao')
  String? get icao;

  @BuiltValueField(wireName: r'lat')
  num get lat;

  @BuiltValueField(wireName: r'lon')
  num get lon;

  MapAirportEntity._();

  factory MapAirportEntity([void updates(MapAirportEntityBuilder b)]) = _$MapAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MapAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MapAirportEntity> get serializer => _$MapAirportEntitySerializer();
}

class _$MapAirportEntitySerializer implements PrimitiveSerializer<MapAirportEntity> {
  @override
  final Iterable<Type> types = const [MapAirportEntity, _$MapAirportEntity];

  @override
  final String wireName = r'MapAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MapAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.iata != null) {
      yield r'iata';
      yield serializers.serialize(
        object.iata,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.icao != null) {
      yield r'icao';
      yield serializers.serialize(
        object.icao,
        specifiedType: const FullType.nullable(String),
      );
    }
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
    MapAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MapAirportEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'iata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.iata = valueDes;
          break;
        case r'icao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.icao = valueDes;
          break;
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
  MapAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MapAirportEntityBuilder();
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


