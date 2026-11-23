// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_flown_tail_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MostFlownTailEntity extends MostFlownTailEntity {
  @override
  final String reg;
  @override
  final String? typeName;
  @override
  final num count;

  factory _$MostFlownTailEntity(
          [void Function(MostFlownTailEntityBuilder)? updates]) =>
      (MostFlownTailEntityBuilder()..update(updates))._build();

  _$MostFlownTailEntity._(
      {required this.reg, this.typeName, required this.count})
      : super._();
  @override
  MostFlownTailEntity rebuild(
          void Function(MostFlownTailEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MostFlownTailEntityBuilder toBuilder() =>
      MostFlownTailEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MostFlownTailEntity &&
        reg == other.reg &&
        typeName == other.typeName &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reg.hashCode);
    _$hash = $jc(_$hash, typeName.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MostFlownTailEntity')
          ..add('reg', reg)
          ..add('typeName', typeName)
          ..add('count', count))
        .toString();
  }
}

class MostFlownTailEntityBuilder
    implements Builder<MostFlownTailEntity, MostFlownTailEntityBuilder> {
  _$MostFlownTailEntity? _$v;

  String? _reg;
  String? get reg => _$this._reg;
  set reg(String? reg) => _$this._reg = reg;

  String? _typeName;
  String? get typeName => _$this._typeName;
  set typeName(String? typeName) => _$this._typeName = typeName;

  num? _count;
  num? get count => _$this._count;
  set count(num? count) => _$this._count = count;

  MostFlownTailEntityBuilder() {
    MostFlownTailEntity._defaults(this);
  }

  MostFlownTailEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reg = $v.reg;
      _typeName = $v.typeName;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MostFlownTailEntity other) {
    _$v = other as _$MostFlownTailEntity;
  }

  @override
  void update(void Function(MostFlownTailEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MostFlownTailEntity build() => _build();

  _$MostFlownTailEntity _build() {
    final _$result = _$v ??
        _$MostFlownTailEntity._(
          reg: BuiltValueNullFieldError.checkNotNull(
              reg, r'MostFlownTailEntity', 'reg'),
          typeName: typeName,
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'MostFlownTailEntity', 'count'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
