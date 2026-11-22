// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatsAirportEntity extends StatsAirportEntity {
  @override
  final String? iata;
  @override
  final String? icao;
  @override
  final String name;
  @override
  final String city;
  @override
  final String? isoCountry;
  @override
  final num? lat;
  @override
  final num? lon;
  @override
  final num? elevationFt;

  factory _$StatsAirportEntity(
          [void Function(StatsAirportEntityBuilder)? updates]) =>
      (StatsAirportEntityBuilder()..update(updates))._build();

  _$StatsAirportEntity._(
      {this.iata,
      this.icao,
      required this.name,
      required this.city,
      this.isoCountry,
      this.lat,
      this.lon,
      this.elevationFt})
      : super._();
  @override
  StatsAirportEntity rebuild(
          void Function(StatsAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatsAirportEntityBuilder toBuilder() =>
      StatsAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatsAirportEntity &&
        iata == other.iata &&
        icao == other.icao &&
        name == other.name &&
        city == other.city &&
        isoCountry == other.isoCountry &&
        lat == other.lat &&
        lon == other.lon &&
        elevationFt == other.elevationFt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, iata.hashCode);
    _$hash = $jc(_$hash, icao.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, isoCountry.hashCode);
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, lon.hashCode);
    _$hash = $jc(_$hash, elevationFt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatsAirportEntity')
          ..add('iata', iata)
          ..add('icao', icao)
          ..add('name', name)
          ..add('city', city)
          ..add('isoCountry', isoCountry)
          ..add('lat', lat)
          ..add('lon', lon)
          ..add('elevationFt', elevationFt))
        .toString();
  }
}

class StatsAirportEntityBuilder
    implements Builder<StatsAirportEntity, StatsAirportEntityBuilder> {
  _$StatsAirportEntity? _$v;

  String? _iata;
  String? get iata => _$this._iata;
  set iata(String? iata) => _$this._iata = iata;

  String? _icao;
  String? get icao => _$this._icao;
  set icao(String? icao) => _$this._icao = icao;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _isoCountry;
  String? get isoCountry => _$this._isoCountry;
  set isoCountry(String? isoCountry) => _$this._isoCountry = isoCountry;

  num? _lat;
  num? get lat => _$this._lat;
  set lat(num? lat) => _$this._lat = lat;

  num? _lon;
  num? get lon => _$this._lon;
  set lon(num? lon) => _$this._lon = lon;

  num? _elevationFt;
  num? get elevationFt => _$this._elevationFt;
  set elevationFt(num? elevationFt) => _$this._elevationFt = elevationFt;

  StatsAirportEntityBuilder() {
    StatsAirportEntity._defaults(this);
  }

  StatsAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _iata = $v.iata;
      _icao = $v.icao;
      _name = $v.name;
      _city = $v.city;
      _isoCountry = $v.isoCountry;
      _lat = $v.lat;
      _lon = $v.lon;
      _elevationFt = $v.elevationFt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatsAirportEntity other) {
    _$v = other as _$StatsAirportEntity;
  }

  @override
  void update(void Function(StatsAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatsAirportEntity build() => _build();

  _$StatsAirportEntity _build() {
    final _$result = _$v ??
        _$StatsAirportEntity._(
          iata: iata,
          icao: icao,
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'StatsAirportEntity', 'name'),
          city: BuiltValueNullFieldError.checkNotNull(
              city, r'StatsAirportEntity', 'city'),
          isoCountry: isoCountry,
          lat: lat,
          lon: lon,
          elevationFt: elevationFt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
