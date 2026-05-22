// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_visibility_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeatherForecastVisibilityEntity
    extends WeatherForecastVisibilityEntity {
  @override
  final String symbol;
  @override
  final String visibility;
  @override
  final JsonObject? units;

  factory _$WeatherForecastVisibilityEntity(
          [void Function(WeatherForecastVisibilityEntityBuilder)? updates]) =>
      (WeatherForecastVisibilityEntityBuilder()..update(updates))._build();

  _$WeatherForecastVisibilityEntity._(
      {required this.symbol, required this.visibility, this.units})
      : super._();
  @override
  WeatherForecastVisibilityEntity rebuild(
          void Function(WeatherForecastVisibilityEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastVisibilityEntityBuilder toBuilder() =>
      WeatherForecastVisibilityEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecastVisibilityEntity &&
        symbol == other.symbol &&
        visibility == other.visibility &&
        units == other.units;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jc(_$hash, units.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecastVisibilityEntity')
          ..add('symbol', symbol)
          ..add('visibility', visibility)
          ..add('units', units))
        .toString();
  }
}

class WeatherForecastVisibilityEntityBuilder
    implements
        Builder<WeatherForecastVisibilityEntity,
            WeatherForecastVisibilityEntityBuilder> {
  _$WeatherForecastVisibilityEntity? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _visibility;
  String? get visibility => _$this._visibility;
  set visibility(String? visibility) => _$this._visibility = visibility;

  JsonObject? _units;
  JsonObject? get units => _$this._units;
  set units(JsonObject? units) => _$this._units = units;

  WeatherForecastVisibilityEntityBuilder() {
    WeatherForecastVisibilityEntity._defaults(this);
  }

  WeatherForecastVisibilityEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _visibility = $v.visibility;
      _units = $v.units;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecastVisibilityEntity other) {
    _$v = other as _$WeatherForecastVisibilityEntity;
  }

  @override
  void update(void Function(WeatherForecastVisibilityEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecastVisibilityEntity build() => _build();

  _$WeatherForecastVisibilityEntity _build() {
    final _$result = _$v ??
        _$WeatherForecastVisibilityEntity._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'WeatherForecastVisibilityEntity', 'symbol'),
          visibility: BuiltValueNullFieldError.checkNotNull(
              visibility, r'WeatherForecastVisibilityEntity', 'visibility'),
          units: units,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
