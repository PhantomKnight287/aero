// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airline_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirlineInfo extends AirlineInfo {
  @override
  final String name;
  @override
  final String iataCode;
  @override
  final String? icaoCode;

  factory _$AirlineInfo([void Function(AirlineInfoBuilder)? updates]) =>
      (new AirlineInfoBuilder()..update(updates))._build();

  _$AirlineInfo._({required this.name, required this.iataCode, this.icaoCode})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'AirlineInfo', 'name');
    BuiltValueNullFieldError.checkNotNull(iataCode, r'AirlineInfo', 'iataCode');
  }

  @override
  AirlineInfo rebuild(void Function(AirlineInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirlineInfoBuilder toBuilder() => new AirlineInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirlineInfo &&
        name == other.name &&
        iataCode == other.iataCode &&
        icaoCode == other.icaoCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, iataCode.hashCode);
    _$hash = $jc(_$hash, icaoCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirlineInfo')
          ..add('name', name)
          ..add('iataCode', iataCode)
          ..add('icaoCode', icaoCode))
        .toString();
  }
}

class AirlineInfoBuilder implements Builder<AirlineInfo, AirlineInfoBuilder> {
  _$AirlineInfo? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _iataCode;
  String? get iataCode => _$this._iataCode;
  set iataCode(String? iataCode) => _$this._iataCode = iataCode;

  String? _icaoCode;
  String? get icaoCode => _$this._icaoCode;
  set icaoCode(String? icaoCode) => _$this._icaoCode = icaoCode;

  AirlineInfoBuilder() {
    AirlineInfo._defaults(this);
  }

  AirlineInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _iataCode = $v.iataCode;
      _icaoCode = $v.icaoCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirlineInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AirlineInfo;
  }

  @override
  void update(void Function(AirlineInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirlineInfo build() => _build();

  _$AirlineInfo _build() {
    final _$result = _$v ??
        new _$AirlineInfo._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'AirlineInfo', 'name'),
          iataCode: BuiltValueNullFieldError.checkNotNull(
              iataCode, r'AirlineInfo', 'iataCode'),
          icaoCode: icaoCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
