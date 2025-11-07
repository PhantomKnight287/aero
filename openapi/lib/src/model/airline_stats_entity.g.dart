// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airline_stats_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AirlineStatsEntity extends AirlineStatsEntity {
  @override
  final String airlineName;
  @override
  final String airlineIata;
  @override
  final String? airlineIcao;
  @override
  final String? image;
  @override
  final num flightCount;

  factory _$AirlineStatsEntity(
          [void Function(AirlineStatsEntityBuilder)? updates]) =>
      (AirlineStatsEntityBuilder()..update(updates))._build();

  _$AirlineStatsEntity._(
      {required this.airlineName,
      required this.airlineIata,
      this.airlineIcao,
      this.image,
      required this.flightCount})
      : super._();
  @override
  AirlineStatsEntity rebuild(
          void Function(AirlineStatsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirlineStatsEntityBuilder toBuilder() =>
      AirlineStatsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirlineStatsEntity &&
        airlineName == other.airlineName &&
        airlineIata == other.airlineIata &&
        airlineIcao == other.airlineIcao &&
        image == other.image &&
        flightCount == other.flightCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airlineName.hashCode);
    _$hash = $jc(_$hash, airlineIata.hashCode);
    _$hash = $jc(_$hash, airlineIcao.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, flightCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirlineStatsEntity')
          ..add('airlineName', airlineName)
          ..add('airlineIata', airlineIata)
          ..add('airlineIcao', airlineIcao)
          ..add('image', image)
          ..add('flightCount', flightCount))
        .toString();
  }
}

class AirlineStatsEntityBuilder
    implements Builder<AirlineStatsEntity, AirlineStatsEntityBuilder> {
  _$AirlineStatsEntity? _$v;

  String? _airlineName;
  String? get airlineName => _$this._airlineName;
  set airlineName(String? airlineName) => _$this._airlineName = airlineName;

  String? _airlineIata;
  String? get airlineIata => _$this._airlineIata;
  set airlineIata(String? airlineIata) => _$this._airlineIata = airlineIata;

  String? _airlineIcao;
  String? get airlineIcao => _$this._airlineIcao;
  set airlineIcao(String? airlineIcao) => _$this._airlineIcao = airlineIcao;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  num? _flightCount;
  num? get flightCount => _$this._flightCount;
  set flightCount(num? flightCount) => _$this._flightCount = flightCount;

  AirlineStatsEntityBuilder() {
    AirlineStatsEntity._defaults(this);
  }

  AirlineStatsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airlineName = $v.airlineName;
      _airlineIata = $v.airlineIata;
      _airlineIcao = $v.airlineIcao;
      _image = $v.image;
      _flightCount = $v.flightCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirlineStatsEntity other) {
    _$v = other as _$AirlineStatsEntity;
  }

  @override
  void update(void Function(AirlineStatsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirlineStatsEntity build() => _build();

  _$AirlineStatsEntity _build() {
    final _$result = _$v ??
        _$AirlineStatsEntity._(
          airlineName: BuiltValueNullFieldError.checkNotNull(
              airlineName, r'AirlineStatsEntity', 'airlineName'),
          airlineIata: BuiltValueNullFieldError.checkNotNull(
              airlineIata, r'AirlineStatsEntity', 'airlineIata'),
          airlineIcao: airlineIcao,
          image: image,
          flightCount: BuiltValueNullFieldError.checkNotNull(
              flightCount, r'AirlineStatsEntity', 'flightCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
