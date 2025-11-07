// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_stats_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfileStatsResponseEntity extends ProfileStatsResponseEntity {
  @override
  final MostFlownAircraftEntity mostFlownAircraft;
  @override
  final PassportEntity passport;
  @override
  final FlightDistanceEntity shortestDistanceFlight;
  @override
  final FlightDistanceEntity longestDistanceFlight;
  @override
  final FlightDurationEntity shortestDurationFlight;
  @override
  final FlightDurationEntity longestDurationFlight;
  @override
  final BuiltList<AirlineStatsEntity> airlines;
  @override
  final BuiltList<AirportStatsEntity> airports;
  @override
  final BuiltList<TopRouteEntity> topRoutes;

  factory _$ProfileStatsResponseEntity(
          [void Function(ProfileStatsResponseEntityBuilder)? updates]) =>
      (ProfileStatsResponseEntityBuilder()..update(updates))._build();

  _$ProfileStatsResponseEntity._(
      {required this.mostFlownAircraft,
      required this.passport,
      required this.shortestDistanceFlight,
      required this.longestDistanceFlight,
      required this.shortestDurationFlight,
      required this.longestDurationFlight,
      required this.airlines,
      required this.airports,
      required this.topRoutes})
      : super._();
  @override
  ProfileStatsResponseEntity rebuild(
          void Function(ProfileStatsResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileStatsResponseEntityBuilder toBuilder() =>
      ProfileStatsResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileStatsResponseEntity &&
        mostFlownAircraft == other.mostFlownAircraft &&
        passport == other.passport &&
        shortestDistanceFlight == other.shortestDistanceFlight &&
        longestDistanceFlight == other.longestDistanceFlight &&
        shortestDurationFlight == other.shortestDurationFlight &&
        longestDurationFlight == other.longestDurationFlight &&
        airlines == other.airlines &&
        airports == other.airports &&
        topRoutes == other.topRoutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mostFlownAircraft.hashCode);
    _$hash = $jc(_$hash, passport.hashCode);
    _$hash = $jc(_$hash, shortestDistanceFlight.hashCode);
    _$hash = $jc(_$hash, longestDistanceFlight.hashCode);
    _$hash = $jc(_$hash, shortestDurationFlight.hashCode);
    _$hash = $jc(_$hash, longestDurationFlight.hashCode);
    _$hash = $jc(_$hash, airlines.hashCode);
    _$hash = $jc(_$hash, airports.hashCode);
    _$hash = $jc(_$hash, topRoutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileStatsResponseEntity')
          ..add('mostFlownAircraft', mostFlownAircraft)
          ..add('passport', passport)
          ..add('shortestDistanceFlight', shortestDistanceFlight)
          ..add('longestDistanceFlight', longestDistanceFlight)
          ..add('shortestDurationFlight', shortestDurationFlight)
          ..add('longestDurationFlight', longestDurationFlight)
          ..add('airlines', airlines)
          ..add('airports', airports)
          ..add('topRoutes', topRoutes))
        .toString();
  }
}

class ProfileStatsResponseEntityBuilder
    implements
        Builder<ProfileStatsResponseEntity, ProfileStatsResponseEntityBuilder> {
  _$ProfileStatsResponseEntity? _$v;

  MostFlownAircraftEntityBuilder? _mostFlownAircraft;
  MostFlownAircraftEntityBuilder get mostFlownAircraft =>
      _$this._mostFlownAircraft ??= MostFlownAircraftEntityBuilder();
  set mostFlownAircraft(MostFlownAircraftEntityBuilder? mostFlownAircraft) =>
      _$this._mostFlownAircraft = mostFlownAircraft;

  PassportEntityBuilder? _passport;
  PassportEntityBuilder get passport =>
      _$this._passport ??= PassportEntityBuilder();
  set passport(PassportEntityBuilder? passport) => _$this._passport = passport;

  FlightDistanceEntityBuilder? _shortestDistanceFlight;
  FlightDistanceEntityBuilder get shortestDistanceFlight =>
      _$this._shortestDistanceFlight ??= FlightDistanceEntityBuilder();
  set shortestDistanceFlight(
          FlightDistanceEntityBuilder? shortestDistanceFlight) =>
      _$this._shortestDistanceFlight = shortestDistanceFlight;

  FlightDistanceEntityBuilder? _longestDistanceFlight;
  FlightDistanceEntityBuilder get longestDistanceFlight =>
      _$this._longestDistanceFlight ??= FlightDistanceEntityBuilder();
  set longestDistanceFlight(
          FlightDistanceEntityBuilder? longestDistanceFlight) =>
      _$this._longestDistanceFlight = longestDistanceFlight;

  FlightDurationEntityBuilder? _shortestDurationFlight;
  FlightDurationEntityBuilder get shortestDurationFlight =>
      _$this._shortestDurationFlight ??= FlightDurationEntityBuilder();
  set shortestDurationFlight(
          FlightDurationEntityBuilder? shortestDurationFlight) =>
      _$this._shortestDurationFlight = shortestDurationFlight;

  FlightDurationEntityBuilder? _longestDurationFlight;
  FlightDurationEntityBuilder get longestDurationFlight =>
      _$this._longestDurationFlight ??= FlightDurationEntityBuilder();
  set longestDurationFlight(
          FlightDurationEntityBuilder? longestDurationFlight) =>
      _$this._longestDurationFlight = longestDurationFlight;

  ListBuilder<AirlineStatsEntity>? _airlines;
  ListBuilder<AirlineStatsEntity> get airlines =>
      _$this._airlines ??= ListBuilder<AirlineStatsEntity>();
  set airlines(ListBuilder<AirlineStatsEntity>? airlines) =>
      _$this._airlines = airlines;

  ListBuilder<AirportStatsEntity>? _airports;
  ListBuilder<AirportStatsEntity> get airports =>
      _$this._airports ??= ListBuilder<AirportStatsEntity>();
  set airports(ListBuilder<AirportStatsEntity>? airports) =>
      _$this._airports = airports;

  ListBuilder<TopRouteEntity>? _topRoutes;
  ListBuilder<TopRouteEntity> get topRoutes =>
      _$this._topRoutes ??= ListBuilder<TopRouteEntity>();
  set topRoutes(ListBuilder<TopRouteEntity>? topRoutes) =>
      _$this._topRoutes = topRoutes;

  ProfileStatsResponseEntityBuilder() {
    ProfileStatsResponseEntity._defaults(this);
  }

  ProfileStatsResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mostFlownAircraft = $v.mostFlownAircraft.toBuilder();
      _passport = $v.passport.toBuilder();
      _shortestDistanceFlight = $v.shortestDistanceFlight.toBuilder();
      _longestDistanceFlight = $v.longestDistanceFlight.toBuilder();
      _shortestDurationFlight = $v.shortestDurationFlight.toBuilder();
      _longestDurationFlight = $v.longestDurationFlight.toBuilder();
      _airlines = $v.airlines.toBuilder();
      _airports = $v.airports.toBuilder();
      _topRoutes = $v.topRoutes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileStatsResponseEntity other) {
    _$v = other as _$ProfileStatsResponseEntity;
  }

  @override
  void update(void Function(ProfileStatsResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileStatsResponseEntity build() => _build();

  _$ProfileStatsResponseEntity _build() {
    _$ProfileStatsResponseEntity _$result;
    try {
      _$result = _$v ??
          _$ProfileStatsResponseEntity._(
            mostFlownAircraft: mostFlownAircraft.build(),
            passport: passport.build(),
            shortestDistanceFlight: shortestDistanceFlight.build(),
            longestDistanceFlight: longestDistanceFlight.build(),
            shortestDurationFlight: shortestDurationFlight.build(),
            longestDurationFlight: longestDurationFlight.build(),
            airlines: airlines.build(),
            airports: airports.build(),
            topRoutes: topRoutes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mostFlownAircraft';
        mostFlownAircraft.build();
        _$failedField = 'passport';
        passport.build();
        _$failedField = 'shortestDistanceFlight';
        shortestDistanceFlight.build();
        _$failedField = 'longestDistanceFlight';
        longestDistanceFlight.build();
        _$failedField = 'shortestDurationFlight';
        shortestDurationFlight.build();
        _$failedField = 'longestDurationFlight';
        longestDurationFlight.build();
        _$failedField = 'airlines';
        airlines.build();
        _$failedField = 'airports';
        airports.build();
        _$failedField = 'topRoutes';
        topRoutes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ProfileStatsResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
