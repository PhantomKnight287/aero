//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stats_airport_entity.g.dart';

/// StatsAirportEntity
///
/// Properties:
/// * [iata] 
/// * [icao] 
/// * [name] 
/// * [city] 
/// * [isoCountry] 
/// * [lat] 
/// * [lon] 
/// * [elevationFt] 
@BuiltValue()
abstract class StatsAirportEntity implements Built<StatsAirportEntity, StatsAirportEntityBuilder> {
  @BuiltValueField(wireName: r'iata')
  String? get iata;

  @BuiltValueField(wireName: r'icao')
  String? get icao;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'city')
  String get city;

  @BuiltValueField(wireName: r'isoCountry')
  String? get isoCountry;

  @BuiltValueField(wireName: r'lat')
  num? get lat;

  @BuiltValueField(wireName: r'lon')
  num? get lon;

  @BuiltValueField(wireName: r'elevationFt')
  num? get elevationFt;

  StatsAirportEntity._();

  factory StatsAirportEntity([void updates(StatsAirportEntityBuilder b)]) = _$StatsAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatsAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatsAirportEntity> get serializer => _$StatsAirportEntitySerializer();
}

class _$StatsAirportEntitySerializer implements PrimitiveSerializer<StatsAirportEntity> {
  @override
  final Iterable<Type> types = const [StatsAirportEntity, _$StatsAirportEntity];

  @override
  final String wireName = r'StatsAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatsAirportEntity object, {
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
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'city';
    yield serializers.serialize(
      object.city,
      specifiedType: const FullType(String),
    );
    if (object.isoCountry != null) {
      yield r'isoCountry';
      yield serializers.serialize(
        object.isoCountry,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.lat != null) {
      yield r'lat';
      yield serializers.serialize(
        object.lat,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lon != null) {
      yield r'lon';
      yield serializers.serialize(
        object.lon,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.elevationFt != null) {
      yield r'elevationFt';
      yield serializers.serialize(
        object.elevationFt,
        specifiedType: const FullType.nullable(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StatsAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatsAirportEntityBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.city = valueDes;
          break;
        case r'isoCountry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.isoCountry = valueDes;
          break;
        case r'lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lat = valueDes;
          break;
        case r'lon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lon = valueDes;
          break;
        case r'elevationFt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.elevationFt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatsAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatsAirportEntityBuilder();
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


