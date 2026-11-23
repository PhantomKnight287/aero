//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/stats_flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_type_entity.g.dart';

/// AircraftTypeEntity
///
/// Properties:
/// * [typeCode] - ICAO type code, e.g. B77W
/// * [typeName] 
/// * [image] 
/// * [flightCount] 
/// * [flights] - Newest first
@BuiltValue()
abstract class AircraftTypeEntity implements Built<AircraftTypeEntity, AircraftTypeEntityBuilder> {
  /// ICAO type code, e.g. B77W
  @BuiltValueField(wireName: r'typeCode')
  String? get typeCode;

  @BuiltValueField(wireName: r'typeName')
  String get typeName;

  @BuiltValueField(wireName: r'image')
  String? get image;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  /// Newest first
  @BuiltValueField(wireName: r'flights')
  BuiltList<StatsFlightSummaryEntity> get flights;

  AircraftTypeEntity._();

  factory AircraftTypeEntity([void updates(AircraftTypeEntityBuilder b)]) = _$AircraftTypeEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftTypeEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftTypeEntity> get serializer => _$AircraftTypeEntitySerializer();
}

class _$AircraftTypeEntitySerializer implements PrimitiveSerializer<AircraftTypeEntity> {
  @override
  final Iterable<Type> types = const [AircraftTypeEntity, _$AircraftTypeEntity];

  @override
  final String wireName = r'AircraftTypeEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftTypeEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.typeCode != null) {
      yield r'typeCode';
      yield serializers.serialize(
        object.typeCode,
        specifiedType: const FullType(String),
      );
    }
    yield r'typeName';
    yield serializers.serialize(
      object.typeName,
      specifiedType: const FullType(String),
    );
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
    yield r'flights';
    yield serializers.serialize(
      object.flights,
      specifiedType: const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftTypeEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftTypeEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'typeCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typeCode = valueDes;
          break;
        case r'typeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.typeName = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.image = valueDes;
          break;
        case r'flightCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.flightCount = valueDes;
          break;
        case r'flights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
          ) as BuiltList<StatsFlightSummaryEntity>;
          result.flights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftTypeEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftTypeEntityBuilder();
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


