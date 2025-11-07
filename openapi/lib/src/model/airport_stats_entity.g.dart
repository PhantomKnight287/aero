// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_stats_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirportStatsEntity extends AirportStatsEntity {
  @override
  final String airportCode;
  @override
  final String airportName;
  @override
  final num departureCount;

  factory _$AirportStatsEntity(
          [void Function(AirportStatsEntityBuilder)? updates]) =>
      (AirportStatsEntityBuilder()..update(updates))._build();

  _$AirportStatsEntity._(
      {required this.airportCode,
      required this.airportName,
      required this.departureCount})
      : super._();
  @override
  AirportStatsEntity rebuild(
          void Function(AirportStatsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportStatsEntityBuilder toBuilder() =>
      AirportStatsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportStatsEntity &&
        airportCode == other.airportCode &&
        airportName == other.airportName &&
        departureCount == other.departureCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airportCode.hashCode);
    _$hash = $jc(_$hash, airportName.hashCode);
    _$hash = $jc(_$hash, departureCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportStatsEntity')
          ..add('airportCode', airportCode)
          ..add('airportName', airportName)
          ..add('departureCount', departureCount))
        .toString();
  }
}

class AirportStatsEntityBuilder
    implements Builder<AirportStatsEntity, AirportStatsEntityBuilder> {
  _$AirportStatsEntity? _$v;

  String? _airportCode;
  String? get airportCode => _$this._airportCode;
  set airportCode(String? airportCode) => _$this._airportCode = airportCode;

  String? _airportName;
  String? get airportName => _$this._airportName;
  set airportName(String? airportName) => _$this._airportName = airportName;

  num? _departureCount;
  num? get departureCount => _$this._departureCount;
  set departureCount(num? departureCount) =>
      _$this._departureCount = departureCount;

  AirportStatsEntityBuilder() {
    AirportStatsEntity._defaults(this);
  }

  AirportStatsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airportCode = $v.airportCode;
      _airportName = $v.airportName;
      _departureCount = $v.departureCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportStatsEntity other) {
    _$v = other as _$AirportStatsEntity;
  }

  @override
  void update(void Function(AirportStatsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportStatsEntity build() => _build();

  _$AirportStatsEntity _build() {
    final _$result = _$v ??
        _$AirportStatsEntity._(
          airportCode: BuiltValueNullFieldError.checkNotNull(
              airportCode, r'AirportStatsEntity', 'airportCode'),
          airportName: BuiltValueNullFieldError.checkNotNull(
              airportName, r'AirportStatsEntity', 'airportName'),
          departureCount: BuiltValueNullFieldError.checkNotNull(
              departureCount, r'AirportStatsEntity', 'departureCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
