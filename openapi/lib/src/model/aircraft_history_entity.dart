//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/flight_summary_entity.dart';
import 'package:openapi/src/model/aircraft_leg_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_history_entity.g.dart';

/// AircraftHistoryEntity
///
/// Properties:
/// * [registration] 
/// * [inbound] - This airframe's previous leg (inbound to this flight)
/// * [ownFlights] - The user's other logged flights on the same registration
@BuiltValue()
abstract class AircraftHistoryEntity implements Built<AircraftHistoryEntity, AircraftHistoryEntityBuilder> {
  @BuiltValueField(wireName: r'registration')
  String? get registration;

  /// This airframe's previous leg (inbound to this flight)
  @BuiltValueField(wireName: r'inbound')
  AircraftLegEntity? get inbound;

  /// The user's other logged flights on the same registration
  @BuiltValueField(wireName: r'ownFlights')
  BuiltList<FlightSummaryEntity> get ownFlights;

  AircraftHistoryEntity._();

  factory AircraftHistoryEntity([void updates(AircraftHistoryEntityBuilder b)]) = _$AircraftHistoryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftHistoryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftHistoryEntity> get serializer => _$AircraftHistoryEntitySerializer();
}

class _$AircraftHistoryEntitySerializer implements PrimitiveSerializer<AircraftHistoryEntity> {
  @override
  final Iterable<Type> types = const [AircraftHistoryEntity, _$AircraftHistoryEntity];

  @override
  final String wireName = r'AircraftHistoryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftHistoryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'registration';
    yield object.registration == null ? null : serializers.serialize(
      object.registration,
      specifiedType: const FullType.nullable(String),
    );
    yield r'inbound';
    yield object.inbound == null ? null : serializers.serialize(
      object.inbound,
      specifiedType: const FullType.nullable(AircraftLegEntity),
    );
    yield r'ownFlights';
    yield serializers.serialize(
      object.ownFlights,
      specifiedType: const FullType(BuiltList, [FullType(FlightSummaryEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftHistoryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftHistoryEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'registration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.registration = valueDes;
          break;
        case r'inbound':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AircraftLegEntity),
          ) as AircraftLegEntity?;
          if (valueDes == null) continue;
          result.inbound.replace(valueDes);
          break;
        case r'ownFlights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FlightSummaryEntity)]),
          ) as BuiltList<FlightSummaryEntity>;
          result.ownFlights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftHistoryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftHistoryEntityBuilder();
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


