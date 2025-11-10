// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_summary_destination_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightSummaryDestinationEntity extends FlightSummaryDestinationEntity {
  @override
  final String code;
  @override
  final String? codeIata;
  @override
  final String? codeIcao;
  @override
  final String? name;
  @override
  final String? city;

  factory _$FlightSummaryDestinationEntity(
          [void Function(FlightSummaryDestinationEntityBuilder)? updates]) =>
      (FlightSummaryDestinationEntityBuilder()..update(updates))._build();

  _$FlightSummaryDestinationEntity._(
      {required this.code, this.codeIata, this.codeIcao, this.name, this.city})
      : super._();
  @override
  FlightSummaryDestinationEntity rebuild(
          void Function(FlightSummaryDestinationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightSummaryDestinationEntityBuilder toBuilder() =>
      FlightSummaryDestinationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightSummaryDestinationEntity &&
        code == other.code &&
        codeIata == other.codeIata &&
        codeIcao == other.codeIcao &&
        name == other.name &&
        city == other.city;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, codeIata.hashCode);
    _$hash = $jc(_$hash, codeIcao.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightSummaryDestinationEntity')
          ..add('code', code)
          ..add('codeIata', codeIata)
          ..add('codeIcao', codeIcao)
          ..add('name', name)
          ..add('city', city))
        .toString();
  }
}

class FlightSummaryDestinationEntityBuilder
    implements
        Builder<FlightSummaryDestinationEntity,
            FlightSummaryDestinationEntityBuilder> {
  _$FlightSummaryDestinationEntity? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _codeIata;
  String? get codeIata => _$this._codeIata;
  set codeIata(String? codeIata) => _$this._codeIata = codeIata;

  String? _codeIcao;
  String? get codeIcao => _$this._codeIcao;
  set codeIcao(String? codeIcao) => _$this._codeIcao = codeIcao;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  FlightSummaryDestinationEntityBuilder() {
    FlightSummaryDestinationEntity._defaults(this);
  }

  FlightSummaryDestinationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _codeIata = $v.codeIata;
      _codeIcao = $v.codeIcao;
      _name = $v.name;
      _city = $v.city;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightSummaryDestinationEntity other) {
    _$v = other as _$FlightSummaryDestinationEntity;
  }

  @override
  void update(void Function(FlightSummaryDestinationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightSummaryDestinationEntity build() => _build();

  _$FlightSummaryDestinationEntity _build() {
    final _$result = _$v ??
        _$FlightSummaryDestinationEntity._(
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'FlightSummaryDestinationEntity', 'code'),
          codeIata: codeIata,
          codeIcao: codeIcao,
          name: name,
          city: city,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
