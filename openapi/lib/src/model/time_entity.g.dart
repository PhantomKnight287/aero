// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TimeEntity extends TimeEntity {
  @override
  final String utc;
  @override
  final String local;

  factory _$TimeEntity([void Function(TimeEntityBuilder)? updates]) =>
      (TimeEntityBuilder()..update(updates))._build();

  _$TimeEntity._({required this.utc, required this.local}) : super._();
  @override
  TimeEntity rebuild(void Function(TimeEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimeEntityBuilder toBuilder() => TimeEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimeEntity && utc == other.utc && local == other.local;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, utc.hashCode);
    _$hash = $jc(_$hash, local.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TimeEntity')
          ..add('utc', utc)
          ..add('local', local))
        .toString();
  }
}

class TimeEntityBuilder implements Builder<TimeEntity, TimeEntityBuilder> {
  _$TimeEntity? _$v;

  String? _utc;
  String? get utc => _$this._utc;
  set utc(String? utc) => _$this._utc = utc;

  String? _local;
  String? get local => _$this._local;
  set local(String? local) => _$this._local = local;

  TimeEntityBuilder() {
    TimeEntity._defaults(this);
  }

  TimeEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _utc = $v.utc;
      _local = $v.local;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimeEntity other) {
    _$v = other as _$TimeEntity;
  }

  @override
  void update(void Function(TimeEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TimeEntity build() => _build();

  _$TimeEntity _build() {
    final _$result = _$v ??
        _$TimeEntity._(
          utc: BuiltValueNullFieldError.checkNotNull(utc, r'TimeEntity', 'utc'),
          local: BuiltValueNullFieldError.checkNotNull(
              local, r'TimeEntity', 'local'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
