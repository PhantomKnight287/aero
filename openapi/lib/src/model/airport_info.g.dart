// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirportInfo extends AirportInfo {
  @override
  final String? actualRunway;
  @override
  final String? actualTime;
  @override
  final String? baggage;
  @override
  final String? delay;
  @override
  final String? estimatedRunway;
  @override
  final String? estimatedTime;
  @override
  final String? gate;
  @override
  final String? iataCode;
  @override
  final String? icaoCode;
  @override
  final String? scheduledTime;
  @override
  final String? terminal;

  factory _$AirportInfo([void Function(AirportInfoBuilder)? updates]) =>
      (new AirportInfoBuilder()..update(updates))._build();

  _$AirportInfo._(
      {this.actualRunway,
      this.actualTime,
      this.baggage,
      this.delay,
      this.estimatedRunway,
      this.estimatedTime,
      this.gate,
      this.iataCode,
      this.icaoCode,
      this.scheduledTime,
      this.terminal})
      : super._();

  @override
  AirportInfo rebuild(void Function(AirportInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportInfoBuilder toBuilder() => new AirportInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportInfo &&
        actualRunway == other.actualRunway &&
        actualTime == other.actualTime &&
        baggage == other.baggage &&
        delay == other.delay &&
        estimatedRunway == other.estimatedRunway &&
        estimatedTime == other.estimatedTime &&
        gate == other.gate &&
        iataCode == other.iataCode &&
        icaoCode == other.icaoCode &&
        scheduledTime == other.scheduledTime &&
        terminal == other.terminal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, actualRunway.hashCode);
    _$hash = $jc(_$hash, actualTime.hashCode);
    _$hash = $jc(_$hash, baggage.hashCode);
    _$hash = $jc(_$hash, delay.hashCode);
    _$hash = $jc(_$hash, estimatedRunway.hashCode);
    _$hash = $jc(_$hash, estimatedTime.hashCode);
    _$hash = $jc(_$hash, gate.hashCode);
    _$hash = $jc(_$hash, iataCode.hashCode);
    _$hash = $jc(_$hash, icaoCode.hashCode);
    _$hash = $jc(_$hash, scheduledTime.hashCode);
    _$hash = $jc(_$hash, terminal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportInfo')
          ..add('actualRunway', actualRunway)
          ..add('actualTime', actualTime)
          ..add('baggage', baggage)
          ..add('delay', delay)
          ..add('estimatedRunway', estimatedRunway)
          ..add('estimatedTime', estimatedTime)
          ..add('gate', gate)
          ..add('iataCode', iataCode)
          ..add('icaoCode', icaoCode)
          ..add('scheduledTime', scheduledTime)
          ..add('terminal', terminal))
        .toString();
  }
}

class AirportInfoBuilder implements Builder<AirportInfo, AirportInfoBuilder> {
  _$AirportInfo? _$v;

  String? _actualRunway;
  String? get actualRunway => _$this._actualRunway;
  set actualRunway(String? actualRunway) => _$this._actualRunway = actualRunway;

  String? _actualTime;
  String? get actualTime => _$this._actualTime;
  set actualTime(String? actualTime) => _$this._actualTime = actualTime;

  String? _baggage;
  String? get baggage => _$this._baggage;
  set baggage(String? baggage) => _$this._baggage = baggage;

  String? _delay;
  String? get delay => _$this._delay;
  set delay(String? delay) => _$this._delay = delay;

  String? _estimatedRunway;
  String? get estimatedRunway => _$this._estimatedRunway;
  set estimatedRunway(String? estimatedRunway) =>
      _$this._estimatedRunway = estimatedRunway;

  String? _estimatedTime;
  String? get estimatedTime => _$this._estimatedTime;
  set estimatedTime(String? estimatedTime) =>
      _$this._estimatedTime = estimatedTime;

  String? _gate;
  String? get gate => _$this._gate;
  set gate(String? gate) => _$this._gate = gate;

  String? _iataCode;
  String? get iataCode => _$this._iataCode;
  set iataCode(String? iataCode) => _$this._iataCode = iataCode;

  String? _icaoCode;
  String? get icaoCode => _$this._icaoCode;
  set icaoCode(String? icaoCode) => _$this._icaoCode = icaoCode;

  String? _scheduledTime;
  String? get scheduledTime => _$this._scheduledTime;
  set scheduledTime(String? scheduledTime) =>
      _$this._scheduledTime = scheduledTime;

  String? _terminal;
  String? get terminal => _$this._terminal;
  set terminal(String? terminal) => _$this._terminal = terminal;

  AirportInfoBuilder() {
    AirportInfo._defaults(this);
  }

  AirportInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actualRunway = $v.actualRunway;
      _actualTime = $v.actualTime;
      _baggage = $v.baggage;
      _delay = $v.delay;
      _estimatedRunway = $v.estimatedRunway;
      _estimatedTime = $v.estimatedTime;
      _gate = $v.gate;
      _iataCode = $v.iataCode;
      _icaoCode = $v.icaoCode;
      _scheduledTime = $v.scheduledTime;
      _terminal = $v.terminal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AirportInfo;
  }

  @override
  void update(void Function(AirportInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportInfo build() => _build();

  _$AirportInfo _build() {
    final _$result = _$v ??
        new _$AirportInfo._(
          actualRunway: actualRunway,
          actualTime: actualTime,
          baggage: baggage,
          delay: delay,
          estimatedRunway: estimatedRunway,
          estimatedTime: estimatedTime,
          gate: gate,
          iataCode: iataCode,
          icaoCode: icaoCode,
          scheduledTime: scheduledTime,
          terminal: terminal,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
