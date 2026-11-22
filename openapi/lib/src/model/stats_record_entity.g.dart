// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_record_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatsRecordEntity extends StatsRecordEntity {
  @override
  final StatsFlightSummaryEntity flight;
  @override
  final num value;

  factory _$StatsRecordEntity(
          [void Function(StatsRecordEntityBuilder)? updates]) =>
      (StatsRecordEntityBuilder()..update(updates))._build();

  _$StatsRecordEntity._({required this.flight, required this.value})
      : super._();
  @override
  StatsRecordEntity rebuild(void Function(StatsRecordEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatsRecordEntityBuilder toBuilder() =>
      StatsRecordEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatsRecordEntity &&
        flight == other.flight &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flight.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatsRecordEntity')
          ..add('flight', flight)
          ..add('value', value))
        .toString();
  }
}

class StatsRecordEntityBuilder
    implements Builder<StatsRecordEntity, StatsRecordEntityBuilder> {
  _$StatsRecordEntity? _$v;

  StatsFlightSummaryEntityBuilder? _flight;
  StatsFlightSummaryEntityBuilder get flight =>
      _$this._flight ??= StatsFlightSummaryEntityBuilder();
  set flight(StatsFlightSummaryEntityBuilder? flight) =>
      _$this._flight = flight;

  num? _value;
  num? get value => _$this._value;
  set value(num? value) => _$this._value = value;

  StatsRecordEntityBuilder() {
    StatsRecordEntity._defaults(this);
  }

  StatsRecordEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flight = $v.flight.toBuilder();
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatsRecordEntity other) {
    _$v = other as _$StatsRecordEntity;
  }

  @override
  void update(void Function(StatsRecordEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatsRecordEntity build() => _build();

  _$StatsRecordEntity _build() {
    _$StatsRecordEntity _$result;
    try {
      _$result = _$v ??
          _$StatsRecordEntity._(
            flight: flight.build(),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'StatsRecordEntity', 'value'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flight';
        flight.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StatsRecordEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
