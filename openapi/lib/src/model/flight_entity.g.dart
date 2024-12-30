// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightEntity extends FlightEntity {
  @override
  final AirlineInfo airline;
  @override
  final AircraftFlightEntity flight;
  @override
  final AirportInfo departure;
  @override
  final AirportInfo arrival;
  @override
  final FlightStatus status;
  @override
  final FlighType type;
  @override
  final JsonObject codeshared;

  factory _$FlightEntity([void Function(FlightEntityBuilder)? updates]) =>
      (new FlightEntityBuilder()..update(updates))._build();

  _$FlightEntity._(
      {required this.airline,
      required this.flight,
      required this.departure,
      required this.arrival,
      required this.status,
      required this.type,
      required this.codeshared})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(airline, r'FlightEntity', 'airline');
    BuiltValueNullFieldError.checkNotNull(flight, r'FlightEntity', 'flight');
    BuiltValueNullFieldError.checkNotNull(
        departure, r'FlightEntity', 'departure');
    BuiltValueNullFieldError.checkNotNull(arrival, r'FlightEntity', 'arrival');
    BuiltValueNullFieldError.checkNotNull(status, r'FlightEntity', 'status');
    BuiltValueNullFieldError.checkNotNull(type, r'FlightEntity', 'type');
    BuiltValueNullFieldError.checkNotNull(
        codeshared, r'FlightEntity', 'codeshared');
  }

  @override
  FlightEntity rebuild(void Function(FlightEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightEntityBuilder toBuilder() => new FlightEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightEntity &&
        airline == other.airline &&
        flight == other.flight &&
        departure == other.departure &&
        arrival == other.arrival &&
        status == other.status &&
        type == other.type &&
        codeshared == other.codeshared;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jc(_$hash, flight.hashCode);
    _$hash = $jc(_$hash, departure.hashCode);
    _$hash = $jc(_$hash, arrival.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, codeshared.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightEntity')
          ..add('airline', airline)
          ..add('flight', flight)
          ..add('departure', departure)
          ..add('arrival', arrival)
          ..add('status', status)
          ..add('type', type)
          ..add('codeshared', codeshared))
        .toString();
  }
}

class FlightEntityBuilder
    implements Builder<FlightEntity, FlightEntityBuilder> {
  _$FlightEntity? _$v;

  AirlineInfoBuilder? _airline;
  AirlineInfoBuilder get airline =>
      _$this._airline ??= new AirlineInfoBuilder();
  set airline(AirlineInfoBuilder? airline) => _$this._airline = airline;

  AircraftFlightEntityBuilder? _flight;
  AircraftFlightEntityBuilder get flight =>
      _$this._flight ??= new AircraftFlightEntityBuilder();
  set flight(AircraftFlightEntityBuilder? flight) => _$this._flight = flight;

  AirportInfoBuilder? _departure;
  AirportInfoBuilder get departure =>
      _$this._departure ??= new AirportInfoBuilder();
  set departure(AirportInfoBuilder? departure) => _$this._departure = departure;

  AirportInfoBuilder? _arrival;
  AirportInfoBuilder get arrival =>
      _$this._arrival ??= new AirportInfoBuilder();
  set arrival(AirportInfoBuilder? arrival) => _$this._arrival = arrival;

  FlightStatus? _status;
  FlightStatus? get status => _$this._status;
  set status(FlightStatus? status) => _$this._status = status;

  FlighType? _type;
  FlighType? get type => _$this._type;
  set type(FlighType? type) => _$this._type = type;

  JsonObject? _codeshared;
  JsonObject? get codeshared => _$this._codeshared;
  set codeshared(JsonObject? codeshared) => _$this._codeshared = codeshared;

  FlightEntityBuilder() {
    FlightEntity._defaults(this);
  }

  FlightEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airline = $v.airline.toBuilder();
      _flight = $v.flight.toBuilder();
      _departure = $v.departure.toBuilder();
      _arrival = $v.arrival.toBuilder();
      _status = $v.status;
      _type = $v.type;
      _codeshared = $v.codeshared;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FlightEntity;
  }

  @override
  void update(void Function(FlightEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightEntity build() => _build();

  _$FlightEntity _build() {
    _$FlightEntity _$result;
    try {
      _$result = _$v ??
          new _$FlightEntity._(
            airline: airline.build(),
            flight: flight.build(),
            departure: departure.build(),
            arrival: arrival.build(),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FlightEntity', 'status'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'FlightEntity', 'type'),
            codeshared: BuiltValueNullFieldError.checkNotNull(
                codeshared, r'FlightEntity', 'codeshared'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airline';
        airline.build();
        _$failedField = 'flight';
        flight.build();
        _$failedField = 'departure';
        departure.build();
        _$failedField = 'arrival';
        arrival.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FlightEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
