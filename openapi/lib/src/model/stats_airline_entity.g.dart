// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_airline_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatsAirlineEntity extends StatsAirlineEntity {
  @override
  final String name;
  @override
  final String? iata;
  @override
  final String? icao;
  @override
  final String? image;

  factory _$StatsAirlineEntity(
          [void Function(StatsAirlineEntityBuilder)? updates]) =>
      (StatsAirlineEntityBuilder()..update(updates))._build();

  _$StatsAirlineEntity._({required this.name, this.iata, this.icao, this.image})
      : super._();
  @override
  StatsAirlineEntity rebuild(
          void Function(StatsAirlineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatsAirlineEntityBuilder toBuilder() =>
      StatsAirlineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatsAirlineEntity &&
        name == other.name &&
        iata == other.iata &&
        icao == other.icao &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, iata.hashCode);
    _$hash = $jc(_$hash, icao.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatsAirlineEntity')
          ..add('name', name)
          ..add('iata', iata)
          ..add('icao', icao)
          ..add('image', image))
        .toString();
  }
}

class StatsAirlineEntityBuilder
    implements Builder<StatsAirlineEntity, StatsAirlineEntityBuilder> {
  _$StatsAirlineEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _iata;
  String? get iata => _$this._iata;
  set iata(String? iata) => _$this._iata = iata;

  String? _icao;
  String? get icao => _$this._icao;
  set icao(String? icao) => _$this._icao = icao;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  StatsAirlineEntityBuilder() {
    StatsAirlineEntity._defaults(this);
  }

  StatsAirlineEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _iata = $v.iata;
      _icao = $v.icao;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatsAirlineEntity other) {
    _$v = other as _$StatsAirlineEntity;
  }

  @override
  void update(void Function(StatsAirlineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatsAirlineEntity build() => _build();

  _$StatsAirlineEntity _build() {
    final _$result = _$v ??
        _$StatsAirlineEntity._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'StatsAirlineEntity', 'name'),
          iata: iata,
          icao: icao,
          image: image,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
