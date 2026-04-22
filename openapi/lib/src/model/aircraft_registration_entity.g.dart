// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_registration_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftRegistrationEntity extends AircraftRegistrationEntity {
  @override
  final String id;
  @override
  final String reg;
  @override
  final bool active;
  @override
  final String? hexIcao;
  @override
  final String? airlineName;
  @override
  final String? registrationDate;

  factory _$AircraftRegistrationEntity(
          [void Function(AircraftRegistrationEntityBuilder)? updates]) =>
      (AircraftRegistrationEntityBuilder()..update(updates))._build();

  _$AircraftRegistrationEntity._(
      {required this.id,
      required this.reg,
      required this.active,
      this.hexIcao,
      this.airlineName,
      this.registrationDate})
      : super._();
  @override
  AircraftRegistrationEntity rebuild(
          void Function(AircraftRegistrationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftRegistrationEntityBuilder toBuilder() =>
      AircraftRegistrationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftRegistrationEntity &&
        id == other.id &&
        reg == other.reg &&
        active == other.active &&
        hexIcao == other.hexIcao &&
        airlineName == other.airlineName &&
        registrationDate == other.registrationDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reg.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, hexIcao.hashCode);
    _$hash = $jc(_$hash, airlineName.hashCode);
    _$hash = $jc(_$hash, registrationDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftRegistrationEntity')
          ..add('id', id)
          ..add('reg', reg)
          ..add('active', active)
          ..add('hexIcao', hexIcao)
          ..add('airlineName', airlineName)
          ..add('registrationDate', registrationDate))
        .toString();
  }
}

class AircraftRegistrationEntityBuilder
    implements
        Builder<AircraftRegistrationEntity, AircraftRegistrationEntityBuilder> {
  _$AircraftRegistrationEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _reg;
  String? get reg => _$this._reg;
  set reg(String? reg) => _$this._reg = reg;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  String? _hexIcao;
  String? get hexIcao => _$this._hexIcao;
  set hexIcao(String? hexIcao) => _$this._hexIcao = hexIcao;

  String? _airlineName;
  String? get airlineName => _$this._airlineName;
  set airlineName(String? airlineName) => _$this._airlineName = airlineName;

  String? _registrationDate;
  String? get registrationDate => _$this._registrationDate;
  set registrationDate(String? registrationDate) =>
      _$this._registrationDate = registrationDate;

  AircraftRegistrationEntityBuilder() {
    AircraftRegistrationEntity._defaults(this);
  }

  AircraftRegistrationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _reg = $v.reg;
      _active = $v.active;
      _hexIcao = $v.hexIcao;
      _airlineName = $v.airlineName;
      _registrationDate = $v.registrationDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftRegistrationEntity other) {
    _$v = other as _$AircraftRegistrationEntity;
  }

  @override
  void update(void Function(AircraftRegistrationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftRegistrationEntity build() => _build();

  _$AircraftRegistrationEntity _build() {
    final _$result = _$v ??
        _$AircraftRegistrationEntity._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'AircraftRegistrationEntity', 'id'),
          reg: BuiltValueNullFieldError.checkNotNull(
              reg, r'AircraftRegistrationEntity', 'reg'),
          active: BuiltValueNullFieldError.checkNotNull(
              active, r'AircraftRegistrationEntity', 'active'),
          hexIcao: hexIcao,
          airlineName: airlineName,
          registrationDate: registrationDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
