// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_windshear_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeatherForecastWindshearEntity extends WeatherForecastWindshearEntity {
  @override
  final String symbol;
  @override
  final String height;
  @override
  final String direction;
  @override
  final String speed;
  @override
  final JsonObject? units;

  factory _$WeatherForecastWindshearEntity(
          [void Function(WeatherForecastWindshearEntityBuilder)? updates]) =>
      (WeatherForecastWindshearEntityBuilder()..update(updates))._build();

  _$WeatherForecastWindshearEntity._(
      {required this.symbol,
      required this.height,
      required this.direction,
      required this.speed,
      this.units})
      : super._();
  @override
  WeatherForecastWindshearEntity rebuild(
          void Function(WeatherForecastWindshearEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastWindshearEntityBuilder toBuilder() =>
      WeatherForecastWindshearEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecastWindshearEntity &&
        symbol == other.symbol &&
        height == other.height &&
        direction == other.direction &&
        speed == other.speed &&
        units == other.units;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, speed.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecastWindshearEntity')
          ..add('symbol', symbol)
          ..add('height', height)
          ..add('direction', direction)
          ..add('speed', speed)
          ..add('units', units))
        .toString();
  }
}

class WeatherForecastWindshearEntityBuilder
    implements
        Builder<WeatherForecastWindshearEntity,
            WeatherForecastWindshearEntityBuilder> {
  _$WeatherForecastWindshearEntity? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _height;
  String? get height => _$this._height;
  set height(String? height) => _$this._height = height;

  String? _direction;
  String? get direction => _$this._direction;
  set direction(String? direction) => _$this._direction = direction;

  String? _speed;
  String? get speed => _$this._speed;
  set speed(String? speed) => _$this._speed = speed;

  JsonObject? _units;
  JsonObject? get units => _$this._units;
  set units(JsonObject? units) => _$this._units = units;

  WeatherForecastWindshearEntityBuilder() {
    WeatherForecastWindshearEntity._defaults(this);
  }

  WeatherForecastWindshearEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _height = $v.height;
      _direction = $v.direction;
      _speed = $v.speed;
      _units = $v.units;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecastWindshearEntity other) {
    _$v = other as _$WeatherForecastWindshearEntity;
  }

  @override
  void update(void Function(WeatherForecastWindshearEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecastWindshearEntity build() => _build();

  _$WeatherForecastWindshearEntity _build() {
    final _$result = _$v ??
        _$WeatherForecastWindshearEntity._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'WeatherForecastWindshearEntity', 'symbol'),
          height: BuiltValueNullFieldError.checkNotNull(
              height, r'WeatherForecastWindshearEntity', 'height'),
          direction: BuiltValueNullFieldError.checkNotNull(
              direction, r'WeatherForecastWindshearEntity', 'direction'),
          speed: BuiltValueNullFieldError.checkNotNull(
              speed, r'WeatherForecastWindshearEntity', 'speed'),
          units: units,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
