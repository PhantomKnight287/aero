// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_flight_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftFlightEntity extends AircraftFlightEntity {
  @override
  final String iataNumber;
  @override
  final String icaoNumber;
  @override
  final String number;

  factory _$AircraftFlightEntity(
          [void Function(AircraftFlightEntityBuilder)? updates]) =>
      (AircraftFlightEntityBuilder()..update(updates))._build();

  _$AircraftFlightEntity._(
      {required this.iataNumber,
      required this.icaoNumber,
      required this.number})
      : super._();
  @override
  AircraftFlightEntity rebuild(
          void Function(AircraftFlightEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftFlightEntityBuilder toBuilder() =>
      AircraftFlightEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftFlightEntity &&
        iataNumber == other.iataNumber &&
        icaoNumber == other.icaoNumber &&
        number == other.number;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, iataNumber.hashCode);
    _$hash = $jc(_$hash, icaoNumber.hashCode);
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftFlightEntity')
          ..add('iataNumber', iataNumber)
          ..add('icaoNumber', icaoNumber)
          ..add('number', number))
        .toString();
  }
}

class AircraftFlightEntityBuilder
    implements Builder<AircraftFlightEntity, AircraftFlightEntityBuilder> {
  _$AircraftFlightEntity? _$v;

  String? _iataNumber;
  String? get iataNumber => _$this._iataNumber;
  set iataNumber(String? iataNumber) => _$this._iataNumber = iataNumber;

  String? _icaoNumber;
  String? get icaoNumber => _$this._icaoNumber;
  set icaoNumber(String? icaoNumber) => _$this._icaoNumber = icaoNumber;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  AircraftFlightEntityBuilder() {
    AircraftFlightEntity._defaults(this);
  }

  AircraftFlightEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _iataNumber = $v.iataNumber;
      _icaoNumber = $v.icaoNumber;
      _number = $v.number;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftFlightEntity other) {
    _$v = other as _$AircraftFlightEntity;
  }

  @override
  void update(void Function(AircraftFlightEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftFlightEntity build() => _build();

  _$AircraftFlightEntity _build() {
    final _$result = _$v ??
        _$AircraftFlightEntity._(
          iataNumber: BuiltValueNullFieldError.checkNotNull(
              iataNumber, r'AircraftFlightEntity', 'iataNumber'),
          icaoNumber: BuiltValueNullFieldError.checkNotNull(
              icaoNumber, r'AircraftFlightEntity', 'icaoNumber'),
          number: BuiltValueNullFieldError.checkNotNull(
              number, r'AircraftFlightEntity', 'number'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
