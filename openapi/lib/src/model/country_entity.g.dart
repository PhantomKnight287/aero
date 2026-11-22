// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CountryEntity extends CountryEntity {
  @override
  final String isoCountry;
  @override
  final String name;
  @override
  final num flightCount;

  factory _$CountryEntity([void Function(CountryEntityBuilder)? updates]) =>
      (CountryEntityBuilder()..update(updates))._build();

  _$CountryEntity._(
      {required this.isoCountry, required this.name, required this.flightCount})
      : super._();
  @override
  CountryEntity rebuild(void Function(CountryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryEntityBuilder toBuilder() => CountryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryEntity &&
        isoCountry == other.isoCountry &&
        name == other.name &&
        flightCount == other.flightCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isoCountry.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CountryEntity')
          ..add('isoCountry', isoCountry)
          ..add('name', name)
          ..add('flightCount', flightCount))
        .toString();
  }
}

class CountryEntityBuilder
    implements Builder<CountryEntity, CountryEntityBuilder> {
  _$CountryEntity? _$v;

  String? _isoCountry;
  String? get isoCountry => _$this._isoCountry;
  set isoCountry(String? isoCountry) => _$this._isoCountry = isoCountry;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  CountryEntityBuilder() {
    CountryEntity._defaults(this);
  }

  CountryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isoCountry = $v.isoCountry;
      _name = $v.name;
      _flightCount = $v.flightCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryEntity other) {
    _$v = other as _$CountryEntity;
  }

  @override
  void update(void Function(CountryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CountryEntity build() => _build();

  _$CountryEntity _build() {
    final _$result = _$v ??
        _$CountryEntity._(
          isoCountry: BuiltValueNullFieldError.checkNotNull(
              isoCountry, r'CountryEntity', 'isoCountry'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CountryEntity', 'name'),
          flightCount: BuiltValueNullFieldError.checkNotNull(
              flightCount, r'CountryEntity', 'flightCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
