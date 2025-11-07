// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_distance_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightDistanceEntity extends FlightDistanceEntity {
  @override
  final FlightSummaryEntity flight;
  @override
  final num distanceKm;

  factory _$FlightDistanceEntity(
          [void Function(FlightDistanceEntityBuilder)? updates]) =>
      (FlightDistanceEntityBuilder()..update(updates))._build();

  _$FlightDistanceEntity._({required this.flight, required this.distanceKm})
      : super._();
  @override
  FlightDistanceEntity rebuild(
          void Function(FlightDistanceEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightDistanceEntityBuilder toBuilder() =>
      FlightDistanceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightDistanceEntity &&
        flight == other.flight &&
        distanceKm == other.distanceKm;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flight.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightDistanceEntity')
          ..add('flight', flight)
          ..add('distanceKm', distanceKm))
        .toString();
  }
}

class FlightDistanceEntityBuilder
    implements Builder<FlightDistanceEntity, FlightDistanceEntityBuilder> {
  _$FlightDistanceEntity? _$v;

  FlightSummaryEntityBuilder? _flight;
  FlightSummaryEntityBuilder get flight =>
      _$this._flight ??= FlightSummaryEntityBuilder();
  set flight(FlightSummaryEntityBuilder? flight) => _$this._flight = flight;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  FlightDistanceEntityBuilder() {
    FlightDistanceEntity._defaults(this);
  }

  FlightDistanceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flight = $v.flight.toBuilder();
      _distanceKm = $v.distanceKm;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightDistanceEntity other) {
    _$v = other as _$FlightDistanceEntity;
  }

  @override
  void update(void Function(FlightDistanceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightDistanceEntity build() => _build();

  _$FlightDistanceEntity _build() {
    _$FlightDistanceEntity _$result;
    try {
      _$result = _$v ??
          _$FlightDistanceEntity._(
            flight: flight.build(),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
                distanceKm, r'FlightDistanceEntity', 'distanceKm'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flight';
        flight.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightDistanceEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
