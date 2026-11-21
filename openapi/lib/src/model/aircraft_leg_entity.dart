//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_leg_entity.g.dart';

/// AircraftLegEntity
///
/// Properties:
/// * [faFlightId] 
/// * [ident] 
/// * [identIata] 
/// * [identIcao] 
/// * [status] - FlightAware status text
/// * [originIata] 
/// * [originIcao] 
/// * [originCity] 
/// * [originTimezone] 
/// * [destinationIata] 
/// * [destinationIcao] 
/// * [destinationCity] 
/// * [destinationTimezone] 
/// * [scheduledOut] - ISO time
/// * [estimatedOut] - ISO time
/// * [actualOut] - ISO time
/// * [scheduledIn] - ISO time
/// * [estimatedIn] - ISO time
/// * [actualIn] - ISO time
/// * [arrivalDelay] - Seconds, negative = early
/// * [progressPercent] - 0-100
/// * [cancelled] 
@BuiltValue()
abstract class AircraftLegEntity implements Built<AircraftLegEntity, AircraftLegEntityBuilder> {
  @BuiltValueField(wireName: r'faFlightId')
  String get faFlightId;

  @BuiltValueField(wireName: r'ident')
  String get ident;

  @BuiltValueField(wireName: r'identIata')
  String? get identIata;

  @BuiltValueField(wireName: r'identIcao')
  String? get identIcao;

  /// FlightAware status text
  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'originIata')
  String? get originIata;

  @BuiltValueField(wireName: r'originIcao')
  String? get originIcao;

  @BuiltValueField(wireName: r'originCity')
  String? get originCity;

  @BuiltValueField(wireName: r'originTimezone')
  String? get originTimezone;

  @BuiltValueField(wireName: r'destinationIata')
  String? get destinationIata;

  @BuiltValueField(wireName: r'destinationIcao')
  String? get destinationIcao;

  @BuiltValueField(wireName: r'destinationCity')
  String? get destinationCity;

  @BuiltValueField(wireName: r'destinationTimezone')
  String? get destinationTimezone;

  /// ISO time
  @BuiltValueField(wireName: r'scheduledOut')
  String? get scheduledOut;

  /// ISO time
  @BuiltValueField(wireName: r'estimatedOut')
  String? get estimatedOut;

  /// ISO time
  @BuiltValueField(wireName: r'actualOut')
  String? get actualOut;

  /// ISO time
  @BuiltValueField(wireName: r'scheduledIn')
  String? get scheduledIn;

  /// ISO time
  @BuiltValueField(wireName: r'estimatedIn')
  String? get estimatedIn;

  /// ISO time
  @BuiltValueField(wireName: r'actualIn')
  String? get actualIn;

  /// Seconds, negative = early
  @BuiltValueField(wireName: r'arrivalDelay')
  num? get arrivalDelay;

  /// 0-100
  @BuiltValueField(wireName: r'progressPercent')
  num? get progressPercent;

  @BuiltValueField(wireName: r'cancelled')
  bool get cancelled;

  AircraftLegEntity._();

  factory AircraftLegEntity([void updates(AircraftLegEntityBuilder b)]) = _$AircraftLegEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftLegEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftLegEntity> get serializer => _$AircraftLegEntitySerializer();
}

class _$AircraftLegEntitySerializer implements PrimitiveSerializer<AircraftLegEntity> {
  @override
  final Iterable<Type> types = const [AircraftLegEntity, _$AircraftLegEntity];

  @override
  final String wireName = r'AircraftLegEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftLegEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'faFlightId';
    yield serializers.serialize(
      object.faFlightId,
      specifiedType: const FullType(String),
    );
    yield r'ident';
    yield serializers.serialize(
      object.ident,
      specifiedType: const FullType(String),
    );
    if (object.identIata != null) {
      yield r'identIata';
      yield serializers.serialize(
        object.identIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.identIcao != null) {
      yield r'identIcao';
      yield serializers.serialize(
        object.identIcao,
        specifiedType: const FullType(String),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    if (object.originIata != null) {
      yield r'originIata';
      yield serializers.serialize(
        object.originIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.originIcao != null) {
      yield r'originIcao';
      yield serializers.serialize(
        object.originIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.originCity != null) {
      yield r'originCity';
      yield serializers.serialize(
        object.originCity,
        specifiedType: const FullType(String),
      );
    }
    if (object.originTimezone != null) {
      yield r'originTimezone';
      yield serializers.serialize(
        object.originTimezone,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationIata != null) {
      yield r'destinationIata';
      yield serializers.serialize(
        object.destinationIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationIcao != null) {
      yield r'destinationIcao';
      yield serializers.serialize(
        object.destinationIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationCity != null) {
      yield r'destinationCity';
      yield serializers.serialize(
        object.destinationCity,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationTimezone != null) {
      yield r'destinationTimezone';
      yield serializers.serialize(
        object.destinationTimezone,
        specifiedType: const FullType(String),
      );
    }
    if (object.scheduledOut != null) {
      yield r'scheduledOut';
      yield serializers.serialize(
        object.scheduledOut,
        specifiedType: const FullType(String),
      );
    }
    if (object.estimatedOut != null) {
      yield r'estimatedOut';
      yield serializers.serialize(
        object.estimatedOut,
        specifiedType: const FullType(String),
      );
    }
    if (object.actualOut != null) {
      yield r'actualOut';
      yield serializers.serialize(
        object.actualOut,
        specifiedType: const FullType(String),
      );
    }
    if (object.scheduledIn != null) {
      yield r'scheduledIn';
      yield serializers.serialize(
        object.scheduledIn,
        specifiedType: const FullType(String),
      );
    }
    if (object.estimatedIn != null) {
      yield r'estimatedIn';
      yield serializers.serialize(
        object.estimatedIn,
        specifiedType: const FullType(String),
      );
    }
    if (object.actualIn != null) {
      yield r'actualIn';
      yield serializers.serialize(
        object.actualIn,
        specifiedType: const FullType(String),
      );
    }
    if (object.arrivalDelay != null) {
      yield r'arrivalDelay';
      yield serializers.serialize(
        object.arrivalDelay,
        specifiedType: const FullType(num),
      );
    }
    if (object.progressPercent != null) {
      yield r'progressPercent';
      yield serializers.serialize(
        object.progressPercent,
        specifiedType: const FullType(num),
      );
    }
    yield r'cancelled';
    yield serializers.serialize(
      object.cancelled,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftLegEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftLegEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'faFlightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.faFlightId = valueDes;
          break;
        case r'ident':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ident = valueDes;
          break;
        case r'identIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.identIata = valueDes;
          break;
        case r'identIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.identIcao = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'originIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.originIata = valueDes;
          break;
        case r'originIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.originIcao = valueDes;
          break;
        case r'originCity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.originCity = valueDes;
          break;
        case r'originTimezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.originTimezone = valueDes;
          break;
        case r'destinationIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.destinationIata = valueDes;
          break;
        case r'destinationIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.destinationIcao = valueDes;
          break;
        case r'destinationCity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.destinationCity = valueDes;
          break;
        case r'destinationTimezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.destinationTimezone = valueDes;
          break;
        case r'scheduledOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scheduledOut = valueDes;
          break;
        case r'estimatedOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedOut = valueDes;
          break;
        case r'actualOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actualOut = valueDes;
          break;
        case r'scheduledIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scheduledIn = valueDes;
          break;
        case r'estimatedIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedIn = valueDes;
          break;
        case r'actualIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actualIn = valueDes;
          break;
        case r'arrivalDelay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.arrivalDelay = valueDes;
          break;
        case r'progressPercent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.progressPercent = valueDes;
          break;
        case r'cancelled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cancelled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftLegEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftLegEntityBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


