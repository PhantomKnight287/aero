// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_line_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeatherForecastLineEntity extends WeatherForecastLineEntity {
  @override
  final String type;
  @override
  final String start;
  @override
  final JsonObject? end;
  @override
  final JsonObject? turbulenceLayers;
  @override
  final JsonObject? icingLayers;
  @override
  final JsonObject? barometricPressure;
  @override
  final JsonObject? significantWeather;
  @override
  final WeatherForecastWindsEntity? winds;
  @override
  final WeatherForecastWindshearEntity? windshear;
  @override
  final WeatherForecastVisibilityEntity? visibility;
  @override
  final BuiltList<WeatherForecastCloudEntity>? clouds;

  factory _$WeatherForecastLineEntity(
          [void Function(WeatherForecastLineEntityBuilder)? updates]) =>
      (WeatherForecastLineEntityBuilder()..update(updates))._build();

  _$WeatherForecastLineEntity._(
      {required this.type,
      required this.start,
      this.end,
      this.turbulenceLayers,
      this.icingLayers,
      this.barometricPressure,
      this.significantWeather,
      this.winds,
      this.windshear,
      this.visibility,
      this.clouds})
      : super._();
  @override
  WeatherForecastLineEntity rebuild(
          void Function(WeatherForecastLineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastLineEntityBuilder toBuilder() =>
      WeatherForecastLineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecastLineEntity &&
        type == other.type &&
        start == other.start &&
        end == other.end &&
        turbulenceLayers == other.turbulenceLayers &&
        icingLayers == other.icingLayers &&
        barometricPressure == other.barometricPressure &&
        significantWeather == other.significantWeather &&
        winds == other.winds &&
        windshear == other.windshear &&
        visibility == other.visibility &&
        clouds == other.clouds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jc(_$hash, turbulenceLayers.hashCode);
    _$hash = $jc(_$hash, icingLayers.hashCode);
    _$hash = $jc(_$hash, barometricPressure.hashCode);
    _$hash = $jc(_$hash, significantWeather.hashCode);
    _$hash = $jc(_$hash, winds.hashCode);
    _$hash = $jc(_$hash, windshear.hashCode);
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jc(_$hash, clouds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecastLineEntity')
          ..add('type', type)
          ..add('start', start)
          ..add('end', end)
          ..add('turbulenceLayers', turbulenceLayers)
          ..add('icingLayers', icingLayers)
          ..add('barometricPressure', barometricPressure)
          ..add('significantWeather', significantWeather)
          ..add('winds', winds)
          ..add('windshear', windshear)
          ..add('visibility', visibility)
          ..add('clouds', clouds))
        .toString();
  }
}

class WeatherForecastLineEntityBuilder
    implements
        Builder<WeatherForecastLineEntity, WeatherForecastLineEntityBuilder> {
  _$WeatherForecastLineEntity? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  JsonObject? _end;
  JsonObject? get end => _$this._end;
  set end(JsonObject? end) => _$this._end = end;

  JsonObject? _turbulenceLayers;
  JsonObject? get turbulenceLayers => _$this._turbulenceLayers;
  set turbulenceLayers(JsonObject? turbulenceLayers) =>
      _$this._turbulenceLayers = turbulenceLayers;

  JsonObject? _icingLayers;
  JsonObject? get icingLayers => _$this._icingLayers;
  set icingLayers(JsonObject? icingLayers) => _$this._icingLayers = icingLayers;

  JsonObject? _barometricPressure;
  JsonObject? get barometricPressure => _$this._barometricPressure;
  set barometricPressure(JsonObject? barometricPressure) =>
      _$this._barometricPressure = barometricPressure;

  JsonObject? _significantWeather;
  JsonObject? get significantWeather => _$this._significantWeather;
  set significantWeather(JsonObject? significantWeather) =>
      _$this._significantWeather = significantWeather;

  WeatherForecastWindsEntityBuilder? _winds;
  WeatherForecastWindsEntityBuilder get winds =>
      _$this._winds ??= WeatherForecastWindsEntityBuilder();
  set winds(WeatherForecastWindsEntityBuilder? winds) => _$this._winds = winds;

  WeatherForecastWindshearEntityBuilder? _windshear;
  WeatherForecastWindshearEntityBuilder get windshear =>
      _$this._windshear ??= WeatherForecastWindshearEntityBuilder();
  set windshear(WeatherForecastWindshearEntityBuilder? windshear) =>
      _$this._windshear = windshear;

  WeatherForecastVisibilityEntityBuilder? _visibility;
  WeatherForecastVisibilityEntityBuilder get visibility =>
      _$this._visibility ??= WeatherForecastVisibilityEntityBuilder();
  set visibility(WeatherForecastVisibilityEntityBuilder? visibility) =>
      _$this._visibility = visibility;

  ListBuilder<WeatherForecastCloudEntity>? _clouds;
  ListBuilder<WeatherForecastCloudEntity> get clouds =>
      _$this._clouds ??= ListBuilder<WeatherForecastCloudEntity>();
  set clouds(ListBuilder<WeatherForecastCloudEntity>? clouds) =>
      _$this._clouds = clouds;

  WeatherForecastLineEntityBuilder() {
    WeatherForecastLineEntity._defaults(this);
  }

  WeatherForecastLineEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _start = $v.start;
      _end = $v.end;
      _turbulenceLayers = $v.turbulenceLayers;
      _icingLayers = $v.icingLayers;
      _barometricPressure = $v.barometricPressure;
      _significantWeather = $v.significantWeather;
      _winds = $v.winds?.toBuilder();
      _windshear = $v.windshear?.toBuilder();
      _visibility = $v.visibility?.toBuilder();
      _clouds = $v.clouds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecastLineEntity other) {
    _$v = other as _$WeatherForecastLineEntity;
  }

  @override
  void update(void Function(WeatherForecastLineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecastLineEntity build() => _build();

  _$WeatherForecastLineEntity _build() {
    _$WeatherForecastLineEntity _$result;
    try {
      _$result = _$v ??
          _$WeatherForecastLineEntity._(
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'WeatherForecastLineEntity', 'type'),
            start: BuiltValueNullFieldError.checkNotNull(
                start, r'WeatherForecastLineEntity', 'start'),
            end: end,
            turbulenceLayers: turbulenceLayers,
            icingLayers: icingLayers,
            barometricPressure: barometricPressure,
            significantWeather: significantWeather,
            winds: _winds?.build(),
            windshear: _windshear?.build(),
            visibility: _visibility?.build(),
            clouds: _clouds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'winds';
        _winds?.build();
        _$failedField = 'windshear';
        _windshear?.build();
        _$failedField = 'visibility';
        _visibility?.build();
        _$failedField = 'clouds';
        _clouds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WeatherForecastLineEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
