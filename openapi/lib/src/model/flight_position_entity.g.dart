// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_position_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FlightPositionEntityAltitudeChangeEnum
    _$flightPositionEntityAltitudeChangeEnum_C =
    const FlightPositionEntityAltitudeChangeEnum._('C');
const FlightPositionEntityAltitudeChangeEnum
    _$flightPositionEntityAltitudeChangeEnum_D =
    const FlightPositionEntityAltitudeChangeEnum._('D');
const FlightPositionEntityAltitudeChangeEnum
    _$flightPositionEntityAltitudeChangeEnum_underscore =
    const FlightPositionEntityAltitudeChangeEnum._('underscore');

FlightPositionEntityAltitudeChangeEnum
    _$flightPositionEntityAltitudeChangeEnumValueOf(String name) {
  switch (name) {
    case 'C':
      return _$flightPositionEntityAltitudeChangeEnum_C;
    case 'D':
      return _$flightPositionEntityAltitudeChangeEnum_D;
    case 'underscore':
      return _$flightPositionEntityAltitudeChangeEnum_underscore;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FlightPositionEntityAltitudeChangeEnum>
    _$flightPositionEntityAltitudeChangeEnumValues = BuiltSet<
        FlightPositionEntityAltitudeChangeEnum>(const <FlightPositionEntityAltitudeChangeEnum>[
  _$flightPositionEntityAltitudeChangeEnum_C,
  _$flightPositionEntityAltitudeChangeEnum_D,
  _$flightPositionEntityAltitudeChangeEnum_underscore,
]);

const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_P =
    const FlightPositionEntityUpdateTypeEnum._('P');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_O =
    const FlightPositionEntityUpdateTypeEnum._('O');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_Z =
    const FlightPositionEntityUpdateTypeEnum._('Z');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_A =
    const FlightPositionEntityUpdateTypeEnum._('A');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_M =
    const FlightPositionEntityUpdateTypeEnum._('M');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_D =
    const FlightPositionEntityUpdateTypeEnum._('D');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_X =
    const FlightPositionEntityUpdateTypeEnum._('X');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_S =
    const FlightPositionEntityUpdateTypeEnum._('S');
const FlightPositionEntityUpdateTypeEnum
    _$flightPositionEntityUpdateTypeEnum_V =
    const FlightPositionEntityUpdateTypeEnum._('V');

FlightPositionEntityUpdateTypeEnum _$flightPositionEntityUpdateTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'P':
      return _$flightPositionEntityUpdateTypeEnum_P;
    case 'O':
      return _$flightPositionEntityUpdateTypeEnum_O;
    case 'Z':
      return _$flightPositionEntityUpdateTypeEnum_Z;
    case 'A':
      return _$flightPositionEntityUpdateTypeEnum_A;
    case 'M':
      return _$flightPositionEntityUpdateTypeEnum_M;
    case 'D':
      return _$flightPositionEntityUpdateTypeEnum_D;
    case 'X':
      return _$flightPositionEntityUpdateTypeEnum_X;
    case 'S':
      return _$flightPositionEntityUpdateTypeEnum_S;
    case 'V':
      return _$flightPositionEntityUpdateTypeEnum_V;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FlightPositionEntityUpdateTypeEnum>
    _$flightPositionEntityUpdateTypeEnumValues = BuiltSet<
        FlightPositionEntityUpdateTypeEnum>(const <FlightPositionEntityUpdateTypeEnum>[
  _$flightPositionEntityUpdateTypeEnum_P,
  _$flightPositionEntityUpdateTypeEnum_O,
  _$flightPositionEntityUpdateTypeEnum_Z,
  _$flightPositionEntityUpdateTypeEnum_A,
  _$flightPositionEntityUpdateTypeEnum_M,
  _$flightPositionEntityUpdateTypeEnum_D,
  _$flightPositionEntityUpdateTypeEnum_X,
  _$flightPositionEntityUpdateTypeEnum_S,
  _$flightPositionEntityUpdateTypeEnum_V,
]);

Serializer<FlightPositionEntityAltitudeChangeEnum>
    _$flightPositionEntityAltitudeChangeEnumSerializer =
    _$FlightPositionEntityAltitudeChangeEnumSerializer();
Serializer<FlightPositionEntityUpdateTypeEnum>
    _$flightPositionEntityUpdateTypeEnumSerializer =
    _$FlightPositionEntityUpdateTypeEnumSerializer();

class _$FlightPositionEntityAltitudeChangeEnumSerializer
    implements PrimitiveSerializer<FlightPositionEntityAltitudeChangeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'C': 'C',
    'D': 'D',
    'underscore': '-',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'C': 'C',
    'D': 'D',
    '-': 'underscore',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FlightPositionEntityAltitudeChangeEnum
  ];
  @override
  final String wireName = 'FlightPositionEntityAltitudeChangeEnum';

  @override
  Object serialize(Serializers serializers,
          FlightPositionEntityAltitudeChangeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FlightPositionEntityAltitudeChangeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FlightPositionEntityAltitudeChangeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FlightPositionEntityUpdateTypeEnumSerializer
    implements PrimitiveSerializer<FlightPositionEntityUpdateTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'P': 'P',
    'O': 'O',
    'Z': 'Z',
    'A': 'A',
    'M': 'M',
    'D': 'D',
    'X': 'X',
    'S': 'S',
    'V': 'V',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'P': 'P',
    'O': 'O',
    'Z': 'Z',
    'A': 'A',
    'M': 'M',
    'D': 'D',
    'X': 'X',
    'S': 'S',
    'V': 'V',
  };

  @override
  final Iterable<Type> types = const <Type>[FlightPositionEntityUpdateTypeEnum];
  @override
  final String wireName = 'FlightPositionEntityUpdateTypeEnum';

  @override
  Object serialize(
          Serializers serializers, FlightPositionEntityUpdateTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FlightPositionEntityUpdateTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FlightPositionEntityUpdateTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FlightPositionEntity extends FlightPositionEntity {
  @override
  final String? faFlightId;
  @override
  final num altitude;
  @override
  final FlightPositionEntityAltitudeChangeEnum altitudeChange;
  @override
  final num groundspeed;
  @override
  final num? heading;
  @override
  final num latitude;
  @override
  final num longitude;
  @override
  final String timestamp;
  @override
  final FlightPositionEntityUpdateTypeEnum? updateType;

  factory _$FlightPositionEntity(
          [void Function(FlightPositionEntityBuilder)? updates]) =>
      (FlightPositionEntityBuilder()..update(updates))._build();

  _$FlightPositionEntity._(
      {this.faFlightId,
      required this.altitude,
      required this.altitudeChange,
      required this.groundspeed,
      this.heading,
      required this.latitude,
      required this.longitude,
      required this.timestamp,
      this.updateType})
      : super._();
  @override
  FlightPositionEntity rebuild(
          void Function(FlightPositionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightPositionEntityBuilder toBuilder() =>
      FlightPositionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightPositionEntity &&
        faFlightId == other.faFlightId &&
        altitude == other.altitude &&
        altitudeChange == other.altitudeChange &&
        groundspeed == other.groundspeed &&
        heading == other.heading &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        timestamp == other.timestamp &&
        updateType == other.updateType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, faFlightId.hashCode);
    _$hash = $jc(_$hash, altitude.hashCode);
    _$hash = $jc(_$hash, altitudeChange.hashCode);
    _$hash = $jc(_$hash, groundspeed.hashCode);
    _$hash = $jc(_$hash, heading.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, updateType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightPositionEntity')
          ..add('faFlightId', faFlightId)
          ..add('altitude', altitude)
          ..add('altitudeChange', altitudeChange)
          ..add('groundspeed', groundspeed)
          ..add('heading', heading)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('timestamp', timestamp)
          ..add('updateType', updateType))
        .toString();
  }
}

class FlightPositionEntityBuilder
    implements Builder<FlightPositionEntity, FlightPositionEntityBuilder> {
  _$FlightPositionEntity? _$v;

  String? _faFlightId;
  String? get faFlightId => _$this._faFlightId;
  set faFlightId(String? faFlightId) => _$this._faFlightId = faFlightId;

  num? _altitude;
  num? get altitude => _$this._altitude;
  set altitude(num? altitude) => _$this._altitude = altitude;

  FlightPositionEntityAltitudeChangeEnum? _altitudeChange;
  FlightPositionEntityAltitudeChangeEnum? get altitudeChange =>
      _$this._altitudeChange;
  set altitudeChange(FlightPositionEntityAltitudeChangeEnum? altitudeChange) =>
      _$this._altitudeChange = altitudeChange;

  num? _groundspeed;
  num? get groundspeed => _$this._groundspeed;
  set groundspeed(num? groundspeed) => _$this._groundspeed = groundspeed;

  num? _heading;
  num? get heading => _$this._heading;
  set heading(num? heading) => _$this._heading = heading;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  String? _timestamp;
  String? get timestamp => _$this._timestamp;
  set timestamp(String? timestamp) => _$this._timestamp = timestamp;

  FlightPositionEntityUpdateTypeEnum? _updateType;
  FlightPositionEntityUpdateTypeEnum? get updateType => _$this._updateType;
  set updateType(FlightPositionEntityUpdateTypeEnum? updateType) =>
      _$this._updateType = updateType;

  FlightPositionEntityBuilder() {
    FlightPositionEntity._defaults(this);
  }

  FlightPositionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _faFlightId = $v.faFlightId;
      _altitude = $v.altitude;
      _altitudeChange = $v.altitudeChange;
      _groundspeed = $v.groundspeed;
      _heading = $v.heading;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _timestamp = $v.timestamp;
      _updateType = $v.updateType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightPositionEntity other) {
    _$v = other as _$FlightPositionEntity;
  }

  @override
  void update(void Function(FlightPositionEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightPositionEntity build() => _build();

  _$FlightPositionEntity _build() {
    final _$result = _$v ??
        _$FlightPositionEntity._(
          faFlightId: faFlightId,
          altitude: BuiltValueNullFieldError.checkNotNull(
              altitude, r'FlightPositionEntity', 'altitude'),
          altitudeChange: BuiltValueNullFieldError.checkNotNull(
              altitudeChange, r'FlightPositionEntity', 'altitudeChange'),
          groundspeed: BuiltValueNullFieldError.checkNotNull(
              groundspeed, r'FlightPositionEntity', 'groundspeed'),
          heading: heading,
          latitude: BuiltValueNullFieldError.checkNotNull(
              latitude, r'FlightPositionEntity', 'latitude'),
          longitude: BuiltValueNullFieldError.checkNotNull(
              longitude, r'FlightPositionEntity', 'longitude'),
          timestamp: BuiltValueNullFieldError.checkNotNull(
              timestamp, r'FlightPositionEntity', 'timestamp'),
          updateType: updateType,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
