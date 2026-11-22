// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MapAirportEntity extends MapAirportEntity {
  @override
  final String? iata;
  @override
  final String? icao;
  @override
  final num lat;
  @override
  final num lon;

  factory _$MapAirportEntity(
          [void Function(MapAirportEntityBuilder)? updates]) =>
      (MapAirportEntityBuilder()..update(updates))._build();

  _$MapAirportEntity._(
      {this.iata, this.icao, required this.lat, required this.lon})
      : super._();
  @override
  MapAirportEntity rebuild(void Function(MapAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MapAirportEntityBuilder toBuilder() =>
      MapAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MapAirportEntity &&
        iata == other.iata &&
        icao == other.icao &&
        lat == other.lat &&
        lon == other.lon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, iata.hashCode);
    _$hash = $jc(_$hash, icao.hashCode);
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, lon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MapAirportEntity')
          ..add('iata', iata)
          ..add('icao', icao)
          ..add('lat', lat)
          ..add('lon', lon))
        .toString();
  }
}

class MapAirportEntityBuilder
    implements Builder<MapAirportEntity, MapAirportEntityBuilder> {
  _$MapAirportEntity? _$v;

  String? _iata;
  String? get iata => _$this._iata;
  set iata(String? iata) => _$this._iata = iata;

  String? _icao;
  String? get icao => _$this._icao;
  set icao(String? icao) => _$this._icao = icao;

  num? _lat;
  num? get lat => _$this._lat;
  set lat(num? lat) => _$this._lat = lat;

  num? _lon;
  num? get lon => _$this._lon;
  set lon(num? lon) => _$this._lon = lon;

  MapAirportEntityBuilder() {
    MapAirportEntity._defaults(this);
  }

  MapAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _iata = $v.iata;
      _icao = $v.icao;
      _lat = $v.lat;
      _lon = $v.lon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MapAirportEntity other) {
    _$v = other as _$MapAirportEntity;
  }

  @override
  void update(void Function(MapAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MapAirportEntity build() => _build();

  _$MapAirportEntity _build() {
    final _$result = _$v ??
        _$MapAirportEntity._(
          iata: iata,
          icao: icao,
          lat: BuiltValueNullFieldError.checkNotNull(
              lat, r'MapAirportEntity', 'lat'),
          lon: BuiltValueNullFieldError.checkNotNull(
              lon, r'MapAirportEntity', 'lon'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
