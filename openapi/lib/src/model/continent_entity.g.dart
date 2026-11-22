// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continent_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContinentEntity extends ContinentEntity {
  @override
  final ContinentBucket bucket;
  @override
  final num countryCount;
  @override
  final num flightShare;
  @override
  final num flightCount;

  factory _$ContinentEntity([void Function(ContinentEntityBuilder)? updates]) =>
      (ContinentEntityBuilder()..update(updates))._build();

  _$ContinentEntity._(
      {required this.bucket,
      required this.countryCount,
      required this.flightShare,
      required this.flightCount})
      : super._();
  @override
  ContinentEntity rebuild(void Function(ContinentEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContinentEntityBuilder toBuilder() => ContinentEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContinentEntity &&
        bucket == other.bucket &&
        countryCount == other.countryCount &&
        flightShare == other.flightShare &&
        flightCount == other.flightCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bucket.hashCode);
    _$hash = $jc(_$hash, countryCount.hashCode);
    _$hash = $jc(_$hash, flightShare.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContinentEntity')
          ..add('bucket', bucket)
          ..add('countryCount', countryCount)
          ..add('flightShare', flightShare)
          ..add('flightCount', flightCount))
        .toString();
  }
}

class ContinentEntityBuilder
    implements Builder<ContinentEntity, ContinentEntityBuilder> {
  _$ContinentEntity? _$v;

  ContinentBucket? _bucket;
  ContinentBucket? get bucket => _$this._bucket;
  set bucket(ContinentBucket? bucket) => _$this._bucket = bucket;

  num? _countryCount;
  num? get countryCount => _$this._countryCount;
  set countryCount(num? countryCount) => _$this._countryCount = countryCount;

  num? _flightShare;
  num? get flightShare => _$this._flightShare;
  set flightShare(num? flightShare) => _$this._flightShare = flightShare;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  ContinentEntityBuilder() {
    ContinentEntity._defaults(this);
  }

  ContinentEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bucket = $v.bucket;
      _countryCount = $v.countryCount;
      _flightShare = $v.flightShare;
      _flightCount = $v.flightCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContinentEntity other) {
    _$v = other as _$ContinentEntity;
  }

  @override
  void update(void Function(ContinentEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContinentEntity build() => _build();

  _$ContinentEntity _build() {
    final _$result = _$v ??
        _$ContinentEntity._(
          bucket: BuiltValueNullFieldError.checkNotNull(
              bucket, r'ContinentEntity', 'bucket'),
          countryCount: BuiltValueNullFieldError.checkNotNull(
              countryCount, r'ContinentEntity', 'countryCount'),
          flightShare: BuiltValueNullFieldError.checkNotNull(
              flightShare, r'ContinentEntity', 'flightShare'),
          flightCount: BuiltValueNullFieldError.checkNotNull(
              flightCount, r'ContinentEntity', 'flightCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
