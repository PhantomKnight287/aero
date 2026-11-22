// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_count_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$YearCountEntity extends YearCountEntity {
  @override
  final num year;
  @override
  final num count;

  factory _$YearCountEntity([void Function(YearCountEntityBuilder)? updates]) =>
      (YearCountEntityBuilder()..update(updates))._build();

  _$YearCountEntity._({required this.year, required this.count}) : super._();
  @override
  YearCountEntity rebuild(void Function(YearCountEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  YearCountEntityBuilder toBuilder() => YearCountEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is YearCountEntity &&
        year == other.year &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'YearCountEntity')
          ..add('year', year)
          ..add('count', count))
        .toString();
  }
}

class YearCountEntityBuilder
    implements Builder<YearCountEntity, YearCountEntityBuilder> {
  _$YearCountEntity? _$v;

  num? _year;
  num? get year => _$this._year;
  set year(num? year) => _$this._year = year;

  num? _count;
  num? get count => _$this._count;
  set count(num? count) => _$this._count = count;

  YearCountEntityBuilder() {
    YearCountEntity._defaults(this);
  }

  YearCountEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _year = $v.year;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(YearCountEntity other) {
    _$v = other as _$YearCountEntity;
  }

  @override
  void update(void Function(YearCountEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  YearCountEntity build() => _build();

  _$YearCountEntity _build() {
    final _$result = _$v ??
        _$YearCountEntity._(
          year: BuiltValueNullFieldError.checkNotNull(
              year, r'YearCountEntity', 'year'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'YearCountEntity', 'count'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
