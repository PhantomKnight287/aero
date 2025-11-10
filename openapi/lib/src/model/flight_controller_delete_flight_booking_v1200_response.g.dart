// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_controller_delete_flight_booking_v1200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightControllerDeleteFlightBookingV1200Response
    extends FlightControllerDeleteFlightBookingV1200Response {
  @override
  final String? message;

  factory _$FlightControllerDeleteFlightBookingV1200Response(
          [void Function(
                  FlightControllerDeleteFlightBookingV1200ResponseBuilder)?
              updates]) =>
      (FlightControllerDeleteFlightBookingV1200ResponseBuilder()
            ..update(updates))
          ._build();

  _$FlightControllerDeleteFlightBookingV1200Response._({this.message})
      : super._();
  @override
  FlightControllerDeleteFlightBookingV1200Response rebuild(
          void Function(FlightControllerDeleteFlightBookingV1200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightControllerDeleteFlightBookingV1200ResponseBuilder toBuilder() =>
      FlightControllerDeleteFlightBookingV1200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightControllerDeleteFlightBookingV1200Response &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FlightControllerDeleteFlightBookingV1200Response')
          ..add('message', message))
        .toString();
  }
}

class FlightControllerDeleteFlightBookingV1200ResponseBuilder
    implements
        Builder<FlightControllerDeleteFlightBookingV1200Response,
            FlightControllerDeleteFlightBookingV1200ResponseBuilder> {
  _$FlightControllerDeleteFlightBookingV1200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  FlightControllerDeleteFlightBookingV1200ResponseBuilder() {
    FlightControllerDeleteFlightBookingV1200Response._defaults(this);
  }

  FlightControllerDeleteFlightBookingV1200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightControllerDeleteFlightBookingV1200Response other) {
    _$v = other as _$FlightControllerDeleteFlightBookingV1200Response;
  }

  @override
  void update(
      void Function(FlightControllerDeleteFlightBookingV1200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightControllerDeleteFlightBookingV1200Response build() => _build();

  _$FlightControllerDeleteFlightBookingV1200Response _build() {
    final _$result = _$v ??
        _$FlightControllerDeleteFlightBookingV1200Response._(
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
