// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericErrorEntity extends GenericErrorEntity {
  @override
  final String message;

  factory _$GenericErrorEntity(
          [void Function(GenericErrorEntityBuilder)? updates]) =>
      (new GenericErrorEntityBuilder()..update(updates))._build();

  _$GenericErrorEntity._({required this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, r'GenericErrorEntity', 'message');
  }

  @override
  GenericErrorEntity rebuild(
          void Function(GenericErrorEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericErrorEntityBuilder toBuilder() =>
      new GenericErrorEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericErrorEntity && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenericErrorEntity')
          ..add('message', message))
        .toString();
  }
}

class GenericErrorEntityBuilder
    implements Builder<GenericErrorEntity, GenericErrorEntityBuilder> {
  _$GenericErrorEntity? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GenericErrorEntityBuilder() {
    GenericErrorEntity._defaults(this);
  }

  GenericErrorEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericErrorEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GenericErrorEntity;
  }

  @override
  void update(void Function(GenericErrorEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericErrorEntity build() => _build();

  _$GenericErrorEntity _build() {
    final _$result = _$v ??
        new _$GenericErrorEntity._(
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'GenericErrorEntity', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
