// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_history_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftHistoryEntity extends AircraftHistoryEntity {
  @override
  final String? registration;
  @override
  final AircraftLegEntity? inbound;
  @override
  final BuiltList<FlightSummaryEntity> ownFlights;

  factory _$AircraftHistoryEntity(
          [void Function(AircraftHistoryEntityBuilder)? updates]) =>
      (AircraftHistoryEntityBuilder()..update(updates))._build();

  _$AircraftHistoryEntity._(
      {this.registration, this.inbound, required this.ownFlights})
      : super._();
  @override
  AircraftHistoryEntity rebuild(
          void Function(AircraftHistoryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftHistoryEntityBuilder toBuilder() =>
      AircraftHistoryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftHistoryEntity &&
        registration == other.registration &&
        inbound == other.inbound &&
        ownFlights == other.ownFlights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, registration.hashCode);
    _$hash = $jc(_$hash, inbound.hashCode);
    _$hash = $jc(_$hash, ownFlights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftHistoryEntity')
          ..add('registration', registration)
          ..add('inbound', inbound)
          ..add('ownFlights', ownFlights))
        .toString();
  }
}

class AircraftHistoryEntityBuilder
    implements Builder<AircraftHistoryEntity, AircraftHistoryEntityBuilder> {
  _$AircraftHistoryEntity? _$v;

  String? _registration;
  String? get registration => _$this._registration;
  set registration(String? registration) => _$this._registration = registration;

  AircraftLegEntityBuilder? _inbound;
  AircraftLegEntityBuilder get inbound =>
      _$this._inbound ??= AircraftLegEntityBuilder();
  set inbound(AircraftLegEntityBuilder? inbound) => _$this._inbound = inbound;

  ListBuilder<FlightSummaryEntity>? _ownFlights;
  ListBuilder<FlightSummaryEntity> get ownFlights =>
      _$this._ownFlights ??= ListBuilder<FlightSummaryEntity>();
  set ownFlights(ListBuilder<FlightSummaryEntity>? ownFlights) =>
      _$this._ownFlights = ownFlights;

  AircraftHistoryEntityBuilder() {
    AircraftHistoryEntity._defaults(this);
  }

  AircraftHistoryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _registration = $v.registration;
      _inbound = $v.inbound?.toBuilder();
      _ownFlights = $v.ownFlights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftHistoryEntity other) {
    _$v = other as _$AircraftHistoryEntity;
  }

  @override
  void update(void Function(AircraftHistoryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftHistoryEntity build() => _build();

  _$AircraftHistoryEntity _build() {
    _$AircraftHistoryEntity _$result;
    try {
      _$result = _$v ??
          _$AircraftHistoryEntity._(
            registration: registration,
            inbound: _inbound?.build(),
            ownFlights: ownFlights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'inbound';
        _inbound?.build();
        _$failedField = 'ownFlights';
        ownFlights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AircraftHistoryEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
