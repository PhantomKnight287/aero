// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_history_response_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightHistoryResponseEntity extends FlightHistoryResponseEntity {
  @override
  final BuiltList<StatsFlightSummaryEntity> items;
  @override
  final String? nextCursor;
  @override
  final BuiltList<YearCountEntity> yearCounts;

  factory _$FlightHistoryResponseEntity(
          [void Function(FlightHistoryResponseEntityBuilder)? updates]) =>
      (FlightHistoryResponseEntityBuilder()..update(updates))._build();

  _$FlightHistoryResponseEntity._(
      {required this.items, this.nextCursor, required this.yearCounts})
      : super._();
  @override
  FlightHistoryResponseEntity rebuild(
          void Function(FlightHistoryResponseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightHistoryResponseEntityBuilder toBuilder() =>
      FlightHistoryResponseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightHistoryResponseEntity &&
        items == other.items &&
        nextCursor == other.nextCursor &&
        yearCounts == other.yearCounts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, yearCounts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightHistoryResponseEntity')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('yearCounts', yearCounts))
        .toString();
  }
}

class FlightHistoryResponseEntityBuilder
    implements
        Builder<FlightHistoryResponseEntity,
            FlightHistoryResponseEntityBuilder> {
  _$FlightHistoryResponseEntity? _$v;

  ListBuilder<StatsFlightSummaryEntity>? _items;
  ListBuilder<StatsFlightSummaryEntity> get items =>
      _$this._items ??= ListBuilder<StatsFlightSummaryEntity>();
  set items(ListBuilder<StatsFlightSummaryEntity>? items) =>
      _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  ListBuilder<YearCountEntity>? _yearCounts;
  ListBuilder<YearCountEntity> get yearCounts =>
      _$this._yearCounts ??= ListBuilder<YearCountEntity>();
  set yearCounts(ListBuilder<YearCountEntity>? yearCounts) =>
      _$this._yearCounts = yearCounts;

  FlightHistoryResponseEntityBuilder() {
    FlightHistoryResponseEntity._defaults(this);
  }

  FlightHistoryResponseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _nextCursor = $v.nextCursor;
      _yearCounts = $v.yearCounts.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightHistoryResponseEntity other) {
    _$v = other as _$FlightHistoryResponseEntity;
  }

  @override
  void update(void Function(FlightHistoryResponseEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightHistoryResponseEntity build() => _build();

  _$FlightHistoryResponseEntity _build() {
    _$FlightHistoryResponseEntity _$result;
    try {
      _$result = _$v ??
          _$FlightHistoryResponseEntity._(
            items: items.build(),
            nextCursor: nextCursor,
            yearCounts: yearCounts.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();

        _$failedField = 'yearCounts';
        yearCounts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightHistoryResponseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
