// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_summary_airline_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightSummaryAirlineEntity extends FlightSummaryAirlineEntity {
  @override
  final String name;
  @override
  final String? iata;
  @override
  final String? icao;
  @override
  final String? image;

  factory _$FlightSummaryAirlineEntity(
          [void Function(FlightSummaryAirlineEntityBuilder)? updates]) =>
      (FlightSummaryAirlineEntityBuilder()..update(updates))._build();

  _$FlightSummaryAirlineEntity._(
      {required this.name, this.iata, this.icao, this.image})
      : super._();
  @override
  FlightSummaryAirlineEntity rebuild(
          void Function(FlightSummaryAirlineEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightSummaryAirlineEntityBuilder toBuilder() =>
      FlightSummaryAirlineEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightSummaryAirlineEntity &&
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
    return (newBuiltValueToStringHelper(r'FlightSummaryAirlineEntity')
          ..add('name', name)
          ..add('iata', iata)
          ..add('icao', icao)
          ..add('image', image))
        .toString();
  }
}

class FlightSummaryAirlineEntityBuilder
    implements
        Builder<FlightSummaryAirlineEntity, FlightSummaryAirlineEntityBuilder> {
  _$FlightSummaryAirlineEntity? _$v;

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

  FlightSummaryAirlineEntityBuilder() {
    FlightSummaryAirlineEntity._defaults(this);
  }

  FlightSummaryAirlineEntityBuilder get _$this {
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
  void replace(FlightSummaryAirlineEntity other) {
    _$v = other as _$FlightSummaryAirlineEntity;
  }

  @override
  void update(void Function(FlightSummaryAirlineEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightSummaryAirlineEntity build() => _build();

  _$FlightSummaryAirlineEntity _build() {
    final _$result = _$v ??
        _$FlightSummaryAirlineEntity._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'FlightSummaryAirlineEntity', 'name'),
          iata: iata,
          icao: icao,
          image: image,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
