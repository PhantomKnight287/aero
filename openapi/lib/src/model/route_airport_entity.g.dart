// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteAirportEntity extends RouteAirportEntity {
  @override
  final String iata;
  @override
  final String icao;
  @override
  final String name;
  @override
  final String timeZone;
  @override
  final String shortName;
  @override
  final String countryCode;
  @override
  final String municipalityName;
  @override
  final LocationEntity location;

  factory _$RouteAirportEntity(
          [void Function(RouteAirportEntityBuilder)? updates]) =>
      (RouteAirportEntityBuilder()..update(updates))._build();

  _$RouteAirportEntity._(
      {required this.iata,
      required this.icao,
      required this.name,
      required this.timeZone,
      required this.shortName,
      required this.countryCode,
      required this.municipalityName,
      required this.location})
      : super._();
  @override
  RouteAirportEntity rebuild(
          void Function(RouteAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteAirportEntityBuilder toBuilder() =>
      RouteAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteAirportEntity &&
        iata == other.iata &&
        icao == other.icao &&
        name == other.name &&
        timeZone == other.timeZone &&
        shortName == other.shortName &&
        countryCode == other.countryCode &&
        municipalityName == other.municipalityName &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, iata.hashCode);
    _$hash = $jc(_$hash, icao.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, timeZone.hashCode);
    _$hash = $jc(_$hash, shortName.hashCode);
    _$hash = $jc(_$hash, countryCode.hashCode);
    _$hash = $jc(_$hash, municipalityName.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteAirportEntity')
          ..add('iata', iata)
          ..add('icao', icao)
          ..add('name', name)
          ..add('timeZone', timeZone)
          ..add('shortName', shortName)
          ..add('countryCode', countryCode)
          ..add('municipalityName', municipalityName)
          ..add('location', location))
        .toString();
  }
}

class RouteAirportEntityBuilder
    implements Builder<RouteAirportEntity, RouteAirportEntityBuilder> {
  _$RouteAirportEntity? _$v;

  String? _iata;
  String? get iata => _$this._iata;
  set iata(String? iata) => _$this._iata = iata;

  String? _icao;
  String? get icao => _$this._icao;
  set icao(String? icao) => _$this._icao = icao;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _timeZone;
  String? get timeZone => _$this._timeZone;
  set timeZone(String? timeZone) => _$this._timeZone = timeZone;

  String? _shortName;
  String? get shortName => _$this._shortName;
  set shortName(String? shortName) => _$this._shortName = shortName;

  String? _countryCode;
  String? get countryCode => _$this._countryCode;
  set countryCode(String? countryCode) => _$this._countryCode = countryCode;

  String? _municipalityName;
  String? get municipalityName => _$this._municipalityName;
  set municipalityName(String? municipalityName) =>
      _$this._municipalityName = municipalityName;

  LocationEntityBuilder? _location;
  LocationEntityBuilder get location =>
      _$this._location ??= LocationEntityBuilder();
  set location(LocationEntityBuilder? location) => _$this._location = location;

  RouteAirportEntityBuilder() {
    RouteAirportEntity._defaults(this);
  }

  RouteAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _iata = $v.iata;
      _icao = $v.icao;
      _name = $v.name;
      _timeZone = $v.timeZone;
      _shortName = $v.shortName;
      _countryCode = $v.countryCode;
      _municipalityName = $v.municipalityName;
      _location = $v.location.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteAirportEntity other) {
    _$v = other as _$RouteAirportEntity;
  }

  @override
  void update(void Function(RouteAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteAirportEntity build() => _build();

  _$RouteAirportEntity _build() {
    _$RouteAirportEntity _$result;
    try {
      _$result = _$v ??
          _$RouteAirportEntity._(
            iata: BuiltValueNullFieldError.checkNotNull(
                iata, r'RouteAirportEntity', 'iata'),
            icao: BuiltValueNullFieldError.checkNotNull(
                icao, r'RouteAirportEntity', 'icao'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'RouteAirportEntity', 'name'),
            timeZone: BuiltValueNullFieldError.checkNotNull(
                timeZone, r'RouteAirportEntity', 'timeZone'),
            shortName: BuiltValueNullFieldError.checkNotNull(
                shortName, r'RouteAirportEntity', 'shortName'),
            countryCode: BuiltValueNullFieldError.checkNotNull(
                countryCode, r'RouteAirportEntity', 'countryCode'),
            municipalityName: BuiltValueNullFieldError.checkNotNull(
                municipalityName, r'RouteAirportEntity', 'municipalityName'),
            location: location.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        location.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RouteAirportEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
