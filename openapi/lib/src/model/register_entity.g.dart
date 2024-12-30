// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterEntity extends RegisterEntity {
  @override
  final String token;
  @override
  final UserEntity user;

  factory _$RegisterEntity([void Function(RegisterEntityBuilder)? updates]) =>
      (new RegisterEntityBuilder()..update(updates))._build();

  _$RegisterEntity._({required this.token, required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(token, r'RegisterEntity', 'token');
    BuiltValueNullFieldError.checkNotNull(user, r'RegisterEntity', 'user');
  }

  @override
  RegisterEntity rebuild(void Function(RegisterEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterEntityBuilder toBuilder() =>
      new RegisterEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterEntity &&
        token == other.token &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterEntity')
          ..add('token', token)
          ..add('user', user))
        .toString();
  }
}

class RegisterEntityBuilder
    implements Builder<RegisterEntity, RegisterEntityBuilder> {
  _$RegisterEntity? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  UserEntityBuilder? _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder? user) => _$this._user = user;

  RegisterEntityBuilder() {
    RegisterEntity._defaults(this);
  }

  RegisterEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegisterEntity;
  }

  @override
  void update(void Function(RegisterEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterEntity build() => _build();

  _$RegisterEntity _build() {
    _$RegisterEntity _$result;
    try {
      _$result = _$v ??
          new _$RegisterEntity._(
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'RegisterEntity', 'token'),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RegisterEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
