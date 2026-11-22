// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_per_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightsPerEntity extends FlightsPerEntity {
  @override
  final BuiltList<YearCountEntity> year;
  @override
  final BuiltList<num> month;
  @override
  final BuiltList<num> weekday;

  factory _$FlightsPerEntity(
          [void Function(FlightsPerEntityBuilder)? updates]) =>
      (FlightsPerEntityBuilder()..update(updates))._build();

  _$FlightsPerEntity._(
      {required this.year, required this.month, required this.weekday})
      : super._();
  @override
  FlightsPerEntity rebuild(void Function(FlightsPerEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightsPerEntityBuilder toBuilder() =>
      FlightsPerEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightsPerEntity &&
        year == other.year &&
        month == other.month &&
        weekday == other.weekday;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, weekday.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FlightsPerEntity')
          ..add('year', year)
          ..add('month', month)
          ..add('weekday', weekday))
        .toString();
  }
}

class FlightsPerEntityBuilder
    implements Builder<FlightsPerEntity, FlightsPerEntityBuilder> {
  _$FlightsPerEntity? _$v;

  ListBuilder<YearCountEntity>? _year;
  ListBuilder<YearCountEntity> get year =>
      _$this._year ??= ListBuilder<YearCountEntity>();
  set year(ListBuilder<YearCountEntity>? year) => _$this._year = year;

  ListBuilder<num>? _month;
  ListBuilder<num> get month => _$this._month ??= ListBuilder<num>();
  set month(ListBuilder<num>? month) => _$this._month = month;

  ListBuilder<num>? _weekday;
  ListBuilder<num> get weekday => _$this._weekday ??= ListBuilder<num>();
  set weekday(ListBuilder<num>? weekday) => _$this._weekday = weekday;

  FlightsPerEntityBuilder() {
    FlightsPerEntity._defaults(this);
  }

  FlightsPerEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _year = $v.year.toBuilder();
      _month = $v.month.toBuilder();
      _weekday = $v.weekday.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightsPerEntity other) {
    _$v = other as _$FlightsPerEntity;
  }

  @override
  void update(void Function(FlightsPerEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightsPerEntity build() => _build();

  _$FlightsPerEntity _build() {
    _$FlightsPerEntity _$result;
    try {
      _$result = _$v ??
          _$FlightsPerEntity._(
            year: year.build(),
            month: month.build(),
            weekday: weekday.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'year';
        year.build();
        _$failedField = 'month';
        month.build();
        _$failedField = 'weekday';
        weekday.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FlightsPerEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
