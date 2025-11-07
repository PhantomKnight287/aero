// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_summary_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightSummaryEntity extends FlightSummaryEntity {
  @override
  final String id;
  @override
  final String flightNo;
  @override
  final String callSign;
  @override
  final FlightSummaryAirlineEntity airline;
  @override
  final String departureAirportCode;
  @override
  final String departureAirportName;
  @override
  final String arrivalAirportCode;
  @override
  final String arrivalAirportName;
  @override
  final String date;

  factory _$FlightSummaryEntity(
          [void Function(FlightSummaryEntityBuilder)? updates]) =>
      (FlightSummaryEntityBuilder()..update(updates))._build();

  _$FlightSummaryEntity._(
      {required this.id,
      required this.flightNo,
      required this.callSign,
      required this.airline,
      required this.departureAirportCode,
      required this.departureAirportName,
      required this.arrivalAirportCode,
      required this.arrivalAirportName,
      required this.date})
      : super._();
  @override
  FlightSummaryEntity rebuild(
          void Function(FlightSummaryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightSummaryEntityBuilder toBuilder() =>
      FlightSummaryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightSummaryEntity &&
        id == other.id &&
        flightNo == other.flightNo &&
        callSign == other.callSign &&
        airline == other.airline &&
        departureAirportCode == other.departureAirportCode &&
        departureAirportName == other.departureAirportName &&
        arrivalAirportCode == other.arrivalAirportCode &&
        arrivalAirportName == other.arrivalAirportName &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, flightNo.hashCode);
    _$hash = $jc(_$hash, callSign.hashCode);
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jc(_$hash, departureAirportCode.hashCode);
    _$hash = $jc(_$hash, departureAirportName.hashCode);
    _$hash = $jc(_$hash, arrivalAirportCode.hashCode);
    _$hash = $jc(_$hash, arrivalAirportName.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightSummaryEntity')
          ..add('id', id)
          ..add('flightNo', flightNo)
          ..add('callSign', callSign)
          ..add('airline', airline)
          ..add('departureAirportCode', departureAirportCode)
          ..add('departureAirportName', departureAirportName)
          ..add('arrivalAirportCode', arrivalAirportCode)
          ..add('arrivalAirportName', arrivalAirportName)
          ..add('date', date))
        .toString();
  }
}

class FlightSummaryEntityBuilder
    implements Builder<FlightSummaryEntity, FlightSummaryEntityBuilder> {
  _$FlightSummaryEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _flightNo;
  String? get flightNo => _$this._flightNo;
  set flightNo(String? flightNo) => _$this._flightNo = flightNo;

  String? _callSign;
  String? get callSign => _$this._callSign;
  set callSign(String? callSign) => _$this._callSign = callSign;

  FlightSummaryAirlineEntityBuilder? _airline;
  FlightSummaryAirlineEntityBuilder get airline =>
      _$this._airline ??= FlightSummaryAirlineEntityBuilder();
  set airline(FlightSummaryAirlineEntityBuilder? airline) =>
      _$this._airline = airline;

  String? _departureAirportCode;
  String? get departureAirportCode => _$this._departureAirportCode;
  set departureAirportCode(String? departureAirportCode) =>
      _$this._departureAirportCode = departureAirportCode;

  String? _departureAirportName;
  String? get departureAirportName => _$this._departureAirportName;
  set departureAirportName(String? departureAirportName) =>
      _$this._departureAirportName = departureAirportName;

  String? _arrivalAirportCode;
  String? get arrivalAirportCode => _$this._arrivalAirportCode;
  set arrivalAirportCode(String? arrivalAirportCode) =>
      _$this._arrivalAirportCode = arrivalAirportCode;

  String? _arrivalAirportName;
  String? get arrivalAirportName => _$this._arrivalAirportName;
  set arrivalAirportName(String? arrivalAirportName) =>
      _$this._arrivalAirportName = arrivalAirportName;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  FlightSummaryEntityBuilder() {
    FlightSummaryEntity._defaults(this);
  }

  FlightSummaryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _flightNo = $v.flightNo;
      _callSign = $v.callSign;
      _airline = $v.airline.toBuilder();
      _departureAirportCode = $v.departureAirportCode;
      _departureAirportName = $v.departureAirportName;
      _arrivalAirportCode = $v.arrivalAirportCode;
      _arrivalAirportName = $v.arrivalAirportName;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightSummaryEntity other) {
    _$v = other as _$FlightSummaryEntity;
  }

  @override
  void update(void Function(FlightSummaryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightSummaryEntity build() => _build();

  _$FlightSummaryEntity _build() {
    _$FlightSummaryEntity _$result;
    try {
      _$result = _$v ??
          _$FlightSummaryEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'FlightSummaryEntity', 'id'),
            flightNo: BuiltValueNullFieldError.checkNotNull(
                flightNo, r'FlightSummaryEntity', 'flightNo'),
            callSign: BuiltValueNullFieldError.checkNotNull(
                callSign, r'FlightSummaryEntity', 'callSign'),
            airline: airline.build(),
            departureAirportCode: BuiltValueNullFieldError.checkNotNull(
                departureAirportCode,
                r'FlightSummaryEntity',
                'departureAirportCode'),
            departureAirportName: BuiltValueNullFieldError.checkNotNull(
                departureAirportName,
                r'FlightSummaryEntity',
                'departureAirportName'),
            arrivalAirportCode: BuiltValueNullFieldError.checkNotNull(
                arrivalAirportCode,
                r'FlightSummaryEntity',
                'arrivalAirportCode'),
            arrivalAirportName: BuiltValueNullFieldError.checkNotNull(
                arrivalAirportName,
                r'FlightSummaryEntity',
                'arrivalAirportName'),
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'FlightSummaryEntity', 'date'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airline';
        airline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightSummaryEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
