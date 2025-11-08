// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_stats_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AircraftStatsEntity extends AircraftStatsEntity {
  @override
  final String mostFlownAircraftName;
  @override
  final num mostFlownAircraftFlightCount;
  @override
  final String? mostFlownAircraftImage;
  @override
  final BuiltList<FlightSummaryEntity> mostFlownAircraftFlights;
  @override
  final String mostCommonTailNumber;
  @override
  final num mostCommonTailNumberCount;
  @override
  final num? medianAge;
  @override
  final AircraftWithAge? youngestAircraft;
  @override
  final AircraftWithAge? oldestAircraft;

  factory _$AircraftStatsEntity(
          [void Function(AircraftStatsEntityBuilder)? updates]) =>
      (AircraftStatsEntityBuilder()..update(updates))._build();

  _$AircraftStatsEntity._(
      {required this.mostFlownAircraftName,
      required this.mostFlownAircraftFlightCount,
      this.mostFlownAircraftImage,
      required this.mostFlownAircraftFlights,
      required this.mostCommonTailNumber,
      required this.mostCommonTailNumberCount,
      this.medianAge,
      this.youngestAircraft,
      this.oldestAircraft})
      : super._();
  @override
  AircraftStatsEntity rebuild(
          void Function(AircraftStatsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AircraftStatsEntityBuilder toBuilder() =>
      AircraftStatsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AircraftStatsEntity &&
        mostFlownAircraftName == other.mostFlownAircraftName &&
        mostFlownAircraftFlightCount == other.mostFlownAircraftFlightCount &&
        mostFlownAircraftImage == other.mostFlownAircraftImage &&
        mostFlownAircraftFlights == other.mostFlownAircraftFlights &&
        mostCommonTailNumber == other.mostCommonTailNumber &&
        mostCommonTailNumberCount == other.mostCommonTailNumberCount &&
        medianAge == other.medianAge &&
        youngestAircraft == other.youngestAircraft &&
        oldestAircraft == other.oldestAircraft;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mostFlownAircraftName.hashCode);
    _$hash = $jc(_$hash, mostFlownAircraftFlightCount.hashCode);
    _$hash = $jc(_$hash, mostFlownAircraftImage.hashCode);
    _$hash = $jc(_$hash, mostFlownAircraftFlights.hashCode);
    _$hash = $jc(_$hash, mostCommonTailNumber.hashCode);
    _$hash = $jc(_$hash, mostCommonTailNumberCount.hashCode);
    _$hash = $jc(_$hash, medianAge.hashCode);
    _$hash = $jc(_$hash, youngestAircraft.hashCode);
    _$hash = $jc(_$hash, oldestAircraft.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AircraftStatsEntity')
          ..add('mostFlownAircraftName', mostFlownAircraftName)
          ..add('mostFlownAircraftFlightCount', mostFlownAircraftFlightCount)
          ..add('mostFlownAircraftImage', mostFlownAircraftImage)
          ..add('mostFlownAircraftFlights', mostFlownAircraftFlights)
          ..add('mostCommonTailNumber', mostCommonTailNumber)
          ..add('mostCommonTailNumberCount', mostCommonTailNumberCount)
          ..add('medianAge', medianAge)
          ..add('youngestAircraft', youngestAircraft)
          ..add('oldestAircraft', oldestAircraft))
        .toString();
  }
}

class AircraftStatsEntityBuilder
    implements Builder<AircraftStatsEntity, AircraftStatsEntityBuilder> {
  _$AircraftStatsEntity? _$v;

  String? _mostFlownAircraftName;
  String? get mostFlownAircraftName => _$this._mostFlownAircraftName;
  set mostFlownAircraftName(String? mostFlownAircraftName) =>
      _$this._mostFlownAircraftName = mostFlownAircraftName;

  num? _mostFlownAircraftFlightCount;
  num? get mostFlownAircraftFlightCount => _$this._mostFlownAircraftFlightCount;
  set mostFlownAircraftFlightCount(num? mostFlownAircraftFlightCount) =>
      _$this._mostFlownAircraftFlightCount = mostFlownAircraftFlightCount;

  String? _mostFlownAircraftImage;
  String? get mostFlownAircraftImage => _$this._mostFlownAircraftImage;
  set mostFlownAircraftImage(String? mostFlownAircraftImage) =>
      _$this._mostFlownAircraftImage = mostFlownAircraftImage;

  ListBuilder<FlightSummaryEntity>? _mostFlownAircraftFlights;
  ListBuilder<FlightSummaryEntity> get mostFlownAircraftFlights =>
      _$this._mostFlownAircraftFlights ??= ListBuilder<FlightSummaryEntity>();
  set mostFlownAircraftFlights(
          ListBuilder<FlightSummaryEntity>? mostFlownAircraftFlights) =>
      _$this._mostFlownAircraftFlights = mostFlownAircraftFlights;

  String? _mostCommonTailNumber;
  String? get mostCommonTailNumber => _$this._mostCommonTailNumber;
  set mostCommonTailNumber(String? mostCommonTailNumber) =>
      _$this._mostCommonTailNumber = mostCommonTailNumber;

  num? _mostCommonTailNumberCount;
  num? get mostCommonTailNumberCount => _$this._mostCommonTailNumberCount;
  set mostCommonTailNumberCount(num? mostCommonTailNumberCount) =>
      _$this._mostCommonTailNumberCount = mostCommonTailNumberCount;

  num? _medianAge;
  num? get medianAge => _$this._medianAge;
  set medianAge(num? medianAge) => _$this._medianAge = medianAge;

  AircraftWithAgeBuilder? _youngestAircraft;
  AircraftWithAgeBuilder get youngestAircraft =>
      _$this._youngestAircraft ??= AircraftWithAgeBuilder();
  set youngestAircraft(AircraftWithAgeBuilder? youngestAircraft) =>
      _$this._youngestAircraft = youngestAircraft;

  AircraftWithAgeBuilder? _oldestAircraft;
  AircraftWithAgeBuilder get oldestAircraft =>
      _$this._oldestAircraft ??= AircraftWithAgeBuilder();
  set oldestAircraft(AircraftWithAgeBuilder? oldestAircraft) =>
      _$this._oldestAircraft = oldestAircraft;

  AircraftStatsEntityBuilder() {
    AircraftStatsEntity._defaults(this);
  }

  AircraftStatsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mostFlownAircraftName = $v.mostFlownAircraftName;
      _mostFlownAircraftFlightCount = $v.mostFlownAircraftFlightCount;
      _mostFlownAircraftImage = $v.mostFlownAircraftImage;
      _mostFlownAircraftFlights = $v.mostFlownAircraftFlights.toBuilder();
      _mostCommonTailNumber = $v.mostCommonTailNumber;
      _mostCommonTailNumberCount = $v.mostCommonTailNumberCount;
      _medianAge = $v.medianAge;
      _youngestAircraft = $v.youngestAircraft?.toBuilder();
      _oldestAircraft = $v.oldestAircraft?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AircraftStatsEntity other) {
    _$v = other as _$AircraftStatsEntity;
  }

  @override
  void update(void Function(AircraftStatsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AircraftStatsEntity build() => _build();

  _$AircraftStatsEntity _build() {
    _$AircraftStatsEntity _$result;
    try {
      _$result = _$v ??
          _$AircraftStatsEntity._(
            mostFlownAircraftName: BuiltValueNullFieldError.checkNotNull(
                mostFlownAircraftName,
                r'AircraftStatsEntity',
                'mostFlownAircraftName'),
            mostFlownAircraftFlightCount: BuiltValueNullFieldError.checkNotNull(
                mostFlownAircraftFlightCount,
                r'AircraftStatsEntity',
                'mostFlownAircraftFlightCount'),
            mostFlownAircraftImage: mostFlownAircraftImage,
            mostFlownAircraftFlights: mostFlownAircraftFlights.build(),
            mostCommonTailNumber: BuiltValueNullFieldError.checkNotNull(
                mostCommonTailNumber,
                r'AircraftStatsEntity',
                'mostCommonTailNumber'),
            mostCommonTailNumberCount: BuiltValueNullFieldError.checkNotNull(
                mostCommonTailNumberCount,
                r'AircraftStatsEntity',
                'mostCommonTailNumberCount'),
            medianAge: medianAge,
            youngestAircraft: _youngestAircraft?.build(),
            oldestAircraft: _oldestAircraft?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mostFlownAircraftFlights';
        mostFlownAircraftFlights.build();

        _$failedField = 'youngestAircraft';
        _youngestAircraft?.build();
        _$failedField = 'oldestAircraft';
        _oldestAircraft?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AircraftStatsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
