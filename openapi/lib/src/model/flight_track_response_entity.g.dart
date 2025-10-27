// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_track_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightTrackResponseEntity extends FlightTrackResponseEntity {
  @override
  final num? actualDistance;
  @override
  final BuiltList<FlightPositionEntity> positions;

  factory _$FlightTrackResponseEntity(
          [void Function(FlightTrackResponseEntityBuilder)? updates]) =>
      (FlightTrackResponseEntityBuilder()..update(updates))._build();

  _$FlightTrackResponseEntity._({this.actualDistance, required this.positions})
      : super._();
  @override
  FlightTrackResponseEntity rebuild(
          void Function(FlightTrackResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightTrackResponseEntityBuilder toBuilder() =>
      FlightTrackResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightTrackResponseEntity &&
        actualDistance == other.actualDistance &&
        positions == other.positions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, actualDistance.hashCode);
    _$hash = $jc(_$hash, positions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightTrackResponseEntity')
          ..add('actualDistance', actualDistance)
          ..add('positions', positions))
        .toString();
  }
}

class FlightTrackResponseEntityBuilder
    implements
        Builder<FlightTrackResponseEntity, FlightTrackResponseEntityBuilder> {
  _$FlightTrackResponseEntity? _$v;

  num? _actualDistance;
  num? get actualDistance => _$this._actualDistance;
  set actualDistance(num? actualDistance) =>
      _$this._actualDistance = actualDistance;

  ListBuilder<FlightPositionEntity>? _positions;
  ListBuilder<FlightPositionEntity> get positions =>
      _$this._positions ??= ListBuilder<FlightPositionEntity>();
  set positions(ListBuilder<FlightPositionEntity>? positions) =>
      _$this._positions = positions;

  FlightTrackResponseEntityBuilder() {
    FlightTrackResponseEntity._defaults(this);
  }

  FlightTrackResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actualDistance = $v.actualDistance;
      _positions = $v.positions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightTrackResponseEntity other) {
    _$v = other as _$FlightTrackResponseEntity;
  }

  @override
  void update(void Function(FlightTrackResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightTrackResponseEntity build() => _build();

  _$FlightTrackResponseEntity _build() {
    _$FlightTrackResponseEntity _$result;
    try {
      _$result = _$v ??
          _$FlightTrackResponseEntity._(
            actualDistance: actualDistance,
            positions: positions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'positions';
        positions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightTrackResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
