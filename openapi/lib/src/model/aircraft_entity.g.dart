// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftEntity extends AircraftEntity {
  @override
  final String? modeS;
  @override
  final String? registration;
  @override
  final String model;
  @override
  final String? image;
  @override
  final String? aircraftId;
  @override
  final String? age;
  @override
  final String? firstFlightDate;
  @override
  final String? deliveryDate;
  @override
  final bool? isFreighter;
  @override
  final String? attribution;

  factory _$AircraftEntity([void Function(AircraftEntityBuilder)? updates]) =>
      (new AircraftEntityBuilder()..update(updates))._build();

  _$AircraftEntity._(
      {this.modeS,
      this.registration,
      required this.model,
      this.image,
      this.aircraftId,
      this.age,
      this.firstFlightDate,
      this.deliveryDate,
      this.isFreighter,
      this.attribution})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(model, r'AircraftEntity', 'model');
  }

  @override
  AircraftEntity rebuild(void Function(AircraftEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftEntityBuilder toBuilder() =>
      new AircraftEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftEntity &&
        modeS == other.modeS &&
        registration == other.registration &&
        model == other.model &&
        image == other.image &&
        aircraftId == other.aircraftId &&
        age == other.age &&
        firstFlightDate == other.firstFlightDate &&
        deliveryDate == other.deliveryDate &&
        isFreighter == other.isFreighter &&
        attribution == other.attribution;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, modeS.hashCode);
    _$hash = $jc(_$hash, registration.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, aircraftId.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, firstFlightDate.hashCode);
    _$hash = $jc(_$hash, deliveryDate.hashCode);
    _$hash = $jc(_$hash, isFreighter.hashCode);
    _$hash = $jc(_$hash, attribution.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftEntity')
          ..add('modeS', modeS)
          ..add('registration', registration)
          ..add('model', model)
          ..add('image', image)
          ..add('aircraftId', aircraftId)
          ..add('age', age)
          ..add('firstFlightDate', firstFlightDate)
          ..add('deliveryDate', deliveryDate)
          ..add('isFreighter', isFreighter)
          ..add('attribution', attribution))
        .toString();
  }
}

class AircraftEntityBuilder
    implements Builder<AircraftEntity, AircraftEntityBuilder> {
  _$AircraftEntity? _$v;

  String? _modeS;
  String? get modeS => _$this._modeS;
  set modeS(String? modeS) => _$this._modeS = modeS;

  String? _registration;
  String? get registration => _$this._registration;
  set registration(String? registration) => _$this._registration = registration;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _aircraftId;
  String? get aircraftId => _$this._aircraftId;
  set aircraftId(String? aircraftId) => _$this._aircraftId = aircraftId;

  String? _age;
  String? get age => _$this._age;
  set age(String? age) => _$this._age = age;

  String? _firstFlightDate;
  String? get firstFlightDate => _$this._firstFlightDate;
  set firstFlightDate(String? firstFlightDate) =>
      _$this._firstFlightDate = firstFlightDate;

  String? _deliveryDate;
  String? get deliveryDate => _$this._deliveryDate;
  set deliveryDate(String? deliveryDate) => _$this._deliveryDate = deliveryDate;

  bool? _isFreighter;
  bool? get isFreighter => _$this._isFreighter;
  set isFreighter(bool? isFreighter) => _$this._isFreighter = isFreighter;

  String? _attribution;
  String? get attribution => _$this._attribution;
  set attribution(String? attribution) => _$this._attribution = attribution;

  AircraftEntityBuilder() {
    AircraftEntity._defaults(this);
  }

  AircraftEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _modeS = $v.modeS;
      _registration = $v.registration;
      _model = $v.model;
      _image = $v.image;
      _aircraftId = $v.aircraftId;
      _age = $v.age;
      _firstFlightDate = $v.firstFlightDate;
      _deliveryDate = $v.deliveryDate;
      _isFreighter = $v.isFreighter;
      _attribution = $v.attribution;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AircraftEntity;
  }

  @override
  void update(void Function(AircraftEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftEntity build() => _build();

  _$AircraftEntity _build() {
    final _$result = _$v ??
        new _$AircraftEntity._(
          modeS: modeS,
          registration: registration,
          model: BuiltValueNullFieldError.checkNotNull(
              model, r'AircraftEntity', 'model'),
          image: image,
          aircraftId: aircraftId,
          age: age,
          firstFlightDate: firstFlightDate,
          deliveryDate: deliveryDate,
          isFreighter: isFreighter,
          attribution: attribution,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
