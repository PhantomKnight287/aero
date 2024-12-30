// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FlightStatus _$scheduled = const FlightStatus._('scheduled');
const FlightStatus _$active = const FlightStatus._('active');
const FlightStatus _$landed = const FlightStatus._('landed');
const FlightStatus _$cancelled = const FlightStatus._('cancelled');
const FlightStatus _$incident = const FlightStatus._('incident');
const FlightStatus _$diverted = const FlightStatus._('diverted');
const FlightStatus _$unknown = const FlightStatus._('unknown');

FlightStatus _$valueOf(String name) {
  switch (name) {
    case 'scheduled':
      return _$scheduled;
    case 'active':
      return _$active;
    case 'landed':
      return _$landed;
    case 'cancelled':
      return _$cancelled;
    case 'incident':
      return _$incident;
    case 'diverted':
      return _$diverted;
    case 'unknown':
      return _$unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<FlightStatus> _$values =
    new BuiltSet<FlightStatus>(const <FlightStatus>[
  _$scheduled,
  _$active,
  _$landed,
  _$cancelled,
  _$incident,
  _$diverted,
  _$unknown,
]);

class _$FlightStatusMeta {
  const _$FlightStatusMeta();
  FlightStatus get scheduled => _$scheduled;
  FlightStatus get active => _$active;
  FlightStatus get landed => _$landed;
  FlightStatus get cancelled => _$cancelled;
  FlightStatus get incident => _$incident;
  FlightStatus get diverted => _$diverted;
  FlightStatus get unknown => _$unknown;
  FlightStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<FlightStatus> get values => _$values;
}

abstract class _$FlightStatusMixin {
  // ignore: non_constant_identifier_names
  _$FlightStatusMeta get FlightStatus => const _$FlightStatusMeta();
}

Serializer<FlightStatus> _$flightStatusSerializer =
    new _$FlightStatusSerializer();

class _$FlightStatusSerializer implements PrimitiveSerializer<FlightStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'scheduled': 'scheduled',
    'active': 'active',
    'landed': 'landed',
    'cancelled': 'cancelled',
    'incident': 'incident',
    'diverted': 'diverted',
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'scheduled': 'scheduled',
    'active': 'active',
    'landed': 'landed',
    'cancelled': 'cancelled',
    'incident': 'incident',
    'diverted': 'diverted',
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[FlightStatus];
  @override
  final String wireName = 'FlightStatus';

  @override
  Object serialize(Serializers serializers, FlightStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FlightStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FlightStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
