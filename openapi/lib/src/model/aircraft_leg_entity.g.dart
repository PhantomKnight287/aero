// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_leg_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftLegEntity extends AircraftLegEntity {
  @override
  final String faFlightId;
  @override
  final String ident;
  @override
  final String? identIata;
  @override
  final String? identIcao;
  @override
  final String status;
  @override
  final String? originIata;
  @override
  final String? originIcao;
  @override
  final String? originCity;
  @override
  final String? originTimezone;
  @override
  final String? destinationIata;
  @override
  final String? destinationIcao;
  @override
  final String? destinationCity;
  @override
  final String? destinationTimezone;
  @override
  final String? scheduledOut;
  @override
  final String? estimatedOut;
  @override
  final String? actualOut;
  @override
  final String? scheduledIn;
  @override
  final String? estimatedIn;
  @override
  final String? actualIn;
  @override
  final num? arrivalDelay;
  @override
  final num? progressPercent;
  @override
  final bool cancelled;

  factory _$AircraftLegEntity(
          [void Function(AircraftLegEntityBuilder)? updates]) =>
      (AircraftLegEntityBuilder()..update(updates))._build();

  _$AircraftLegEntity._(
      {required this.faFlightId,
      required this.ident,
      this.identIata,
      this.identIcao,
      required this.status,
      this.originIata,
      this.originIcao,
      this.originCity,
      this.originTimezone,
      this.destinationIata,
      this.destinationIcao,
      this.destinationCity,
      this.destinationTimezone,
      this.scheduledOut,
      this.estimatedOut,
      this.actualOut,
      this.scheduledIn,
      this.estimatedIn,
      this.actualIn,
      this.arrivalDelay,
      this.progressPercent,
      required this.cancelled})
      : super._();
  @override
  AircraftLegEntity rebuild(void Function(AircraftLegEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftLegEntityBuilder toBuilder() =>
      AircraftLegEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftLegEntity &&
        faFlightId == other.faFlightId &&
        ident == other.ident &&
        identIata == other.identIata &&
        identIcao == other.identIcao &&
        status == other.status &&
        originIata == other.originIata &&
        originIcao == other.originIcao &&
        originCity == other.originCity &&
        originTimezone == other.originTimezone &&
        destinationIata == other.destinationIata &&
        destinationIcao == other.destinationIcao &&
        destinationCity == other.destinationCity &&
        destinationTimezone == other.destinationTimezone &&
        scheduledOut == other.scheduledOut &&
        estimatedOut == other.estimatedOut &&
        actualOut == other.actualOut &&
        scheduledIn == other.scheduledIn &&
        estimatedIn == other.estimatedIn &&
        actualIn == other.actualIn &&
        arrivalDelay == other.arrivalDelay &&
        progressPercent == other.progressPercent &&
        cancelled == other.cancelled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, faFlightId.hashCode);
    _$hash = $jc(_$hash, ident.hashCode);
    _$hash = $jc(_$hash, identIata.hashCode);
    _$hash = $jc(_$hash, identIcao.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, originIata.hashCode);
    _$hash = $jc(_$hash, originIcao.hashCode);
    _$hash = $jc(_$hash, originCity.hashCode);
    _$hash = $jc(_$hash, originTimezone.hashCode);
    _$hash = $jc(_$hash, destinationIata.hashCode);
    _$hash = $jc(_$hash, destinationIcao.hashCode);
    _$hash = $jc(_$hash, destinationCity.hashCode);
    _$hash = $jc(_$hash, destinationTimezone.hashCode);
    _$hash = $jc(_$hash, scheduledOut.hashCode);
    _$hash = $jc(_$hash, estimatedOut.hashCode);
    _$hash = $jc(_$hash, actualOut.hashCode);
    _$hash = $jc(_$hash, scheduledIn.hashCode);
    _$hash = $jc(_$hash, estimatedIn.hashCode);
    _$hash = $jc(_$hash, actualIn.hashCode);
    _$hash = $jc(_$hash, arrivalDelay.hashCode);
    _$hash = $jc(_$hash, progressPercent.hashCode);
    _$hash = $jc(_$hash, cancelled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftLegEntity')
          ..add('faFlightId', faFlightId)
          ..add('ident', ident)
          ..add('identIata', identIata)
          ..add('identIcao', identIcao)
          ..add('status', status)
          ..add('originIata', originIata)
          ..add('originIcao', originIcao)
          ..add('originCity', originCity)
          ..add('originTimezone', originTimezone)
          ..add('destinationIata', destinationIata)
          ..add('destinationIcao', destinationIcao)
          ..add('destinationCity', destinationCity)
          ..add('destinationTimezone', destinationTimezone)
          ..add('scheduledOut', scheduledOut)
          ..add('estimatedOut', estimatedOut)
          ..add('actualOut', actualOut)
          ..add('scheduledIn', scheduledIn)
          ..add('estimatedIn', estimatedIn)
          ..add('actualIn', actualIn)
          ..add('arrivalDelay', arrivalDelay)
          ..add('progressPercent', progressPercent)
          ..add('cancelled', cancelled))
        .toString();
  }
}

class AircraftLegEntityBuilder
    implements Builder<AircraftLegEntity, AircraftLegEntityBuilder> {
  _$AircraftLegEntity? _$v;

  String? _faFlightId;
  String? get faFlightId => _$this._faFlightId;
  set faFlightId(String? faFlightId) => _$this._faFlightId = faFlightId;

  String? _ident;
  String? get ident => _$this._ident;
  set ident(String? ident) => _$this._ident = ident;

  String? _identIata;
  String? get identIata => _$this._identIata;
  set identIata(String? identIata) => _$this._identIata = identIata;

  String? _identIcao;
  String? get identIcao => _$this._identIcao;
  set identIcao(String? identIcao) => _$this._identIcao = identIcao;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _originIata;
  String? get originIata => _$this._originIata;
  set originIata(String? originIata) => _$this._originIata = originIata;

  String? _originIcao;
  String? get originIcao => _$this._originIcao;
  set originIcao(String? originIcao) => _$this._originIcao = originIcao;

  String? _originCity;
  String? get originCity => _$this._originCity;
  set originCity(String? originCity) => _$this._originCity = originCity;

  String? _originTimezone;
  String? get originTimezone => _$this._originTimezone;
  set originTimezone(String? originTimezone) =>
      _$this._originTimezone = originTimezone;

  String? _destinationIata;
  String? get destinationIata => _$this._destinationIata;
  set destinationIata(String? destinationIata) =>
      _$this._destinationIata = destinationIata;

  String? _destinationIcao;
  String? get destinationIcao => _$this._destinationIcao;
  set destinationIcao(String? destinationIcao) =>
      _$this._destinationIcao = destinationIcao;

  String? _destinationCity;
  String? get destinationCity => _$this._destinationCity;
  set destinationCity(String? destinationCity) =>
      _$this._destinationCity = destinationCity;

  String? _destinationTimezone;
  String? get destinationTimezone => _$this._destinationTimezone;
  set destinationTimezone(String? destinationTimezone) =>
      _$this._destinationTimezone = destinationTimezone;

  String? _scheduledOut;
  String? get scheduledOut => _$this._scheduledOut;
  set scheduledOut(String? scheduledOut) => _$this._scheduledOut = scheduledOut;

  String? _estimatedOut;
  String? get estimatedOut => _$this._estimatedOut;
  set estimatedOut(String? estimatedOut) => _$this._estimatedOut = estimatedOut;

  String? _actualOut;
  String? get actualOut => _$this._actualOut;
  set actualOut(String? actualOut) => _$this._actualOut = actualOut;

  String? _scheduledIn;
  String? get scheduledIn => _$this._scheduledIn;
  set scheduledIn(String? scheduledIn) => _$this._scheduledIn = scheduledIn;

  String? _estimatedIn;
  String? get estimatedIn => _$this._estimatedIn;
  set estimatedIn(String? estimatedIn) => _$this._estimatedIn = estimatedIn;

  String? _actualIn;
  String? get actualIn => _$this._actualIn;
  set actualIn(String? actualIn) => _$this._actualIn = actualIn;

  num? _arrivalDelay;
  num? get arrivalDelay => _$this._arrivalDelay;
  set arrivalDelay(num? arrivalDelay) => _$this._arrivalDelay = arrivalDelay;

  num? _progressPercent;
  num? get progressPercent => _$this._progressPercent;
  set progressPercent(num? progressPercent) =>
      _$this._progressPercent = progressPercent;

  bool? _cancelled;
  bool? get cancelled => _$this._cancelled;
  set cancelled(bool? cancelled) => _$this._cancelled = cancelled;

  AircraftLegEntityBuilder() {
    AircraftLegEntity._defaults(this);
  }

  AircraftLegEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _faFlightId = $v.faFlightId;
      _ident = $v.ident;
      _identIata = $v.identIata;
      _identIcao = $v.identIcao;
      _status = $v.status;
      _originIata = $v.originIata;
      _originIcao = $v.originIcao;
      _originCity = $v.originCity;
      _originTimezone = $v.originTimezone;
      _destinationIata = $v.destinationIata;
      _destinationIcao = $v.destinationIcao;
      _destinationCity = $v.destinationCity;
      _destinationTimezone = $v.destinationTimezone;
      _scheduledOut = $v.scheduledOut;
      _estimatedOut = $v.estimatedOut;
      _actualOut = $v.actualOut;
      _scheduledIn = $v.scheduledIn;
      _estimatedIn = $v.estimatedIn;
      _actualIn = $v.actualIn;
      _arrivalDelay = $v.arrivalDelay;
      _progressPercent = $v.progressPercent;
      _cancelled = $v.cancelled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftLegEntity other) {
    _$v = other as _$AircraftLegEntity;
  }

  @override
  void update(void Function(AircraftLegEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftLegEntity build() => _build();

  _$AircraftLegEntity _build() {
    final _$result = _$v ??
        _$AircraftLegEntity._(
          faFlightId: BuiltValueNullFieldError.checkNotNull(
              faFlightId, r'AircraftLegEntity', 'faFlightId'),
          ident: BuiltValueNullFieldError.checkNotNull(
              ident, r'AircraftLegEntity', 'ident'),
          identIata: identIata,
          identIcao: identIcao,
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'AircraftLegEntity', 'status'),
          originIata: originIata,
          originIcao: originIcao,
          originCity: originCity,
          originTimezone: originTimezone,
          destinationIata: destinationIata,
          destinationIcao: destinationIcao,
          destinationCity: destinationCity,
          destinationTimezone: destinationTimezone,
          scheduledOut: scheduledOut,
          estimatedOut: estimatedOut,
          actualOut: actualOut,
          scheduledIn: scheduledIn,
          estimatedIn: estimatedIn,
          actualIn: actualIn,
          arrivalDelay: arrivalDelay,
          progressPercent: progressPercent,
          cancelled: BuiltValueNullFieldError.checkNotNull(
              cancelled, r'AircraftLegEntity', 'cancelled'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
