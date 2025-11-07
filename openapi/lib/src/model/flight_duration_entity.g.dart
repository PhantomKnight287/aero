// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_duration_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightDurationEntity extends FlightDurationEntity {
  @override
  final FlightSummaryEntity flight;
  @override
  final num durationMinutes;

  factory _$FlightDurationEntity(
          [void Function(FlightDurationEntityBuilder)? updates]) =>
      (FlightDurationEntityBuilder()..update(updates))._build();

  _$FlightDurationEntity._(
      {required this.flight, required this.durationMinutes})
      : super._();
  @override
  FlightDurationEntity rebuild(
          void Function(FlightDurationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightDurationEntityBuilder toBuilder() =>
      FlightDurationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightDurationEntity &&
        flight == other.flight &&
        durationMinutes == other.durationMinutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flight.hashCode);
    _$hash = $jc(_$hash, durationMinutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightDurationEntity')
          ..add('flight', flight)
          ..add('durationMinutes', durationMinutes))
        .toString();
  }
}

class FlightDurationEntityBuilder
    implements Builder<FlightDurationEntity, FlightDurationEntityBuilder> {
  _$FlightDurationEntity? _$v;

  FlightSummaryEntityBuilder? _flight;
  FlightSummaryEntityBuilder get flight =>
      _$this._flight ??= FlightSummaryEntityBuilder();
  set flight(FlightSummaryEntityBuilder? flight) => _$this._flight = flight;

  num? _durationMinutes;
  num? get durationMinutes => _$this._durationMinutes;
  set durationMinutes(num? durationMinutes) =>
      _$this._durationMinutes = durationMinutes;

  FlightDurationEntityBuilder() {
    FlightDurationEntity._defaults(this);
  }

  FlightDurationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flight = $v.flight.toBuilder();
      _durationMinutes = $v.durationMinutes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightDurationEntity other) {
    _$v = other as _$FlightDurationEntity;
  }

  @override
  void update(void Function(FlightDurationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightDurationEntity build() => _build();

  _$FlightDurationEntity _build() {
    _$FlightDurationEntity _$result;
    try {
      _$result = _$v ??
          _$FlightDurationEntity._(
            flight: flight.build(),
            durationMinutes: BuiltValueNullFieldError.checkNotNull(
                durationMinutes, r'FlightDurationEntity', 'durationMinutes'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flight';
        flight.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightDurationEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
