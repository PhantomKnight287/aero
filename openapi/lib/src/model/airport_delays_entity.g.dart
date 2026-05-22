// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_delays_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AirportDelaysEntityColorEnum _$airportDelaysEntityColorEnum_red =
    const AirportDelaysEntityColorEnum._('red');
const AirportDelaysEntityColorEnum _$airportDelaysEntityColorEnum_yellow =
    const AirportDelaysEntityColorEnum._('yellow');
const AirportDelaysEntityColorEnum _$airportDelaysEntityColorEnum_green =
    const AirportDelaysEntityColorEnum._('green');

AirportDelaysEntityColorEnum _$airportDelaysEntityColorEnumValueOf(
    String name) {
  switch (name) {
    case 'red':
      return _$airportDelaysEntityColorEnum_red;
    case 'yellow':
      return _$airportDelaysEntityColorEnum_yellow;
    case 'green':
      return _$airportDelaysEntityColorEnum_green;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AirportDelaysEntityColorEnum>
    _$airportDelaysEntityColorEnumValues =
    BuiltSet<AirportDelaysEntityColorEnum>(const <AirportDelaysEntityColorEnum>[
  _$airportDelaysEntityColorEnum_red,
  _$airportDelaysEntityColorEnum_yellow,
  _$airportDelaysEntityColorEnum_green,
]);

Serializer<AirportDelaysEntityColorEnum>
    _$airportDelaysEntityColorEnumSerializer =
    _$AirportDelaysEntityColorEnumSerializer();

class _$AirportDelaysEntityColorEnumSerializer
    implements PrimitiveSerializer<AirportDelaysEntityColorEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'red': 'red',
    'yellow': 'yellow',
    'green': 'green',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'red': 'red',
    'yellow': 'yellow',
    'green': 'green',
  };

  @override
  final Iterable<Type> types = const <Type>[AirportDelaysEntityColorEnum];
  @override
  final String wireName = 'AirportDelaysEntityColorEnum';

  @override
  Object serialize(Serializers serializers, AirportDelaysEntityColorEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirportDelaysEntityColorEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirportDelaysEntityColorEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AirportDelaysEntity extends AirportDelaysEntity {
  @override
  final String airport;
  @override
  final String category;
  @override
  final AirportDelaysEntityColorEnum color;
  @override
  final num delaySecs;
  @override
  final BuiltList<AirportDelayReasonEntity> reasons;

  factory _$AirportDelaysEntity(
          [void Function(AirportDelaysEntityBuilder)? updates]) =>
      (AirportDelaysEntityBuilder()..update(updates))._build();

  _$AirportDelaysEntity._(
      {required this.airport,
      required this.category,
      required this.color,
      required this.delaySecs,
      required this.reasons})
      : super._();
  @override
  AirportDelaysEntity rebuild(
          void Function(AirportDelaysEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportDelaysEntityBuilder toBuilder() =>
      AirportDelaysEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportDelaysEntity &&
        airport == other.airport &&
        category == other.category &&
        color == other.color &&
        delaySecs == other.delaySecs &&
        reasons == other.reasons;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, airport.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, delaySecs.hashCode);
    _$hash = $jc(_$hash, reasons.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportDelaysEntity')
          ..add('airport', airport)
          ..add('category', category)
          ..add('color', color)
          ..add('delaySecs', delaySecs)
          ..add('reasons', reasons))
        .toString();
  }
}

class AirportDelaysEntityBuilder
    implements Builder<AirportDelaysEntity, AirportDelaysEntityBuilder> {
  _$AirportDelaysEntity? _$v;

  String? _airport;
  String? get airport => _$this._airport;
  set airport(String? airport) => _$this._airport = airport;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  AirportDelaysEntityColorEnum? _color;
  AirportDelaysEntityColorEnum? get color => _$this._color;
  set color(AirportDelaysEntityColorEnum? color) => _$this._color = color;

  num? _delaySecs;
  num? get delaySecs => _$this._delaySecs;
  set delaySecs(num? delaySecs) => _$this._delaySecs = delaySecs;

  ListBuilder<AirportDelayReasonEntity>? _reasons;
  ListBuilder<AirportDelayReasonEntity> get reasons =>
      _$this._reasons ??= ListBuilder<AirportDelayReasonEntity>();
  set reasons(ListBuilder<AirportDelayReasonEntity>? reasons) =>
      _$this._reasons = reasons;

  AirportDelaysEntityBuilder() {
    AirportDelaysEntity._defaults(this);
  }

  AirportDelaysEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _airport = $v.airport;
      _category = $v.category;
      _color = $v.color;
      _delaySecs = $v.delaySecs;
      _reasons = $v.reasons.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportDelaysEntity other) {
    _$v = other as _$AirportDelaysEntity;
  }

  @override
  void update(void Function(AirportDelaysEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportDelaysEntity build() => _build();

  _$AirportDelaysEntity _build() {
    _$AirportDelaysEntity _$result;
    try {
      _$result = _$v ??
          _$AirportDelaysEntity._(
            airport: BuiltValueNullFieldError.checkNotNull(
                airport, r'AirportDelaysEntity', 'airport'),
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'AirportDelaysEntity', 'category'),
            color: BuiltValueNullFieldError.checkNotNull(
                color, r'AirportDelaysEntity', 'color'),
            delaySecs: BuiltValueNullFieldError.checkNotNull(
                delaySecs, r'AirportDelaysEntity', 'delaySecs'),
            reasons: reasons.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reasons';
        reasons.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AirportDelaysEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
