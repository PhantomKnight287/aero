//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/location_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_airport_entity.g.dart';

/// RouteAirportEntity
///
/// Properties:
/// * [iata] 
/// * [icao] 
/// * [name] 
/// * [timeZone] 
/// * [shortName] 
/// * [countryCode] 
/// * [municipalityName] 
/// * [location] 
@BuiltValue()
abstract class RouteAirportEntity implements Built<RouteAirportEntity, RouteAirportEntityBuilder> {
  @BuiltValueField(wireName: r'iata')
  String get iata;

  @BuiltValueField(wireName: r'icao')
  String get icao;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'timeZone')
  String get timeZone;

  @BuiltValueField(wireName: r'shortName')
  String get shortName;

  @BuiltValueField(wireName: r'countryCode')
  String get countryCode;

  @BuiltValueField(wireName: r'municipalityName')
  String get municipalityName;

  @BuiltValueField(wireName: r'location')
  LocationEntity get location;

  RouteAirportEntity._();

  factory RouteAirportEntity([void updates(RouteAirportEntityBuilder b)]) = _$RouteAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RouteAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RouteAirportEntity> get serializer => _$RouteAirportEntitySerializer();
}

class _$RouteAirportEntitySerializer implements PrimitiveSerializer<RouteAirportEntity> {
  @override
  final Iterable<Type> types = const [RouteAirportEntity, _$RouteAirportEntity];

  @override
  final String wireName = r'RouteAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RouteAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'iata';
    yield serializers.serialize(
      object.iata,
      specifiedType: const FullType(String),
    );
    yield r'icao';
    yield serializers.serialize(
      object.icao,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'timeZone';
    yield serializers.serialize(
      object.timeZone,
      specifiedType: const FullType(String),
    );
    yield r'shortName';
    yield serializers.serialize(
      object.shortName,
      specifiedType: const FullType(String),
    );
    yield r'countryCode';
    yield serializers.serialize(
      object.countryCode,
      specifiedType: const FullType(String),
    );
    yield r'municipalityName';
    yield serializers.serialize(
      object.municipalityName,
      specifiedType: const FullType(String),
    );
    yield r'location';
    yield serializers.serialize(
      object.location,
      specifiedType: const FullType(LocationEntity),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RouteAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RouteAirportEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'timeZone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.timeZone = valueDes;
          break;
        case r'shortName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shortName = valueDes;
          break;
        case r'countryCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.countryCode = valueDes;
          break;
        case r'municipalityName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.municipalityName = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LocationEntity),
          ) as LocationEntity;
          result.location.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RouteAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RouteAirportEntityBuilder();
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

