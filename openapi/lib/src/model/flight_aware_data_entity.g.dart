// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_aware_data_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightAwareDataEntity extends FlightAwareDataEntity {
  @override
  final String id;
  @override
  final String ident;
  @override
  final String? identIcao;
  @override
  final String? identIata;
  @override
  final String? actualRunwayOff;
  @override
  final String? actualRunwayOn;
  @override
  final String? operator_;
  @override
  final String? operatorIcao;
  @override
  final String? operatorIata;
  @override
  final String? flightNumber;
  @override
  final String? registration;
  @override
  final String? atcIdent;
  @override
  final String? inboundFaFlightId;
  @override
  final BuiltList<String>? codesharesIata;
  @override
  final BuiltList<String>? codesharesIcao;
  @override
  final num? departureDelay;
  @override
  final num? arrivalDelay;
  @override
  final num? filedEte;
  @override
  final num? progressPercent;
  @override
  final String status;
  @override
  final String? aircraftType;
  @override
  final num? routeDistance;
  @override
  final num? filedAirspeed;
  @override
  final num? filedAltitude;
  @override
  final String? route;
  @override
  final String? baggageClaim;
  @override
  final num? seatsCabinBusiness;
  @override
  final num? seatsCabinCoach;
  @override
  final num? seatsCabinFirst;
  @override
  final String? gateOrigin;
  @override
  final String? gateDestination;
  @override
  final String? terminalOrigin;
  @override
  final String? terminalDestination;
  @override
  final DateTime? scheduledOut;
  @override
  final DateTime? estimatedOut;
  @override
  final DateTime? actualOut;
  @override
  final DateTime? scheduledOff;
  @override
  final DateTime? estimatedOff;
  @override
  final DateTime? actualOff;
  @override
  final DateTime? scheduledOn;
  @override
  final DateTime? estimatedOn;
  @override
  final DateTime? actualOn;
  @override
  final DateTime? scheduledIn;
  @override
  final DateTime? estimatedIn;
  @override
  final DateTime? actualIn;
  @override
  final bool foresightPredictionsAvailable;
  @override
  final bool blocked;
  @override
  final bool diverted;
  @override
  final bool cancelled;
  @override
  final bool positionOnly;
  @override
  final String? originCode;
  @override
  final String? originCodeIcao;
  @override
  final String? originCodeIata;
  @override
  final String? originCodeLid;
  @override
  final String? originTimezone;
  @override
  final String? originName;
  @override
  final String? originCity;
  @override
  final String? destinationCode;
  @override
  final String? destinationCodeIcao;
  @override
  final String? destinationCodeIata;
  @override
  final String? destinationCodeLid;
  @override
  final String? destinationTimezone;
  @override
  final String? destinationName;
  @override
  final String? destinationCity;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$FlightAwareDataEntity(
          [void Function(FlightAwareDataEntityBuilder)? updates]) =>
      (FlightAwareDataEntityBuilder()..update(updates))._build();

  _$FlightAwareDataEntity._(
      {required this.id,
      required this.ident,
      this.identIcao,
      this.identIata,
      this.actualRunwayOff,
      this.actualRunwayOn,
      this.operator_,
      this.operatorIcao,
      this.operatorIata,
      this.flightNumber,
      this.registration,
      this.atcIdent,
      this.inboundFaFlightId,
      this.codesharesIata,
      this.codesharesIcao,
      this.departureDelay,
      this.arrivalDelay,
      this.filedEte,
      this.progressPercent,
      required this.status,
      this.aircraftType,
      this.routeDistance,
      this.filedAirspeed,
      this.filedAltitude,
      this.route,
      this.baggageClaim,
      this.seatsCabinBusiness,
      this.seatsCabinCoach,
      this.seatsCabinFirst,
      this.gateOrigin,
      this.gateDestination,
      this.terminalOrigin,
      this.terminalDestination,
      this.scheduledOut,
      this.estimatedOut,
      this.actualOut,
      this.scheduledOff,
      this.estimatedOff,
      this.actualOff,
      this.scheduledOn,
      this.estimatedOn,
      this.actualOn,
      this.scheduledIn,
      this.estimatedIn,
      this.actualIn,
      required this.foresightPredictionsAvailable,
      required this.blocked,
      required this.diverted,
      required this.cancelled,
      required this.positionOnly,
      this.originCode,
      this.originCodeIcao,
      this.originCodeIata,
      this.originCodeLid,
      this.originTimezone,
      this.originName,
      this.originCity,
      this.destinationCode,
      this.destinationCodeIcao,
      this.destinationCodeIata,
      this.destinationCodeLid,
      this.destinationTimezone,
      this.destinationName,
      this.destinationCity,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  FlightAwareDataEntity rebuild(
          void Function(FlightAwareDataEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightAwareDataEntityBuilder toBuilder() =>
      FlightAwareDataEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightAwareDataEntity &&
        id == other.id &&
        ident == other.ident &&
        identIcao == other.identIcao &&
        identIata == other.identIata &&
        actualRunwayOff == other.actualRunwayOff &&
        actualRunwayOn == other.actualRunwayOn &&
        operator_ == other.operator_ &&
        operatorIcao == other.operatorIcao &&
        operatorIata == other.operatorIata &&
        flightNumber == other.flightNumber &&
        registration == other.registration &&
        atcIdent == other.atcIdent &&
        inboundFaFlightId == other.inboundFaFlightId &&
        codesharesIata == other.codesharesIata &&
        codesharesIcao == other.codesharesIcao &&
        departureDelay == other.departureDelay &&
        arrivalDelay == other.arrivalDelay &&
        filedEte == other.filedEte &&
        progressPercent == other.progressPercent &&
        status == other.status &&
        aircraftType == other.aircraftType &&
        routeDistance == other.routeDistance &&
        filedAirspeed == other.filedAirspeed &&
        filedAltitude == other.filedAltitude &&
        route == other.route &&
        baggageClaim == other.baggageClaim &&
        seatsCabinBusiness == other.seatsCabinBusiness &&
        seatsCabinCoach == other.seatsCabinCoach &&
        seatsCabinFirst == other.seatsCabinFirst &&
        gateOrigin == other.gateOrigin &&
        gateDestination == other.gateDestination &&
        terminalOrigin == other.terminalOrigin &&
        terminalDestination == other.terminalDestination &&
        scheduledOut == other.scheduledOut &&
        estimatedOut == other.estimatedOut &&
        actualOut == other.actualOut &&
        scheduledOff == other.scheduledOff &&
        estimatedOff == other.estimatedOff &&
        actualOff == other.actualOff &&
        scheduledOn == other.scheduledOn &&
        estimatedOn == other.estimatedOn &&
        actualOn == other.actualOn &&
        scheduledIn == other.scheduledIn &&
        estimatedIn == other.estimatedIn &&
        actualIn == other.actualIn &&
        foresightPredictionsAvailable == other.foresightPredictionsAvailable &&
        blocked == other.blocked &&
        diverted == other.diverted &&
        cancelled == other.cancelled &&
        positionOnly == other.positionOnly &&
        originCode == other.originCode &&
        originCodeIcao == other.originCodeIcao &&
        originCodeIata == other.originCodeIata &&
        originCodeLid == other.originCodeLid &&
        originTimezone == other.originTimezone &&
        originName == other.originName &&
        originCity == other.originCity &&
        destinationCode == other.destinationCode &&
        destinationCodeIcao == other.destinationCodeIcao &&
        destinationCodeIata == other.destinationCodeIata &&
        destinationCodeLid == other.destinationCodeLid &&
        destinationTimezone == other.destinationTimezone &&
        destinationName == other.destinationName &&
        destinationCity == other.destinationCity &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, ident.hashCode);
    _$hash = $jc(_$hash, identIcao.hashCode);
    _$hash = $jc(_$hash, identIata.hashCode);
    _$hash = $jc(_$hash, actualRunwayOff.hashCode);
    _$hash = $jc(_$hash, actualRunwayOn.hashCode);
    _$hash = $jc(_$hash, operator_.hashCode);
    _$hash = $jc(_$hash, operatorIcao.hashCode);
    _$hash = $jc(_$hash, operatorIata.hashCode);
    _$hash = $jc(_$hash, flightNumber.hashCode);
    _$hash = $jc(_$hash, registration.hashCode);
    _$hash = $jc(_$hash, atcIdent.hashCode);
    _$hash = $jc(_$hash, inboundFaFlightId.hashCode);
    _$hash = $jc(_$hash, codesharesIata.hashCode);
    _$hash = $jc(_$hash, codesharesIcao.hashCode);
    _$hash = $jc(_$hash, departureDelay.hashCode);
    _$hash = $jc(_$hash, arrivalDelay.hashCode);
    _$hash = $jc(_$hash, filedEte.hashCode);
    _$hash = $jc(_$hash, progressPercent.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, aircraftType.hashCode);
    _$hash = $jc(_$hash, routeDistance.hashCode);
    _$hash = $jc(_$hash, filedAirspeed.hashCode);
    _$hash = $jc(_$hash, filedAltitude.hashCode);
    _$hash = $jc(_$hash, route.hashCode);
    _$hash = $jc(_$hash, baggageClaim.hashCode);
    _$hash = $jc(_$hash, seatsCabinBusiness.hashCode);
    _$hash = $jc(_$hash, seatsCabinCoach.hashCode);
    _$hash = $jc(_$hash, seatsCabinFirst.hashCode);
    _$hash = $jc(_$hash, gateOrigin.hashCode);
    _$hash = $jc(_$hash, gateDestination.hashCode);
    _$hash = $jc(_$hash, terminalOrigin.hashCode);
    _$hash = $jc(_$hash, terminalDestination.hashCode);
    _$hash = $jc(_$hash, scheduledOut.hashCode);
    _$hash = $jc(_$hash, estimatedOut.hashCode);
    _$hash = $jc(_$hash, actualOut.hashCode);
    _$hash = $jc(_$hash, scheduledOff.hashCode);
    _$hash = $jc(_$hash, estimatedOff.hashCode);
    _$hash = $jc(_$hash, actualOff.hashCode);
    _$hash = $jc(_$hash, scheduledOn.hashCode);
    _$hash = $jc(_$hash, estimatedOn.hashCode);
    _$hash = $jc(_$hash, actualOn.hashCode);
    _$hash = $jc(_$hash, scheduledIn.hashCode);
    _$hash = $jc(_$hash, estimatedIn.hashCode);
    _$hash = $jc(_$hash, actualIn.hashCode);
    _$hash = $jc(_$hash, foresightPredictionsAvailable.hashCode);
    _$hash = $jc(_$hash, blocked.hashCode);
    _$hash = $jc(_$hash, diverted.hashCode);
    _$hash = $jc(_$hash, cancelled.hashCode);
    _$hash = $jc(_$hash, positionOnly.hashCode);
    _$hash = $jc(_$hash, originCode.hashCode);
    _$hash = $jc(_$hash, originCodeIcao.hashCode);
    _$hash = $jc(_$hash, originCodeIata.hashCode);
    _$hash = $jc(_$hash, originCodeLid.hashCode);
    _$hash = $jc(_$hash, originTimezone.hashCode);
    _$hash = $jc(_$hash, originName.hashCode);
    _$hash = $jc(_$hash, originCity.hashCode);
    _$hash = $jc(_$hash, destinationCode.hashCode);
    _$hash = $jc(_$hash, destinationCodeIcao.hashCode);
    _$hash = $jc(_$hash, destinationCodeIata.hashCode);
    _$hash = $jc(_$hash, destinationCodeLid.hashCode);
    _$hash = $jc(_$hash, destinationTimezone.hashCode);
    _$hash = $jc(_$hash, destinationName.hashCode);
    _$hash = $jc(_$hash, destinationCity.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightAwareDataEntity')
          ..add('id', id)
          ..add('ident', ident)
          ..add('identIcao', identIcao)
          ..add('identIata', identIata)
          ..add('actualRunwayOff', actualRunwayOff)
          ..add('actualRunwayOn', actualRunwayOn)
          ..add('operator_', operator_)
          ..add('operatorIcao', operatorIcao)
          ..add('operatorIata', operatorIata)
          ..add('flightNumber', flightNumber)
          ..add('registration', registration)
          ..add('atcIdent', atcIdent)
          ..add('inboundFaFlightId', inboundFaFlightId)
          ..add('codesharesIata', codesharesIata)
          ..add('codesharesIcao', codesharesIcao)
          ..add('departureDelay', departureDelay)
          ..add('arrivalDelay', arrivalDelay)
          ..add('filedEte', filedEte)
          ..add('progressPercent', progressPercent)
          ..add('status', status)
          ..add('aircraftType', aircraftType)
          ..add('routeDistance', routeDistance)
          ..add('filedAirspeed', filedAirspeed)
          ..add('filedAltitude', filedAltitude)
          ..add('route', route)
          ..add('baggageClaim', baggageClaim)
          ..add('seatsCabinBusiness', seatsCabinBusiness)
          ..add('seatsCabinCoach', seatsCabinCoach)
          ..add('seatsCabinFirst', seatsCabinFirst)
          ..add('gateOrigin', gateOrigin)
          ..add('gateDestination', gateDestination)
          ..add('terminalOrigin', terminalOrigin)
          ..add('terminalDestination', terminalDestination)
          ..add('scheduledOut', scheduledOut)
          ..add('estimatedOut', estimatedOut)
          ..add('actualOut', actualOut)
          ..add('scheduledOff', scheduledOff)
          ..add('estimatedOff', estimatedOff)
          ..add('actualOff', actualOff)
          ..add('scheduledOn', scheduledOn)
          ..add('estimatedOn', estimatedOn)
          ..add('actualOn', actualOn)
          ..add('scheduledIn', scheduledIn)
          ..add('estimatedIn', estimatedIn)
          ..add('actualIn', actualIn)
          ..add('foresightPredictionsAvailable', foresightPredictionsAvailable)
          ..add('blocked', blocked)
          ..add('diverted', diverted)
          ..add('cancelled', cancelled)
          ..add('positionOnly', positionOnly)
          ..add('originCode', originCode)
          ..add('originCodeIcao', originCodeIcao)
          ..add('originCodeIata', originCodeIata)
          ..add('originCodeLid', originCodeLid)
          ..add('originTimezone', originTimezone)
          ..add('originName', originName)
          ..add('originCity', originCity)
          ..add('destinationCode', destinationCode)
          ..add('destinationCodeIcao', destinationCodeIcao)
          ..add('destinationCodeIata', destinationCodeIata)
          ..add('destinationCodeLid', destinationCodeLid)
          ..add('destinationTimezone', destinationTimezone)
          ..add('destinationName', destinationName)
          ..add('destinationCity', destinationCity)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class FlightAwareDataEntityBuilder
    implements Builder<FlightAwareDataEntity, FlightAwareDataEntityBuilder> {
  _$FlightAwareDataEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _ident;
  String? get ident => _$this._ident;
  set ident(String? ident) => _$this._ident = ident;

  String? _identIcao;
  String? get identIcao => _$this._identIcao;
  set identIcao(String? identIcao) => _$this._identIcao = identIcao;

  String? _identIata;
  String? get identIata => _$this._identIata;
  set identIata(String? identIata) => _$this._identIata = identIata;

  String? _actualRunwayOff;
  String? get actualRunwayOff => _$this._actualRunwayOff;
  set actualRunwayOff(String? actualRunwayOff) =>
      _$this._actualRunwayOff = actualRunwayOff;

  String? _actualRunwayOn;
  String? get actualRunwayOn => _$this._actualRunwayOn;
  set actualRunwayOn(String? actualRunwayOn) =>
      _$this._actualRunwayOn = actualRunwayOn;

  String? _operator_;
  String? get operator_ => _$this._operator_;
  set operator_(String? operator_) => _$this._operator_ = operator_;

  String? _operatorIcao;
  String? get operatorIcao => _$this._operatorIcao;
  set operatorIcao(String? operatorIcao) => _$this._operatorIcao = operatorIcao;

  String? _operatorIata;
  String? get operatorIata => _$this._operatorIata;
  set operatorIata(String? operatorIata) => _$this._operatorIata = operatorIata;

  String? _flightNumber;
  String? get flightNumber => _$this._flightNumber;
  set flightNumber(String? flightNumber) => _$this._flightNumber = flightNumber;

  String? _registration;
  String? get registration => _$this._registration;
  set registration(String? registration) => _$this._registration = registration;

  String? _atcIdent;
  String? get atcIdent => _$this._atcIdent;
  set atcIdent(String? atcIdent) => _$this._atcIdent = atcIdent;

  String? _inboundFaFlightId;
  String? get inboundFaFlightId => _$this._inboundFaFlightId;
  set inboundFaFlightId(String? inboundFaFlightId) =>
      _$this._inboundFaFlightId = inboundFaFlightId;

  ListBuilder<String>? _codesharesIata;
  ListBuilder<String> get codesharesIata =>
      _$this._codesharesIata ??= ListBuilder<String>();
  set codesharesIata(ListBuilder<String>? codesharesIata) =>
      _$this._codesharesIata = codesharesIata;

  ListBuilder<String>? _codesharesIcao;
  ListBuilder<String> get codesharesIcao =>
      _$this._codesharesIcao ??= ListBuilder<String>();
  set codesharesIcao(ListBuilder<String>? codesharesIcao) =>
      _$this._codesharesIcao = codesharesIcao;

  num? _departureDelay;
  num? get departureDelay => _$this._departureDelay;
  set departureDelay(num? departureDelay) =>
      _$this._departureDelay = departureDelay;

  num? _arrivalDelay;
  num? get arrivalDelay => _$this._arrivalDelay;
  set arrivalDelay(num? arrivalDelay) => _$this._arrivalDelay = arrivalDelay;

  num? _filedEte;
  num? get filedEte => _$this._filedEte;
  set filedEte(num? filedEte) => _$this._filedEte = filedEte;

  num? _progressPercent;
  num? get progressPercent => _$this._progressPercent;
  set progressPercent(num? progressPercent) =>
      _$this._progressPercent = progressPercent;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _aircraftType;
  String? get aircraftType => _$this._aircraftType;
  set aircraftType(String? aircraftType) => _$this._aircraftType = aircraftType;

  num? _routeDistance;
  num? get routeDistance => _$this._routeDistance;
  set routeDistance(num? routeDistance) =>
      _$this._routeDistance = routeDistance;

  num? _filedAirspeed;
  num? get filedAirspeed => _$this._filedAirspeed;
  set filedAirspeed(num? filedAirspeed) =>
      _$this._filedAirspeed = filedAirspeed;

  num? _filedAltitude;
  num? get filedAltitude => _$this._filedAltitude;
  set filedAltitude(num? filedAltitude) =>
      _$this._filedAltitude = filedAltitude;

  String? _route;
  String? get route => _$this._route;
  set route(String? route) => _$this._route = route;

  String? _baggageClaim;
  String? get baggageClaim => _$this._baggageClaim;
  set baggageClaim(String? baggageClaim) => _$this._baggageClaim = baggageClaim;

  num? _seatsCabinBusiness;
  num? get seatsCabinBusiness => _$this._seatsCabinBusiness;
  set seatsCabinBusiness(num? seatsCabinBusiness) =>
      _$this._seatsCabinBusiness = seatsCabinBusiness;

  num? _seatsCabinCoach;
  num? get seatsCabinCoach => _$this._seatsCabinCoach;
  set seatsCabinCoach(num? seatsCabinCoach) =>
      _$this._seatsCabinCoach = seatsCabinCoach;

  num? _seatsCabinFirst;
  num? get seatsCabinFirst => _$this._seatsCabinFirst;
  set seatsCabinFirst(num? seatsCabinFirst) =>
      _$this._seatsCabinFirst = seatsCabinFirst;

  String? _gateOrigin;
  String? get gateOrigin => _$this._gateOrigin;
  set gateOrigin(String? gateOrigin) => _$this._gateOrigin = gateOrigin;

  String? _gateDestination;
  String? get gateDestination => _$this._gateDestination;
  set gateDestination(String? gateDestination) =>
      _$this._gateDestination = gateDestination;

  String? _terminalOrigin;
  String? get terminalOrigin => _$this._terminalOrigin;
  set terminalOrigin(String? terminalOrigin) =>
      _$this._terminalOrigin = terminalOrigin;

  String? _terminalDestination;
  String? get terminalDestination => _$this._terminalDestination;
  set terminalDestination(String? terminalDestination) =>
      _$this._terminalDestination = terminalDestination;

  DateTime? _scheduledOut;
  DateTime? get scheduledOut => _$this._scheduledOut;
  set scheduledOut(DateTime? scheduledOut) =>
      _$this._scheduledOut = scheduledOut;

  DateTime? _estimatedOut;
  DateTime? get estimatedOut => _$this._estimatedOut;
  set estimatedOut(DateTime? estimatedOut) =>
      _$this._estimatedOut = estimatedOut;

  DateTime? _actualOut;
  DateTime? get actualOut => _$this._actualOut;
  set actualOut(DateTime? actualOut) => _$this._actualOut = actualOut;

  DateTime? _scheduledOff;
  DateTime? get scheduledOff => _$this._scheduledOff;
  set scheduledOff(DateTime? scheduledOff) =>
      _$this._scheduledOff = scheduledOff;

  DateTime? _estimatedOff;
  DateTime? get estimatedOff => _$this._estimatedOff;
  set estimatedOff(DateTime? estimatedOff) =>
      _$this._estimatedOff = estimatedOff;

  DateTime? _actualOff;
  DateTime? get actualOff => _$this._actualOff;
  set actualOff(DateTime? actualOff) => _$this._actualOff = actualOff;

  DateTime? _scheduledOn;
  DateTime? get scheduledOn => _$this._scheduledOn;
  set scheduledOn(DateTime? scheduledOn) => _$this._scheduledOn = scheduledOn;

  DateTime? _estimatedOn;
  DateTime? get estimatedOn => _$this._estimatedOn;
  set estimatedOn(DateTime? estimatedOn) => _$this._estimatedOn = estimatedOn;

  DateTime? _actualOn;
  DateTime? get actualOn => _$this._actualOn;
  set actualOn(DateTime? actualOn) => _$this._actualOn = actualOn;

  DateTime? _scheduledIn;
  DateTime? get scheduledIn => _$this._scheduledIn;
  set scheduledIn(DateTime? scheduledIn) => _$this._scheduledIn = scheduledIn;

  DateTime? _estimatedIn;
  DateTime? get estimatedIn => _$this._estimatedIn;
  set estimatedIn(DateTime? estimatedIn) => _$this._estimatedIn = estimatedIn;

  DateTime? _actualIn;
  DateTime? get actualIn => _$this._actualIn;
  set actualIn(DateTime? actualIn) => _$this._actualIn = actualIn;

  bool? _foresightPredictionsAvailable;
  bool? get foresightPredictionsAvailable =>
      _$this._foresightPredictionsAvailable;
  set foresightPredictionsAvailable(bool? foresightPredictionsAvailable) =>
      _$this._foresightPredictionsAvailable = foresightPredictionsAvailable;

  bool? _blocked;
  bool? get blocked => _$this._blocked;
  set blocked(bool? blocked) => _$this._blocked = blocked;

  bool? _diverted;
  bool? get diverted => _$this._diverted;
  set diverted(bool? diverted) => _$this._diverted = diverted;

  bool? _cancelled;
  bool? get cancelled => _$this._cancelled;
  set cancelled(bool? cancelled) => _$this._cancelled = cancelled;

  bool? _positionOnly;
  bool? get positionOnly => _$this._positionOnly;
  set positionOnly(bool? positionOnly) => _$this._positionOnly = positionOnly;

  String? _originCode;
  String? get originCode => _$this._originCode;
  set originCode(String? originCode) => _$this._originCode = originCode;

  String? _originCodeIcao;
  String? get originCodeIcao => _$this._originCodeIcao;
  set originCodeIcao(String? originCodeIcao) =>
      _$this._originCodeIcao = originCodeIcao;

  String? _originCodeIata;
  String? get originCodeIata => _$this._originCodeIata;
  set originCodeIata(String? originCodeIata) =>
      _$this._originCodeIata = originCodeIata;

  String? _originCodeLid;
  String? get originCodeLid => _$this._originCodeLid;
  set originCodeLid(String? originCodeLid) =>
      _$this._originCodeLid = originCodeLid;

  String? _originTimezone;
  String? get originTimezone => _$this._originTimezone;
  set originTimezone(String? originTimezone) =>
      _$this._originTimezone = originTimezone;

  String? _originName;
  String? get originName => _$this._originName;
  set originName(String? originName) => _$this._originName = originName;

  String? _originCity;
  String? get originCity => _$this._originCity;
  set originCity(String? originCity) => _$this._originCity = originCity;

  String? _destinationCode;
  String? get destinationCode => _$this._destinationCode;
  set destinationCode(String? destinationCode) =>
      _$this._destinationCode = destinationCode;

  String? _destinationCodeIcao;
  String? get destinationCodeIcao => _$this._destinationCodeIcao;
  set destinationCodeIcao(String? destinationCodeIcao) =>
      _$this._destinationCodeIcao = destinationCodeIcao;

  String? _destinationCodeIata;
  String? get destinationCodeIata => _$this._destinationCodeIata;
  set destinationCodeIata(String? destinationCodeIata) =>
      _$this._destinationCodeIata = destinationCodeIata;

  String? _destinationCodeLid;
  String? get destinationCodeLid => _$this._destinationCodeLid;
  set destinationCodeLid(String? destinationCodeLid) =>
      _$this._destinationCodeLid = destinationCodeLid;

  String? _destinationTimezone;
  String? get destinationTimezone => _$this._destinationTimezone;
  set destinationTimezone(String? destinationTimezone) =>
      _$this._destinationTimezone = destinationTimezone;

  String? _destinationName;
  String? get destinationName => _$this._destinationName;
  set destinationName(String? destinationName) =>
      _$this._destinationName = destinationName;

  String? _destinationCity;
  String? get destinationCity => _$this._destinationCity;
  set destinationCity(String? destinationCity) =>
      _$this._destinationCity = destinationCity;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  FlightAwareDataEntityBuilder() {
    FlightAwareDataEntity._defaults(this);
  }

  FlightAwareDataEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _ident = $v.ident;
      _identIcao = $v.identIcao;
      _identIata = $v.identIata;
      _actualRunwayOff = $v.actualRunwayOff;
      _actualRunwayOn = $v.actualRunwayOn;
      _operator_ = $v.operator_;
      _operatorIcao = $v.operatorIcao;
      _operatorIata = $v.operatorIata;
      _flightNumber = $v.flightNumber;
      _registration = $v.registration;
      _atcIdent = $v.atcIdent;
      _inboundFaFlightId = $v.inboundFaFlightId;
      _codesharesIata = $v.codesharesIata?.toBuilder();
      _codesharesIcao = $v.codesharesIcao?.toBuilder();
      _departureDelay = $v.departureDelay;
      _arrivalDelay = $v.arrivalDelay;
      _filedEte = $v.filedEte;
      _progressPercent = $v.progressPercent;
      _status = $v.status;
      _aircraftType = $v.aircraftType;
      _routeDistance = $v.routeDistance;
      _filedAirspeed = $v.filedAirspeed;
      _filedAltitude = $v.filedAltitude;
      _route = $v.route;
      _baggageClaim = $v.baggageClaim;
      _seatsCabinBusiness = $v.seatsCabinBusiness;
      _seatsCabinCoach = $v.seatsCabinCoach;
      _seatsCabinFirst = $v.seatsCabinFirst;
      _gateOrigin = $v.gateOrigin;
      _gateDestination = $v.gateDestination;
      _terminalOrigin = $v.terminalOrigin;
      _terminalDestination = $v.terminalDestination;
      _scheduledOut = $v.scheduledOut;
      _estimatedOut = $v.estimatedOut;
      _actualOut = $v.actualOut;
      _scheduledOff = $v.scheduledOff;
      _estimatedOff = $v.estimatedOff;
      _actualOff = $v.actualOff;
      _scheduledOn = $v.scheduledOn;
      _estimatedOn = $v.estimatedOn;
      _actualOn = $v.actualOn;
      _scheduledIn = $v.scheduledIn;
      _estimatedIn = $v.estimatedIn;
      _actualIn = $v.actualIn;
      _foresightPredictionsAvailable = $v.foresightPredictionsAvailable;
      _blocked = $v.blocked;
      _diverted = $v.diverted;
      _cancelled = $v.cancelled;
      _positionOnly = $v.positionOnly;
      _originCode = $v.originCode;
      _originCodeIcao = $v.originCodeIcao;
      _originCodeIata = $v.originCodeIata;
      _originCodeLid = $v.originCodeLid;
      _originTimezone = $v.originTimezone;
      _originName = $v.originName;
      _originCity = $v.originCity;
      _destinationCode = $v.destinationCode;
      _destinationCodeIcao = $v.destinationCodeIcao;
      _destinationCodeIata = $v.destinationCodeIata;
      _destinationCodeLid = $v.destinationCodeLid;
      _destinationTimezone = $v.destinationTimezone;
      _destinationName = $v.destinationName;
      _destinationCity = $v.destinationCity;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightAwareDataEntity other) {
    _$v = other as _$FlightAwareDataEntity;
  }

  @override
  void update(void Function(FlightAwareDataEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightAwareDataEntity build() => _build();

  _$FlightAwareDataEntity _build() {
    _$FlightAwareDataEntity _$result;
    try {
      _$result = _$v ??
          _$FlightAwareDataEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'FlightAwareDataEntity', 'id'),
            ident: BuiltValueNullFieldError.checkNotNull(
                ident, r'FlightAwareDataEntity', 'ident'),
            identIcao: identIcao,
            identIata: identIata,
            actualRunwayOff: actualRunwayOff,
            actualRunwayOn: actualRunwayOn,
            operator_: operator_,
            operatorIcao: operatorIcao,
            operatorIata: operatorIata,
            flightNumber: flightNumber,
            registration: registration,
            atcIdent: atcIdent,
            inboundFaFlightId: inboundFaFlightId,
            codesharesIata: _codesharesIata?.build(),
            codesharesIcao: _codesharesIcao?.build(),
            departureDelay: departureDelay,
            arrivalDelay: arrivalDelay,
            filedEte: filedEte,
            progressPercent: progressPercent,
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FlightAwareDataEntity', 'status'),
            aircraftType: aircraftType,
            routeDistance: routeDistance,
            filedAirspeed: filedAirspeed,
            filedAltitude: filedAltitude,
            route: route,
            baggageClaim: baggageClaim,
            seatsCabinBusiness: seatsCabinBusiness,
            seatsCabinCoach: seatsCabinCoach,
            seatsCabinFirst: seatsCabinFirst,
            gateOrigin: gateOrigin,
            gateDestination: gateDestination,
            terminalOrigin: terminalOrigin,
            terminalDestination: terminalDestination,
            scheduledOut: scheduledOut,
            estimatedOut: estimatedOut,
            actualOut: actualOut,
            scheduledOff: scheduledOff,
            estimatedOff: estimatedOff,
            actualOff: actualOff,
            scheduledOn: scheduledOn,
            estimatedOn: estimatedOn,
            actualOn: actualOn,
            scheduledIn: scheduledIn,
            estimatedIn: estimatedIn,
            actualIn: actualIn,
            foresightPredictionsAvailable:
                BuiltValueNullFieldError.checkNotNull(
                    foresightPredictionsAvailable,
                    r'FlightAwareDataEntity',
                    'foresightPredictionsAvailable'),
            blocked: BuiltValueNullFieldError.checkNotNull(
                blocked, r'FlightAwareDataEntity', 'blocked'),
            diverted: BuiltValueNullFieldError.checkNotNull(
                diverted, r'FlightAwareDataEntity', 'diverted'),
            cancelled: BuiltValueNullFieldError.checkNotNull(
                cancelled, r'FlightAwareDataEntity', 'cancelled'),
            positionOnly: BuiltValueNullFieldError.checkNotNull(
                positionOnly, r'FlightAwareDataEntity', 'positionOnly'),
            originCode: originCode,
            originCodeIcao: originCodeIcao,
            originCodeIata: originCodeIata,
            originCodeLid: originCodeLid,
            originTimezone: originTimezone,
            originName: originName,
            originCity: originCity,
            destinationCode: destinationCode,
            destinationCodeIcao: destinationCodeIcao,
            destinationCodeIata: destinationCodeIata,
            destinationCodeLid: destinationCodeLid,
            destinationTimezone: destinationTimezone,
            destinationName: destinationName,
            destinationCity: destinationCity,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'FlightAwareDataEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'FlightAwareDataEntity', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'codesharesIata';
        _codesharesIata?.build();
        _$failedField = 'codesharesIcao';
        _codesharesIcao?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightAwareDataEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
