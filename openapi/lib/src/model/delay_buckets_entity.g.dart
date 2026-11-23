// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delay_buckets_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DelayBucketsEntity extends DelayBucketsEntity {
  @override
  final num early;
  @override
  final num onTime;
  @override
  final num late15;
  @override
  final num late30;
  @override
  final num late45;
  @override
  final num cancelled;
  @override
  final num diverted;
  @override
  final num total;

  factory _$DelayBucketsEntity(
          [void Function(DelayBucketsEntityBuilder)? updates]) =>
      (DelayBucketsEntityBuilder()..update(updates))._build();

  _$DelayBucketsEntity._(
      {required this.early,
      required this.onTime,
      required this.late15,
      required this.late30,
      required this.late45,
      required this.cancelled,
      required this.diverted,
      required this.total})
      : super._();
  @override
  DelayBucketsEntity rebuild(
          void Function(DelayBucketsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DelayBucketsEntityBuilder toBuilder() =>
      DelayBucketsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DelayBucketsEntity &&
        early == other.early &&
        onTime == other.onTime &&
        late15 == other.late15 &&
        late30 == other.late30 &&
        late45 == other.late45 &&
        cancelled == other.cancelled &&
        diverted == other.diverted &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, early.hashCode);
    _$hash = $jc(_$hash, onTime.hashCode);
    _$hash = $jc(_$hash, late15.hashCode);
    _$hash = $jc(_$hash, late30.hashCode);
    _$hash = $jc(_$hash, late45.hashCode);
    _$hash = $jc(_$hash, cancelled.hashCode);
    _$hash = $jc(_$hash, diverted.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DelayBucketsEntity')
          ..add('early', early)
          ..add('onTime', onTime)
          ..add('late15', late15)
          ..add('late30', late30)
          ..add('late45', late45)
          ..add('cancelled', cancelled)
          ..add('diverted', diverted)
          ..add('total', total))
        .toString();
  }
}

class DelayBucketsEntityBuilder
    implements Builder<DelayBucketsEntity, DelayBucketsEntityBuilder> {
  _$DelayBucketsEntity? _$v;

  num? _early;
  num? get early => _$this._early;
  set early(num? early) => _$this._early = early;

  num? _onTime;
  num? get onTime => _$this._onTime;
  set onTime(num? onTime) => _$this._onTime = onTime;

  num? _late15;
  num? get late15 => _$this._late15;
  set late15(num? late15) => _$this._late15 = late15;

  num? _late30;
  num? get late30 => _$this._late30;
  set late30(num? late30) => _$this._late30 = late30;

  num? _late45;
  num? get late45 => _$this._late45;
  set late45(num? late45) => _$this._late45 = late45;

  num? _cancelled;
  num? get cancelled => _$this._cancelled;
  set cancelled(num? cancelled) => _$this._cancelled = cancelled;

  num? _diverted;
  num? get diverted => _$this._diverted;
  set diverted(num? diverted) => _$this._diverted = diverted;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  DelayBucketsEntityBuilder() {
    DelayBucketsEntity._defaults(this);
  }

  DelayBucketsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _early = $v.early;
      _onTime = $v.onTime;
      _late15 = $v.late15;
      _late30 = $v.late30;
      _late45 = $v.late45;
      _cancelled = $v.cancelled;
      _diverted = $v.diverted;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DelayBucketsEntity other) {
    _$v = other as _$DelayBucketsEntity;
  }

  @override
  void update(void Function(DelayBucketsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DelayBucketsEntity build() => _build();

  _$DelayBucketsEntity _build() {
    final _$result = _$v ??
        _$DelayBucketsEntity._(
          early: BuiltValueNullFieldError.checkNotNull(
              early, r'DelayBucketsEntity', 'early'),
          onTime: BuiltValueNullFieldError.checkNotNull(
              onTime, r'DelayBucketsEntity', 'onTime'),
          late15: BuiltValueNullFieldError.checkNotNull(
              late15, r'DelayBucketsEntity', 'late15'),
          late30: BuiltValueNullFieldError.checkNotNull(
              late30, r'DelayBucketsEntity', 'late30'),
          late45: BuiltValueNullFieldError.checkNotNull(
              late45, r'DelayBucketsEntity', 'late45'),
          cancelled: BuiltValueNullFieldError.checkNotNull(
              cancelled, r'DelayBucketsEntity', 'cancelled'),
          diverted: BuiltValueNullFieldError.checkNotNull(
              diverted, r'DelayBucketsEntity', 'diverted'),
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'DelayBucketsEntity', 'total'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
