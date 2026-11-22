// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runways_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RunwaysEntity extends RunwaysEntity {
  @override
  final num basedOn;
  @override
  final BuiltList<RunwayUseEntity> items;

  factory _$RunwaysEntity([void Function(RunwaysEntityBuilder)? updates]) =>
      (RunwaysEntityBuilder()..update(updates))._build();

  _$RunwaysEntity._({required this.basedOn, required this.items}) : super._();
  @override
  RunwaysEntity rebuild(void Function(RunwaysEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RunwaysEntityBuilder toBuilder() => RunwaysEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RunwaysEntity &&
        basedOn == other.basedOn &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, basedOn.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RunwaysEntity')
          ..add('basedOn', basedOn)
          ..add('items', items))
        .toString();
  }
}

class RunwaysEntityBuilder
    implements Builder<RunwaysEntity, RunwaysEntityBuilder> {
  _$RunwaysEntity? _$v;

  num? _basedOn;
  num? get basedOn => _$this._basedOn;
  set basedOn(num? basedOn) => _$this._basedOn = basedOn;

  ListBuilder<RunwayUseEntity>? _items;
  ListBuilder<RunwayUseEntity> get items =>
      _$this._items ??= ListBuilder<RunwayUseEntity>();
  set items(ListBuilder<RunwayUseEntity>? items) => _$this._items = items;

  RunwaysEntityBuilder() {
    RunwaysEntity._defaults(this);
  }

  RunwaysEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _basedOn = $v.basedOn;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RunwaysEntity other) {
    _$v = other as _$RunwaysEntity;
  }

  @override
  void update(void Function(RunwaysEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RunwaysEntity build() => _build();

  _$RunwaysEntity _build() {
    _$RunwaysEntity _$result;
    try {
      _$result = _$v ??
          _$RunwaysEntity._(
            basedOn: BuiltValueNullFieldError.checkNotNull(
                basedOn, r'RunwaysEntity', 'basedOn'),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RunwaysEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
