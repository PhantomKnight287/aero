// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delay_summary_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DelaySummaryEntity extends DelaySummaryEntity {
  @override
  final num basedOn;
  @override
  final num arrivedCount;
  @override
  final num delayedCount;
  @override
  final num minutesLost;
  @override
  final num avgDelayMinutes;
  @override
  final num netMinutes;
  @override
  final DelayBucketsEntity buckets;
  @override
  final StatsRecordEntity? worst;
  @override
  final BuiltList<DelayAirlineEntity> airlines;
  @override
  final BuiltList<DelayAirportEntity> airports;
  @override
  final BuiltList<StatsRecordEntity> flights;

  factory _$DelaySummaryEntity(
          [void Function(DelaySummaryEntityBuilder)? updates]) =>
      (DelaySummaryEntityBuilder()..update(updates))._build();

  _$DelaySummaryEntity._(
      {required this.basedOn,
      required this.arrivedCount,
      required this.delayedCount,
      required this.minutesLost,
      required this.avgDelayMinutes,
      required this.netMinutes,
      required this.buckets,
      this.worst,
      required this.airlines,
      required this.airports,
      required this.flights})
      : super._();
  @override
  DelaySummaryEntity rebuild(
          void Function(DelaySummaryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DelaySummaryEntityBuilder toBuilder() =>
      DelaySummaryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DelaySummaryEntity &&
        basedOn == other.basedOn &&
        arrivedCount == other.arrivedCount &&
        delayedCount == other.delayedCount &&
        minutesLost == other.minutesLost &&
        avgDelayMinutes == other.avgDelayMinutes &&
        netMinutes == other.netMinutes &&
        buckets == other.buckets &&
        worst == other.worst &&
        airlines == other.airlines &&
        airports == other.airports &&
        flights == other.flights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, basedOn.hashCode);
    _$hash = $jc(_$hash, arrivedCount.hashCode);
    _$hash = $jc(_$hash, delayedCount.hashCode);
    _$hash = $jc(_$hash, minutesLost.hashCode);
    _$hash = $jc(_$hash, avgDelayMinutes.hashCode);
    _$hash = $jc(_$hash, netMinutes.hashCode);
    _$hash = $jc(_$hash, buckets.hashCode);
    _$hash = $jc(_$hash, worst.hashCode);
    _$hash = $jc(_$hash, airlines.hashCode);
    _$hash = $jc(_$hash, airports.hashCode);
    _$hash = $jc(_$hash, flights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DelaySummaryEntity')
          ..add('basedOn', basedOn)
          ..add('arrivedCount', arrivedCount)
          ..add('delayedCount', delayedCount)
          ..add('minutesLost', minutesLost)
          ..add('avgDelayMinutes', avgDelayMinutes)
          ..add('netMinutes', netMinutes)
          ..add('buckets', buckets)
          ..add('worst', worst)
          ..add('airlines', airlines)
          ..add('airports', airports)
          ..add('flights', flights))
        .toString();
  }
}

class DelaySummaryEntityBuilder
    implements Builder<DelaySummaryEntity, DelaySummaryEntityBuilder> {
  _$DelaySummaryEntity? _$v;

  num? _basedOn;
  num? get basedOn => _$this._basedOn;
  set basedOn(num? basedOn) => _$this._basedOn = basedOn;

  num? _arrivedCount;
  num? get arrivedCount => _$this._arrivedCount;
  set arrivedCount(num? arrivedCount) => _$this._arrivedCount = arrivedCount;

  num? _delayedCount;
  num? get delayedCount => _$this._delayedCount;
  set delayedCount(num? delayedCount) => _$this._delayedCount = delayedCount;

  num? _minutesLost;
  num? get minutesLost => _$this._minutesLost;
  set minutesLost(num? minutesLost) => _$this._minutesLost = minutesLost;

  num? _avgDelayMinutes;
  num? get avgDelayMinutes => _$this._avgDelayMinutes;
  set avgDelayMinutes(num? avgDelayMinutes) =>
      _$this._avgDelayMinutes = avgDelayMinutes;

  num? _netMinutes;
  num? get netMinutes => _$this._netMinutes;
  set netMinutes(num? netMinutes) => _$this._netMinutes = netMinutes;

  DelayBucketsEntityBuilder? _buckets;
  DelayBucketsEntityBuilder get buckets =>
      _$this._buckets ??= DelayBucketsEntityBuilder();
  set buckets(DelayBucketsEntityBuilder? buckets) => _$this._buckets = buckets;

  StatsRecordEntityBuilder? _worst;
  StatsRecordEntityBuilder get worst =>
      _$this._worst ??= StatsRecordEntityBuilder();
  set worst(StatsRecordEntityBuilder? worst) => _$this._worst = worst;

  ListBuilder<DelayAirlineEntity>? _airlines;
  ListBuilder<DelayAirlineEntity> get airlines =>
      _$this._airlines ??= ListBuilder<DelayAirlineEntity>();
  set airlines(ListBuilder<DelayAirlineEntity>? airlines) =>
      _$this._airlines = airlines;

  ListBuilder<DelayAirportEntity>? _airports;
  ListBuilder<DelayAirportEntity> get airports =>
      _$this._airports ??= ListBuilder<DelayAirportEntity>();
  set airports(ListBuilder<DelayAirportEntity>? airports) =>
      _$this._airports = airports;

  ListBuilder<StatsRecordEntity>? _flights;
  ListBuilder<StatsRecordEntity> get flights =>
      _$this._flights ??= ListBuilder<StatsRecordEntity>();
  set flights(ListBuilder<StatsRecordEntity>? flights) =>
      _$this._flights = flights;

  DelaySummaryEntityBuilder() {
    DelaySummaryEntity._defaults(this);
  }

  DelaySummaryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _basedOn = $v.basedOn;
      _arrivedCount = $v.arrivedCount;
      _delayedCount = $v.delayedCount;
      _minutesLost = $v.minutesLost;
      _avgDelayMinutes = $v.avgDelayMinutes;
      _netMinutes = $v.netMinutes;
      _buckets = $v.buckets.toBuilder();
      _worst = $v.worst?.toBuilder();
      _airlines = $v.airlines.toBuilder();
      _airports = $v.airports.toBuilder();
      _flights = $v.flights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DelaySummaryEntity other) {
    _$v = other as _$DelaySummaryEntity;
  }

  @override
  void update(void Function(DelaySummaryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DelaySummaryEntity build() => _build();

  _$DelaySummaryEntity _build() {
    _$DelaySummaryEntity _$result;
    try {
      _$result = _$v ??
          _$DelaySummaryEntity._(
            basedOn: BuiltValueNullFieldError.checkNotNull(
                basedOn, r'DelaySummaryEntity', 'basedOn'),
            arrivedCount: BuiltValueNullFieldError.checkNotNull(
                arrivedCount, r'DelaySummaryEntity', 'arrivedCount'),
            delayedCount: BuiltValueNullFieldError.checkNotNull(
                delayedCount, r'DelaySummaryEntity', 'delayedCount'),
            minutesLost: BuiltValueNullFieldError.checkNotNull(
                minutesLost, r'DelaySummaryEntity', 'minutesLost'),
            avgDelayMinutes: BuiltValueNullFieldError.checkNotNull(
                avgDelayMinutes, r'DelaySummaryEntity', 'avgDelayMinutes'),
            netMinutes: BuiltValueNullFieldError.checkNotNull(
                netMinutes, r'DelaySummaryEntity', 'netMinutes'),
            buckets: buckets.build(),
            worst: _worst?.build(),
            airlines: airlines.build(),
            airports: airports.build(),
            flights: flights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'buckets';
        buckets.build();
        _$failedField = 'worst';
        _worst?.build();
        _$failedField = 'airlines';
        airlines.build();
        _$failedField = 'airports';
        airports.build();
        _$failedField = 'flights';
        flights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DelaySummaryEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
