// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_info_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteInfoEntity extends RouteInfoEntity {
  @override
  final RouteAirportEntity airport;
  @override
  final String? terminal;
  @override
  final String? gate;
  @override
  final TimeEntity scheduledTime;
  @override
  final TimeEntity? revisedTime;
  @override
  final TimeEntity? predictedTime;

  factory _$RouteInfoEntity([void Function(RouteInfoEntityBuilder)? updates]) =>
      (RouteInfoEntityBuilder()..update(updates))._build();

  _$RouteInfoEntity._(
      {required this.airport,
      this.terminal,
      this.gate,
      required this.scheduledTime,
      this.revisedTime,
      this.predictedTime})
      : super._();
  @override
  RouteInfoEntity rebuild(void Function(RouteInfoEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteInfoEntityBuilder toBuilder() => RouteInfoEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteInfoEntity &&
        airport == other.airport &&
        terminal == other.terminal &&
        gate == other.gate &&
        scheduledTime == other.scheduledTime &&
        revisedTime == other.revisedTime &&
        predictedTime == other.predictedTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airport.hashCode);
    _$hash = $jc(_$hash, terminal.hashCode);
    _$hash = $jc(_$hash, gate.hashCode);
    _$hash = $jc(_$hash, scheduledTime.hashCode);
    _$hash = $jc(_$hash, revisedTime.hashCode);
    _$hash = $jc(_$hash, predictedTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteInfoEntity')
          ..add('airport', airport)
          ..add('terminal', terminal)
          ..add('gate', gate)
          ..add('scheduledTime', scheduledTime)
          ..add('revisedTime', revisedTime)
          ..add('predictedTime', predictedTime))
        .toString();
  }
}

class RouteInfoEntityBuilder
    implements Builder<RouteInfoEntity, RouteInfoEntityBuilder> {
  _$RouteInfoEntity? _$v;

  RouteAirportEntityBuilder? _airport;
  RouteAirportEntityBuilder get airport =>
      _$this._airport ??= RouteAirportEntityBuilder();
  set airport(RouteAirportEntityBuilder? airport) => _$this._airport = airport;

  String? _terminal;
  String? get terminal => _$this._terminal;
  set terminal(String? terminal) => _$this._terminal = terminal;

  String? _gate;
  String? get gate => _$this._gate;
  set gate(String? gate) => _$this._gate = gate;

  TimeEntityBuilder? _scheduledTime;
  TimeEntityBuilder get scheduledTime =>
      _$this._scheduledTime ??= TimeEntityBuilder();
  set scheduledTime(TimeEntityBuilder? scheduledTime) =>
      _$this._scheduledTime = scheduledTime;

  TimeEntityBuilder? _revisedTime;
  TimeEntityBuilder get revisedTime =>
      _$this._revisedTime ??= TimeEntityBuilder();
  set revisedTime(TimeEntityBuilder? revisedTime) =>
      _$this._revisedTime = revisedTime;

  TimeEntityBuilder? _predictedTime;
  TimeEntityBuilder get predictedTime =>
      _$this._predictedTime ??= TimeEntityBuilder();
  set predictedTime(TimeEntityBuilder? predictedTime) =>
      _$this._predictedTime = predictedTime;

  RouteInfoEntityBuilder() {
    RouteInfoEntity._defaults(this);
  }

  RouteInfoEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airport = $v.airport.toBuilder();
      _terminal = $v.terminal;
      _gate = $v.gate;
      _scheduledTime = $v.scheduledTime.toBuilder();
      _revisedTime = $v.revisedTime?.toBuilder();
      _predictedTime = $v.predictedTime?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteInfoEntity other) {
    _$v = other as _$RouteInfoEntity;
  }

  @override
  void update(void Function(RouteInfoEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteInfoEntity build() => _build();

  _$RouteInfoEntity _build() {
    _$RouteInfoEntity _$result;
    try {
      _$result = _$v ??
          _$RouteInfoEntity._(
            airport: airport.build(),
            terminal: terminal,
            gate: gate,
            scheduledTime: scheduledTime.build(),
            revisedTime: _revisedTime?.build(),
            predictedTime: _predictedTime?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airport';
        airport.build();

        _$failedField = 'scheduledTime';
        scheduledTime.build();
        _$failedField = 'revisedTime';
        _revisedTime?.build();
        _$failedField = 'predictedTime';
        _predictedTime?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RouteInfoEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
