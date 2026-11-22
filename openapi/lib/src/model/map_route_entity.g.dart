// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_route_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MapRouteEntity extends MapRouteEntity {
  @override
  final num fromLat;
  @override
  final num fromLon;
  @override
  final num toLat;
  @override
  final num toLon;
  @override
  final num count;

  factory _$MapRouteEntity([void Function(MapRouteEntityBuilder)? updates]) =>
      (MapRouteEntityBuilder()..update(updates))._build();

  _$MapRouteEntity._(
      {required this.fromLat,
      required this.fromLon,
      required this.toLat,
      required this.toLon,
      required this.count})
      : super._();
  @override
  MapRouteEntity rebuild(void Function(MapRouteEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MapRouteEntityBuilder toBuilder() => MapRouteEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MapRouteEntity &&
        fromLat == other.fromLat &&
        fromLon == other.fromLon &&
        toLat == other.toLat &&
        toLon == other.toLon &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fromLat.hashCode);
    _$hash = $jc(_$hash, fromLon.hashCode);
    _$hash = $jc(_$hash, toLat.hashCode);
    _$hash = $jc(_$hash, toLon.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MapRouteEntity')
          ..add('fromLat', fromLat)
          ..add('fromLon', fromLon)
          ..add('toLat', toLat)
          ..add('toLon', toLon)
          ..add('count', count))
        .toString();
  }
}

class MapRouteEntityBuilder
    implements Builder<MapRouteEntity, MapRouteEntityBuilder> {
  _$MapRouteEntity? _$v;

  num? _fromLat;
  num? get fromLat => _$this._fromLat;
  set fromLat(num? fromLat) => _$this._fromLat = fromLat;

  num? _fromLon;
  num? get fromLon => _$this._fromLon;
  set fromLon(num? fromLon) => _$this._fromLon = fromLon;

  num? _toLat;
  num? get toLat => _$this._toLat;
  set toLat(num? toLat) => _$this._toLat = toLat;

  num? _toLon;
  num? get toLon => _$this._toLon;
  set toLon(num? toLon) => _$this._toLon = toLon;

  num? _count;
  num? get count => _$this._count;
  set count(num? count) => _$this._count = count;

  MapRouteEntityBuilder() {
    MapRouteEntity._defaults(this);
  }

  MapRouteEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fromLat = $v.fromLat;
      _fromLon = $v.fromLon;
      _toLat = $v.toLat;
      _toLon = $v.toLon;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MapRouteEntity other) {
    _$v = other as _$MapRouteEntity;
  }

  @override
  void update(void Function(MapRouteEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MapRouteEntity build() => _build();

  _$MapRouteEntity _build() {
    final _$result = _$v ??
        _$MapRouteEntity._(
          fromLat: BuiltValueNullFieldError.checkNotNull(
              fromLat, r'MapRouteEntity', 'fromLat'),
          fromLon: BuiltValueNullFieldError.checkNotNull(
              fromLon, r'MapRouteEntity', 'fromLon'),
          toLat: BuiltValueNullFieldError.checkNotNull(
              toLat, r'MapRouteEntity', 'toLat'),
          toLon: BuiltValueNullFieldError.checkNotNull(
              toLon, r'MapRouteEntity', 'toLon'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'MapRouteEntity', 'count'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
