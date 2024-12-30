// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'great_circle_distance_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GreatCircleDistanceEntity extends GreatCircleDistanceEntity {
  @override
  final num meter;
  @override
  final num km;
  @override
  final num mile;
  @override
  final num nm;
  @override
  final num feet;

  factory _$GreatCircleDistanceEntity(
          [void Function(GreatCircleDistanceEntityBuilder)? updates]) =>
      (new GreatCircleDistanceEntityBuilder()..update(updates))._build();

  _$GreatCircleDistanceEntity._(
      {required this.meter,
      required this.km,
      required this.mile,
      required this.nm,
      required this.feet})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        meter, r'GreatCircleDistanceEntity', 'meter');
    BuiltValueNullFieldError.checkNotNull(
        km, r'GreatCircleDistanceEntity', 'km');
    BuiltValueNullFieldError.checkNotNull(
        mile, r'GreatCircleDistanceEntity', 'mile');
    BuiltValueNullFieldError.checkNotNull(
        nm, r'GreatCircleDistanceEntity', 'nm');
    BuiltValueNullFieldError.checkNotNull(
        feet, r'GreatCircleDistanceEntity', 'feet');
  }

  @override
  GreatCircleDistanceEntity rebuild(
          void Function(GreatCircleDistanceEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GreatCircleDistanceEntityBuilder toBuilder() =>
      new GreatCircleDistanceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GreatCircleDistanceEntity &&
        meter == other.meter &&
        km == other.km &&
        mile == other.mile &&
        nm == other.nm &&
        feet == other.feet;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, meter.hashCode);
    _$hash = $jc(_$hash, km.hashCode);
    _$hash = $jc(_$hash, mile.hashCode);
    _$hash = $jc(_$hash, nm.hashCode);
    _$hash = $jc(_$hash, feet.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GreatCircleDistanceEntity')
          ..add('meter', meter)
          ..add('km', km)
          ..add('mile', mile)
          ..add('nm', nm)
          ..add('feet', feet))
        .toString();
  }
}

class GreatCircleDistanceEntityBuilder
    implements
        Builder<GreatCircleDistanceEntity, GreatCircleDistanceEntityBuilder> {
  _$GreatCircleDistanceEntity? _$v;

  num? _meter;
  num? get meter => _$this._meter;
  set meter(num? meter) => _$this._meter = meter;

  num? _km;
  num? get km => _$this._km;
  set km(num? km) => _$this._km = km;

  num? _mile;
  num? get mile => _$this._mile;
  set mile(num? mile) => _$this._mile = mile;

  num? _nm;
  num? get nm => _$this._nm;
  set nm(num? nm) => _$this._nm = nm;

  num? _feet;
  num? get feet => _$this._feet;
  set feet(num? feet) => _$this._feet = feet;

  GreatCircleDistanceEntityBuilder() {
    GreatCircleDistanceEntity._defaults(this);
  }

  GreatCircleDistanceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _meter = $v.meter;
      _km = $v.km;
      _mile = $v.mile;
      _nm = $v.nm;
      _feet = $v.feet;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GreatCircleDistanceEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GreatCircleDistanceEntity;
  }

  @override
  void update(void Function(GreatCircleDistanceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GreatCircleDistanceEntity build() => _build();

  _$GreatCircleDistanceEntity _build() {
    final _$result = _$v ??
        new _$GreatCircleDistanceEntity._(
          meter: BuiltValueNullFieldError.checkNotNull(
              meter, r'GreatCircleDistanceEntity', 'meter'),
          km: BuiltValueNullFieldError.checkNotNull(
              km, r'GreatCircleDistanceEntity', 'km'),
          mile: BuiltValueNullFieldError.checkNotNull(
              mile, r'GreatCircleDistanceEntity', 'mile'),
          nm: BuiltValueNullFieldError.checkNotNull(
              nm, r'GreatCircleDistanceEntity', 'nm'),
          feet: BuiltValueNullFieldError.checkNotNull(
              feet, r'GreatCircleDistanceEntity', 'feet'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
