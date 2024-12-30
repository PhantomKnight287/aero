// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirportEntity extends AirportEntity {
  @override
  final String id;
  @override
  final String ident;
  @override
  final AirportType type;
  @override
  final String? elevation;
  @override
  final String continent;
  @override
  final String isoCountry;
  @override
  final String isoRegion;
  @override
  final String? municipality;
  @override
  final String? gpsCode;
  @override
  final String? iataCode;
  @override
  final String name;
  @override
  final String lat;
  @override
  final String long;

  factory _$AirportEntity([void Function(AirportEntityBuilder)? updates]) =>
      (new AirportEntityBuilder()..update(updates))._build();

  _$AirportEntity._(
      {required this.id,
      required this.ident,
      required this.type,
      this.elevation,
      required this.continent,
      required this.isoCountry,
      required this.isoRegion,
      this.municipality,
      this.gpsCode,
      this.iataCode,
      required this.name,
      required this.lat,
      required this.long})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'AirportEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(ident, r'AirportEntity', 'ident');
    BuiltValueNullFieldError.checkNotNull(type, r'AirportEntity', 'type');
    BuiltValueNullFieldError.checkNotNull(
        continent, r'AirportEntity', 'continent');
    BuiltValueNullFieldError.checkNotNull(
        isoCountry, r'AirportEntity', 'isoCountry');
    BuiltValueNullFieldError.checkNotNull(
        isoRegion, r'AirportEntity', 'isoRegion');
    BuiltValueNullFieldError.checkNotNull(name, r'AirportEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(lat, r'AirportEntity', 'lat');
    BuiltValueNullFieldError.checkNotNull(long, r'AirportEntity', 'long');
  }

  @override
  AirportEntity rebuild(void Function(AirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportEntityBuilder toBuilder() => new AirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportEntity &&
        id == other.id &&
        ident == other.ident &&
        type == other.type &&
        elevation == other.elevation &&
        continent == other.continent &&
        isoCountry == other.isoCountry &&
        isoRegion == other.isoRegion &&
        municipality == other.municipality &&
        gpsCode == other.gpsCode &&
        iataCode == other.iataCode &&
        name == other.name &&
        lat == other.lat &&
        long == other.long;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, ident.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, elevation.hashCode);
    _$hash = $jc(_$hash, continent.hashCode);
    _$hash = $jc(_$hash, isoCountry.hashCode);
    _$hash = $jc(_$hash, isoRegion.hashCode);
    _$hash = $jc(_$hash, municipality.hashCode);
    _$hash = $jc(_$hash, gpsCode.hashCode);
    _$hash = $jc(_$hash, iataCode.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, long.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportEntity')
          ..add('id', id)
          ..add('ident', ident)
          ..add('type', type)
          ..add('elevation', elevation)
          ..add('continent', continent)
          ..add('isoCountry', isoCountry)
          ..add('isoRegion', isoRegion)
          ..add('municipality', municipality)
          ..add('gpsCode', gpsCode)
          ..add('iataCode', iataCode)
          ..add('name', name)
          ..add('lat', lat)
          ..add('long', long))
        .toString();
  }
}

class AirportEntityBuilder
    implements Builder<AirportEntity, AirportEntityBuilder> {
  _$AirportEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _ident;
  String? get ident => _$this._ident;
  set ident(String? ident) => _$this._ident = ident;

  AirportType? _type;
  AirportType? get type => _$this._type;
  set type(AirportType? type) => _$this._type = type;

  String? _elevation;
  String? get elevation => _$this._elevation;
  set elevation(String? elevation) => _$this._elevation = elevation;

  String? _continent;
  String? get continent => _$this._continent;
  set continent(String? continent) => _$this._continent = continent;

  String? _isoCountry;
  String? get isoCountry => _$this._isoCountry;
  set isoCountry(String? isoCountry) => _$this._isoCountry = isoCountry;

  String? _isoRegion;
  String? get isoRegion => _$this._isoRegion;
  set isoRegion(String? isoRegion) => _$this._isoRegion = isoRegion;

  String? _municipality;
  String? get municipality => _$this._municipality;
  set municipality(String? municipality) => _$this._municipality = municipality;

  String? _gpsCode;
  String? get gpsCode => _$this._gpsCode;
  set gpsCode(String? gpsCode) => _$this._gpsCode = gpsCode;

  String? _iataCode;
  String? get iataCode => _$this._iataCode;
  set iataCode(String? iataCode) => _$this._iataCode = iataCode;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _lat;
  String? get lat => _$this._lat;
  set lat(String? lat) => _$this._lat = lat;

  String? _long;
  String? get long => _$this._long;
  set long(String? long) => _$this._long = long;

  AirportEntityBuilder() {
    AirportEntity._defaults(this);
  }

  AirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _ident = $v.ident;
      _type = $v.type;
      _elevation = $v.elevation;
      _continent = $v.continent;
      _isoCountry = $v.isoCountry;
      _isoRegion = $v.isoRegion;
      _municipality = $v.municipality;
      _gpsCode = $v.gpsCode;
      _iataCode = $v.iataCode;
      _name = $v.name;
      _lat = $v.lat;
      _long = $v.long;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AirportEntity;
  }

  @override
  void update(void Function(AirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportEntity build() => _build();

  _$AirportEntity _build() {
    final _$result = _$v ??
        new _$AirportEntity._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'AirportEntity', 'id'),
          ident: BuiltValueNullFieldError.checkNotNull(
              ident, r'AirportEntity', 'ident'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'AirportEntity', 'type'),
          elevation: elevation,
          continent: BuiltValueNullFieldError.checkNotNull(
              continent, r'AirportEntity', 'continent'),
          isoCountry: BuiltValueNullFieldError.checkNotNull(
              isoCountry, r'AirportEntity', 'isoCountry'),
          isoRegion: BuiltValueNullFieldError.checkNotNull(
              isoRegion, r'AirportEntity', 'isoRegion'),
          municipality: municipality,
          gpsCode: gpsCode,
          iataCode: iataCode,
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'AirportEntity', 'name'),
          lat: BuiltValueNullFieldError.checkNotNull(
              lat, r'AirportEntity', 'lat'),
          long: BuiltValueNullFieldError.checkNotNull(
              long, r'AirportEntity', 'long'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
