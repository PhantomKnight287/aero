// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoded_weather_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DecodedWeatherEntity extends DecodedWeatherEntity {
  @override
  final String? raw;
  @override
  final JsonObject? decoded;

  factory _$DecodedWeatherEntity(
          [void Function(DecodedWeatherEntityBuilder)? updates]) =>
      (DecodedWeatherEntityBuilder()..update(updates))._build();

  _$DecodedWeatherEntity._({this.raw, this.decoded}) : super._();
  @override
  DecodedWeatherEntity rebuild(
          void Function(DecodedWeatherEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DecodedWeatherEntityBuilder toBuilder() =>
      DecodedWeatherEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DecodedWeatherEntity &&
        raw == other.raw &&
        decoded == other.decoded;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, raw.hashCode);
    _$hash = $jc(_$hash, decoded.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DecodedWeatherEntity')
          ..add('raw', raw)
          ..add('decoded', decoded))
        .toString();
  }
}

class DecodedWeatherEntityBuilder
    implements Builder<DecodedWeatherEntity, DecodedWeatherEntityBuilder> {
  _$DecodedWeatherEntity? _$v;

  String? _raw;
  String? get raw => _$this._raw;
  set raw(String? raw) => _$this._raw = raw;

  JsonObject? _decoded;
  JsonObject? get decoded => _$this._decoded;
  set decoded(JsonObject? decoded) => _$this._decoded = decoded;

  DecodedWeatherEntityBuilder() {
    DecodedWeatherEntity._defaults(this);
  }

  DecodedWeatherEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _raw = $v.raw;
      _decoded = $v.decoded;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DecodedWeatherEntity other) {
    _$v = other as _$DecodedWeatherEntity;
  }

  @override
  void update(void Function(DecodedWeatherEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DecodedWeatherEntity build() => _build();

  _$DecodedWeatherEntity _build() {
    final _$result = _$v ??
        _$DecodedWeatherEntity._(
          raw: raw,
          decoded: decoded,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
