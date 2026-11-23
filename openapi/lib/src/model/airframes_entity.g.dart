// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airframes_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirframesEntity extends AirframesEntity {
  @override
  final num? medianAgeYears;
  @override
  final AirframeEntity? oldest;
  @override
  final AirframeEntity? newest;
  @override
  final MostFlownTailEntity? mostFlownTail;

  factory _$AirframesEntity([void Function(AirframesEntityBuilder)? updates]) =>
      (AirframesEntityBuilder()..update(updates))._build();

  _$AirframesEntity._(
      {this.medianAgeYears, this.oldest, this.newest, this.mostFlownTail})
      : super._();
  @override
  AirframesEntity rebuild(void Function(AirframesEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirframesEntityBuilder toBuilder() => AirframesEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirframesEntity &&
        medianAgeYears == other.medianAgeYears &&
        oldest == other.oldest &&
        newest == other.newest &&
        mostFlownTail == other.mostFlownTail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, medianAgeYears.hashCode);
    _$hash = $jc(_$hash, oldest.hashCode);
    _$hash = $jc(_$hash, newest.hashCode);
    _$hash = $jc(_$hash, mostFlownTail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirframesEntity')
          ..add('medianAgeYears', medianAgeYears)
          ..add('oldest', oldest)
          ..add('newest', newest)
          ..add('mostFlownTail', mostFlownTail))
        .toString();
  }
}

class AirframesEntityBuilder
    implements Builder<AirframesEntity, AirframesEntityBuilder> {
  _$AirframesEntity? _$v;

  num? _medianAgeYears;
  num? get medianAgeYears => _$this._medianAgeYears;
  set medianAgeYears(num? medianAgeYears) =>
      _$this._medianAgeYears = medianAgeYears;

  AirframeEntityBuilder? _oldest;
  AirframeEntityBuilder get oldest =>
      _$this._oldest ??= AirframeEntityBuilder();
  set oldest(AirframeEntityBuilder? oldest) => _$this._oldest = oldest;

  AirframeEntityBuilder? _newest;
  AirframeEntityBuilder get newest =>
      _$this._newest ??= AirframeEntityBuilder();
  set newest(AirframeEntityBuilder? newest) => _$this._newest = newest;

  MostFlownTailEntityBuilder? _mostFlownTail;
  MostFlownTailEntityBuilder get mostFlownTail =>
      _$this._mostFlownTail ??= MostFlownTailEntityBuilder();
  set mostFlownTail(MostFlownTailEntityBuilder? mostFlownTail) =>
      _$this._mostFlownTail = mostFlownTail;

  AirframesEntityBuilder() {
    AirframesEntity._defaults(this);
  }

  AirframesEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _medianAgeYears = $v.medianAgeYears;
      _oldest = $v.oldest?.toBuilder();
      _newest = $v.newest?.toBuilder();
      _mostFlownTail = $v.mostFlownTail?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirframesEntity other) {
    _$v = other as _$AirframesEntity;
  }

  @override
  void update(void Function(AirframesEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirframesEntity build() => _build();

  _$AirframesEntity _build() {
    _$AirframesEntity _$result;
    try {
      _$result = _$v ??
          _$AirframesEntity._(
            medianAgeYears: medianAgeYears,
            oldest: _oldest?.build(),
            newest: _newest?.build(),
            mostFlownTail: _mostFlownTail?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'oldest';
        _oldest?.build();
        _$failedField = 'newest';
        _newest?.build();
        _$failedField = 'mostFlownTail';
        _mostFlownTail?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirframesEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
