// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airline_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirlineEntity extends AirlineEntity {
  @override
  final String id;
  @override
  final String name;
  @override
  final String icao;
  @override
  final String iata;
  @override
  final String? image;

  factory _$AirlineEntity([void Function(AirlineEntityBuilder)? updates]) =>
      (AirlineEntityBuilder()..update(updates))._build();

  _$AirlineEntity._(
      {required this.id,
      required this.name,
      required this.icao,
      required this.iata,
      this.image})
      : super._();
  @override
  AirlineEntity rebuild(void Function(AirlineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirlineEntityBuilder toBuilder() => AirlineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirlineEntity &&
        id == other.id &&
        name == other.name &&
        icao == other.icao &&
        iata == other.iata &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icao.hashCode);
    _$hash = $jc(_$hash, iata.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirlineEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('icao', icao)
          ..add('iata', iata)
          ..add('image', image))
        .toString();
  }
}

class AirlineEntityBuilder
    implements Builder<AirlineEntity, AirlineEntityBuilder> {
  _$AirlineEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _icao;
  String? get icao => _$this._icao;
  set icao(String? icao) => _$this._icao = icao;

  String? _iata;
  String? get iata => _$this._iata;
  set iata(String? iata) => _$this._iata = iata;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  AirlineEntityBuilder() {
    AirlineEntity._defaults(this);
  }

  AirlineEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _icao = $v.icao;
      _iata = $v.iata;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirlineEntity other) {
    _$v = other as _$AirlineEntity;
  }

  @override
  void update(void Function(AirlineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirlineEntity build() => _build();

  _$AirlineEntity _build() {
    final _$result = _$v ??
        _$AirlineEntity._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'AirlineEntity', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'AirlineEntity', 'name'),
          icao: BuiltValueNullFieldError.checkNotNull(
              icao, r'AirlineEntity', 'icao'),
          iata: BuiltValueNullFieldError.checkNotNull(
              iata, r'AirlineEntity', 'iata'),
          image: image,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
