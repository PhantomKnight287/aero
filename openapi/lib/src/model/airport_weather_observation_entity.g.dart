// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_weather_observation_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AirportWeatherObservationEntityPressureUnitsEnum
    _$airportWeatherObservationEntityPressureUnitsEnum_empty =
    const AirportWeatherObservationEntityPressureUnitsEnum._('empty');
const AirportWeatherObservationEntityPressureUnitsEnum
    _$airportWeatherObservationEntityPressureUnitsEnum_mb =
    const AirportWeatherObservationEntityPressureUnitsEnum._('mb');
const AirportWeatherObservationEntityPressureUnitsEnum
    _$airportWeatherObservationEntityPressureUnitsEnum_inHg =
    const AirportWeatherObservationEntityPressureUnitsEnum._('inHg');

AirportWeatherObservationEntityPressureUnitsEnum
    _$airportWeatherObservationEntityPressureUnitsEnumValueOf(String name) {
  switch (name) {
    case 'empty':
      return _$airportWeatherObservationEntityPressureUnitsEnum_empty;
    case 'mb':
      return _$airportWeatherObservationEntityPressureUnitsEnum_mb;
    case 'inHg':
      return _$airportWeatherObservationEntityPressureUnitsEnum_inHg;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AirportWeatherObservationEntityPressureUnitsEnum>
    _$airportWeatherObservationEntityPressureUnitsEnumValues = BuiltSet<
        AirportWeatherObservationEntityPressureUnitsEnum>(const <AirportWeatherObservationEntityPressureUnitsEnum>[
  _$airportWeatherObservationEntityPressureUnitsEnum_empty,
  _$airportWeatherObservationEntityPressureUnitsEnum_mb,
  _$airportWeatherObservationEntityPressureUnitsEnum_inHg,
]);

const AirportWeatherObservationEntityVisibilityUnitsEnum
    _$airportWeatherObservationEntityVisibilityUnitsEnum_empty =
    const AirportWeatherObservationEntityVisibilityUnitsEnum._('empty');
const AirportWeatherObservationEntityVisibilityUnitsEnum
    _$airportWeatherObservationEntityVisibilityUnitsEnum_meters =
    const AirportWeatherObservationEntityVisibilityUnitsEnum._('meters');
const AirportWeatherObservationEntityVisibilityUnitsEnum
    _$airportWeatherObservationEntityVisibilityUnitsEnum_SM =
    const AirportWeatherObservationEntityVisibilityUnitsEnum._('SM');

AirportWeatherObservationEntityVisibilityUnitsEnum
    _$airportWeatherObservationEntityVisibilityUnitsEnumValueOf(String name) {
  switch (name) {
    case 'empty':
      return _$airportWeatherObservationEntityVisibilityUnitsEnum_empty;
    case 'meters':
      return _$airportWeatherObservationEntityVisibilityUnitsEnum_meters;
    case 'SM':
      return _$airportWeatherObservationEntityVisibilityUnitsEnum_SM;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AirportWeatherObservationEntityVisibilityUnitsEnum>
    _$airportWeatherObservationEntityVisibilityUnitsEnumValues = BuiltSet<
        AirportWeatherObservationEntityVisibilityUnitsEnum>(const <AirportWeatherObservationEntityVisibilityUnitsEnum>[
  _$airportWeatherObservationEntityVisibilityUnitsEnum_empty,
  _$airportWeatherObservationEntityVisibilityUnitsEnum_meters,
  _$airportWeatherObservationEntityVisibilityUnitsEnum_SM,
]);

const AirportWeatherObservationEntityWindUnitsEnum
    _$airportWeatherObservationEntityWindUnitsEnum_MPS =
    const AirportWeatherObservationEntityWindUnitsEnum._('MPS');
const AirportWeatherObservationEntityWindUnitsEnum
    _$airportWeatherObservationEntityWindUnitsEnum_KT =
    const AirportWeatherObservationEntityWindUnitsEnum._('KT');

AirportWeatherObservationEntityWindUnitsEnum
    _$airportWeatherObservationEntityWindUnitsEnumValueOf(String name) {
  switch (name) {
    case 'MPS':
      return _$airportWeatherObservationEntityWindUnitsEnum_MPS;
    case 'KT':
      return _$airportWeatherObservationEntityWindUnitsEnum_KT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AirportWeatherObservationEntityWindUnitsEnum>
    _$airportWeatherObservationEntityWindUnitsEnumValues = BuiltSet<
        AirportWeatherObservationEntityWindUnitsEnum>(const <AirportWeatherObservationEntityWindUnitsEnum>[
  _$airportWeatherObservationEntityWindUnitsEnum_MPS,
  _$airportWeatherObservationEntityWindUnitsEnum_KT,
]);

Serializer<AirportWeatherObservationEntityPressureUnitsEnum>
    _$airportWeatherObservationEntityPressureUnitsEnumSerializer =
    _$AirportWeatherObservationEntityPressureUnitsEnumSerializer();
Serializer<AirportWeatherObservationEntityVisibilityUnitsEnum>
    _$airportWeatherObservationEntityVisibilityUnitsEnumSerializer =
    _$AirportWeatherObservationEntityVisibilityUnitsEnumSerializer();
Serializer<AirportWeatherObservationEntityWindUnitsEnum>
    _$airportWeatherObservationEntityWindUnitsEnumSerializer =
    _$AirportWeatherObservationEntityWindUnitsEnumSerializer();

class _$AirportWeatherObservationEntityPressureUnitsEnumSerializer
    implements
        PrimitiveSerializer<AirportWeatherObservationEntityPressureUnitsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'empty': '',
    'mb': 'mb',
    'inHg': 'in Hg',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '': 'empty',
    'mb': 'mb',
    'in Hg': 'inHg',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AirportWeatherObservationEntityPressureUnitsEnum
  ];
  @override
  final String wireName = 'AirportWeatherObservationEntityPressureUnitsEnum';

  @override
  Object serialize(Serializers serializers,
          AirportWeatherObservationEntityPressureUnitsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirportWeatherObservationEntityPressureUnitsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirportWeatherObservationEntityPressureUnitsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AirportWeatherObservationEntityVisibilityUnitsEnumSerializer
    implements
        PrimitiveSerializer<
            AirportWeatherObservationEntityVisibilityUnitsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'empty': '',
    'meters': 'meters',
    'SM': 'SM',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '': 'empty',
    'meters': 'meters',
    'SM': 'SM',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AirportWeatherObservationEntityVisibilityUnitsEnum
  ];
  @override
  final String wireName = 'AirportWeatherObservationEntityVisibilityUnitsEnum';

  @override
  Object serialize(Serializers serializers,
          AirportWeatherObservationEntityVisibilityUnitsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirportWeatherObservationEntityVisibilityUnitsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirportWeatherObservationEntityVisibilityUnitsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AirportWeatherObservationEntityWindUnitsEnumSerializer
    implements
        PrimitiveSerializer<AirportWeatherObservationEntityWindUnitsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MPS': 'MPS',
    'KT': 'KT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MPS': 'MPS',
    'KT': 'KT',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AirportWeatherObservationEntityWindUnitsEnum
  ];
  @override
  final String wireName = 'AirportWeatherObservationEntityWindUnitsEnum';

  @override
  Object serialize(Serializers serializers,
          AirportWeatherObservationEntityWindUnitsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirportWeatherObservationEntityWindUnitsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirportWeatherObservationEntityWindUnitsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AirportWeatherObservationEntity
    extends AirportWeatherObservationEntity {
  @override
  final String airportCode;
  @override
  final JsonObject? cloudFriendly;
  @override
  final BuiltList<WeatherObservationCloudEntity>? clouds;
  @override
  final JsonObject? conditions;
  @override
  final JsonObject? pressure;
  @override
  final AirportWeatherObservationEntityPressureUnitsEnum? pressureUnits;
  @override
  final String rawData;
  @override
  final JsonObject? tempAir;
  @override
  final JsonObject? tempDewpoint;
  @override
  final JsonObject? tempPerceived;
  @override
  final JsonObject? relativeHumidity;
  @override
  final String time;
  @override
  final JsonObject? visibility;
  @override
  final AirportWeatherObservationEntityVisibilityUnitsEnum? visibilityUnits;
  @override
  final num windDirection;
  @override
  final String windFriendly;
  @override
  final num windSpeed;
  @override
  final num windSpeedGust;
  @override
  final AirportWeatherObservationEntityWindUnitsEnum windUnits;

  factory _$AirportWeatherObservationEntity(
          [void Function(AirportWeatherObservationEntityBuilder)? updates]) =>
      (AirportWeatherObservationEntityBuilder()..update(updates))._build();

  _$AirportWeatherObservationEntity._(
      {required this.airportCode,
      this.cloudFriendly,
      this.clouds,
      this.conditions,
      this.pressure,
      this.pressureUnits,
      required this.rawData,
      this.tempAir,
      this.tempDewpoint,
      this.tempPerceived,
      this.relativeHumidity,
      required this.time,
      this.visibility,
      this.visibilityUnits,
      required this.windDirection,
      required this.windFriendly,
      required this.windSpeed,
      required this.windSpeedGust,
      required this.windUnits})
      : super._();
  @override
  AirportWeatherObservationEntity rebuild(
          void Function(AirportWeatherObservationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportWeatherObservationEntityBuilder toBuilder() =>
      AirportWeatherObservationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportWeatherObservationEntity &&
        airportCode == other.airportCode &&
        cloudFriendly == other.cloudFriendly &&
        clouds == other.clouds &&
        conditions == other.conditions &&
        pressure == other.pressure &&
        pressureUnits == other.pressureUnits &&
        rawData == other.rawData &&
        tempAir == other.tempAir &&
        tempDewpoint == other.tempDewpoint &&
        tempPerceived == other.tempPerceived &&
        relativeHumidity == other.relativeHumidity &&
        time == other.time &&
        visibility == other.visibility &&
        visibilityUnits == other.visibilityUnits &&
        windDirection == other.windDirection &&
        windFriendly == other.windFriendly &&
        windSpeed == other.windSpeed &&
        windSpeedGust == other.windSpeedGust &&
        windUnits == other.windUnits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airportCode.hashCode);
    _$hash = $jc(_$hash, cloudFriendly.hashCode);
    _$hash = $jc(_$hash, clouds.hashCode);
    _$hash = $jc(_$hash, conditions.hashCode);
    _$hash = $jc(_$hash, pressure.hashCode);
    _$hash = $jc(_$hash, pressureUnits.hashCode);
    _$hash = $jc(_$hash, rawData.hashCode);
    _$hash = $jc(_$hash, tempAir.hashCode);
    _$hash = $jc(_$hash, tempDewpoint.hashCode);
    _$hash = $jc(_$hash, tempPerceived.hashCode);
    _$hash = $jc(_$hash, relativeHumidity.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jc(_$hash, visibilityUnits.hashCode);
    _$hash = $jc(_$hash, windDirection.hashCode);
    _$hash = $jc(_$hash, windFriendly.hashCode);
    _$hash = $jc(_$hash, windSpeed.hashCode);
    _$hash = $jc(_$hash, windSpeedGust.hashCode);
    _$hash = $jc(_$hash, windUnits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportWeatherObservationEntity')
          ..add('airportCode', airportCode)
          ..add('cloudFriendly', cloudFriendly)
          ..add('clouds', clouds)
          ..add('conditions', conditions)
          ..add('pressure', pressure)
          ..add('pressureUnits', pressureUnits)
          ..add('rawData', rawData)
          ..add('tempAir', tempAir)
          ..add('tempDewpoint', tempDewpoint)
          ..add('tempPerceived', tempPerceived)
          ..add('relativeHumidity', relativeHumidity)
          ..add('time', time)
          ..add('visibility', visibility)
          ..add('visibilityUnits', visibilityUnits)
          ..add('windDirection', windDirection)
          ..add('windFriendly', windFriendly)
          ..add('windSpeed', windSpeed)
          ..add('windSpeedGust', windSpeedGust)
          ..add('windUnits', windUnits))
        .toString();
  }
}

class AirportWeatherObservationEntityBuilder
    implements
        Builder<AirportWeatherObservationEntity,
            AirportWeatherObservationEntityBuilder> {
  _$AirportWeatherObservationEntity? _$v;

  String? _airportCode;
  String? get airportCode => _$this._airportCode;
  set airportCode(String? airportCode) => _$this._airportCode = airportCode;

  JsonObject? _cloudFriendly;
  JsonObject? get cloudFriendly => _$this._cloudFriendly;
  set cloudFriendly(JsonObject? cloudFriendly) =>
      _$this._cloudFriendly = cloudFriendly;

  ListBuilder<WeatherObservationCloudEntity>? _clouds;
  ListBuilder<WeatherObservationCloudEntity> get clouds =>
      _$this._clouds ??= ListBuilder<WeatherObservationCloudEntity>();
  set clouds(ListBuilder<WeatherObservationCloudEntity>? clouds) =>
      _$this._clouds = clouds;

  JsonObject? _conditions;
  JsonObject? get conditions => _$this._conditions;
  set conditions(JsonObject? conditions) => _$this._conditions = conditions;

  JsonObject? _pressure;
  JsonObject? get pressure => _$this._pressure;
  set pressure(JsonObject? pressure) => _$this._pressure = pressure;

  AirportWeatherObservationEntityPressureUnitsEnum? _pressureUnits;
  AirportWeatherObservationEntityPressureUnitsEnum? get pressureUnits =>
      _$this._pressureUnits;
  set pressureUnits(
          AirportWeatherObservationEntityPressureUnitsEnum? pressureUnits) =>
      _$this._pressureUnits = pressureUnits;

  String? _rawData;
  String? get rawData => _$this._rawData;
  set rawData(String? rawData) => _$this._rawData = rawData;

  JsonObject? _tempAir;
  JsonObject? get tempAir => _$this._tempAir;
  set tempAir(JsonObject? tempAir) => _$this._tempAir = tempAir;

  JsonObject? _tempDewpoint;
  JsonObject? get tempDewpoint => _$this._tempDewpoint;
  set tempDewpoint(JsonObject? tempDewpoint) =>
      _$this._tempDewpoint = tempDewpoint;

  JsonObject? _tempPerceived;
  JsonObject? get tempPerceived => _$this._tempPerceived;
  set tempPerceived(JsonObject? tempPerceived) =>
      _$this._tempPerceived = tempPerceived;

  JsonObject? _relativeHumidity;
  JsonObject? get relativeHumidity => _$this._relativeHumidity;
  set relativeHumidity(JsonObject? relativeHumidity) =>
      _$this._relativeHumidity = relativeHumidity;

  String? _time;
  String? get time => _$this._time;
  set time(String? time) => _$this._time = time;

  JsonObject? _visibility;
  JsonObject? get visibility => _$this._visibility;
  set visibility(JsonObject? visibility) => _$this._visibility = visibility;

  AirportWeatherObservationEntityVisibilityUnitsEnum? _visibilityUnits;
  AirportWeatherObservationEntityVisibilityUnitsEnum? get visibilityUnits =>
      _$this._visibilityUnits;
  set visibilityUnits(
          AirportWeatherObservationEntityVisibilityUnitsEnum?
              visibilityUnits) =>
      _$this._visibilityUnits = visibilityUnits;

  num? _windDirection;
  num? get windDirection => _$this._windDirection;
  set windDirection(num? windDirection) =>
      _$this._windDirection = windDirection;

  String? _windFriendly;
  String? get windFriendly => _$this._windFriendly;
  set windFriendly(String? windFriendly) => _$this._windFriendly = windFriendly;

  num? _windSpeed;
  num? get windSpeed => _$this._windSpeed;
  set windSpeed(num? windSpeed) => _$this._windSpeed = windSpeed;

  num? _windSpeedGust;
  num? get windSpeedGust => _$this._windSpeedGust;
  set windSpeedGust(num? windSpeedGust) =>
      _$this._windSpeedGust = windSpeedGust;

  AirportWeatherObservationEntityWindUnitsEnum? _windUnits;
  AirportWeatherObservationEntityWindUnitsEnum? get windUnits =>
      _$this._windUnits;
  set windUnits(AirportWeatherObservationEntityWindUnitsEnum? windUnits) =>
      _$this._windUnits = windUnits;

  AirportWeatherObservationEntityBuilder() {
    AirportWeatherObservationEntity._defaults(this);
  }

  AirportWeatherObservationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airportCode = $v.airportCode;
      _cloudFriendly = $v.cloudFriendly;
      _clouds = $v.clouds?.toBuilder();
      _conditions = $v.conditions;
      _pressure = $v.pressure;
      _pressureUnits = $v.pressureUnits;
      _rawData = $v.rawData;
      _tempAir = $v.tempAir;
      _tempDewpoint = $v.tempDewpoint;
      _tempPerceived = $v.tempPerceived;
      _relativeHumidity = $v.relativeHumidity;
      _time = $v.time;
      _visibility = $v.visibility;
      _visibilityUnits = $v.visibilityUnits;
      _windDirection = $v.windDirection;
      _windFriendly = $v.windFriendly;
      _windSpeed = $v.windSpeed;
      _windSpeedGust = $v.windSpeedGust;
      _windUnits = $v.windUnits;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportWeatherObservationEntity other) {
    _$v = other as _$AirportWeatherObservationEntity;
  }

  @override
  void update(void Function(AirportWeatherObservationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportWeatherObservationEntity build() => _build();

  _$AirportWeatherObservationEntity _build() {
    _$AirportWeatherObservationEntity _$result;
    try {
      _$result = _$v ??
          _$AirportWeatherObservationEntity._(
            airportCode: BuiltValueNullFieldError.checkNotNull(
                airportCode, r'AirportWeatherObservationEntity', 'airportCode'),
            cloudFriendly: cloudFriendly,
            clouds: _clouds?.build(),
            conditions: conditions,
            pressure: pressure,
            pressureUnits: pressureUnits,
            rawData: BuiltValueNullFieldError.checkNotNull(
                rawData, r'AirportWeatherObservationEntity', 'rawData'),
            tempAir: tempAir,
            tempDewpoint: tempDewpoint,
            tempPerceived: tempPerceived,
            relativeHumidity: relativeHumidity,
            time: BuiltValueNullFieldError.checkNotNull(
                time, r'AirportWeatherObservationEntity', 'time'),
            visibility: visibility,
            visibilityUnits: visibilityUnits,
            windDirection: BuiltValueNullFieldError.checkNotNull(windDirection,
                r'AirportWeatherObservationEntity', 'windDirection'),
            windFriendly: BuiltValueNullFieldError.checkNotNull(windFriendly,
                r'AirportWeatherObservationEntity', 'windFriendly'),
            windSpeed: BuiltValueNullFieldError.checkNotNull(
                windSpeed, r'AirportWeatherObservationEntity', 'windSpeed'),
            windSpeedGust: BuiltValueNullFieldError.checkNotNull(windSpeedGust,
                r'AirportWeatherObservationEntity', 'windSpeedGust'),
            windUnits: BuiltValueNullFieldError.checkNotNull(
                windUnits, r'AirportWeatherObservationEntity', 'windUnits'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'clouds';
        _clouds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirportWeatherObservationEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
