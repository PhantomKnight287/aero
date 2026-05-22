// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_alert_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightAlertDTO extends FlightAlertDTO {
  @override
  final String playerId;

  factory _$FlightAlertDTO([void Function(FlightAlertDTOBuilder)? updates]) =>
      (FlightAlertDTOBuilder()..update(updates))._build();

  _$FlightAlertDTO._({required this.playerId}) : super._();
  @override
  FlightAlertDTO rebuild(void Function(FlightAlertDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightAlertDTOBuilder toBuilder() => FlightAlertDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightAlertDTO && playerId == other.playerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, playerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightAlertDTO')
          ..add('playerId', playerId))
        .toString();
  }
}

class FlightAlertDTOBuilder
    implements Builder<FlightAlertDTO, FlightAlertDTOBuilder> {
  _$FlightAlertDTO? _$v;

  String? _playerId;
  String? get playerId => _$this._playerId;
  set playerId(String? playerId) => _$this._playerId = playerId;

  FlightAlertDTOBuilder() {
    FlightAlertDTO._defaults(this);
  }

  FlightAlertDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _playerId = $v.playerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightAlertDTO other) {
    _$v = other as _$FlightAlertDTO;
  }

  @override
  void update(void Function(FlightAlertDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightAlertDTO build() => _build();

  _$FlightAlertDTO _build() {
    final _$result = _$v ??
        _$FlightAlertDTO._(
          playerId: BuiltValueNullFieldError.checkNotNull(
              playerId, r'FlightAlertDTO', 'playerId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
