// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_section_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftSectionEntity extends AircraftSectionEntity {
  @override
  final num basedOn;
  @override
  final BuiltList<AircraftTypeEntity> types;
  @override
  final BuiltList<AircraftFamilyEntity> families;
  @override
  final AirframesEntity airframes;

  factory _$AircraftSectionEntity(
          [void Function(AircraftSectionEntityBuilder)? updates]) =>
      (AircraftSectionEntityBuilder()..update(updates))._build();

  _$AircraftSectionEntity._(
      {required this.basedOn,
      required this.types,
      required this.families,
      required this.airframes})
      : super._();
  @override
  AircraftSectionEntity rebuild(
          void Function(AircraftSectionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftSectionEntityBuilder toBuilder() =>
      AircraftSectionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftSectionEntity &&
        basedOn == other.basedOn &&
        types == other.types &&
        families == other.families &&
        airframes == other.airframes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, basedOn.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jc(_$hash, families.hashCode);
    _$hash = $jc(_$hash, airframes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftSectionEntity')
          ..add('basedOn', basedOn)
          ..add('types', types)
          ..add('families', families)
          ..add('airframes', airframes))
        .toString();
  }
}

class AircraftSectionEntityBuilder
    implements Builder<AircraftSectionEntity, AircraftSectionEntityBuilder> {
  _$AircraftSectionEntity? _$v;

  num? _basedOn;
  num? get basedOn => _$this._basedOn;
  set basedOn(num? basedOn) => _$this._basedOn = basedOn;

  ListBuilder<AircraftTypeEntity>? _types;
  ListBuilder<AircraftTypeEntity> get types =>
      _$this._types ??= ListBuilder<AircraftTypeEntity>();
  set types(ListBuilder<AircraftTypeEntity>? types) => _$this._types = types;

  ListBuilder<AircraftFamilyEntity>? _families;
  ListBuilder<AircraftFamilyEntity> get families =>
      _$this._families ??= ListBuilder<AircraftFamilyEntity>();
  set families(ListBuilder<AircraftFamilyEntity>? families) =>
      _$this._families = families;

  AirframesEntityBuilder? _airframes;
  AirframesEntityBuilder get airframes =>
      _$this._airframes ??= AirframesEntityBuilder();
  set airframes(AirframesEntityBuilder? airframes) =>
      _$this._airframes = airframes;

  AircraftSectionEntityBuilder() {
    AircraftSectionEntity._defaults(this);
  }

  AircraftSectionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _basedOn = $v.basedOn;
      _types = $v.types.toBuilder();
      _families = $v.families.toBuilder();
      _airframes = $v.airframes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftSectionEntity other) {
    _$v = other as _$AircraftSectionEntity;
  }

  @override
  void update(void Function(AircraftSectionEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftSectionEntity build() => _build();

  _$AircraftSectionEntity _build() {
    _$AircraftSectionEntity _$result;
    try {
      _$result = _$v ??
          _$AircraftSectionEntity._(
            basedOn: BuiltValueNullFieldError.checkNotNull(
                basedOn, r'AircraftSectionEntity', 'basedOn'),
            types: types.build(),
            families: families.build(),
            airframes: airframes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'types';
        types.build();
        _$failedField = 'families';
        families.build();
        _$failedField = 'airframes';
        airframes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AircraftSectionEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
