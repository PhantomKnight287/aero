// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LocationEntity extends LocationEntity {
  @override
  final num lat;
  @override
  final num lon;

  factory _$LocationEntity([void Function(LocationEntityBuilder)? updates]) =>
      (LocationEntityBuilder()..update(updates))._build();

  _$LocationEntity._({required this.lat, required this.lon}) : super._();
  @override
  LocationEntity rebuild(void Function(LocationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationEntityBuilder toBuilder() => LocationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationEntity && lat == other.lat && lon == other.lon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, lon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LocationEntity')
          ..add('lat', lat)
          ..add('lon', lon))
        .toString();
  }
}

class LocationEntityBuilder
    implements Builder<LocationEntity, LocationEntityBuilder> {
  _$LocationEntity? _$v;

  num? _lat;
  num? get lat => _$this._lat;
  set lat(num? lat) => _$this._lat = lat;

  num? _lon;
  num? get lon => _$this._lon;
  set lon(num? lon) => _$this._lon = lon;

  LocationEntityBuilder() {
    LocationEntity._defaults(this);
  }

  LocationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lat = $v.lat;
      _lon = $v.lon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocationEntity other) {
    _$v = other as _$LocationEntity;
  }

  @override
  void update(void Function(LocationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocationEntity build() => _build();

  _$LocationEntity _build() {
    final _$result = _$v ??
        _$LocationEntity._(
          lat: BuiltValueNullFieldError.checkNotNull(
              lat, r'LocationEntity', 'lat'),
          lon: BuiltValueNullFieldError.checkNotNull(
              lon, r'LocationEntity', 'lon'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
