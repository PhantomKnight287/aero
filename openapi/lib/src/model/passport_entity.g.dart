// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PassportEntity extends PassportEntity {
  @override
  final num totalFlights;
  @override
  final num totalDistanceKm;
  @override
  final num blockMinutes;
  @override
  final num airMinutes;
  @override
  final num airBasedOn;
  @override
  final num taxiMinutes;
  @override
  final num taxiBasedOn;
  @override
  final num totalAirports;
  @override
  final num totalAirlines;
  @override
  final num totalCountries;
  @override
  final num domestic;
  @override
  final num international;
  @override
  final num longHaul;

  factory _$PassportEntity([void Function(PassportEntityBuilder)? updates]) =>
      (PassportEntityBuilder()..update(updates))._build();

  _$PassportEntity._(
      {required this.totalFlights,
      required this.totalDistanceKm,
      required this.blockMinutes,
      required this.airMinutes,
      required this.airBasedOn,
      required this.taxiMinutes,
      required this.taxiBasedOn,
      required this.totalAirports,
      required this.totalAirlines,
      required this.totalCountries,
      required this.domestic,
      required this.international,
      required this.longHaul})
      : super._();
  @override
  PassportEntity rebuild(void Function(PassportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PassportEntityBuilder toBuilder() => PassportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PassportEntity &&
        totalFlights == other.totalFlights &&
        totalDistanceKm == other.totalDistanceKm &&
        blockMinutes == other.blockMinutes &&
        airMinutes == other.airMinutes &&
        airBasedOn == other.airBasedOn &&
        taxiMinutes == other.taxiMinutes &&
        taxiBasedOn == other.taxiBasedOn &&
        totalAirports == other.totalAirports &&
        totalAirlines == other.totalAirlines &&
        totalCountries == other.totalCountries &&
        domestic == other.domestic &&
        international == other.international &&
        longHaul == other.longHaul;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalFlights.hashCode);
    _$hash = $jc(_$hash, totalDistanceKm.hashCode);
    _$hash = $jc(_$hash, blockMinutes.hashCode);
    _$hash = $jc(_$hash, airMinutes.hashCode);
    _$hash = $jc(_$hash, airBasedOn.hashCode);
    _$hash = $jc(_$hash, taxiMinutes.hashCode);
    _$hash = $jc(_$hash, taxiBasedOn.hashCode);
    _$hash = $jc(_$hash, totalAirports.hashCode);
    _$hash = $jc(_$hash, totalAirlines.hashCode);
    _$hash = $jc(_$hash, totalCountries.hashCode);
    _$hash = $jc(_$hash, domestic.hashCode);
    _$hash = $jc(_$hash, international.hashCode);
    _$hash = $jc(_$hash, longHaul.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PassportEntity')
          ..add('totalFlights', totalFlights)
          ..add('totalDistanceKm', totalDistanceKm)
          ..add('blockMinutes', blockMinutes)
          ..add('airMinutes', airMinutes)
          ..add('airBasedOn', airBasedOn)
          ..add('taxiMinutes', taxiMinutes)
          ..add('taxiBasedOn', taxiBasedOn)
          ..add('totalAirports', totalAirports)
          ..add('totalAirlines', totalAirlines)
          ..add('totalCountries', totalCountries)
          ..add('domestic', domestic)
          ..add('international', international)
          ..add('longHaul', longHaul))
        .toString();
  }
}

class PassportEntityBuilder
    implements Builder<PassportEntity, PassportEntityBuilder> {
  _$PassportEntity? _$v;

  num? _totalFlights;
  num? get totalFlights => _$this._totalFlights;
  set totalFlights(num? totalFlights) => _$this._totalFlights = totalFlights;

  num? _totalDistanceKm;
  num? get totalDistanceKm => _$this._totalDistanceKm;
  set totalDistanceKm(num? totalDistanceKm) =>
      _$this._totalDistanceKm = totalDistanceKm;

  num? _blockMinutes;
  num? get blockMinutes => _$this._blockMinutes;
  set blockMinutes(num? blockMinutes) => _$this._blockMinutes = blockMinutes;

  num? _airMinutes;
  num? get airMinutes => _$this._airMinutes;
  set airMinutes(num? airMinutes) => _$this._airMinutes = airMinutes;

  num? _airBasedOn;
  num? get airBasedOn => _$this._airBasedOn;
  set airBasedOn(num? airBasedOn) => _$this._airBasedOn = airBasedOn;

  num? _taxiMinutes;
  num? get taxiMinutes => _$this._taxiMinutes;
  set taxiMinutes(num? taxiMinutes) => _$this._taxiMinutes = taxiMinutes;

  num? _taxiBasedOn;
  num? get taxiBasedOn => _$this._taxiBasedOn;
  set taxiBasedOn(num? taxiBasedOn) => _$this._taxiBasedOn = taxiBasedOn;

  num? _totalAirports;
  num? get totalAirports => _$this._totalAirports;
  set totalAirports(num? totalAirports) =>
      _$this._totalAirports = totalAirports;

  num? _totalAirlines;
  num? get totalAirlines => _$this._totalAirlines;
  set totalAirlines(num? totalAirlines) =>
      _$this._totalAirlines = totalAirlines;

  num? _totalCountries;
  num? get totalCountries => _$this._totalCountries;
  set totalCountries(num? totalCountries) =>
      _$this._totalCountries = totalCountries;

  num? _domestic;
  num? get domestic => _$this._domestic;
  set domestic(num? domestic) => _$this._domestic = domestic;

  num? _international;
  num? get international => _$this._international;
  set international(num? international) =>
      _$this._international = international;

  num? _longHaul;
  num? get longHaul => _$this._longHaul;
  set longHaul(num? longHaul) => _$this._longHaul = longHaul;

  PassportEntityBuilder() {
    PassportEntity._defaults(this);
  }

  PassportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalFlights = $v.totalFlights;
      _totalDistanceKm = $v.totalDistanceKm;
      _blockMinutes = $v.blockMinutes;
      _airMinutes = $v.airMinutes;
      _airBasedOn = $v.airBasedOn;
      _taxiMinutes = $v.taxiMinutes;
      _taxiBasedOn = $v.taxiBasedOn;
      _totalAirports = $v.totalAirports;
      _totalAirlines = $v.totalAirlines;
      _totalCountries = $v.totalCountries;
      _domestic = $v.domestic;
      _international = $v.international;
      _longHaul = $v.longHaul;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PassportEntity other) {
    _$v = other as _$PassportEntity;
  }

  @override
  void update(void Function(PassportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PassportEntity build() => _build();

  _$PassportEntity _build() {
    final _$result = _$v ??
        _$PassportEntity._(
          totalFlights: BuiltValueNullFieldError.checkNotNull(
              totalFlights, r'PassportEntity', 'totalFlights'),
          totalDistanceKm: BuiltValueNullFieldError.checkNotNull(
              totalDistanceKm, r'PassportEntity', 'totalDistanceKm'),
          blockMinutes: BuiltValueNullFieldError.checkNotNull(
              blockMinutes, r'PassportEntity', 'blockMinutes'),
          airMinutes: BuiltValueNullFieldError.checkNotNull(
              airMinutes, r'PassportEntity', 'airMinutes'),
          airBasedOn: BuiltValueNullFieldError.checkNotNull(
              airBasedOn, r'PassportEntity', 'airBasedOn'),
          taxiMinutes: BuiltValueNullFieldError.checkNotNull(
              taxiMinutes, r'PassportEntity', 'taxiMinutes'),
          taxiBasedOn: BuiltValueNullFieldError.checkNotNull(
              taxiBasedOn, r'PassportEntity', 'taxiBasedOn'),
          totalAirports: BuiltValueNullFieldError.checkNotNull(
              totalAirports, r'PassportEntity', 'totalAirports'),
          totalAirlines: BuiltValueNullFieldError.checkNotNull(
              totalAirlines, r'PassportEntity', 'totalAirlines'),
          totalCountries: BuiltValueNullFieldError.checkNotNull(
              totalCountries, r'PassportEntity', 'totalCountries'),
          domestic: BuiltValueNullFieldError.checkNotNull(
              domestic, r'PassportEntity', 'domestic'),
          international: BuiltValueNullFieldError.checkNotNull(
              international, r'PassportEntity', 'international'),
          longHaul: BuiltValueNullFieldError.checkNotNull(
              longHaul, r'PassportEntity', 'longHaul'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
