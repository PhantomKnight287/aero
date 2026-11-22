// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_airline_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TopAirlineEntity extends TopAirlineEntity {
  @override
  final StatsAirlineEntity airline;
  @override
  final num flightCount;
  @override
  final num distanceKm;

  factory _$TopAirlineEntity(
          [void Function(TopAirlineEntityBuilder)? updates]) =>
      (TopAirlineEntityBuilder()..update(updates))._build();

  _$TopAirlineEntity._(
      {required this.airline,
      required this.flightCount,
      required this.distanceKm})
      : super._();
  @override
  TopAirlineEntity rebuild(void Function(TopAirlineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopAirlineEntityBuilder toBuilder() =>
      TopAirlineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TopAirlineEntity &&
        airline == other.airline &&
        flightCount == other.flightCount &&
        distanceKm == other.distanceKm;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airline.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TopAirlineEntity')
          ..add('airline', airline)
          ..add('flightCount', flightCount)
          ..add('distanceKm', distanceKm))
        .toString();
  }
}

class TopAirlineEntityBuilder
    implements Builder<TopAirlineEntity, TopAirlineEntityBuilder> {
  _$TopAirlineEntity? _$v;

  StatsAirlineEntityBuilder? _airline;
  StatsAirlineEntityBuilder get airline =>
      _$this._airline ??= StatsAirlineEntityBuilder();
  set airline(StatsAirlineEntityBuilder? airline) => _$this._airline = airline;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  TopAirlineEntityBuilder() {
    TopAirlineEntity._defaults(this);
  }

  TopAirlineEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airline = $v.airline.toBuilder();
      _flightCount = $v.flightCount;
      _distanceKm = $v.distanceKm;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopAirlineEntity other) {
    _$v = other as _$TopAirlineEntity;
  }

  @override
  void update(void Function(TopAirlineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TopAirlineEntity build() => _build();

  _$TopAirlineEntity _build() {
    _$TopAirlineEntity _$result;
    try {
      _$result = _$v ??
          _$TopAirlineEntity._(
            airline: airline.build(),
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'TopAirlineEntity', 'flightCount'),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
                distanceKm, r'TopAirlineEntity', 'distanceKm'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'airline';
        airline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TopAirlineEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
