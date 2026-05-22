// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_winds_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeatherForecastWindsEntity extends WeatherForecastWindsEntity {
  @override
  final String symbol;
  @override
  final String direction;
  @override
  final num speed;
  @override
  final JsonObject? units;
  @override
  final JsonObject? peakGusts;

  factory _$WeatherForecastWindsEntity(
          [void Function(WeatherForecastWindsEntityBuilder)? updates]) =>
      (WeatherForecastWindsEntityBuilder()..update(updates))._build();

  _$WeatherForecastWindsEntity._(
      {required this.symbol,
      required this.direction,
      required this.speed,
      this.units,
      this.peakGusts})
      : super._();
  @override
  WeatherForecastWindsEntity rebuild(
          void Function(WeatherForecastWindsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastWindsEntityBuilder toBuilder() =>
      WeatherForecastWindsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecastWindsEntity &&
        symbol == other.symbol &&
        direction == other.direction &&
        speed == other.speed &&
        units == other.units &&
        peakGusts == other.peakGusts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, speed.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jc(_$hash, peakGusts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecastWindsEntity')
          ..add('symbol', symbol)
          ..add('direction', direction)
          ..add('speed', speed)
          ..add('units', units)
          ..add('peakGusts', peakGusts))
        .toString();
  }
}

class WeatherForecastWindsEntityBuilder
    implements
        Builder<WeatherForecastWindsEntity, WeatherForecastWindsEntityBuilder> {
  _$WeatherForecastWindsEntity? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _direction;
  String? get direction => _$this._direction;
  set direction(String? direction) => _$this._direction = direction;

  num? _speed;
  num? get speed => _$this._speed;
  set speed(num? speed) => _$this._speed = speed;

  JsonObject? _units;
  JsonObject? get units => _$this._units;
  set units(JsonObject? units) => _$this._units = units;

  JsonObject? _peakGusts;
  JsonObject? get peakGusts => _$this._peakGusts;
  set peakGusts(JsonObject? peakGusts) => _$this._peakGusts = peakGusts;

  WeatherForecastWindsEntityBuilder() {
    WeatherForecastWindsEntity._defaults(this);
  }

  WeatherForecastWindsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _direction = $v.direction;
      _speed = $v.speed;
      _units = $v.units;
      _peakGusts = $v.peakGusts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecastWindsEntity other) {
    _$v = other as _$WeatherForecastWindsEntity;
  }

  @override
  void update(void Function(WeatherForecastWindsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecastWindsEntity build() => _build();

  _$WeatherForecastWindsEntity _build() {
    final _$result = _$v ??
        _$WeatherForecastWindsEntity._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'WeatherForecastWindsEntity', 'symbol'),
          direction: BuiltValueNullFieldError.checkNotNull(
              direction, r'WeatherForecastWindsEntity', 'direction'),
          speed: BuiltValueNullFieldError.checkNotNull(
              speed, r'WeatherForecastWindsEntity', 'speed'),
          units: units,
          peakGusts: peakGusts,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
