// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_type_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftTypeEntity extends AircraftTypeEntity {
  @override
  final String? typeCode;
  @override
  final String typeName;
  @override
  final String? image;
  @override
  final num flightCount;
  @override
  final BuiltList<StatsFlightSummaryEntity> flights;

  factory _$AircraftTypeEntity(
          [void Function(AircraftTypeEntityBuilder)? updates]) =>
      (AircraftTypeEntityBuilder()..update(updates))._build();

  _$AircraftTypeEntity._(
      {this.typeCode,
      required this.typeName,
      this.image,
      required this.flightCount,
      required this.flights})
      : super._();
  @override
  AircraftTypeEntity rebuild(
          void Function(AircraftTypeEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftTypeEntityBuilder toBuilder() =>
      AircraftTypeEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftTypeEntity &&
        typeCode == other.typeCode &&
        typeName == other.typeName &&
        image == other.image &&
        flightCount == other.flightCount &&
        flights == other.flights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, typeCode.hashCode);
    _$hash = $jc(_$hash, typeName.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jc(_$hash, flights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftTypeEntity')
          ..add('typeCode', typeCode)
          ..add('typeName', typeName)
          ..add('image', image)
          ..add('flightCount', flightCount)
          ..add('flights', flights))
        .toString();
  }
}

class AircraftTypeEntityBuilder
    implements Builder<AircraftTypeEntity, AircraftTypeEntityBuilder> {
  _$AircraftTypeEntity? _$v;

  String? _typeCode;
  String? get typeCode => _$this._typeCode;
  set typeCode(String? typeCode) => _$this._typeCode = typeCode;

  String? _typeName;
  String? get typeName => _$this._typeName;
  set typeName(String? typeName) => _$this._typeName = typeName;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  ListBuilder<StatsFlightSummaryEntity>? _flights;
  ListBuilder<StatsFlightSummaryEntity> get flights =>
      _$this._flights ??= ListBuilder<StatsFlightSummaryEntity>();
  set flights(ListBuilder<StatsFlightSummaryEntity>? flights) =>
      _$this._flights = flights;

  AircraftTypeEntityBuilder() {
    AircraftTypeEntity._defaults(this);
  }

  AircraftTypeEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _typeCode = $v.typeCode;
      _typeName = $v.typeName;
      _image = $v.image;
      _flightCount = $v.flightCount;
      _flights = $v.flights.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftTypeEntity other) {
    _$v = other as _$AircraftTypeEntity;
  }

  @override
  void update(void Function(AircraftTypeEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftTypeEntity build() => _build();

  _$AircraftTypeEntity _build() {
    _$AircraftTypeEntity _$result;
    try {
      _$result = _$v ??
          _$AircraftTypeEntity._(
            typeCode: typeCode,
            typeName: BuiltValueNullFieldError.checkNotNull(
                typeName, r'AircraftTypeEntity', 'typeName'),
            image: image,
            flightCount: BuiltValueNullFieldError.checkNotNull(
                flightCount, r'AircraftTypeEntity', 'flightCount'),
            flights: flights.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'flights';
        flights.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AircraftTypeEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
