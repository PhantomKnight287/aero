// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_decoded_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WeatherForecastDecodedEntity extends WeatherForecastDecodedEntity {
  @override
  final String start;
  @override
  final String end;
  @override
  final BuiltList<WeatherForecastLineEntity>? lines;

  factory _$WeatherForecastDecodedEntity(
          [void Function(WeatherForecastDecodedEntityBuilder)? updates]) =>
      (WeatherForecastDecodedEntityBuilder()..update(updates))._build();

  _$WeatherForecastDecodedEntity._(
      {required this.start, required this.end, this.lines})
      : super._();
  @override
  WeatherForecastDecodedEntity rebuild(
          void Function(WeatherForecastDecodedEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastDecodedEntityBuilder toBuilder() =>
      WeatherForecastDecodedEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecastDecodedEntity &&
        start == other.start &&
        end == other.end &&
        lines == other.lines;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jc(_$hash, lines.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecastDecodedEntity')
          ..add('start', start)
          ..add('end', end)
          ..add('lines', lines))
        .toString();
  }
}

class WeatherForecastDecodedEntityBuilder
    implements
        Builder<WeatherForecastDecodedEntity,
            WeatherForecastDecodedEntityBuilder> {
  _$WeatherForecastDecodedEntity? _$v;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  String? _end;
  String? get end => _$this._end;
  set end(String? end) => _$this._end = end;

  ListBuilder<WeatherForecastLineEntity>? _lines;
  ListBuilder<WeatherForecastLineEntity> get lines =>
      _$this._lines ??= ListBuilder<WeatherForecastLineEntity>();
  set lines(ListBuilder<WeatherForecastLineEntity>? lines) =>
      _$this._lines = lines;

  WeatherForecastDecodedEntityBuilder() {
    WeatherForecastDecodedEntity._defaults(this);
  }

  WeatherForecastDecodedEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _start = $v.start;
      _end = $v.end;
      _lines = $v.lines?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecastDecodedEntity other) {
    _$v = other as _$WeatherForecastDecodedEntity;
  }

  @override
  void update(void Function(WeatherForecastDecodedEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecastDecodedEntity build() => _build();

  _$WeatherForecastDecodedEntity _build() {
    _$WeatherForecastDecodedEntity _$result;
    try {
      _$result = _$v ??
          _$WeatherForecastDecodedEntity._(
            start: BuiltValueNullFieldError.checkNotNull(
                start, r'WeatherForecastDecodedEntity', 'start'),
            end: BuiltValueNullFieldError.checkNotNull(
                end, r'WeatherForecastDecodedEntity', 'end'),
            lines: _lines?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lines';
        _lines?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WeatherForecastDecodedEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
