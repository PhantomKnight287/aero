// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fligh_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FlighType _$arrival = const FlighType._('arrival');
const FlighType _$departure = const FlighType._('departure');

FlighType _$valueOf(String name) {
  switch (name) {
    case 'arrival':
      return _$arrival;
    case 'departure':
      return _$departure;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<FlighType> _$values = new BuiltSet<FlighType>(const <FlighType>[
  _$arrival,
  _$departure,
]);

class _$FlighTypeMeta {
  const _$FlighTypeMeta();
  FlighType get arrival => _$arrival;
  FlighType get departure => _$departure;
  FlighType valueOf(String name) => _$valueOf(name);
  BuiltSet<FlighType> get values => _$values;
}

abstract class _$FlighTypeMixin {
  // ignore: non_constant_identifier_names
  _$FlighTypeMeta get FlighType => const _$FlighTypeMeta();
}

Serializer<FlighType> _$flighTypeSerializer = new _$FlighTypeSerializer();

class _$FlighTypeSerializer implements PrimitiveSerializer<FlighType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arrival': 'arrival',
    'departure': 'departure',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'arrival': 'arrival',
    'departure': 'departure',
  };

  @override
  final Iterable<Type> types = const <Type>[FlighType];
  @override
  final String wireName = 'FlighType';

  @override
  Object serialize(Serializers serializers, FlighType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FlighType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FlighType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
