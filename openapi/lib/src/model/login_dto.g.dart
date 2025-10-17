// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginDTO extends LoginDTO {
  @override
  final String email;
  @override
  final String password;

  factory _$LoginDTO([void Function(LoginDTOBuilder)? updates]) =>
      (LoginDTOBuilder()..update(updates))._build();

  _$LoginDTO._({required this.email, required this.password}) : super._();
  @override
  LoginDTO rebuild(void Function(LoginDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginDTOBuilder toBuilder() => LoginDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginDTO &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginDTO')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class LoginDTOBuilder implements Builder<LoginDTO, LoginDTOBuilder> {
  _$LoginDTO? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  LoginDTOBuilder() {
    LoginDTO._defaults(this);
  }

  LoginDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginDTO other) {
    _$v = other as _$LoginDTO;
  }

  @override
  void update(void Function(LoginDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginDTO build() => _build();

  _$LoginDTO _build() {
    final _$result = _$v ??
        _$LoginDTO._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'LoginDTO', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'LoginDTO', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
