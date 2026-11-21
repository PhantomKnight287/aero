// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_controller_delete_flight_v1200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightControllerDeleteFlightV1200Response
    extends FlightControllerDeleteFlightV1200Response {
  @override
  final String? message;

  factory _$FlightControllerDeleteFlightV1200Response(
          [void Function(FlightControllerDeleteFlightV1200ResponseBuilder)?
              updates]) =>
      (FlightControllerDeleteFlightV1200ResponseBuilder()..update(updates))
          ._build();

  _$FlightControllerDeleteFlightV1200Response._({this.message}) : super._();
  @override
  FlightControllerDeleteFlightV1200Response rebuild(
          void Function(FlightControllerDeleteFlightV1200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightControllerDeleteFlightV1200ResponseBuilder toBuilder() =>
      FlightControllerDeleteFlightV1200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightControllerDeleteFlightV1200Response &&
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
            r'FlightControllerDeleteFlightV1200Response')
          ..add('message', message))
        .toString();
  }
}

class FlightControllerDeleteFlightV1200ResponseBuilder
    implements
        Builder<FlightControllerDeleteFlightV1200Response,
            FlightControllerDeleteFlightV1200ResponseBuilder> {
  _$FlightControllerDeleteFlightV1200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  FlightControllerDeleteFlightV1200ResponseBuilder() {
    FlightControllerDeleteFlightV1200Response._defaults(this);
  }

  FlightControllerDeleteFlightV1200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightControllerDeleteFlightV1200Response other) {
    _$v = other as _$FlightControllerDeleteFlightV1200Response;
  }

  @override
  void update(
      void Function(FlightControllerDeleteFlightV1200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightControllerDeleteFlightV1200Response build() => _build();

  _$FlightControllerDeleteFlightV1200Response _build() {
    final _$result = _$v ??
        _$FlightControllerDeleteFlightV1200Response._(
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
