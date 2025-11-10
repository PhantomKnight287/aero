// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_candidate_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightCandidateEntity extends FlightCandidateEntity {
  @override
  final String faFlightId;
  @override
  final String ident;
  @override
  final FlightSummaryOriginEntity origin;
  @override
  final FlightSummaryDestinationEntity destination;
  @override
  final DateTime? scheduledOut;
  @override
  final DateTime? scheduledOff;
  @override
  final String status;
  @override
  final FlightSummaryAirlineEntity airline;

  factory _$FlightCandidateEntity(
          [void Function(FlightCandidateEntityBuilder)? updates]) =>
      (FlightCandidateEntityBuilder()..update(updates))._build();

  _$FlightCandidateEntity._(
      {required this.faFlightId,
      required this.ident,
      required this.origin,
      required this.destination,
      this.scheduledOut,
      this.scheduledOff,
      required this.status,
      required this.airline})
      : super._();
  @override
  FlightCandidateEntity rebuild(
          void Function(FlightCandidateEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightCandidateEntityBuilder toBuilder() =>
      FlightCandidateEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightCandidateEntity &&
        faFlightId == other.faFlightId &&
        ident == other.ident &&
        origin == other.origin &&
        destination == other.destination &&
        scheduledOut == other.scheduledOut &&
        scheduledOff == other.scheduledOff &&
        status == other.status &&
        airline == other.airline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, faFlightId.hashCode);
    _$hash = $jc(_$hash, ident.hashCode);
    _$hash = $jc(_$hash, origin.hashCode);
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, scheduledOut.hashCode);
    _$hash = $jc(_$hash, scheduledOff.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightCandidateEntity')
          ..add('faFlightId', faFlightId)
          ..add('ident', ident)
          ..add('origin', origin)
          ..add('destination', destination)
          ..add('scheduledOut', scheduledOut)
          ..add('scheduledOff', scheduledOff)
          ..add('status', status)
          ..add('airline', airline))
        .toString();
  }
}

class FlightCandidateEntityBuilder
    implements Builder<FlightCandidateEntity, FlightCandidateEntityBuilder> {
  _$FlightCandidateEntity? _$v;

  String? _faFlightId;
  String? get faFlightId => _$this._faFlightId;
  set faFlightId(String? faFlightId) => _$this._faFlightId = faFlightId;

  String? _ident;
  String? get ident => _$this._ident;
  set ident(String? ident) => _$this._ident = ident;

  FlightSummaryOriginEntityBuilder? _origin;
  FlightSummaryOriginEntityBuilder get origin =>
      _$this._origin ??= FlightSummaryOriginEntityBuilder();
  set origin(FlightSummaryOriginEntityBuilder? origin) =>
      _$this._origin = origin;

  FlightSummaryDestinationEntityBuilder? _destination;
  FlightSummaryDestinationEntityBuilder get destination =>
      _$this._destination ??= FlightSummaryDestinationEntityBuilder();
  set destination(FlightSummaryDestinationEntityBuilder? destination) =>
      _$this._destination = destination;

  DateTime? _scheduledOut;
  DateTime? get scheduledOut => _$this._scheduledOut;
  set scheduledOut(DateTime? scheduledOut) =>
      _$this._scheduledOut = scheduledOut;

  DateTime? _scheduledOff;
  DateTime? get scheduledOff => _$this._scheduledOff;
  set scheduledOff(DateTime? scheduledOff) =>
      _$this._scheduledOff = scheduledOff;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  FlightSummaryAirlineEntityBuilder? _airline;
  FlightSummaryAirlineEntityBuilder get airline =>
      _$this._airline ??= FlightSummaryAirlineEntityBuilder();
  set airline(FlightSummaryAirlineEntityBuilder? airline) =>
      _$this._airline = airline;

  FlightCandidateEntityBuilder() {
    FlightCandidateEntity._defaults(this);
  }

  FlightCandidateEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _faFlightId = $v.faFlightId;
      _ident = $v.ident;
      _origin = $v.origin.toBuilder();
      _destination = $v.destination.toBuilder();
      _scheduledOut = $v.scheduledOut;
      _scheduledOff = $v.scheduledOff;
      _status = $v.status;
      _airline = $v.airline.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightCandidateEntity other) {
    _$v = other as _$FlightCandidateEntity;
  }

  @override
  void update(void Function(FlightCandidateEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightCandidateEntity build() => _build();

  _$FlightCandidateEntity _build() {
    _$FlightCandidateEntity _$result;
    try {
      _$result = _$v ??
          _$FlightCandidateEntity._(
            faFlightId: BuiltValueNullFieldError.checkNotNull(
                faFlightId, r'FlightCandidateEntity', 'faFlightId'),
            ident: BuiltValueNullFieldError.checkNotNull(
                ident, r'FlightCandidateEntity', 'ident'),
            origin: origin.build(),
            destination: destination.build(),
            scheduledOut: scheduledOut,
            scheduledOff: scheduledOff,
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FlightCandidateEntity', 'status'),
            airline: airline.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'origin';
        origin.build();
        _$failedField = 'destination';
        destination.build();

        _$failedField = 'airline';
        airline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightCandidateEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
