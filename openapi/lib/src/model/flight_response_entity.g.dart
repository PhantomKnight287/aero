// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightResponseEntity extends FlightResponseEntity {
  @override
  final String id;
  @override
  final String flightNo;
  @override
  final String callSign;
  @override
  final AircraftEntity? aircraft;
  @override
  final PartialAirlineEntity airline;
  @override
  final RouteInfoEntity arrival;
  @override
  final RouteInfoEntity departure;
  @override
  final bool cargo;
  @override
  final StringifiedGreatCircleDistanceEntity greatCircleDistance;
  @override
  final DateTime date;
  @override
  final String? image;

  factory _$FlightResponseEntity(
          [void Function(FlightResponseEntityBuilder)? updates]) =>
      (new FlightResponseEntityBuilder()..update(updates))._build();

  _$FlightResponseEntity._(
      {required this.id,
      required this.flightNo,
      required this.callSign,
      this.aircraft,
      required this.airline,
      required this.arrival,
      required this.departure,
      required this.cargo,
      required this.greatCircleDistance,
      required this.date,
      this.image})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'FlightResponseEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        flightNo, r'FlightResponseEntity', 'flightNo');
    BuiltValueNullFieldError.checkNotNull(
        callSign, r'FlightResponseEntity', 'callSign');
    BuiltValueNullFieldError.checkNotNull(
        airline, r'FlightResponseEntity', 'airline');
    BuiltValueNullFieldError.checkNotNull(
        arrival, r'FlightResponseEntity', 'arrival');
    BuiltValueNullFieldError.checkNotNull(
        departure, r'FlightResponseEntity', 'departure');
    BuiltValueNullFieldError.checkNotNull(
        cargo, r'FlightResponseEntity', 'cargo');
    BuiltValueNullFieldError.checkNotNull(
        greatCircleDistance, r'FlightResponseEntity', 'greatCircleDistance');
    BuiltValueNullFieldError.checkNotNull(
        date, r'FlightResponseEntity', 'date');
  }

  @override
  FlightResponseEntity rebuild(
          void Function(FlightResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightResponseEntityBuilder toBuilder() =>
      new FlightResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightResponseEntity &&
        id == other.id &&
        flightNo == other.flightNo &&
        callSign == other.callSign &&
        aircraft == other.aircraft &&
        airline == other.airline &&
        arrival == other.arrival &&
        departure == other.departure &&
        cargo == other.cargo &&
        greatCircleDistance == other.greatCircleDistance &&
        date == other.date &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, flightNo.hashCode);
    _$hash = $jc(_$hash, callSign.hashCode);
    _$hash = $jc(_$hash, aircraft.hashCode);
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jc(_$hash, arrival.hashCode);
    _$hash = $jc(_$hash, departure.hashCode);
    _$hash = $jc(_$hash, cargo.hashCode);
    _$hash = $jc(_$hash, greatCircleDistance.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightResponseEntity')
          ..add('id', id)
          ..add('flightNo', flightNo)
          ..add('callSign', callSign)
          ..add('aircraft', aircraft)
          ..add('airline', airline)
          ..add('arrival', arrival)
          ..add('departure', departure)
          ..add('cargo', cargo)
          ..add('greatCircleDistance', greatCircleDistance)
          ..add('date', date)
          ..add('image', image))
        .toString();
  }
}

class FlightResponseEntityBuilder
    implements Builder<FlightResponseEntity, FlightResponseEntityBuilder> {
  _$FlightResponseEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _flightNo;
  String? get flightNo => _$this._flightNo;
  set flightNo(String? flightNo) => _$this._flightNo = flightNo;

  String? _callSign;
  String? get callSign => _$this._callSign;
  set callSign(String? callSign) => _$this._callSign = callSign;

  AircraftEntityBuilder? _aircraft;
  AircraftEntityBuilder get aircraft =>
      _$this._aircraft ??= new AircraftEntityBuilder();
  set aircraft(AircraftEntityBuilder? aircraft) => _$this._aircraft = aircraft;

  PartialAirlineEntityBuilder? _airline;
  PartialAirlineEntityBuilder get airline =>
      _$this._airline ??= new PartialAirlineEntityBuilder();
  set airline(PartialAirlineEntityBuilder? airline) =>
      _$this._airline = airline;

  RouteInfoEntityBuilder? _arrival;
  RouteInfoEntityBuilder get arrival =>
      _$this._arrival ??= new RouteInfoEntityBuilder();
  set arrival(RouteInfoEntityBuilder? arrival) => _$this._arrival = arrival;

  RouteInfoEntityBuilder? _departure;
  RouteInfoEntityBuilder get departure =>
      _$this._departure ??= new RouteInfoEntityBuilder();
  set departure(RouteInfoEntityBuilder? departure) =>
      _$this._departure = departure;

  bool? _cargo;
  bool? get cargo => _$this._cargo;
  set cargo(bool? cargo) => _$this._cargo = cargo;

  StringifiedGreatCircleDistanceEntityBuilder? _greatCircleDistance;
  StringifiedGreatCircleDistanceEntityBuilder get greatCircleDistance =>
      _$this._greatCircleDistance ??=
          new StringifiedGreatCircleDistanceEntityBuilder();
  set greatCircleDistance(
          StringifiedGreatCircleDistanceEntityBuilder? greatCircleDistance) =>
      _$this._greatCircleDistance = greatCircleDistance;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  FlightResponseEntityBuilder() {
    FlightResponseEntity._defaults(this);
  }

  FlightResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _flightNo = $v.flightNo;
      _callSign = $v.callSign;
      _aircraft = $v.aircraft?.toBuilder();
      _airline = $v.airline.toBuilder();
      _arrival = $v.arrival.toBuilder();
      _departure = $v.departure.toBuilder();
      _cargo = $v.cargo;
      _greatCircleDistance = $v.greatCircleDistance.toBuilder();
      _date = $v.date;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightResponseEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FlightResponseEntity;
  }

  @override
  void update(void Function(FlightResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightResponseEntity build() => _build();

  _$FlightResponseEntity _build() {
    _$FlightResponseEntity _$result;
    try {
      _$result = _$v ??
          new _$FlightResponseEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'FlightResponseEntity', 'id'),
            flightNo: BuiltValueNullFieldError.checkNotNull(
                flightNo, r'FlightResponseEntity', 'flightNo'),
            callSign: BuiltValueNullFieldError.checkNotNull(
                callSign, r'FlightResponseEntity', 'callSign'),
            aircraft: _aircraft?.build(),
            airline: airline.build(),
            arrival: arrival.build(),
            departure: departure.build(),
            cargo: BuiltValueNullFieldError.checkNotNull(
                cargo, r'FlightResponseEntity', 'cargo'),
            greatCircleDistance: greatCircleDistance.build(),
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'FlightResponseEntity', 'date'),
            image: image,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'aircraft';
        _aircraft?.build();
        _$failedField = 'airline';
        airline.build();
        _$failedField = 'arrival';
        arrival.build();
        _$failedField = 'departure';
        departure.build();

        _$failedField = 'greatCircleDistance';
        greatCircleDistance.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FlightResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
