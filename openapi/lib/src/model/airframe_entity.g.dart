// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airframe_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirframeEntity extends AirframeEntity {
  @override
  final String reg;
  @override
  final String? typeCode;
  @override
  final String? typeName;
  @override
  final num ageYears;
  @override
  final String? image;
  @override
  final StatsFlightSummaryEntity flight;

  factory _$AirframeEntity([void Function(AirframeEntityBuilder)? updates]) =>
      (AirframeEntityBuilder()..update(updates))._build();

  _$AirframeEntity._(
      {required this.reg,
      this.typeCode,
      this.typeName,
      required this.ageYears,
      this.image,
      required this.flight})
      : super._();
  @override
  AirframeEntity rebuild(void Function(AirframeEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirframeEntityBuilder toBuilder() => AirframeEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirframeEntity &&
        reg == other.reg &&
        typeCode == other.typeCode &&
        typeName == other.typeName &&
        ageYears == other.ageYears &&
        image == other.image &&
        flight == other.flight;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reg.hashCode);
    _$hash = $jc(_$hash, typeCode.hashCode);
    _$hash = $jc(_$hash, typeName.hashCode);
    _$hash = $jc(_$hash, ageYears.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, flight.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirframeEntity')
          ..add('reg', reg)
          ..add('typeCode', typeCode)
          ..add('typeName', typeName)
          ..add('ageYears', ageYears)
          ..add('image', image)
          ..add('flight', flight))
        .toString();
  }
}

class AirframeEntityBuilder
    implements Builder<AirframeEntity, AirframeEntityBuilder> {
  _$AirframeEntity? _$v;

  String? _reg;
  String? get reg => _$this._reg;
  set reg(String? reg) => _$this._reg = reg;

  String? _typeCode;
  String? get typeCode => _$this._typeCode;
  set typeCode(String? typeCode) => _$this._typeCode = typeCode;

  String? _typeName;
  String? get typeName => _$this._typeName;
  set typeName(String? typeName) => _$this._typeName = typeName;

  num? _ageYears;
  num? get ageYears => _$this._ageYears;
  set ageYears(num? ageYears) => _$this._ageYears = ageYears;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  StatsFlightSummaryEntityBuilder? _flight;
  StatsFlightSummaryEntityBuilder get flight =>
      _$this._flight ??= StatsFlightSummaryEntityBuilder();
  set flight(StatsFlightSummaryEntityBuilder? flight) =>
      _$this._flight = flight;

  AirframeEntityBuilder() {
    AirframeEntity._defaults(this);
  }

  AirframeEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reg = $v.reg;
      _typeCode = $v.typeCode;
      _typeName = $v.typeName;
      _ageYears = $v.ageYears;
      _image = $v.image;
      _flight = $v.flight.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirframeEntity other) {
    _$v = other as _$AirframeEntity;
  }

  @override
  void update(void Function(AirframeEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirframeEntity build() => _build();

  _$AirframeEntity _build() {
    _$AirframeEntity _$result;
    try {
      _$result = _$v ??
          _$AirframeEntity._(
            reg: BuiltValueNullFieldError.checkNotNull(
                reg, r'AirframeEntity', 'reg'),
            typeCode: typeCode,
            typeName: typeName,
            ageYears: BuiltValueNullFieldError.checkNotNull(
                ageYears, r'AirframeEntity', 'ageYears'),
            image: image,
            flight: flight.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flight';
        flight.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirframeEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
