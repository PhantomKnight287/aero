// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_by_airport_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TaxiByAirportEntity extends TaxiByAirportEntity {
  @override
  final num basedOn;
  @override
  final BuiltList<TaxiAirportEntity> items;
  @override
  final StatsRecordEntity? longest;

  factory _$TaxiByAirportEntity(
          [void Function(TaxiByAirportEntityBuilder)? updates]) =>
      (TaxiByAirportEntityBuilder()..update(updates))._build();

  _$TaxiByAirportEntity._(
      {required this.basedOn, required this.items, this.longest})
      : super._();
  @override
  TaxiByAirportEntity rebuild(
          void Function(TaxiByAirportEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxiByAirportEntityBuilder toBuilder() =>
      TaxiByAirportEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxiByAirportEntity &&
        basedOn == other.basedOn &&
        items == other.items &&
        longest == other.longest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, basedOn.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, longest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaxiByAirportEntity')
          ..add('basedOn', basedOn)
          ..add('items', items)
          ..add('longest', longest))
        .toString();
  }
}

class TaxiByAirportEntityBuilder
    implements Builder<TaxiByAirportEntity, TaxiByAirportEntityBuilder> {
  _$TaxiByAirportEntity? _$v;

  num? _basedOn;
  num? get basedOn => _$this._basedOn;
  set basedOn(num? basedOn) => _$this._basedOn = basedOn;

  ListBuilder<TaxiAirportEntity>? _items;
  ListBuilder<TaxiAirportEntity> get items =>
      _$this._items ??= ListBuilder<TaxiAirportEntity>();
  set items(ListBuilder<TaxiAirportEntity>? items) => _$this._items = items;

  StatsRecordEntityBuilder? _longest;
  StatsRecordEntityBuilder get longest =>
      _$this._longest ??= StatsRecordEntityBuilder();
  set longest(StatsRecordEntityBuilder? longest) => _$this._longest = longest;

  TaxiByAirportEntityBuilder() {
    TaxiByAirportEntity._defaults(this);
  }

  TaxiByAirportEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _basedOn = $v.basedOn;
      _items = $v.items.toBuilder();
      _longest = $v.longest?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxiByAirportEntity other) {
    _$v = other as _$TaxiByAirportEntity;
  }

  @override
  void update(void Function(TaxiByAirportEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaxiByAirportEntity build() => _build();

  _$TaxiByAirportEntity _build() {
    _$TaxiByAirportEntity _$result;
    try {
      _$result = _$v ??
          _$TaxiByAirportEntity._(
            basedOn: BuiltValueNullFieldError.checkNotNull(
                basedOn, r'TaxiByAirportEntity', 'basedOn'),
            items: items.build(),
            longest: _longest?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'longest';
        _longest?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TaxiByAirportEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
