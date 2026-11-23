// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_stats_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfileStatsResponseEntity extends ProfileStatsResponseEntity {
  @override
  final BuiltList<num> availableYears;
  @override
  final num? year;
  @override
  final PassportEntity passport;
  @override
  final FlightsPerEntity flightsPer;
  @override
  final RecordsEntity records;
  @override
  final BuiltList<TopAirportEntity> topAirports;
  @override
  final BuiltList<TopAirlineEntity> topAirlines;
  @override
  final BuiltList<TopRouteEntity> topRoutes;
  @override
  final BuiltList<CountryEntity> countries;
  @override
  final BuiltList<ContinentEntity> continents;
  @override
  final DelaySummaryEntity delays;
  @override
  final RunwaysEntity runways;
  @override
  final TaxiByAirportEntity taxiByAirport;
  @override
  final ExtremesEntity extremes;
  @override
  final MapDataEntity map;
  @override
  final AircraftSectionEntity aircraft;

  factory _$ProfileStatsResponseEntity(
          [void Function(ProfileStatsResponseEntityBuilder)? updates]) =>
      (ProfileStatsResponseEntityBuilder()..update(updates))._build();

  _$ProfileStatsResponseEntity._(
      {required this.availableYears,
      this.year,
      required this.passport,
      required this.flightsPer,
      required this.records,
      required this.topAirports,
      required this.topAirlines,
      required this.topRoutes,
      required this.countries,
      required this.continents,
      required this.delays,
      required this.runways,
      required this.taxiByAirport,
      required this.extremes,
      required this.map,
      required this.aircraft})
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
        availableYears == other.availableYears &&
        year == other.year &&
        passport == other.passport &&
        flightsPer == other.flightsPer &&
        records == other.records &&
        topAirports == other.topAirports &&
        topAirlines == other.topAirlines &&
        topRoutes == other.topRoutes &&
        countries == other.countries &&
        continents == other.continents &&
        delays == other.delays &&
        runways == other.runways &&
        taxiByAirport == other.taxiByAirport &&
        extremes == other.extremes &&
        map == other.map &&
        aircraft == other.aircraft;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, availableYears.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, passport.hashCode);
    _$hash = $jc(_$hash, flightsPer.hashCode);
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jc(_$hash, topAirports.hashCode);
    _$hash = $jc(_$hash, topAirlines.hashCode);
    _$hash = $jc(_$hash, topRoutes.hashCode);
    _$hash = $jc(_$hash, countries.hashCode);
    _$hash = $jc(_$hash, continents.hashCode);
    _$hash = $jc(_$hash, delays.hashCode);
    _$hash = $jc(_$hash, runways.hashCode);
    _$hash = $jc(_$hash, taxiByAirport.hashCode);
    _$hash = $jc(_$hash, extremes.hashCode);
    _$hash = $jc(_$hash, map.hashCode);
    _$hash = $jc(_$hash, aircraft.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileStatsResponseEntity')
          ..add('availableYears', availableYears)
          ..add('year', year)
          ..add('passport', passport)
          ..add('flightsPer', flightsPer)
          ..add('records', records)
          ..add('topAirports', topAirports)
          ..add('topAirlines', topAirlines)
          ..add('topRoutes', topRoutes)
          ..add('countries', countries)
          ..add('continents', continents)
          ..add('delays', delays)
          ..add('runways', runways)
          ..add('taxiByAirport', taxiByAirport)
          ..add('extremes', extremes)
          ..add('map', map)
          ..add('aircraft', aircraft))
        .toString();
  }
}

class ProfileStatsResponseEntityBuilder
    implements
        Builder<ProfileStatsResponseEntity, ProfileStatsResponseEntityBuilder> {
  _$ProfileStatsResponseEntity? _$v;

  ListBuilder<num>? _availableYears;
  ListBuilder<num> get availableYears =>
      _$this._availableYears ??= ListBuilder<num>();
  set availableYears(ListBuilder<num>? availableYears) =>
      _$this._availableYears = availableYears;

  num? _year;
  num? get year => _$this._year;
  set year(num? year) => _$this._year = year;

  PassportEntityBuilder? _passport;
  PassportEntityBuilder get passport =>
      _$this._passport ??= PassportEntityBuilder();
  set passport(PassportEntityBuilder? passport) => _$this._passport = passport;

  FlightsPerEntityBuilder? _flightsPer;
  FlightsPerEntityBuilder get flightsPer =>
      _$this._flightsPer ??= FlightsPerEntityBuilder();
  set flightsPer(FlightsPerEntityBuilder? flightsPer) =>
      _$this._flightsPer = flightsPer;

  RecordsEntityBuilder? _records;
  RecordsEntityBuilder get records =>
      _$this._records ??= RecordsEntityBuilder();
  set records(RecordsEntityBuilder? records) => _$this._records = records;

  ListBuilder<TopAirportEntity>? _topAirports;
  ListBuilder<TopAirportEntity> get topAirports =>
      _$this._topAirports ??= ListBuilder<TopAirportEntity>();
  set topAirports(ListBuilder<TopAirportEntity>? topAirports) =>
      _$this._topAirports = topAirports;

  ListBuilder<TopAirlineEntity>? _topAirlines;
  ListBuilder<TopAirlineEntity> get topAirlines =>
      _$this._topAirlines ??= ListBuilder<TopAirlineEntity>();
  set topAirlines(ListBuilder<TopAirlineEntity>? topAirlines) =>
      _$this._topAirlines = topAirlines;

  ListBuilder<TopRouteEntity>? _topRoutes;
  ListBuilder<TopRouteEntity> get topRoutes =>
      _$this._topRoutes ??= ListBuilder<TopRouteEntity>();
  set topRoutes(ListBuilder<TopRouteEntity>? topRoutes) =>
      _$this._topRoutes = topRoutes;

  ListBuilder<CountryEntity>? _countries;
  ListBuilder<CountryEntity> get countries =>
      _$this._countries ??= ListBuilder<CountryEntity>();
  set countries(ListBuilder<CountryEntity>? countries) =>
      _$this._countries = countries;

  ListBuilder<ContinentEntity>? _continents;
  ListBuilder<ContinentEntity> get continents =>
      _$this._continents ??= ListBuilder<ContinentEntity>();
  set continents(ListBuilder<ContinentEntity>? continents) =>
      _$this._continents = continents;

  DelaySummaryEntityBuilder? _delays;
  DelaySummaryEntityBuilder get delays =>
      _$this._delays ??= DelaySummaryEntityBuilder();
  set delays(DelaySummaryEntityBuilder? delays) => _$this._delays = delays;

  RunwaysEntityBuilder? _runways;
  RunwaysEntityBuilder get runways =>
      _$this._runways ??= RunwaysEntityBuilder();
  set runways(RunwaysEntityBuilder? runways) => _$this._runways = runways;

  TaxiByAirportEntityBuilder? _taxiByAirport;
  TaxiByAirportEntityBuilder get taxiByAirport =>
      _$this._taxiByAirport ??= TaxiByAirportEntityBuilder();
  set taxiByAirport(TaxiByAirportEntityBuilder? taxiByAirport) =>
      _$this._taxiByAirport = taxiByAirport;

  ExtremesEntityBuilder? _extremes;
  ExtremesEntityBuilder get extremes =>
      _$this._extremes ??= ExtremesEntityBuilder();
  set extremes(ExtremesEntityBuilder? extremes) => _$this._extremes = extremes;

  MapDataEntityBuilder? _map;
  MapDataEntityBuilder get map => _$this._map ??= MapDataEntityBuilder();
  set map(MapDataEntityBuilder? map) => _$this._map = map;

  AircraftSectionEntityBuilder? _aircraft;
  AircraftSectionEntityBuilder get aircraft =>
      _$this._aircraft ??= AircraftSectionEntityBuilder();
  set aircraft(AircraftSectionEntityBuilder? aircraft) =>
      _$this._aircraft = aircraft;

  ProfileStatsResponseEntityBuilder() {
    ProfileStatsResponseEntity._defaults(this);
  }

  ProfileStatsResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _availableYears = $v.availableYears.toBuilder();
      _year = $v.year;
      _passport = $v.passport.toBuilder();
      _flightsPer = $v.flightsPer.toBuilder();
      _records = $v.records.toBuilder();
      _topAirports = $v.topAirports.toBuilder();
      _topAirlines = $v.topAirlines.toBuilder();
      _topRoutes = $v.topRoutes.toBuilder();
      _countries = $v.countries.toBuilder();
      _continents = $v.continents.toBuilder();
      _delays = $v.delays.toBuilder();
      _runways = $v.runways.toBuilder();
      _taxiByAirport = $v.taxiByAirport.toBuilder();
      _extremes = $v.extremes.toBuilder();
      _map = $v.map.toBuilder();
      _aircraft = $v.aircraft.toBuilder();
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
            availableYears: availableYears.build(),
            year: year,
            passport: passport.build(),
            flightsPer: flightsPer.build(),
            records: records.build(),
            topAirports: topAirports.build(),
            topAirlines: topAirlines.build(),
            topRoutes: topRoutes.build(),
            countries: countries.build(),
            continents: continents.build(),
            delays: delays.build(),
            runways: runways.build(),
            taxiByAirport: taxiByAirport.build(),
            extremes: extremes.build(),
            map: map.build(),
            aircraft: aircraft.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'availableYears';
        availableYears.build();

        _$failedField = 'passport';
        passport.build();
        _$failedField = 'flightsPer';
        flightsPer.build();
        _$failedField = 'records';
        records.build();
        _$failedField = 'topAirports';
        topAirports.build();
        _$failedField = 'topAirlines';
        topAirlines.build();
        _$failedField = 'topRoutes';
        topRoutes.build();
        _$failedField = 'countries';
        countries.build();
        _$failedField = 'continents';
        continents.build();
        _$failedField = 'delays';
        delays.build();
        _$failedField = 'runways';
        runways.build();
        _$failedField = 'taxiByAirport';
        taxiByAirport.build();
        _$failedField = 'extremes';
        extremes.build();
        _$failedField = 'map';
        map.build();
        _$failedField = 'aircraft';
        aircraft.build();
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
