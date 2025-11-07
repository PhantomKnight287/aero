// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_route_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TopRouteEntity extends TopRouteEntity {
  @override
  final String origin;
  @override
  final String destination;
  @override
  final num flightCount;

  factory _$TopRouteEntity([void Function(TopRouteEntityBuilder)? updates]) =>
      (TopRouteEntityBuilder()..update(updates))._build();

  _$TopRouteEntity._(
      {required this.origin,
      required this.destination,
      required this.flightCount})
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
        origin == other.origin &&
        destination == other.destination &&
        flightCount == other.flightCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, origin.hashCode);
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TopRouteEntity')
          ..add('origin', origin)
          ..add('destination', destination)
          ..add('flightCount', flightCount))
        .toString();
  }
}

class TopRouteEntityBuilder
    implements Builder<TopRouteEntity, TopRouteEntityBuilder> {
  _$TopRouteEntity? _$v;

  String? _origin;
  String? get origin => _$this._origin;
  set origin(String? origin) => _$this._origin = origin;

  String? _destination;
  String? get destination => _$this._destination;
  set destination(String? destination) => _$this._destination = destination;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  TopRouteEntityBuilder() {
    TopRouteEntity._defaults(this);
  }

  TopRouteEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _origin = $v.origin;
      _destination = $v.destination;
      _flightCount = $v.flightCount;
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
    final _$result = _$v ??
        _$TopRouteEntity._(
          origin: BuiltValueNullFieldError.checkNotNull(
              origin, r'TopRouteEntity', 'origin'),
          destination: BuiltValueNullFieldError.checkNotNull(
              destination, r'TopRouteEntity', 'destination'),
          flightCount: BuiltValueNullFieldError.checkNotNull(
              flightCount, r'TopRouteEntity', 'flightCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
