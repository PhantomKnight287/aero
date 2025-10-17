// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stringified_great_circle_distance_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StringifiedGreatCircleDistanceEntity
    extends StringifiedGreatCircleDistanceEntity {
  @override
  final String? meter;
  @override
  final String? km;
  @override
  final String? mile;
  @override
  final String? nm;
  @override
  final String? feet;

  factory _$StringifiedGreatCircleDistanceEntity(
          [void Function(StringifiedGreatCircleDistanceEntityBuilder)?
              updates]) =>
      (StringifiedGreatCircleDistanceEntityBuilder()..update(updates))._build();

  _$StringifiedGreatCircleDistanceEntity._(
      {this.meter, this.km, this.mile, this.nm, this.feet})
      : super._();
  @override
  StringifiedGreatCircleDistanceEntity rebuild(
          void Function(StringifiedGreatCircleDistanceEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StringifiedGreatCircleDistanceEntityBuilder toBuilder() =>
      StringifiedGreatCircleDistanceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StringifiedGreatCircleDistanceEntity &&
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
    return (newBuiltValueToStringHelper(r'StringifiedGreatCircleDistanceEntity')
          ..add('meter', meter)
          ..add('km', km)
          ..add('mile', mile)
          ..add('nm', nm)
          ..add('feet', feet))
        .toString();
  }
}

class StringifiedGreatCircleDistanceEntityBuilder
    implements
        Builder<StringifiedGreatCircleDistanceEntity,
            StringifiedGreatCircleDistanceEntityBuilder> {
  _$StringifiedGreatCircleDistanceEntity? _$v;

  String? _meter;
  String? get meter => _$this._meter;
  set meter(String? meter) => _$this._meter = meter;

  String? _km;
  String? get km => _$this._km;
  set km(String? km) => _$this._km = km;

  String? _mile;
  String? get mile => _$this._mile;
  set mile(String? mile) => _$this._mile = mile;

  String? _nm;
  String? get nm => _$this._nm;
  set nm(String? nm) => _$this._nm = nm;

  String? _feet;
  String? get feet => _$this._feet;
  set feet(String? feet) => _$this._feet = feet;

  StringifiedGreatCircleDistanceEntityBuilder() {
    StringifiedGreatCircleDistanceEntity._defaults(this);
  }

  StringifiedGreatCircleDistanceEntityBuilder get _$this {
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
  void replace(StringifiedGreatCircleDistanceEntity other) {
    _$v = other as _$StringifiedGreatCircleDistanceEntity;
  }

  @override
  void update(
      void Function(StringifiedGreatCircleDistanceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StringifiedGreatCircleDistanceEntity build() => _build();

  _$StringifiedGreatCircleDistanceEntity _build() {
    final _$result = _$v ??
        _$StringifiedGreatCircleDistanceEntity._(
          meter: meter,
          km: km,
          mile: mile,
          nm: nm,
          feet: feet,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
