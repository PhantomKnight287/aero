// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_flight_summary_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatsFlightSummaryEntity extends StatsFlightSummaryEntity {
  @override
  final String id;
  @override
  final String flightNo;
  @override
  final String? identIata;
  @override
  final String? identIcao;
  @override
  final String? faFlightId;
  @override
  final StatsAirlineEntity airline;
  @override
  final StatsAirportEntity departure;
  @override
  final StatsAirportEntity arrival;
  @override
  final String date;
  @override
  final String localDate;

  factory _$StatsFlightSummaryEntity(
          [void Function(StatsFlightSummaryEntityBuilder)? updates]) =>
      (StatsFlightSummaryEntityBuilder()..update(updates))._build();

  _$StatsFlightSummaryEntity._(
      {required this.id,
      required this.flightNo,
      this.identIata,
      this.identIcao,
      this.faFlightId,
      required this.airline,
      required this.departure,
      required this.arrival,
      required this.date,
      required this.localDate})
      : super._();
  @override
  StatsFlightSummaryEntity rebuild(
          void Function(StatsFlightSummaryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatsFlightSummaryEntityBuilder toBuilder() =>
      StatsFlightSummaryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatsFlightSummaryEntity &&
        id == other.id &&
        flightNo == other.flightNo &&
        identIata == other.identIata &&
        identIcao == other.identIcao &&
        faFlightId == other.faFlightId &&
        airline == other.airline &&
        departure == other.departure &&
        arrival == other.arrival &&
        date == other.date &&
        localDate == other.localDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, flightNo.hashCode);
    _$hash = $jc(_$hash, identIata.hashCode);
    _$hash = $jc(_$hash, identIcao.hashCode);
    _$hash = $jc(_$hash, faFlightId.hashCode);
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jc(_$hash, departure.hashCode);
    _$hash = $jc(_$hash, arrival.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, localDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatsFlightSummaryEntity')
          ..add('id', id)
          ..add('flightNo', flightNo)
          ..add('identIata', identIata)
          ..add('identIcao', identIcao)
          ..add('faFlightId', faFlightId)
          ..add('airline', airline)
          ..add('departure', departure)
          ..add('arrival', arrival)
          ..add('date', date)
          ..add('localDate', localDate))
        .toString();
  }
}

class StatsFlightSummaryEntityBuilder
    implements
        Builder<StatsFlightSummaryEntity, StatsFlightSummaryEntityBuilder> {
  _$StatsFlightSummaryEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _flightNo;
  String? get flightNo => _$this._flightNo;
  set flightNo(String? flightNo) => _$this._flightNo = flightNo;

  String? _identIata;
  String? get identIata => _$this._identIata;
  set identIata(String? identIata) => _$this._identIata = identIata;

  String? _identIcao;
  String? get identIcao => _$this._identIcao;
  set identIcao(String? identIcao) => _$this._identIcao = identIcao;

  String? _faFlightId;
  String? get faFlightId => _$this._faFlightId;
  set faFlightId(String? faFlightId) => _$this._faFlightId = faFlightId;

  StatsAirlineEntityBuilder? _airline;
  StatsAirlineEntityBuilder get airline =>
      _$this._airline ??= StatsAirlineEntityBuilder();
  set airline(StatsAirlineEntityBuilder? airline) => _$this._airline = airline;

  StatsAirportEntityBuilder? _departure;
  StatsAirportEntityBuilder get departure =>
      _$this._departure ??= StatsAirportEntityBuilder();
  set departure(StatsAirportEntityBuilder? departure) =>
      _$this._departure = departure;

  StatsAirportEntityBuilder? _arrival;
  StatsAirportEntityBuilder get arrival =>
      _$this._arrival ??= StatsAirportEntityBuilder();
  set arrival(StatsAirportEntityBuilder? arrival) => _$this._arrival = arrival;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _localDate;
  String? get localDate => _$this._localDate;
  set localDate(String? localDate) => _$this._localDate = localDate;

  StatsFlightSummaryEntityBuilder() {
    StatsFlightSummaryEntity._defaults(this);
  }

  StatsFlightSummaryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _flightNo = $v.flightNo;
      _identIata = $v.identIata;
      _identIcao = $v.identIcao;
      _faFlightId = $v.faFlightId;
      _airline = $v.airline.toBuilder();
      _departure = $v.departure.toBuilder();
      _arrival = $v.arrival.toBuilder();
      _date = $v.date;
      _localDate = $v.localDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatsFlightSummaryEntity other) {
    _$v = other as _$StatsFlightSummaryEntity;
  }

  @override
  void update(void Function(StatsFlightSummaryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatsFlightSummaryEntity build() => _build();

  _$StatsFlightSummaryEntity _build() {
    _$StatsFlightSummaryEntity _$result;
    try {
      _$result = _$v ??
          _$StatsFlightSummaryEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'StatsFlightSummaryEntity', 'id'),
            flightNo: BuiltValueNullFieldError.checkNotNull(
                flightNo, r'StatsFlightSummaryEntity', 'flightNo'),
            identIata: identIata,
            identIcao: identIcao,
            faFlightId: faFlightId,
            airline: airline.build(),
            departure: departure.build(),
            arrival: arrival.build(),
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'StatsFlightSummaryEntity', 'date'),
            localDate: BuiltValueNullFieldError.checkNotNull(
                localDate, r'StatsFlightSummaryEntity', 'localDate'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airline';
        airline.build();
        _$failedField = 'departure';
        departure.build();
        _$failedField = 'arrival';
        arrival.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StatsFlightSummaryEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
