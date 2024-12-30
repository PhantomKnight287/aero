// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_airline_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PartialAirlineEntity extends PartialAirlineEntity {
  @override
  final String name;
  @override
  final String? iata;
  @override
  final String? icao;

  factory _$PartialAirlineEntity(
          [void Function(PartialAirlineEntityBuilder)? updates]) =>
      (new PartialAirlineEntityBuilder()..update(updates))._build();

  _$PartialAirlineEntity._({required this.name, this.iata, this.icao})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'PartialAirlineEntity', 'name');
  }

  @override
  PartialAirlineEntity rebuild(
          void Function(PartialAirlineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PartialAirlineEntityBuilder toBuilder() =>
      new PartialAirlineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PartialAirlineEntity &&
        name == other.name &&
        iata == other.iata &&
        icao == other.icao;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, iata.hashCode);
    _$hash = $jc(_$hash, icao.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PartialAirlineEntity')
          ..add('name', name)
          ..add('iata', iata)
          ..add('icao', icao))
        .toString();
  }
}

class PartialAirlineEntityBuilder
    implements Builder<PartialAirlineEntity, PartialAirlineEntityBuilder> {
  _$PartialAirlineEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _iata;
  String? get iata => _$this._iata;
  set iata(String? iata) => _$this._iata = iata;

  String? _icao;
  String? get icao => _$this._icao;
  set icao(String? icao) => _$this._icao = icao;

  PartialAirlineEntityBuilder() {
    PartialAirlineEntity._defaults(this);
  }

  PartialAirlineEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _iata = $v.iata;
      _icao = $v.icao;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PartialAirlineEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PartialAirlineEntity;
  }

  @override
  void update(void Function(PartialAirlineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PartialAirlineEntity build() => _build();

  _$PartialAirlineEntity _build() {
    final _$result = _$v ??
        new _$PartialAirlineEntity._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'PartialAirlineEntity', 'name'),
          iata: iata,
          icao: icao,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
