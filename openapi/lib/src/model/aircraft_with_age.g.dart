// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_with_age.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftWithAge extends AircraftWithAge {
  @override
  final String aircraftName;
  @override
  final String tailNumber;
  @override
  final num? age;
  @override
  final String? image;

  factory _$AircraftWithAge([void Function(AircraftWithAgeBuilder)? updates]) =>
      (AircraftWithAgeBuilder()..update(updates))._build();

  _$AircraftWithAge._(
      {required this.aircraftName,
      required this.tailNumber,
      this.age,
      this.image})
      : super._();
  @override
  AircraftWithAge rebuild(void Function(AircraftWithAgeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftWithAgeBuilder toBuilder() => AircraftWithAgeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftWithAge &&
        aircraftName == other.aircraftName &&
        tailNumber == other.tailNumber &&
        age == other.age &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, aircraftName.hashCode);
    _$hash = $jc(_$hash, tailNumber.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftWithAge')
          ..add('aircraftName', aircraftName)
          ..add('tailNumber', tailNumber)
          ..add('age', age)
          ..add('image', image))
        .toString();
  }
}

class AircraftWithAgeBuilder
    implements Builder<AircraftWithAge, AircraftWithAgeBuilder> {
  _$AircraftWithAge? _$v;

  String? _aircraftName;
  String? get aircraftName => _$this._aircraftName;
  set aircraftName(String? aircraftName) => _$this._aircraftName = aircraftName;

  String? _tailNumber;
  String? get tailNumber => _$this._tailNumber;
  set tailNumber(String? tailNumber) => _$this._tailNumber = tailNumber;

  num? _age;
  num? get age => _$this._age;
  set age(num? age) => _$this._age = age;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  AircraftWithAgeBuilder() {
    AircraftWithAge._defaults(this);
  }

  AircraftWithAgeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _aircraftName = $v.aircraftName;
      _tailNumber = $v.tailNumber;
      _age = $v.age;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftWithAge other) {
    _$v = other as _$AircraftWithAge;
  }

  @override
  void update(void Function(AircraftWithAgeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftWithAge build() => _build();

  _$AircraftWithAge _build() {
    final _$result = _$v ??
        _$AircraftWithAge._(
          aircraftName: BuiltValueNullFieldError.checkNotNull(
              aircraftName, r'AircraftWithAge', 'aircraftName'),
          tailNumber: BuiltValueNullFieldError.checkNotNull(
              tailNumber, r'AircraftWithAge', 'tailNumber'),
          age: age,
          image: image,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
