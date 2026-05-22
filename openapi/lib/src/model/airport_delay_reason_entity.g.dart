// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_delay_reason_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AirportDelayReasonEntityColorEnum
    _$airportDelayReasonEntityColorEnum_red =
    const AirportDelayReasonEntityColorEnum._('red');
const AirportDelayReasonEntityColorEnum
    _$airportDelayReasonEntityColorEnum_yellow =
    const AirportDelayReasonEntityColorEnum._('yellow');
const AirportDelayReasonEntityColorEnum
    _$airportDelayReasonEntityColorEnum_green =
    const AirportDelayReasonEntityColorEnum._('green');

AirportDelayReasonEntityColorEnum _$airportDelayReasonEntityColorEnumValueOf(
    String name) {
  switch (name) {
    case 'red':
      return _$airportDelayReasonEntityColorEnum_red;
    case 'yellow':
      return _$airportDelayReasonEntityColorEnum_yellow;
    case 'green':
      return _$airportDelayReasonEntityColorEnum_green;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AirportDelayReasonEntityColorEnum>
    _$airportDelayReasonEntityColorEnumValues = BuiltSet<
        AirportDelayReasonEntityColorEnum>(const <AirportDelayReasonEntityColorEnum>[
  _$airportDelayReasonEntityColorEnum_red,
  _$airportDelayReasonEntityColorEnum_yellow,
  _$airportDelayReasonEntityColorEnum_green,
]);

Serializer<AirportDelayReasonEntityColorEnum>
    _$airportDelayReasonEntityColorEnumSerializer =
    _$AirportDelayReasonEntityColorEnumSerializer();

class _$AirportDelayReasonEntityColorEnumSerializer
    implements PrimitiveSerializer<AirportDelayReasonEntityColorEnum> {
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
  final Iterable<Type> types = const <Type>[AirportDelayReasonEntityColorEnum];
  @override
  final String wireName = 'AirportDelayReasonEntityColorEnum';

  @override
  Object serialize(
          Serializers serializers, AirportDelayReasonEntityColorEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AirportDelayReasonEntityColorEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AirportDelayReasonEntityColorEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AirportDelayReasonEntity extends AirportDelayReasonEntity {
  @override
  final String category;
  @override
  final AirportDelayReasonEntityColorEnum color;
  @override
  final num delaySecs;
  @override
  final String reason;

  factory _$AirportDelayReasonEntity(
          [void Function(AirportDelayReasonEntityBuilder)? updates]) =>
      (AirportDelayReasonEntityBuilder()..update(updates))._build();

  _$AirportDelayReasonEntity._(
      {required this.category,
      required this.color,
      required this.delaySecs,
      required this.reason})
      : super._();
  @override
  AirportDelayReasonEntity rebuild(
          void Function(AirportDelayReasonEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AirportDelayReasonEntityBuilder toBuilder() =>
      AirportDelayReasonEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AirportDelayReasonEntity &&
        category == other.category &&
        color == other.color &&
        delaySecs == other.delaySecs &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, delaySecs.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AirportDelayReasonEntity')
          ..add('category', category)
          ..add('color', color)
          ..add('delaySecs', delaySecs)
          ..add('reason', reason))
        .toString();
  }
}

class AirportDelayReasonEntityBuilder
    implements
        Builder<AirportDelayReasonEntity, AirportDelayReasonEntityBuilder> {
  _$AirportDelayReasonEntity? _$v;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  AirportDelayReasonEntityColorEnum? _color;
  AirportDelayReasonEntityColorEnum? get color => _$this._color;
  set color(AirportDelayReasonEntityColorEnum? color) => _$this._color = color;

  num? _delaySecs;
  num? get delaySecs => _$this._delaySecs;
  set delaySecs(num? delaySecs) => _$this._delaySecs = delaySecs;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  AirportDelayReasonEntityBuilder() {
    AirportDelayReasonEntity._defaults(this);
  }

  AirportDelayReasonEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _color = $v.color;
      _delaySecs = $v.delaySecs;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AirportDelayReasonEntity other) {
    _$v = other as _$AirportDelayReasonEntity;
  }

  @override
  void update(void Function(AirportDelayReasonEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AirportDelayReasonEntity build() => _build();

  _$AirportDelayReasonEntity _build() {
    final _$result = _$v ??
        _$AirportDelayReasonEntity._(
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'AirportDelayReasonEntity', 'category'),
          color: BuiltValueNullFieldError.checkNotNull(
              color, r'AirportDelayReasonEntity', 'color'),
          delaySecs: BuiltValueNullFieldError.checkNotNull(
              delaySecs, r'AirportDelayReasonEntity', 'delaySecs'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'AirportDelayReasonEntity', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
