// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delay_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DelayAirportEntity extends DelayAirportEntity {
  @override
  final StatsAirportEntity airport;
  @override
  final num lateDepartures;
  @override
  final num total;

  factory _$DelayAirportEntity(
          [void Function(DelayAirportEntityBuilder)? updates]) =>
      (DelayAirportEntityBuilder()..update(updates))._build();

  _$DelayAirportEntity._(
      {required this.airport,
      required this.lateDepartures,
      required this.total})
      : super._();
  @override
  DelayAirportEntity rebuild(
          void Function(DelayAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DelayAirportEntityBuilder toBuilder() =>
      DelayAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DelayAirportEntity &&
        airport == other.airport &&
        lateDepartures == other.lateDepartures &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airport.hashCode);
    _$hash = $jc(_$hash, lateDepartures.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DelayAirportEntity')
          ..add('airport', airport)
          ..add('lateDepartures', lateDepartures)
          ..add('total', total))
        .toString();
  }
}

class DelayAirportEntityBuilder
    implements Builder<DelayAirportEntity, DelayAirportEntityBuilder> {
  _$DelayAirportEntity? _$v;

  StatsAirportEntityBuilder? _airport;
  StatsAirportEntityBuilder get airport =>
      _$this._airport ??= StatsAirportEntityBuilder();
  set airport(StatsAirportEntityBuilder? airport) => _$this._airport = airport;

  num? _lateDepartures;
  num? get lateDepartures => _$this._lateDepartures;
  set lateDepartures(num? lateDepartures) =>
      _$this._lateDepartures = lateDepartures;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  DelayAirportEntityBuilder() {
    DelayAirportEntity._defaults(this);
  }

  DelayAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airport = $v.airport.toBuilder();
      _lateDepartures = $v.lateDepartures;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DelayAirportEntity other) {
    _$v = other as _$DelayAirportEntity;
  }

  @override
  void update(void Function(DelayAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DelayAirportEntity build() => _build();

  _$DelayAirportEntity _build() {
    _$DelayAirportEntity _$result;
    try {
      _$result = _$v ??
          _$DelayAirportEntity._(
            airport: airport.build(),
            lateDepartures: BuiltValueNullFieldError.checkNotNull(
                lateDepartures, r'DelayAirportEntity', 'lateDepartures'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'DelayAirportEntity', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airport';
        airport.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DelayAirportEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
