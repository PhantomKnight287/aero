// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_details_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirportDetailsEntity extends AirportDetailsEntity {
  @override
  final String ident;
  @override
  final JsonObject? delays;
  @override
  final DecodedWeatherEntity? metar;
  @override
  final DecodedWeatherEntity? taf;

  factory _$AirportDetailsEntity(
          [void Function(AirportDetailsEntityBuilder)? updates]) =>
      (AirportDetailsEntityBuilder()..update(updates))._build();

  _$AirportDetailsEntity._(
      {required this.ident, this.delays, this.metar, this.taf})
      : super._();
  @override
  AirportDetailsEntity rebuild(
          void Function(AirportDetailsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportDetailsEntityBuilder toBuilder() =>
      AirportDetailsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportDetailsEntity &&
        ident == other.ident &&
        delays == other.delays &&
        metar == other.metar &&
        taf == other.taf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ident.hashCode);
    _$hash = $jc(_$hash, delays.hashCode);
    _$hash = $jc(_$hash, metar.hashCode);
    _$hash = $jc(_$hash, taf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportDetailsEntity')
          ..add('ident', ident)
          ..add('delays', delays)
          ..add('metar', metar)
          ..add('taf', taf))
        .toString();
  }
}

class AirportDetailsEntityBuilder
    implements Builder<AirportDetailsEntity, AirportDetailsEntityBuilder> {
  _$AirportDetailsEntity? _$v;

  String? _ident;
  String? get ident => _$this._ident;
  set ident(String? ident) => _$this._ident = ident;

  JsonObject? _delays;
  JsonObject? get delays => _$this._delays;
  set delays(JsonObject? delays) => _$this._delays = delays;

  DecodedWeatherEntityBuilder? _metar;
  DecodedWeatherEntityBuilder get metar =>
      _$this._metar ??= DecodedWeatherEntityBuilder();
  set metar(DecodedWeatherEntityBuilder? metar) => _$this._metar = metar;

  DecodedWeatherEntityBuilder? _taf;
  DecodedWeatherEntityBuilder get taf =>
      _$this._taf ??= DecodedWeatherEntityBuilder();
  set taf(DecodedWeatherEntityBuilder? taf) => _$this._taf = taf;

  AirportDetailsEntityBuilder() {
    AirportDetailsEntity._defaults(this);
  }

  AirportDetailsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ident = $v.ident;
      _delays = $v.delays;
      _metar = $v.metar?.toBuilder();
      _taf = $v.taf?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportDetailsEntity other) {
    _$v = other as _$AirportDetailsEntity;
  }

  @override
  void update(void Function(AirportDetailsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportDetailsEntity build() => _build();

  _$AirportDetailsEntity _build() {
    _$AirportDetailsEntity _$result;
    try {
      _$result = _$v ??
          _$AirportDetailsEntity._(
            ident: BuiltValueNullFieldError.checkNotNull(
                ident, r'AirportDetailsEntity', 'ident'),
            delays: delays,
            metar: _metar?.build(),
            taf: _taf?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metar';
        _metar?.build();
        _$failedField = 'taf';
        _taf?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirportDetailsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
