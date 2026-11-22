// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremes_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExtremesEntity extends ExtremesEntity {
  @override
  final StatsAirportEntity? north;
  @override
  final StatsAirportEntity? south;
  @override
  final StatsAirportEntity? east;
  @override
  final StatsAirportEntity? west;
  @override
  final StatsAirportEntity? highest;

  factory _$ExtremesEntity([void Function(ExtremesEntityBuilder)? updates]) =>
      (ExtremesEntityBuilder()..update(updates))._build();

  _$ExtremesEntity._(
      {this.north, this.south, this.east, this.west, this.highest})
      : super._();
  @override
  ExtremesEntity rebuild(void Function(ExtremesEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExtremesEntityBuilder toBuilder() => ExtremesEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExtremesEntity &&
        north == other.north &&
        south == other.south &&
        east == other.east &&
        west == other.west &&
        highest == other.highest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, north.hashCode);
    _$hash = $jc(_$hash, south.hashCode);
    _$hash = $jc(_$hash, east.hashCode);
    _$hash = $jc(_$hash, west.hashCode);
    _$hash = $jc(_$hash, highest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExtremesEntity')
          ..add('north', north)
          ..add('south', south)
          ..add('east', east)
          ..add('west', west)
          ..add('highest', highest))
        .toString();
  }
}

class ExtremesEntityBuilder
    implements Builder<ExtremesEntity, ExtremesEntityBuilder> {
  _$ExtremesEntity? _$v;

  StatsAirportEntityBuilder? _north;
  StatsAirportEntityBuilder get north =>
      _$this._north ??= StatsAirportEntityBuilder();
  set north(StatsAirportEntityBuilder? north) => _$this._north = north;

  StatsAirportEntityBuilder? _south;
  StatsAirportEntityBuilder get south =>
      _$this._south ??= StatsAirportEntityBuilder();
  set south(StatsAirportEntityBuilder? south) => _$this._south = south;

  StatsAirportEntityBuilder? _east;
  StatsAirportEntityBuilder get east =>
      _$this._east ??= StatsAirportEntityBuilder();
  set east(StatsAirportEntityBuilder? east) => _$this._east = east;

  StatsAirportEntityBuilder? _west;
  StatsAirportEntityBuilder get west =>
      _$this._west ??= StatsAirportEntityBuilder();
  set west(StatsAirportEntityBuilder? west) => _$this._west = west;

  StatsAirportEntityBuilder? _highest;
  StatsAirportEntityBuilder get highest =>
      _$this._highest ??= StatsAirportEntityBuilder();
  set highest(StatsAirportEntityBuilder? highest) => _$this._highest = highest;

  ExtremesEntityBuilder() {
    ExtremesEntity._defaults(this);
  }

  ExtremesEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _north = $v.north?.toBuilder();
      _south = $v.south?.toBuilder();
      _east = $v.east?.toBuilder();
      _west = $v.west?.toBuilder();
      _highest = $v.highest?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExtremesEntity other) {
    _$v = other as _$ExtremesEntity;
  }

  @override
  void update(void Function(ExtremesEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExtremesEntity build() => _build();

  _$ExtremesEntity _build() {
    _$ExtremesEntity _$result;
    try {
      _$result = _$v ??
          _$ExtremesEntity._(
            north: _north?.build(),
            south: _south?.build(),
            east: _east?.build(),
            west: _west?.build(),
            highest: _highest?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'north';
        _north?.build();
        _$failedField = 'south';
        _south?.build();
        _$failedField = 'east';
        _east?.build();
        _$failedField = 'west';
        _west?.build();
        _$failedField = 'highest';
        _highest?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ExtremesEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
