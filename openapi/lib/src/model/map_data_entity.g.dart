// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MapDataEntity extends MapDataEntity {
  @override
  final BuiltList<MapAirportEntity> airports;
  @override
  final BuiltList<MapRouteEntity> routes;

  factory _$MapDataEntity([void Function(MapDataEntityBuilder)? updates]) =>
      (MapDataEntityBuilder()..update(updates))._build();

  _$MapDataEntity._({required this.airports, required this.routes}) : super._();
  @override
  MapDataEntity rebuild(void Function(MapDataEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MapDataEntityBuilder toBuilder() => MapDataEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MapDataEntity &&
        airports == other.airports &&
        routes == other.routes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airports.hashCode);
    _$hash = $jc(_$hash, routes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MapDataEntity')
          ..add('airports', airports)
          ..add('routes', routes))
        .toString();
  }
}

class MapDataEntityBuilder
    implements Builder<MapDataEntity, MapDataEntityBuilder> {
  _$MapDataEntity? _$v;

  ListBuilder<MapAirportEntity>? _airports;
  ListBuilder<MapAirportEntity> get airports =>
      _$this._airports ??= ListBuilder<MapAirportEntity>();
  set airports(ListBuilder<MapAirportEntity>? airports) =>
      _$this._airports = airports;

  ListBuilder<MapRouteEntity>? _routes;
  ListBuilder<MapRouteEntity> get routes =>
      _$this._routes ??= ListBuilder<MapRouteEntity>();
  set routes(ListBuilder<MapRouteEntity>? routes) => _$this._routes = routes;

  MapDataEntityBuilder() {
    MapDataEntity._defaults(this);
  }

  MapDataEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airports = $v.airports.toBuilder();
      _routes = $v.routes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MapDataEntity other) {
    _$v = other as _$MapDataEntity;
  }

  @override
  void update(void Function(MapDataEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MapDataEntity build() => _build();

  _$MapDataEntity _build() {
    _$MapDataEntity _$result;
    try {
      _$result = _$v ??
          _$MapDataEntity._(
            airports: airports.build(),
            routes: routes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airports';
        airports.build();
        _$failedField = 'routes';
        routes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MapDataEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
