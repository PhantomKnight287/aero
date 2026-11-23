// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_family_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftFamilyEntity extends AircraftFamilyEntity {
  @override
  final String family;
  @override
  final BuiltList<String> typeCodes;
  @override
  final num flightCount;
  @override
  final String? firstFlown;

  factory _$AircraftFamilyEntity(
          [void Function(AircraftFamilyEntityBuilder)? updates]) =>
      (AircraftFamilyEntityBuilder()..update(updates))._build();

  _$AircraftFamilyEntity._(
      {required this.family,
      required this.typeCodes,
      required this.flightCount,
      this.firstFlown})
      : super._();
  @override
  AircraftFamilyEntity rebuild(
          void Function(AircraftFamilyEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftFamilyEntityBuilder toBuilder() =>
      AircraftFamilyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftFamilyEntity &&
        family == other.family &&
        typeCodes == other.typeCodes &&
        flightCount == other.flightCount &&
        firstFlown == other.firstFlown;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, family.hashCode);
    _$hash = $jc(_$hash, typeCodes.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, firstFlown.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftFamilyEntity')
          ..add('family', family)
          ..add('typeCodes', typeCodes)
          ..add('flightCount', flightCount)
          ..add('firstFlown', firstFlown))
        .toString();
  }
}

class AircraftFamilyEntityBuilder
    implements Builder<AircraftFamilyEntity, AircraftFamilyEntityBuilder> {
  _$AircraftFamilyEntity? _$v;

  String? _family;
  String? get family => _$this._family;
  set family(String? family) => _$this._family = family;

  ListBuilder<String>? _typeCodes;
  ListBuilder<String> get typeCodes =>
      _$this._typeCodes ??= ListBuilder<String>();
  set typeCodes(ListBuilder<String>? typeCodes) =>
      _$this._typeCodes = typeCodes;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  String? _firstFlown;
  String? get firstFlown => _$this._firstFlown;
  set firstFlown(String? firstFlown) => _$this._firstFlown = firstFlown;

  AircraftFamilyEntityBuilder() {
    AircraftFamilyEntity._defaults(this);
  }

  AircraftFamilyEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _family = $v.family;
      _typeCodes = $v.typeCodes.toBuilder();
      _flightCount = $v.flightCount;
      _firstFlown = $v.firstFlown;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftFamilyEntity other) {
    _$v = other as _$AircraftFamilyEntity;
  }

  @override
  void update(void Function(AircraftFamilyEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftFamilyEntity build() => _build();

  _$AircraftFamilyEntity _build() {
    _$AircraftFamilyEntity _$result;
    try {
      _$result = _$v ??
          _$AircraftFamilyEntity._(
            family: BuiltValueNullFieldError.checkNotNull(
                family, r'AircraftFamilyEntity', 'family'),
            typeCodes: typeCodes.build(),
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'AircraftFamilyEntity', 'flightCount'),
            firstFlown: firstFlown,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'typeCodes';
        typeCodes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AircraftFamilyEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
