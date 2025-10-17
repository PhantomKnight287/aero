// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_controller_get_flights_in_bounds_v1200_response_flights_inner_origin.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin
    extends FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin {
  @override
  final String? code;
  @override
  final String? codeIcao;
  @override
  final String? codeIata;
  @override
  final String? name;
  @override
  final String? city;
  @override
  final String? timezone;

  factory _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin(
          [void Function(
                  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder)?
              updates]) =>
      (FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder()
            ..update(updates))
          ._build();

  _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin._(
      {this.code,
      this.codeIcao,
      this.codeIata,
      this.name,
      this.city,
      this.timezone})
      : super._();
  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin rebuild(
          void Function(
                  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder
      toBuilder() =>
          FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin &&
        code == other.code &&
        codeIcao == other.codeIcao &&
        codeIata == other.codeIata &&
        name == other.name &&
        city == other.city &&
        timezone == other.timezone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, codeIcao.hashCode);
    _$hash = $jc(_$hash, codeIata.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, timezone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin')
          ..add('code', code)
          ..add('codeIcao', codeIcao)
          ..add('codeIata', codeIata)
          ..add('name', name)
          ..add('city', city)
          ..add('timezone', timezone))
        .toString();
  }
}

class FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder
    implements
        Builder<
            FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin,
            FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder> {
  _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _codeIcao;
  String? get codeIcao => _$this._codeIcao;
  set codeIcao(String? codeIcao) => _$this._codeIcao = codeIcao;

  String? _codeIata;
  String? get codeIata => _$this._codeIata;
  set codeIata(String? codeIata) => _$this._codeIata = codeIata;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _timezone;
  String? get timezone => _$this._timezone;
  set timezone(String? timezone) => _$this._timezone = timezone;

  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder() {
    FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin
        ._defaults(this);
  }

  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _codeIcao = $v.codeIcao;
      _codeIata = $v.codeIata;
      _name = $v.name;
      _city = $v.city;
      _timezone = $v.timezone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin
          other) {
    _$v = other
        as _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin;
  }

  @override
  void update(
      void Function(
              FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOriginBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin build() =>
      _build();

  _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin
      _build() {
    final _$result = _$v ??
        _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin._(
          code: code,
          codeIcao: codeIcao,
          codeIata: codeIata,
          name: name,
          city: city,
          timezone: timezone,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
