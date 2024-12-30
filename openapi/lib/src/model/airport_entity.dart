//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/airport_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_entity.g.dart';

/// AirportEntity
///
/// Properties:
/// * [id] 
/// * [ident] 
/// * [type] 
/// * [elevation] - Elevation in feet
/// * [continent] 
/// * [isoCountry] 
/// * [isoRegion] 
/// * [municipality] 
/// * [gpsCode] 
/// * [iataCode] - Nullable for private airports
/// * [name] 
/// * [lat] 
/// * [long] 
@BuiltValue()
abstract class AirportEntity implements Built<AirportEntity, AirportEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'ident')
  String get ident;

  @BuiltValueField(wireName: r'type')
  AirportType get type;
  // enum typeEnum {  small_airport,  seaplane_base,  medium_airport,  large_airport,  heliport,  closed,  balloonport,  };

  /// Elevation in feet
  @BuiltValueField(wireName: r'elevation')
  String? get elevation;

  @BuiltValueField(wireName: r'continent')
  String get continent;

  @BuiltValueField(wireName: r'isoCountry')
  String get isoCountry;

  @BuiltValueField(wireName: r'isoRegion')
  String get isoRegion;

  @BuiltValueField(wireName: r'municipality')
  String? get municipality;

  @BuiltValueField(wireName: r'gpsCode')
  String? get gpsCode;

  /// Nullable for private airports
  @BuiltValueField(wireName: r'iataCode')
  String? get iataCode;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'lat')
  String get lat;

  @BuiltValueField(wireName: r'long')
  String get long;

  AirportEntity._();

  factory AirportEntity([void updates(AirportEntityBuilder b)]) = _$AirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportEntity> get serializer => _$AirportEntitySerializer();
}

class _$AirportEntitySerializer implements PrimitiveSerializer<AirportEntity> {
  @override
  final Iterable<Type> types = const [AirportEntity, _$AirportEntity];

  @override
  final String wireName = r'AirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'ident';
    yield serializers.serialize(
      object.ident,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(AirportType),
    );
    if (object.elevation != null) {
      yield r'elevation';
      yield serializers.serialize(
        object.elevation,
        specifiedType: const FullType(String),
      );
    }
    yield r'continent';
    yield serializers.serialize(
      object.continent,
      specifiedType: const FullType(String),
    );
    yield r'isoCountry';
    yield serializers.serialize(
      object.isoCountry,
      specifiedType: const FullType(String),
    );
    yield r'isoRegion';
    yield serializers.serialize(
      object.isoRegion,
      specifiedType: const FullType(String),
    );
    if (object.municipality != null) {
      yield r'municipality';
      yield serializers.serialize(
        object.municipality,
        specifiedType: const FullType(String),
      );
    }
    if (object.gpsCode != null) {
      yield r'gpsCode';
      yield serializers.serialize(
        object.gpsCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.iataCode != null) {
      yield r'iataCode';
      yield serializers.serialize(
        object.iataCode,
        specifiedType: const FullType(String),
      );
    }
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'lat';
    yield serializers.serialize(
      object.lat,
      specifiedType: const FullType(String),
    );
    yield r'long';
    yield serializers.serialize(
      object.long,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportEntityBuilder result,
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
        case r'ident':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ident = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirportType),
          ) as AirportType;
          result.type = valueDes;
          break;
        case r'elevation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.elevation = valueDes;
          break;
        case r'continent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.continent = valueDes;
          break;
        case r'isoCountry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.isoCountry = valueDes;
          break;
        case r'isoRegion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.isoRegion = valueDes;
          break;
        case r'municipality':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.municipality = valueDes;
          break;
        case r'gpsCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gpsCode = valueDes;
          break;
        case r'iataCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iataCode = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lat = valueDes;
          break;
        case r'long':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.long = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportEntityBuilder();
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

