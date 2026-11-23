// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_history_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteHistoryEntity extends RouteHistoryEntity {
  @override
  final num flightCount;
  @override
  final num distanceKm;
  @override
  final num blockMinutes;
  @override
  final BuiltList<StatsFlightSummaryEntity> recent;

  factory _$RouteHistoryEntity(
          [void Function(RouteHistoryEntityBuilder)? updates]) =>
      (RouteHistoryEntityBuilder()..update(updates))._build();

  _$RouteHistoryEntity._(
      {required this.flightCount,
      required this.distanceKm,
      required this.blockMinutes,
      required this.recent})
      : super._();
  @override
  RouteHistoryEntity rebuild(
          void Function(RouteHistoryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteHistoryEntityBuilder toBuilder() =>
      RouteHistoryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteHistoryEntity &&
        flightCount == other.flightCount &&
        distanceKm == other.distanceKm &&
        blockMinutes == other.blockMinutes &&
        recent == other.recent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jc(_$hash, blockMinutes.hashCode);
    _$hash = $jc(_$hash, recent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteHistoryEntity')
          ..add('flightCount', flightCount)
          ..add('distanceKm', distanceKm)
          ..add('blockMinutes', blockMinutes)
          ..add('recent', recent))
        .toString();
  }
}

class RouteHistoryEntityBuilder
    implements Builder<RouteHistoryEntity, RouteHistoryEntityBuilder> {
  _$RouteHistoryEntity? _$v;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  num? _blockMinutes;
  num? get blockMinutes => _$this._blockMinutes;
  set blockMinutes(num? blockMinutes) => _$this._blockMinutes = blockMinutes;

  ListBuilder<StatsFlightSummaryEntity>? _recent;
  ListBuilder<StatsFlightSummaryEntity> get recent =>
      _$this._recent ??= ListBuilder<StatsFlightSummaryEntity>();
  set recent(ListBuilder<StatsFlightSummaryEntity>? recent) =>
      _$this._recent = recent;

  RouteHistoryEntityBuilder() {
    RouteHistoryEntity._defaults(this);
  }

  RouteHistoryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flightCount = $v.flightCount;
      _distanceKm = $v.distanceKm;
      _blockMinutes = $v.blockMinutes;
      _recent = $v.recent.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteHistoryEntity other) {
    _$v = other as _$RouteHistoryEntity;
  }

  @override
  void update(void Function(RouteHistoryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteHistoryEntity build() => _build();

  _$RouteHistoryEntity _build() {
    _$RouteHistoryEntity _$result;
    try {
      _$result = _$v ??
          _$RouteHistoryEntity._(
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'RouteHistoryEntity', 'flightCount'),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
                distanceKm, r'RouteHistoryEntity', 'distanceKm'),
            blockMinutes: BuiltValueNullFieldError.checkNotNull(
                blockMinutes, r'RouteHistoryEntity', 'blockMinutes'),
            recent: recent.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recent';
        recent.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RouteHistoryEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
