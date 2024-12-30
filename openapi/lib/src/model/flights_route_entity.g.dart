// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_route_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightsRouteEntity extends FlightsRouteEntity {
  @override
  final String from;
  @override
  final String to;

  factory _$FlightsRouteEntity(
          [void Function(FlightsRouteEntityBuilder)? updates]) =>
      (new FlightsRouteEntityBuilder()..update(updates))._build();

  _$FlightsRouteEntity._({required this.from, required this.to}) : super._() {
    BuiltValueNullFieldError.checkNotNull(from, r'FlightsRouteEntity', 'from');
    BuiltValueNullFieldError.checkNotNull(to, r'FlightsRouteEntity', 'to');
  }

  @override
  FlightsRouteEntity rebuild(
          void Function(FlightsRouteEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightsRouteEntityBuilder toBuilder() =>
      new FlightsRouteEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightsRouteEntity && from == other.from && to == other.to;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightsRouteEntity')
          ..add('from', from)
          ..add('to', to))
        .toString();
  }
}

class FlightsRouteEntityBuilder
    implements Builder<FlightsRouteEntity, FlightsRouteEntityBuilder> {
  _$FlightsRouteEntity? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  FlightsRouteEntityBuilder() {
    FlightsRouteEntity._defaults(this);
  }

  FlightsRouteEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightsRouteEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FlightsRouteEntity;
  }

  @override
  void update(void Function(FlightsRouteEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightsRouteEntity build() => _build();

  _$FlightsRouteEntity _build() {
    final _$result = _$v ??
        new _$FlightsRouteEntity._(
          from: BuiltValueNullFieldError.checkNotNull(
              from, r'FlightsRouteEntity', 'from'),
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'FlightsRouteEntity', 'to'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
