// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_flown_aircraft_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MostFlownAircraftEntity extends MostFlownAircraftEntity {
  @override
  final String aircraftName;
  @override
  final num flightCount;

  factory _$MostFlownAircraftEntity(
          [void Function(MostFlownAircraftEntityBuilder)? updates]) =>
      (MostFlownAircraftEntityBuilder()..update(updates))._build();

  _$MostFlownAircraftEntity._(
      {required this.aircraftName, required this.flightCount})
      : super._();
  @override
  MostFlownAircraftEntity rebuild(
          void Function(MostFlownAircraftEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MostFlownAircraftEntityBuilder toBuilder() =>
      MostFlownAircraftEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MostFlownAircraftEntity &&
        aircraftName == other.aircraftName &&
        flightCount == other.flightCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, aircraftName.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MostFlownAircraftEntity')
          ..add('aircraftName', aircraftName)
          ..add('flightCount', flightCount))
        .toString();
  }
}

class MostFlownAircraftEntityBuilder
    implements
        Builder<MostFlownAircraftEntity, MostFlownAircraftEntityBuilder> {
  _$MostFlownAircraftEntity? _$v;

  String? _aircraftName;
  String? get aircraftName => _$this._aircraftName;
  set aircraftName(String? aircraftName) => _$this._aircraftName = aircraftName;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  MostFlownAircraftEntityBuilder() {
    MostFlownAircraftEntity._defaults(this);
  }

  MostFlownAircraftEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _aircraftName = $v.aircraftName;
      _flightCount = $v.flightCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MostFlownAircraftEntity other) {
    _$v = other as _$MostFlownAircraftEntity;
  }

  @override
  void update(void Function(MostFlownAircraftEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MostFlownAircraftEntity build() => _build();

  _$MostFlownAircraftEntity _build() {
    final _$result = _$v ??
        _$MostFlownAircraftEntity._(
          aircraftName: BuiltValueNullFieldError.checkNotNull(
              aircraftName, r'MostFlownAircraftEntity', 'aircraftName'),
          flightCount: BuiltValueNullFieldError.checkNotNull(
              flightCount, r'MostFlownAircraftEntity', 'flightCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
