// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightsResponseEntity extends FlightsResponseEntity {
  @override
  final bool success;
  @override
  final String date;
  @override
  final FlightsRouteEntity route;
  @override
  final num flightCount;
  @override
  final BuiltList<FlightEntity> flights;

  factory _$FlightsResponseEntity(
          [void Function(FlightsResponseEntityBuilder)? updates]) =>
      (FlightsResponseEntityBuilder()..update(updates))._build();

  _$FlightsResponseEntity._(
      {required this.success,
      required this.date,
      required this.route,
      required this.flightCount,
      required this.flights})
      : super._();
  @override
  FlightsResponseEntity rebuild(
          void Function(FlightsResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightsResponseEntityBuilder toBuilder() =>
      FlightsResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightsResponseEntity &&
        success == other.success &&
        date == other.date &&
        route == other.route &&
        flightCount == other.flightCount &&
        flights == other.flights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, route.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, flights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightsResponseEntity')
          ..add('success', success)
          ..add('date', date)
          ..add('route', route)
          ..add('flightCount', flightCount)
          ..add('flights', flights))
        .toString();
  }
}

class FlightsResponseEntityBuilder
    implements Builder<FlightsResponseEntity, FlightsResponseEntityBuilder> {
  _$FlightsResponseEntity? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  FlightsRouteEntityBuilder? _route;
  FlightsRouteEntityBuilder get route =>
      _$this._route ??= FlightsRouteEntityBuilder();
  set route(FlightsRouteEntityBuilder? route) => _$this._route = route;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  ListBuilder<FlightEntity>? _flights;
  ListBuilder<FlightEntity> get flights =>
      _$this._flights ??= ListBuilder<FlightEntity>();
  set flights(ListBuilder<FlightEntity>? flights) => _$this._flights = flights;

  FlightsResponseEntityBuilder() {
    FlightsResponseEntity._defaults(this);
  }

  FlightsResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _date = $v.date;
      _route = $v.route.toBuilder();
      _flightCount = $v.flightCount;
      _flights = $v.flights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightsResponseEntity other) {
    _$v = other as _$FlightsResponseEntity;
  }

  @override
  void update(void Function(FlightsResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightsResponseEntity build() => _build();

  _$FlightsResponseEntity _build() {
    _$FlightsResponseEntity _$result;
    try {
      _$result = _$v ??
          _$FlightsResponseEntity._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'FlightsResponseEntity', 'success'),
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'FlightsResponseEntity', 'date'),
            route: route.build(),
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'FlightsResponseEntity', 'flightCount'),
            flights: flights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'route';
        route.build();

        _$failedField = 'flights';
        flights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightsResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
