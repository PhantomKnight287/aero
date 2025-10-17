// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_controller_get_flights_in_bounds_v1200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightsControllerGetFlightsInBoundsV1200Response
    extends FlightsControllerGetFlightsInBoundsV1200Response {
  @override
  final bool? success;
  @override
  final DateTime? timestamp;
  @override
  final FlightsControllerGetFlightsInBoundsV1200ResponseBounds? bounds;
  @override
  final num? totalAircraft;
  @override
  final num? airborneAircraft;
  @override
  final BuiltList<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>?
      flights;

  factory _$FlightsControllerGetFlightsInBoundsV1200Response(
          [void Function(
                  FlightsControllerGetFlightsInBoundsV1200ResponseBuilder)?
              updates]) =>
      (FlightsControllerGetFlightsInBoundsV1200ResponseBuilder()
            ..update(updates))
          ._build();

  _$FlightsControllerGetFlightsInBoundsV1200Response._(
      {this.success,
      this.timestamp,
      this.bounds,
      this.totalAircraft,
      this.airborneAircraft,
      this.flights})
      : super._();
  @override
  FlightsControllerGetFlightsInBoundsV1200Response rebuild(
          void Function(FlightsControllerGetFlightsInBoundsV1200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseBuilder toBuilder() =>
      FlightsControllerGetFlightsInBoundsV1200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightsControllerGetFlightsInBoundsV1200Response &&
        success == other.success &&
        timestamp == other.timestamp &&
        bounds == other.bounds &&
        totalAircraft == other.totalAircraft &&
        airborneAircraft == other.airborneAircraft &&
        flights == other.flights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, bounds.hashCode);
    _$hash = $jc(_$hash, totalAircraft.hashCode);
    _$hash = $jc(_$hash, airborneAircraft.hashCode);
    _$hash = $jc(_$hash, flights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FlightsControllerGetFlightsInBoundsV1200Response')
          ..add('success', success)
          ..add('timestamp', timestamp)
          ..add('bounds', bounds)
          ..add('totalAircraft', totalAircraft)
          ..add('airborneAircraft', airborneAircraft)
          ..add('flights', flights))
        .toString();
  }
}

class FlightsControllerGetFlightsInBoundsV1200ResponseBuilder
    implements
        Builder<FlightsControllerGetFlightsInBoundsV1200Response,
            FlightsControllerGetFlightsInBoundsV1200ResponseBuilder> {
  _$FlightsControllerGetFlightsInBoundsV1200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder? _bounds;
  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder get bounds =>
      _$this._bounds ??=
          FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder();
  set bounds(
          FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder?
              bounds) =>
      _$this._bounds = bounds;

  num? _totalAircraft;
  num? get totalAircraft => _$this._totalAircraft;
  set totalAircraft(num? totalAircraft) =>
      _$this._totalAircraft = totalAircraft;

  num? _airborneAircraft;
  num? get airborneAircraft => _$this._airborneAircraft;
  set airborneAircraft(num? airborneAircraft) =>
      _$this._airborneAircraft = airborneAircraft;

  ListBuilder<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>?
      _flights;
  ListBuilder<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>
      get flights => _$this._flights ??= ListBuilder<
          FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>();
  set flights(
          ListBuilder<
                  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>?
              flights) =>
      _$this._flights = flights;

  FlightsControllerGetFlightsInBoundsV1200ResponseBuilder() {
    FlightsControllerGetFlightsInBoundsV1200Response._defaults(this);
  }

  FlightsControllerGetFlightsInBoundsV1200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _timestamp = $v.timestamp;
      _bounds = $v.bounds?.toBuilder();
      _totalAircraft = $v.totalAircraft;
      _airborneAircraft = $v.airborneAircraft;
      _flights = $v.flights?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightsControllerGetFlightsInBoundsV1200Response other) {
    _$v = other as _$FlightsControllerGetFlightsInBoundsV1200Response;
  }

  @override
  void update(
      void Function(FlightsControllerGetFlightsInBoundsV1200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200Response build() => _build();

  _$FlightsControllerGetFlightsInBoundsV1200Response _build() {
    _$FlightsControllerGetFlightsInBoundsV1200Response _$result;
    try {
      _$result = _$v ??
          _$FlightsControllerGetFlightsInBoundsV1200Response._(
            success: success,
            timestamp: timestamp,
            bounds: _bounds?.build(),
            totalAircraft: totalAircraft,
            airborneAircraft: airborneAircraft,
            flights: _flights?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bounds';
        _bounds?.build();

        _$failedField = 'flights';
        _flights?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightsControllerGetFlightsInBoundsV1200Response',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
