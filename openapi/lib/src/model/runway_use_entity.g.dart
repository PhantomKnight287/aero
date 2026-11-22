// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runway_use_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RunwayUseEntity extends RunwayUseEntity {
  @override
  final StatsAirportEntity airport;
  @override
  final String runway;
  @override
  final num departures;
  @override
  final num arrivals;

  factory _$RunwayUseEntity([void Function(RunwayUseEntityBuilder)? updates]) =>
      (RunwayUseEntityBuilder()..update(updates))._build();

  _$RunwayUseEntity._(
      {required this.airport,
      required this.runway,
      required this.departures,
      required this.arrivals})
      : super._();
  @override
  RunwayUseEntity rebuild(void Function(RunwayUseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RunwayUseEntityBuilder toBuilder() => RunwayUseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RunwayUseEntity &&
        airport == other.airport &&
        runway == other.runway &&
        departures == other.departures &&
        arrivals == other.arrivals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airport.hashCode);
    _$hash = $jc(_$hash, runway.hashCode);
    _$hash = $jc(_$hash, departures.hashCode);
    _$hash = $jc(_$hash, arrivals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RunwayUseEntity')
          ..add('airport', airport)
          ..add('runway', runway)
          ..add('departures', departures)
          ..add('arrivals', arrivals))
        .toString();
  }
}

class RunwayUseEntityBuilder
    implements Builder<RunwayUseEntity, RunwayUseEntityBuilder> {
  _$RunwayUseEntity? _$v;

  StatsAirportEntityBuilder? _airport;
  StatsAirportEntityBuilder get airport =>
      _$this._airport ??= StatsAirportEntityBuilder();
  set airport(StatsAirportEntityBuilder? airport) => _$this._airport = airport;

  String? _runway;
  String? get runway => _$this._runway;
  set runway(String? runway) => _$this._runway = runway;

  num? _departures;
  num? get departures => _$this._departures;
  set departures(num? departures) => _$this._departures = departures;

  num? _arrivals;
  num? get arrivals => _$this._arrivals;
  set arrivals(num? arrivals) => _$this._arrivals = arrivals;

  RunwayUseEntityBuilder() {
    RunwayUseEntity._defaults(this);
  }

  RunwayUseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airport = $v.airport.toBuilder();
      _runway = $v.runway;
      _departures = $v.departures;
      _arrivals = $v.arrivals;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RunwayUseEntity other) {
    _$v = other as _$RunwayUseEntity;
  }

  @override
  void update(void Function(RunwayUseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RunwayUseEntity build() => _build();

  _$RunwayUseEntity _build() {
    _$RunwayUseEntity _$result;
    try {
      _$result = _$v ??
          _$RunwayUseEntity._(
            airport: airport.build(),
            runway: BuiltValueNullFieldError.checkNotNull(
                runway, r'RunwayUseEntity', 'runway'),
            departures: BuiltValueNullFieldError.checkNotNull(
                departures, r'RunwayUseEntity', 'departures'),
            arrivals: BuiltValueNullFieldError.checkNotNull(
                arrivals, r'RunwayUseEntity', 'arrivals'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airport';
        airport.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RunwayUseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
