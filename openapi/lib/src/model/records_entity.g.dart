// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecordsEntity extends RecordsEntity {
  @override
  final StatsRecordEntity? shortestDistance;
  @override
  final StatsRecordEntity? longestDistance;
  @override
  final StatsRecordEntity? shortestDuration;
  @override
  final StatsRecordEntity? longestDuration;

  factory _$RecordsEntity([void Function(RecordsEntityBuilder)? updates]) =>
      (RecordsEntityBuilder()..update(updates))._build();

  _$RecordsEntity._(
      {this.shortestDistance,
      this.longestDistance,
      this.shortestDuration,
      this.longestDuration})
      : super._();
  @override
  RecordsEntity rebuild(void Function(RecordsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecordsEntityBuilder toBuilder() => RecordsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecordsEntity &&
        shortestDistance == other.shortestDistance &&
        longestDistance == other.longestDistance &&
        shortestDuration == other.shortestDuration &&
        longestDuration == other.longestDuration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, shortestDistance.hashCode);
    _$hash = $jc(_$hash, longestDistance.hashCode);
    _$hash = $jc(_$hash, shortestDuration.hashCode);
    _$hash = $jc(_$hash, longestDuration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecordsEntity')
          ..add('shortestDistance', shortestDistance)
          ..add('longestDistance', longestDistance)
          ..add('shortestDuration', shortestDuration)
          ..add('longestDuration', longestDuration))
        .toString();
  }
}

class RecordsEntityBuilder
    implements Builder<RecordsEntity, RecordsEntityBuilder> {
  _$RecordsEntity? _$v;

  StatsRecordEntityBuilder? _shortestDistance;
  StatsRecordEntityBuilder get shortestDistance =>
      _$this._shortestDistance ??= StatsRecordEntityBuilder();
  set shortestDistance(StatsRecordEntityBuilder? shortestDistance) =>
      _$this._shortestDistance = shortestDistance;

  StatsRecordEntityBuilder? _longestDistance;
  StatsRecordEntityBuilder get longestDistance =>
      _$this._longestDistance ??= StatsRecordEntityBuilder();
  set longestDistance(StatsRecordEntityBuilder? longestDistance) =>
      _$this._longestDistance = longestDistance;

  StatsRecordEntityBuilder? _shortestDuration;
  StatsRecordEntityBuilder get shortestDuration =>
      _$this._shortestDuration ??= StatsRecordEntityBuilder();
  set shortestDuration(StatsRecordEntityBuilder? shortestDuration) =>
      _$this._shortestDuration = shortestDuration;

  StatsRecordEntityBuilder? _longestDuration;
  StatsRecordEntityBuilder get longestDuration =>
      _$this._longestDuration ??= StatsRecordEntityBuilder();
  set longestDuration(StatsRecordEntityBuilder? longestDuration) =>
      _$this._longestDuration = longestDuration;

  RecordsEntityBuilder() {
    RecordsEntity._defaults(this);
  }

  RecordsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shortestDistance = $v.shortestDistance?.toBuilder();
      _longestDistance = $v.longestDistance?.toBuilder();
      _shortestDuration = $v.shortestDuration?.toBuilder();
      _longestDuration = $v.longestDuration?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecordsEntity other) {
    _$v = other as _$RecordsEntity;
  }

  @override
  void update(void Function(RecordsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecordsEntity build() => _build();

  _$RecordsEntity _build() {
    _$RecordsEntity _$result;
    try {
      _$result = _$v ??
          _$RecordsEntity._(
            shortestDistance: _shortestDistance?.build(),
            longestDistance: _longestDistance?.build(),
            shortestDuration: _shortestDuration?.build(),
            longestDuration: _longestDuration?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'shortestDistance';
        _shortestDistance?.build();
        _$failedField = 'longestDistance';
        _longestDistance?.build();
        _$failedField = 'shortestDuration';
        _shortestDuration?.build();
        _$failedField = 'longestDuration';
        _longestDuration?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RecordsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
