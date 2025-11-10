// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_search_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightSearchResponseEntity extends FlightSearchResponseEntity {
  @override
  final BuiltList<FlightCandidateEntity> flights;
  @override
  final num count;

  factory _$FlightSearchResponseEntity(
          [void Function(FlightSearchResponseEntityBuilder)? updates]) =>
      (FlightSearchResponseEntityBuilder()..update(updates))._build();

  _$FlightSearchResponseEntity._({required this.flights, required this.count})
      : super._();
  @override
  FlightSearchResponseEntity rebuild(
          void Function(FlightSearchResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightSearchResponseEntityBuilder toBuilder() =>
      FlightSearchResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightSearchResponseEntity &&
        flights == other.flights &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flights.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightSearchResponseEntity')
          ..add('flights', flights)
          ..add('count', count))
        .toString();
  }
}

class FlightSearchResponseEntityBuilder
    implements
        Builder<FlightSearchResponseEntity, FlightSearchResponseEntityBuilder> {
  _$FlightSearchResponseEntity? _$v;

  ListBuilder<FlightCandidateEntity>? _flights;
  ListBuilder<FlightCandidateEntity> get flights =>
      _$this._flights ??= ListBuilder<FlightCandidateEntity>();
  set flights(ListBuilder<FlightCandidateEntity>? flights) =>
      _$this._flights = flights;

  num? _count;
  num? get count => _$this._count;
  set count(num? count) => _$this._count = count;

  FlightSearchResponseEntityBuilder() {
    FlightSearchResponseEntity._defaults(this);
  }

  FlightSearchResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flights = $v.flights.toBuilder();
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightSearchResponseEntity other) {
    _$v = other as _$FlightSearchResponseEntity;
  }

  @override
  void update(void Function(FlightSearchResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightSearchResponseEntity build() => _build();

  _$FlightSearchResponseEntity _build() {
    _$FlightSearchResponseEntity _$result;
    try {
      _$result = _$v ??
          _$FlightSearchResponseEntity._(
            flights: flights.build(),
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'FlightSearchResponseEntity', 'count'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flights';
        flights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightSearchResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
