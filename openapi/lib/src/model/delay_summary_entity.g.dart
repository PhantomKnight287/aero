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

  factory _$DelaySummaryEntity(
          [void Function(DelaySummaryEntityBuilder)? updates]) =>
      (DelaySummaryEntityBuilder()..update(updates))._build();

  _$DelaySummaryEntity._(
      {required this.basedOn,
      required this.arrivedCount,
      required this.delayedCount,
      required this.minutesLost,
      required this.avgDelayMinutes})
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
        avgDelayMinutes == other.avgDelayMinutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, basedOn.hashCode);
    _$hash = $jc(_$hash, arrivedCount.hashCode);
    _$hash = $jc(_$hash, delayedCount.hashCode);
    _$hash = $jc(_$hash, minutesLost.hashCode);
    _$hash = $jc(_$hash, avgDelayMinutes.hashCode);
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
          ..add('avgDelayMinutes', avgDelayMinutes))
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
    final _$result = _$v ??
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
