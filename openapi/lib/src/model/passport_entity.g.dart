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
  final num totalDurationMinutes;
  @override
  final num totalAirports;
  @override
  final num totalAirlines;

  factory _$PassportEntity([void Function(PassportEntityBuilder)? updates]) =>
      (PassportEntityBuilder()..update(updates))._build();

  _$PassportEntity._(
      {required this.totalFlights,
      required this.totalDistanceKm,
      required this.totalDurationMinutes,
      required this.totalAirports,
      required this.totalAirlines})
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
        totalDurationMinutes == other.totalDurationMinutes &&
        totalAirports == other.totalAirports &&
        totalAirlines == other.totalAirlines;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalFlights.hashCode);
    _$hash = $jc(_$hash, totalDistanceKm.hashCode);
    _$hash = $jc(_$hash, totalDurationMinutes.hashCode);
    _$hash = $jc(_$hash, totalAirports.hashCode);
    _$hash = $jc(_$hash, totalAirlines.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PassportEntity')
          ..add('totalFlights', totalFlights)
          ..add('totalDistanceKm', totalDistanceKm)
          ..add('totalDurationMinutes', totalDurationMinutes)
          ..add('totalAirports', totalAirports)
          ..add('totalAirlines', totalAirlines))
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

  num? _totalDurationMinutes;
  num? get totalDurationMinutes => _$this._totalDurationMinutes;
  set totalDurationMinutes(num? totalDurationMinutes) =>
      _$this._totalDurationMinutes = totalDurationMinutes;

  num? _totalAirports;
  num? get totalAirports => _$this._totalAirports;
  set totalAirports(num? totalAirports) =>
      _$this._totalAirports = totalAirports;

  num? _totalAirlines;
  num? get totalAirlines => _$this._totalAirlines;
  set totalAirlines(num? totalAirlines) =>
      _$this._totalAirlines = totalAirlines;

  PassportEntityBuilder() {
    PassportEntity._defaults(this);
  }

  PassportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalFlights = $v.totalFlights;
      _totalDistanceKm = $v.totalDistanceKm;
      _totalDurationMinutes = $v.totalDurationMinutes;
      _totalAirports = $v.totalAirports;
      _totalAirlines = $v.totalAirlines;
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
          totalDurationMinutes: BuiltValueNullFieldError.checkNotNull(
              totalDurationMinutes, r'PassportEntity', 'totalDurationMinutes'),
          totalAirports: BuiltValueNullFieldError.checkNotNull(
              totalAirports, r'PassportEntity', 'totalAirports'),
          totalAirlines: BuiltValueNullFieldError.checkNotNull(
              totalAirlines, r'PassportEntity', 'totalAirlines'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
