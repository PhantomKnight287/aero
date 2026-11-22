// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TopAirportEntity extends TopAirportEntity {
  @override
  final StatsAirportEntity airport;
  @override
  final num departures;
  @override
  final num arrivals;
  @override
  final num flightCount;
  @override
  final num distanceKm;

  factory _$TopAirportEntity(
          [void Function(TopAirportEntityBuilder)? updates]) =>
      (TopAirportEntityBuilder()..update(updates))._build();

  _$TopAirportEntity._(
      {required this.airport,
      required this.departures,
      required this.arrivals,
      required this.flightCount,
      required this.distanceKm})
      : super._();
  @override
  TopAirportEntity rebuild(void Function(TopAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopAirportEntityBuilder toBuilder() =>
      TopAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TopAirportEntity &&
        airport == other.airport &&
        departures == other.departures &&
        arrivals == other.arrivals &&
        flightCount == other.flightCount &&
        distanceKm == other.distanceKm;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airport.hashCode);
    _$hash = $jc(_$hash, departures.hashCode);
    _$hash = $jc(_$hash, arrivals.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TopAirportEntity')
          ..add('airport', airport)
          ..add('departures', departures)
          ..add('arrivals', arrivals)
          ..add('flightCount', flightCount)
          ..add('distanceKm', distanceKm))
        .toString();
  }
}

class TopAirportEntityBuilder
    implements Builder<TopAirportEntity, TopAirportEntityBuilder> {
  _$TopAirportEntity? _$v;

  StatsAirportEntityBuilder? _airport;
  StatsAirportEntityBuilder get airport =>
      _$this._airport ??= StatsAirportEntityBuilder();
  set airport(StatsAirportEntityBuilder? airport) => _$this._airport = airport;

  num? _departures;
  num? get departures => _$this._departures;
  set departures(num? departures) => _$this._departures = departures;

  num? _arrivals;
  num? get arrivals => _$this._arrivals;
  set arrivals(num? arrivals) => _$this._arrivals = arrivals;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  TopAirportEntityBuilder() {
    TopAirportEntity._defaults(this);
  }

  TopAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airport = $v.airport.toBuilder();
      _departures = $v.departures;
      _arrivals = $v.arrivals;
      _flightCount = $v.flightCount;
      _distanceKm = $v.distanceKm;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopAirportEntity other) {
    _$v = other as _$TopAirportEntity;
  }

  @override
  void update(void Function(TopAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TopAirportEntity build() => _build();

  _$TopAirportEntity _build() {
    _$TopAirportEntity _$result;
    try {
      _$result = _$v ??
          _$TopAirportEntity._(
            airport: airport.build(),
            departures: BuiltValueNullFieldError.checkNotNull(
                departures, r'TopAirportEntity', 'departures'),
            arrivals: BuiltValueNullFieldError.checkNotNull(
                arrivals, r'TopAirportEntity', 'arrivals'),
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'TopAirportEntity', 'flightCount'),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
                distanceKm, r'TopAirportEntity', 'distanceKm'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airport';
        airport.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TopAirportEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
