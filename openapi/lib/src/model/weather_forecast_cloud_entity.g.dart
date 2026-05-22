// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_cloud_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnum_empty =
    const WeatherForecastCloudEntityCoverageEnum._('empty');
const WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnum_skyClear =
    const WeatherForecastCloudEntityCoverageEnum._('skyClear');
const WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnum_few =
    const WeatherForecastCloudEntityCoverageEnum._('few');
const WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnum_scattered =
    const WeatherForecastCloudEntityCoverageEnum._('scattered');
const WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnum_broken =
    const WeatherForecastCloudEntityCoverageEnum._('broken');
const WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnum_overcast =
    const WeatherForecastCloudEntityCoverageEnum._('overcast');

WeatherForecastCloudEntityCoverageEnum
    _$weatherForecastCloudEntityCoverageEnumValueOf(String name) {
  switch (name) {
    case 'empty':
      return _$weatherForecastCloudEntityCoverageEnum_empty;
    case 'skyClear':
      return _$weatherForecastCloudEntityCoverageEnum_skyClear;
    case 'few':
      return _$weatherForecastCloudEntityCoverageEnum_few;
    case 'scattered':
      return _$weatherForecastCloudEntityCoverageEnum_scattered;
    case 'broken':
      return _$weatherForecastCloudEntityCoverageEnum_broken;
    case 'overcast':
      return _$weatherForecastCloudEntityCoverageEnum_overcast;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WeatherForecastCloudEntityCoverageEnum>
    _$weatherForecastCloudEntityCoverageEnumValues = BuiltSet<
        WeatherForecastCloudEntityCoverageEnum>(const <WeatherForecastCloudEntityCoverageEnum>[
  _$weatherForecastCloudEntityCoverageEnum_empty,
  _$weatherForecastCloudEntityCoverageEnum_skyClear,
  _$weatherForecastCloudEntityCoverageEnum_few,
  _$weatherForecastCloudEntityCoverageEnum_scattered,
  _$weatherForecastCloudEntityCoverageEnum_broken,
  _$weatherForecastCloudEntityCoverageEnum_overcast,
]);

Serializer<WeatherForecastCloudEntityCoverageEnum>
    _$weatherForecastCloudEntityCoverageEnumSerializer =
    _$WeatherForecastCloudEntityCoverageEnumSerializer();

class _$WeatherForecastCloudEntityCoverageEnumSerializer
    implements PrimitiveSerializer<WeatherForecastCloudEntityCoverageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'empty': '',
    'skyClear': 'sky_clear',
    'few': 'few',
    'scattered': 'scattered',
    'broken': 'broken',
    'overcast': 'overcast',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '': 'empty',
    'sky_clear': 'skyClear',
    'few': 'few',
    'scattered': 'scattered',
    'broken': 'broken',
    'overcast': 'overcast',
  };

  @override
  final Iterable<Type> types = const <Type>[
    WeatherForecastCloudEntityCoverageEnum
  ];
  @override
  final String wireName = 'WeatherForecastCloudEntityCoverageEnum';

  @override
  Object serialize(Serializers serializers,
          WeatherForecastCloudEntityCoverageEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WeatherForecastCloudEntityCoverageEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WeatherForecastCloudEntityCoverageEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WeatherForecastCloudEntity extends WeatherForecastCloudEntity {
  @override
  final String symbol;
  @override
  final WeatherForecastCloudEntityCoverageEnum? coverage;
  @override
  final JsonObject? altitude;
  @override
  final JsonObject? special;

  factory _$WeatherForecastCloudEntity(
          [void Function(WeatherForecastCloudEntityBuilder)? updates]) =>
      (WeatherForecastCloudEntityBuilder()..update(updates))._build();

  _$WeatherForecastCloudEntity._(
      {required this.symbol, this.coverage, this.altitude, this.special})
      : super._();
  @override
  WeatherForecastCloudEntity rebuild(
          void Function(WeatherForecastCloudEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastCloudEntityBuilder toBuilder() =>
      WeatherForecastCloudEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecastCloudEntity &&
        symbol == other.symbol &&
        coverage == other.coverage &&
        altitude == other.altitude &&
        special == other.special;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, coverage.hashCode);
    _$hash = $jc(_$hash, altitude.hashCode);
    _$hash = $jc(_$hash, special.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecastCloudEntity')
          ..add('symbol', symbol)
          ..add('coverage', coverage)
          ..add('altitude', altitude)
          ..add('special', special))
        .toString();
  }
}

class WeatherForecastCloudEntityBuilder
    implements
        Builder<WeatherForecastCloudEntity, WeatherForecastCloudEntityBuilder> {
  _$WeatherForecastCloudEntity? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  WeatherForecastCloudEntityCoverageEnum? _coverage;
  WeatherForecastCloudEntityCoverageEnum? get coverage => _$this._coverage;
  set coverage(WeatherForecastCloudEntityCoverageEnum? coverage) =>
      _$this._coverage = coverage;

  JsonObject? _altitude;
  JsonObject? get altitude => _$this._altitude;
  set altitude(JsonObject? altitude) => _$this._altitude = altitude;

  JsonObject? _special;
  JsonObject? get special => _$this._special;
  set special(JsonObject? special) => _$this._special = special;

  WeatherForecastCloudEntityBuilder() {
    WeatherForecastCloudEntity._defaults(this);
  }

  WeatherForecastCloudEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _coverage = $v.coverage;
      _altitude = $v.altitude;
      _special = $v.special;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecastCloudEntity other) {
    _$v = other as _$WeatherForecastCloudEntity;
  }

  @override
  void update(void Function(WeatherForecastCloudEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecastCloudEntity build() => _build();

  _$WeatherForecastCloudEntity _build() {
    final _$result = _$v ??
        _$WeatherForecastCloudEntity._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'WeatherForecastCloudEntity', 'symbol'),
          coverage: coverage,
          altitude: altitude,
          special: special,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
