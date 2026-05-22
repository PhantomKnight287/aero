// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_weather_forecast_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirportWeatherForecastEntity extends AirportWeatherForecastEntity {
  @override
  final String airportCode;
  @override
  final BuiltList<String> rawForecast;
  @override
  final String time;
  @override
  final WeatherForecastDecodedEntity? decodedForecast;

  factory _$AirportWeatherForecastEntity(
          [void Function(AirportWeatherForecastEntityBuilder)? updates]) =>
      (AirportWeatherForecastEntityBuilder()..update(updates))._build();

  _$AirportWeatherForecastEntity._(
      {required this.airportCode,
      required this.rawForecast,
      required this.time,
      this.decodedForecast})
      : super._();
  @override
  AirportWeatherForecastEntity rebuild(
          void Function(AirportWeatherForecastEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportWeatherForecastEntityBuilder toBuilder() =>
      AirportWeatherForecastEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportWeatherForecastEntity &&
        airportCode == other.airportCode &&
        rawForecast == other.rawForecast &&
        time == other.time &&
        decodedForecast == other.decodedForecast;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airportCode.hashCode);
    _$hash = $jc(_$hash, rawForecast.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jc(_$hash, decodedForecast.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportWeatherForecastEntity')
          ..add('airportCode', airportCode)
          ..add('rawForecast', rawForecast)
          ..add('time', time)
          ..add('decodedForecast', decodedForecast))
        .toString();
  }
}

class AirportWeatherForecastEntityBuilder
    implements
        Builder<AirportWeatherForecastEntity,
            AirportWeatherForecastEntityBuilder> {
  _$AirportWeatherForecastEntity? _$v;

  String? _airportCode;
  String? get airportCode => _$this._airportCode;
  set airportCode(String? airportCode) => _$this._airportCode = airportCode;

  ListBuilder<String>? _rawForecast;
  ListBuilder<String> get rawForecast =>
      _$this._rawForecast ??= ListBuilder<String>();
  set rawForecast(ListBuilder<String>? rawForecast) =>
      _$this._rawForecast = rawForecast;

  String? _time;
  String? get time => _$this._time;
  set time(String? time) => _$this._time = time;

  WeatherForecastDecodedEntityBuilder? _decodedForecast;
  WeatherForecastDecodedEntityBuilder get decodedForecast =>
      _$this._decodedForecast ??= WeatherForecastDecodedEntityBuilder();
  set decodedForecast(WeatherForecastDecodedEntityBuilder? decodedForecast) =>
      _$this._decodedForecast = decodedForecast;

  AirportWeatherForecastEntityBuilder() {
    AirportWeatherForecastEntity._defaults(this);
  }

  AirportWeatherForecastEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airportCode = $v.airportCode;
      _rawForecast = $v.rawForecast.toBuilder();
      _time = $v.time;
      _decodedForecast = $v.decodedForecast?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportWeatherForecastEntity other) {
    _$v = other as _$AirportWeatherForecastEntity;
  }

  @override
  void update(void Function(AirportWeatherForecastEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportWeatherForecastEntity build() => _build();

  _$AirportWeatherForecastEntity _build() {
    _$AirportWeatherForecastEntity _$result;
    try {
      _$result = _$v ??
          _$AirportWeatherForecastEntity._(
            airportCode: BuiltValueNullFieldError.checkNotNull(
                airportCode, r'AirportWeatherForecastEntity', 'airportCode'),
            rawForecast: rawForecast.build(),
            time: BuiltValueNullFieldError.checkNotNull(
                time, r'AirportWeatherForecastEntity', 'time'),
            decodedForecast: _decodedForecast?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rawForecast';
        rawForecast.build();

        _$failedField = 'decodedForecast';
        _decodedForecast?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirportWeatherForecastEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
