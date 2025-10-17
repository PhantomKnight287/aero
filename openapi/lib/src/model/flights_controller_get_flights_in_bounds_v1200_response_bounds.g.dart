// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_controller_get_flights_in_bounds_v1200_response_bounds.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds
    extends FlightsControllerGetFlightsInBoundsV1200ResponseBounds {
  @override
  final num? minLat;
  @override
  final num? maxLat;
  @override
  final num? minLng;
  @override
  final num? maxLng;

  factory _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds(
          [void Function(
                  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder)?
              updates]) =>
      (FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder()
            ..update(updates))
          ._build();

  _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds._(
      {this.minLat, this.maxLat, this.minLng, this.maxLng})
      : super._();
  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseBounds rebuild(
          void Function(
                  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder toBuilder() =>
      FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FlightsControllerGetFlightsInBoundsV1200ResponseBounds &&
        minLat == other.minLat &&
        maxLat == other.maxLat &&
        minLng == other.minLng &&
        maxLng == other.maxLng;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, minLat.hashCode);
    _$hash = $jc(_$hash, maxLat.hashCode);
    _$hash = $jc(_$hash, minLng.hashCode);
    _$hash = $jc(_$hash, maxLng.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FlightsControllerGetFlightsInBoundsV1200ResponseBounds')
          ..add('minLat', minLat)
          ..add('maxLat', maxLat)
          ..add('minLng', minLng)
          ..add('maxLng', maxLng))
        .toString();
  }
}

class FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder
    implements
        Builder<FlightsControllerGetFlightsInBoundsV1200ResponseBounds,
            FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder> {
  _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds? _$v;

  num? _minLat;
  num? get minLat => _$this._minLat;
  set minLat(num? minLat) => _$this._minLat = minLat;

  num? _maxLat;
  num? get maxLat => _$this._maxLat;
  set maxLat(num? maxLat) => _$this._maxLat = maxLat;

  num? _minLng;
  num? get minLng => _$this._minLng;
  set minLng(num? minLng) => _$this._minLng = minLng;

  num? _maxLng;
  num? get maxLng => _$this._maxLng;
  set maxLng(num? maxLng) => _$this._maxLng = maxLng;

  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder() {
    FlightsControllerGetFlightsInBoundsV1200ResponseBounds._defaults(this);
  }

  FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _minLat = $v.minLat;
      _maxLat = $v.maxLat;
      _minLng = $v.minLng;
      _maxLng = $v.maxLng;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FlightsControllerGetFlightsInBoundsV1200ResponseBounds other) {
    _$v = other as _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds;
  }

  @override
  void update(
      void Function(
              FlightsControllerGetFlightsInBoundsV1200ResponseBoundsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseBounds build() => _build();

  _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds _build() {
    final _$result = _$v ??
        _$FlightsControllerGetFlightsInBoundsV1200ResponseBounds._(
          minLat: minLat,
          maxLat: maxLat,
          minLng: minLng,
          maxLng: maxLng,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
