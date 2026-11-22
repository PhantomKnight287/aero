// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TaxiAirportEntity extends TaxiAirportEntity {
  @override
  final StatsAirportEntity airport;
  @override
  final num? avgTaxiOutMin;
  @override
  final num taxiOutCount;
  @override
  final num? avgTaxiInMin;
  @override
  final num taxiInCount;

  factory _$TaxiAirportEntity(
          [void Function(TaxiAirportEntityBuilder)? updates]) =>
      (TaxiAirportEntityBuilder()..update(updates))._build();

  _$TaxiAirportEntity._(
      {required this.airport,
      this.avgTaxiOutMin,
      required this.taxiOutCount,
      this.avgTaxiInMin,
      required this.taxiInCount})
      : super._();
  @override
  TaxiAirportEntity rebuild(void Function(TaxiAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxiAirportEntityBuilder toBuilder() =>
      TaxiAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxiAirportEntity &&
        airport == other.airport &&
        avgTaxiOutMin == other.avgTaxiOutMin &&
        taxiOutCount == other.taxiOutCount &&
        avgTaxiInMin == other.avgTaxiInMin &&
        taxiInCount == other.taxiInCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airport.hashCode);
    _$hash = $jc(_$hash, avgTaxiOutMin.hashCode);
    _$hash = $jc(_$hash, taxiOutCount.hashCode);
    _$hash = $jc(_$hash, avgTaxiInMin.hashCode);
    _$hash = $jc(_$hash, taxiInCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxiAirportEntity')
          ..add('airport', airport)
          ..add('avgTaxiOutMin', avgTaxiOutMin)
          ..add('taxiOutCount', taxiOutCount)
          ..add('avgTaxiInMin', avgTaxiInMin)
          ..add('taxiInCount', taxiInCount))
        .toString();
  }
}

class TaxiAirportEntityBuilder
    implements Builder<TaxiAirportEntity, TaxiAirportEntityBuilder> {
  _$TaxiAirportEntity? _$v;

  StatsAirportEntityBuilder? _airport;
  StatsAirportEntityBuilder get airport =>
      _$this._airport ??= StatsAirportEntityBuilder();
  set airport(StatsAirportEntityBuilder? airport) => _$this._airport = airport;

  num? _avgTaxiOutMin;
  num? get avgTaxiOutMin => _$this._avgTaxiOutMin;
  set avgTaxiOutMin(num? avgTaxiOutMin) =>
      _$this._avgTaxiOutMin = avgTaxiOutMin;

  num? _taxiOutCount;
  num? get taxiOutCount => _$this._taxiOutCount;
  set taxiOutCount(num? taxiOutCount) => _$this._taxiOutCount = taxiOutCount;

  num? _avgTaxiInMin;
  num? get avgTaxiInMin => _$this._avgTaxiInMin;
  set avgTaxiInMin(num? avgTaxiInMin) => _$this._avgTaxiInMin = avgTaxiInMin;

  num? _taxiInCount;
  num? get taxiInCount => _$this._taxiInCount;
  set taxiInCount(num? taxiInCount) => _$this._taxiInCount = taxiInCount;

  TaxiAirportEntityBuilder() {
    TaxiAirportEntity._defaults(this);
  }

  TaxiAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airport = $v.airport.toBuilder();
      _avgTaxiOutMin = $v.avgTaxiOutMin;
      _taxiOutCount = $v.taxiOutCount;
      _avgTaxiInMin = $v.avgTaxiInMin;
      _taxiInCount = $v.taxiInCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxiAirportEntity other) {
    _$v = other as _$TaxiAirportEntity;
  }

  @override
  void update(void Function(TaxiAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxiAirportEntity build() => _build();

  _$TaxiAirportEntity _build() {
    _$TaxiAirportEntity _$result;
    try {
      _$result = _$v ??
          _$TaxiAirportEntity._(
            airport: airport.build(),
            avgTaxiOutMin: avgTaxiOutMin,
            taxiOutCount: BuiltValueNullFieldError.checkNotNull(
                taxiOutCount, r'TaxiAirportEntity', 'taxiOutCount'),
            avgTaxiInMin: avgTaxiInMin,
            taxiInCount: BuiltValueNullFieldError.checkNotNull(
                taxiInCount, r'TaxiAirportEntity', 'taxiInCount'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airport';
        airport.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TaxiAirportEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
