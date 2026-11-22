// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_route_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TopRouteEntity extends TopRouteEntity {
  @override
  final StatsAirportEntity from;
  @override
  final StatsAirportEntity to;
  @override
  final num flightCount;
  @override
  final num distanceKm;

  factory _$TopRouteEntity([void Function(TopRouteEntityBuilder)? updates]) =>
      (TopRouteEntityBuilder()..update(updates))._build();

  _$TopRouteEntity._(
      {required this.from,
      required this.to,
      required this.flightCount,
      required this.distanceKm})
      : super._();
  @override
  TopRouteEntity rebuild(void Function(TopRouteEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopRouteEntityBuilder toBuilder() => TopRouteEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TopRouteEntity &&
        from == other.from &&
        to == other.to &&
        flightCount == other.flightCount &&
        distanceKm == other.distanceKm;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TopRouteEntity')
          ..add('from', from)
          ..add('to', to)
          ..add('flightCount', flightCount)
          ..add('distanceKm', distanceKm))
        .toString();
  }
}

class TopRouteEntityBuilder
    implements Builder<TopRouteEntity, TopRouteEntityBuilder> {
  _$TopRouteEntity? _$v;

  StatsAirportEntityBuilder? _from;
  StatsAirportEntityBuilder get from =>
      _$this._from ??= StatsAirportEntityBuilder();
  set from(StatsAirportEntityBuilder? from) => _$this._from = from;

  StatsAirportEntityBuilder? _to;
  StatsAirportEntityBuilder get to =>
      _$this._to ??= StatsAirportEntityBuilder();
  set to(StatsAirportEntityBuilder? to) => _$this._to = to;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  TopRouteEntityBuilder() {
    TopRouteEntity._defaults(this);
  }

  TopRouteEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from.toBuilder();
      _to = $v.to.toBuilder();
      _flightCount = $v.flightCount;
      _distanceKm = $v.distanceKm;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopRouteEntity other) {
    _$v = other as _$TopRouteEntity;
  }

  @override
  void update(void Function(TopRouteEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TopRouteEntity build() => _build();

  _$TopRouteEntity _build() {
    _$TopRouteEntity _$result;
    try {
      _$result = _$v ??
          _$TopRouteEntity._(
            from: from.build(),
            to: to.build(),
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'TopRouteEntity', 'flightCount'),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
                distanceKm, r'TopRouteEntity', 'distanceKm'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'from';
        from.build();
        _$failedField = 'to';
        to.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TopRouteEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
