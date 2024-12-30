// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AirportType _$smallAirport = const AirportType._('smallAirport');
const AirportType _$seaplaneBase = const AirportType._('seaplaneBase');
const AirportType _$mediumAirport = const AirportType._('mediumAirport');
const AirportType _$largeAirport = const AirportType._('largeAirport');
const AirportType _$heliport = const AirportType._('heliport');
const AirportType _$closed = const AirportType._('closed');
const AirportType _$balloonport = const AirportType._('balloonport');

AirportType _$valueOf(String name) {
  switch (name) {
    case 'smallAirport':
      return _$smallAirport;
    case 'seaplaneBase':
      return _$seaplaneBase;
    case 'mediumAirport':
      return _$mediumAirport;
    case 'largeAirport':
      return _$largeAirport;
    case 'heliport':
      return _$heliport;
    case 'closed':
      return _$closed;
    case 'balloonport':
      return _$balloonport;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AirportType> _$values =
    new BuiltSet<AirportType>(const <AirportType>[
  _$smallAirport,
  _$seaplaneBase,
  _$mediumAirport,
  _$largeAirport,
  _$heliport,
  _$closed,
  _$balloonport,
]);

class _$AirportTypeMeta {
  const _$AirportTypeMeta();
  AirportType get smallAirport => _$smallAirport;
  AirportType get seaplaneBase => _$seaplaneBase;
  AirportType get mediumAirport => _$mediumAirport;
  AirportType get largeAirport => _$largeAirport;
  AirportType get heliport => _$heliport;
  AirportType get closed => _$closed;
  AirportType get balloonport => _$balloonport;
  AirportType valueOf(String name) => _$valueOf(name);
  BuiltSet<AirportType> get values => _$values;
}

abstract class _$AirportTypeMixin {
  // ignore: non_constant_identifier_names
  _$AirportTypeMeta get AirportType => const _$AirportTypeMeta();
}

Serializer<AirportType> _$airportTypeSerializer = new _$AirportTypeSerializer();

class _$AirportTypeSerializer implements PrimitiveSerializer<AirportType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'smallAirport': 'small_airport',
    'seaplaneBase': 'seaplane_base',
    'mediumAirport': 'medium_airport',
    'largeAirport': 'large_airport',
    'heliport': 'heliport',
    'closed': 'closed',
    'balloonport': 'balloonport',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'small_airport': 'smallAirport',
    'seaplane_base': 'seaplaneBase',
    'medium_airport': 'mediumAirport',
    'large_airport': 'largeAirport',
    'heliport': 'heliport',
    'closed': 'closed',
    'balloonport': 'balloonport',
  };

  @override
  final Iterable<Type> types = const <Type>[AirportType];
  @override
  final String wireName = 'AirportType';

  @override
  Object serialize(Serializers serializers, AirportType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirportType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirportType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
