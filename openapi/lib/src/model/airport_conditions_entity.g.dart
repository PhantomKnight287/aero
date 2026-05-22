// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_conditions_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirportConditionsEntity extends AirportConditionsEntity {
  @override
  final AirportDelaysEntity? delays;
  @override
  final AirportWeatherForecastEntity? forecast;
  @override
  final AirportWeatherObservationEntity? observation;

  factory _$AirportConditionsEntity(
          [void Function(AirportConditionsEntityBuilder)? updates]) =>
      (AirportConditionsEntityBuilder()..update(updates))._build();

  _$AirportConditionsEntity._({this.delays, this.forecast, this.observation})
      : super._();
  @override
  AirportConditionsEntity rebuild(
          void Function(AirportConditionsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportConditionsEntityBuilder toBuilder() =>
      AirportConditionsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportConditionsEntity &&
        delays == other.delays &&
        forecast == other.forecast &&
        observation == other.observation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, delays.hashCode);
    _$hash = $jc(_$hash, forecast.hashCode);
    _$hash = $jc(_$hash, observation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportConditionsEntity')
          ..add('delays', delays)
          ..add('forecast', forecast)
          ..add('observation', observation))
        .toString();
  }
}

class AirportConditionsEntityBuilder
    implements
        Builder<AirportConditionsEntity, AirportConditionsEntityBuilder> {
  _$AirportConditionsEntity? _$v;

  AirportDelaysEntityBuilder? _delays;
  AirportDelaysEntityBuilder get delays =>
      _$this._delays ??= AirportDelaysEntityBuilder();
  set delays(AirportDelaysEntityBuilder? delays) => _$this._delays = delays;

  AirportWeatherForecastEntityBuilder? _forecast;
  AirportWeatherForecastEntityBuilder get forecast =>
      _$this._forecast ??= AirportWeatherForecastEntityBuilder();
  set forecast(AirportWeatherForecastEntityBuilder? forecast) =>
      _$this._forecast = forecast;

  AirportWeatherObservationEntityBuilder? _observation;
  AirportWeatherObservationEntityBuilder get observation =>
      _$this._observation ??= AirportWeatherObservationEntityBuilder();
  set observation(AirportWeatherObservationEntityBuilder? observation) =>
      _$this._observation = observation;

  AirportConditionsEntityBuilder() {
    AirportConditionsEntity._defaults(this);
  }

  AirportConditionsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _delays = $v.delays?.toBuilder();
      _forecast = $v.forecast?.toBuilder();
      _observation = $v.observation?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportConditionsEntity other) {
    _$v = other as _$AirportConditionsEntity;
  }

  @override
  void update(void Function(AirportConditionsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportConditionsEntity build() => _build();

  _$AirportConditionsEntity _build() {
    _$AirportConditionsEntity _$result;
    try {
      _$result = _$v ??
          _$AirportConditionsEntity._(
            delays: _delays?.build(),
            forecast: _forecast?.build(),
            observation: _observation?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'delays';
        _delays?.build();
        _$failedField = 'forecast';
        _forecast?.build();
        _$failedField = 'observation';
        _observation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirportConditionsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
