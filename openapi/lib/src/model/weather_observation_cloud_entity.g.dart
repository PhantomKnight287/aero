// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_observation_cloud_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeatherObservationCloudEntity extends WeatherObservationCloudEntity {
  @override
  final JsonObject? altitude;
  @override
  final String symbol;
  @override
  final String type;

  factory _$WeatherObservationCloudEntity(
          [void Function(WeatherObservationCloudEntityBuilder)? updates]) =>
      (WeatherObservationCloudEntityBuilder()..update(updates))._build();

  _$WeatherObservationCloudEntity._(
      {this.altitude, required this.symbol, required this.type})
      : super._();
  @override
  WeatherObservationCloudEntity rebuild(
          void Function(WeatherObservationCloudEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherObservationCloudEntityBuilder toBuilder() =>
      WeatherObservationCloudEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherObservationCloudEntity &&
        altitude == other.altitude &&
        symbol == other.symbol &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, altitude.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherObservationCloudEntity')
          ..add('altitude', altitude)
          ..add('symbol', symbol)
          ..add('type', type))
        .toString();
  }
}

class WeatherObservationCloudEntityBuilder
    implements
        Builder<WeatherObservationCloudEntity,
            WeatherObservationCloudEntityBuilder> {
  _$WeatherObservationCloudEntity? _$v;

  JsonObject? _altitude;
  JsonObject? get altitude => _$this._altitude;
  set altitude(JsonObject? altitude) => _$this._altitude = altitude;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  WeatherObservationCloudEntityBuilder() {
    WeatherObservationCloudEntity._defaults(this);
  }

  WeatherObservationCloudEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _altitude = $v.altitude;
      _symbol = $v.symbol;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherObservationCloudEntity other) {
    _$v = other as _$WeatherObservationCloudEntity;
  }

  @override
  void update(void Function(WeatherObservationCloudEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherObservationCloudEntity build() => _build();

  _$WeatherObservationCloudEntity _build() {
    final _$result = _$v ??
        _$WeatherObservationCloudEntity._(
          altitude: altitude,
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'WeatherObservationCloudEntity', 'symbol'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'WeatherObservationCloudEntity', 'type'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
