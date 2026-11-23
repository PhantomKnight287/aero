// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delay_airline_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DelayAirlineEntity extends DelayAirlineEntity {
  @override
  final StatsAirlineEntity airline;
  @override
  final num late_;
  @override
  final num total;
  @override
  final num minutesLate;

  factory _$DelayAirlineEntity(
          [void Function(DelayAirlineEntityBuilder)? updates]) =>
      (DelayAirlineEntityBuilder()..update(updates))._build();

  _$DelayAirlineEntity._(
      {required this.airline,
      required this.late_,
      required this.total,
      required this.minutesLate})
      : super._();
  @override
  DelayAirlineEntity rebuild(
          void Function(DelayAirlineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DelayAirlineEntityBuilder toBuilder() =>
      DelayAirlineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DelayAirlineEntity &&
        airline == other.airline &&
        late_ == other.late_ &&
        total == other.total &&
        minutesLate == other.minutesLate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jc(_$hash, late_.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, minutesLate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DelayAirlineEntity')
          ..add('airline', airline)
          ..add('late_', late_)
          ..add('total', total)
          ..add('minutesLate', minutesLate))
        .toString();
  }
}

class DelayAirlineEntityBuilder
    implements Builder<DelayAirlineEntity, DelayAirlineEntityBuilder> {
  _$DelayAirlineEntity? _$v;

  StatsAirlineEntityBuilder? _airline;
  StatsAirlineEntityBuilder get airline =>
      _$this._airline ??= StatsAirlineEntityBuilder();
  set airline(StatsAirlineEntityBuilder? airline) => _$this._airline = airline;

  num? _late_;
  num? get late_ => _$this._late_;
  set late_(num? late_) => _$this._late_ = late_;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  num? _minutesLate;
  num? get minutesLate => _$this._minutesLate;
  set minutesLate(num? minutesLate) => _$this._minutesLate = minutesLate;

  DelayAirlineEntityBuilder() {
    DelayAirlineEntity._defaults(this);
  }

  DelayAirlineEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airline = $v.airline.toBuilder();
      _late_ = $v.late_;
      _total = $v.total;
      _minutesLate = $v.minutesLate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DelayAirlineEntity other) {
    _$v = other as _$DelayAirlineEntity;
  }

  @override
  void update(void Function(DelayAirlineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DelayAirlineEntity build() => _build();

  _$DelayAirlineEntity _build() {
    _$DelayAirlineEntity _$result;
    try {
      _$result = _$v ??
          _$DelayAirlineEntity._(
            airline: airline.build(),
            late_: BuiltValueNullFieldError.checkNotNull(
                late_, r'DelayAirlineEntity', 'late_'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'DelayAirlineEntity', 'total'),
            minutesLate: BuiltValueNullFieldError.checkNotNull(
                minutesLate, r'DelayAirlineEntity', 'minutesLate'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airline';
        airline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DelayAirlineEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
