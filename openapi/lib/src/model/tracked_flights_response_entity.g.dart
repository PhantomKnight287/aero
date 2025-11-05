// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracked_flights_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrackedFlightsResponseEntity extends TrackedFlightsResponseEntity {
  @override
  final bool success;
  @override
  final num total;
  @override
  final BuiltList<FlightResponseEntity> flights;

  factory _$TrackedFlightsResponseEntity(
          [void Function(TrackedFlightsResponseEntityBuilder)? updates]) =>
      (TrackedFlightsResponseEntityBuilder()..update(updates))._build();

  _$TrackedFlightsResponseEntity._(
      {required this.success, required this.total, required this.flights})
      : super._();
  @override
  TrackedFlightsResponseEntity rebuild(
          void Function(TrackedFlightsResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrackedFlightsResponseEntityBuilder toBuilder() =>
      TrackedFlightsResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrackedFlightsResponseEntity &&
        success == other.success &&
        total == other.total &&
        flights == other.flights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, flights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrackedFlightsResponseEntity')
          ..add('success', success)
          ..add('total', total)
          ..add('flights', flights))
        .toString();
  }
}

class TrackedFlightsResponseEntityBuilder
    implements
        Builder<TrackedFlightsResponseEntity,
            TrackedFlightsResponseEntityBuilder> {
  _$TrackedFlightsResponseEntity? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  ListBuilder<FlightResponseEntity>? _flights;
  ListBuilder<FlightResponseEntity> get flights =>
      _$this._flights ??= ListBuilder<FlightResponseEntity>();
  set flights(ListBuilder<FlightResponseEntity>? flights) =>
      _$this._flights = flights;

  TrackedFlightsResponseEntityBuilder() {
    TrackedFlightsResponseEntity._defaults(this);
  }

  TrackedFlightsResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _total = $v.total;
      _flights = $v.flights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TrackedFlightsResponseEntity other) {
    _$v = other as _$TrackedFlightsResponseEntity;
  }

  @override
  void update(void Function(TrackedFlightsResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrackedFlightsResponseEntity build() => _build();

  _$TrackedFlightsResponseEntity _build() {
    _$TrackedFlightsResponseEntity _$result;
    try {
      _$result = _$v ??
          _$TrackedFlightsResponseEntity._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'TrackedFlightsResponseEntity', 'success'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'TrackedFlightsResponseEntity', 'total'),
            flights: flights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flights';
        flights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TrackedFlightsResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
