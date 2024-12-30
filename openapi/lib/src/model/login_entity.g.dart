// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginEntity extends LoginEntity {
  @override
  final String token;
  @override
  final UserEntity user;

  factory _$LoginEntity([void Function(LoginEntityBuilder)? updates]) =>
      (new LoginEntityBuilder()..update(updates))._build();

  _$LoginEntity._({required this.token, required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(token, r'LoginEntity', 'token');
    BuiltValueNullFieldError.checkNotNull(user, r'LoginEntity', 'user');
  }

  @override
  LoginEntity rebuild(void Function(LoginEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginEntityBuilder toBuilder() => new LoginEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginEntity && token == other.token && user == other.user;
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
    return (newBuiltValueToStringHelper(r'LoginEntity')
          ..add('token', token)
          ..add('user', user))
        .toString();
  }
}

class LoginEntityBuilder implements Builder<LoginEntity, LoginEntityBuilder> {
  _$LoginEntity? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  UserEntityBuilder? _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder? user) => _$this._user = user;

  LoginEntityBuilder() {
    LoginEntity._defaults(this);
  }

  LoginEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginEntity;
  }

  @override
  void update(void Function(LoginEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginEntity build() => _build();

  _$LoginEntity _build() {
    _$LoginEntity _$result;
    try {
      _$result = _$v ??
          new _$LoginEntity._(
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'LoginEntity', 'token'),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LoginEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
