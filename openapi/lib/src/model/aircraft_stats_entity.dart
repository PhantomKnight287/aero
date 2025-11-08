//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/aircraft_with_age.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'aircraft_stats_entity.g.dart';

/// AircraftStatsEntity
///
/// Properties:
/// * [mostFlownAircraftName] 
/// * [mostFlownAircraftFlightCount] 
/// * [mostFlownAircraftImage] 
/// * [mostFlownAircraftFlights] 
/// * [mostCommonTailNumber] 
/// * [mostCommonTailNumberCount] 
/// * [medianAge] 
/// * [youngestAircraft] 
/// * [oldestAircraft] 
@BuiltValue()
abstract class AircraftStatsEntity implements Built<AircraftStatsEntity, AircraftStatsEntityBuilder> {
  @BuiltValueField(wireName: r'mostFlownAircraftName')
  String get mostFlownAircraftName;

  @BuiltValueField(wireName: r'mostFlownAircraftFlightCount')
  num get mostFlownAircraftFlightCount;

  @BuiltValueField(wireName: r'mostFlownAircraftImage')
  String? get mostFlownAircraftImage;

  @BuiltValueField(wireName: r'mostFlownAircraftFlights')
  BuiltList<FlightSummaryEntity> get mostFlownAircraftFlights;

  @BuiltValueField(wireName: r'mostCommonTailNumber')
  String get mostCommonTailNumber;

  @BuiltValueField(wireName: r'mostCommonTailNumberCount')
  num get mostCommonTailNumberCount;

  @BuiltValueField(wireName: r'medianAge')
  num? get medianAge;

  @BuiltValueField(wireName: r'youngestAircraft')
  AircraftWithAge? get youngestAircraft;

  @BuiltValueField(wireName: r'oldestAircraft')
  AircraftWithAge? get oldestAircraft;

  AircraftStatsEntity._();

  factory AircraftStatsEntity([void updates(AircraftStatsEntityBuilder b)]) = _$AircraftStatsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AircraftStatsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AircraftStatsEntity> get serializer => _$AircraftStatsEntitySerializer();
}

class _$AircraftStatsEntitySerializer implements PrimitiveSerializer<AircraftStatsEntity> {
  @override
  final Iterable<Type> types = const [AircraftStatsEntity, _$AircraftStatsEntity];

  @override
  final String wireName = r'AircraftStatsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AircraftStatsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mostFlownAircraftName';
    yield serializers.serialize(
      object.mostFlownAircraftName,
      specifiedType: const FullType(String),
    );
    yield r'mostFlownAircraftFlightCount';
    yield serializers.serialize(
      object.mostFlownAircraftFlightCount,
      specifiedType: const FullType(num),
    );
    if (object.mostFlownAircraftImage != null) {
      yield r'mostFlownAircraftImage';
      yield serializers.serialize(
        object.mostFlownAircraftImage,
        specifiedType: const FullType(String),
      );
    }
    yield r'mostFlownAircraftFlights';
    yield serializers.serialize(
      object.mostFlownAircraftFlights,
      specifiedType: const FullType(BuiltList, [FullType(FlightSummaryEntity)]),
    );
    yield r'mostCommonTailNumber';
    yield serializers.serialize(
      object.mostCommonTailNumber,
      specifiedType: const FullType(String),
    );
    yield r'mostCommonTailNumberCount';
    yield serializers.serialize(
      object.mostCommonTailNumberCount,
      specifiedType: const FullType(num),
    );
    if (object.medianAge != null) {
      yield r'medianAge';
      yield serializers.serialize(
        object.medianAge,
        specifiedType: const FullType(num),
      );
    }
    if (object.youngestAircraft != null) {
      yield r'youngestAircraft';
      yield serializers.serialize(
        object.youngestAircraft,
        specifiedType: const FullType(AircraftWithAge),
      );
    }
    if (object.oldestAircraft != null) {
      yield r'oldestAircraft';
      yield serializers.serialize(
        object.oldestAircraft,
        specifiedType: const FullType(AircraftWithAge),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AircraftStatsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AircraftStatsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mostFlownAircraftName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mostFlownAircraftName = valueDes;
          break;
        case r'mostFlownAircraftFlightCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.mostFlownAircraftFlightCount = valueDes;
          break;
        case r'mostFlownAircraftImage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mostFlownAircraftImage = valueDes;
          break;
        case r'mostFlownAircraftFlights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FlightSummaryEntity)]),
          ) as BuiltList<FlightSummaryEntity>;
          result.mostFlownAircraftFlights.replace(valueDes);
          break;
        case r'mostCommonTailNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mostCommonTailNumber = valueDes;
          break;
        case r'mostCommonTailNumberCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.mostCommonTailNumberCount = valueDes;
          break;
        case r'medianAge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.medianAge = valueDes;
          break;
        case r'youngestAircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AircraftWithAge),
          ) as AircraftWithAge;
          result.youngestAircraft.replace(valueDes);
          break;
        case r'oldestAircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AircraftWithAge),
          ) as AircraftWithAge;
          result.oldestAircraft.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AircraftStatsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AircraftStatsEntityBuilder();
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

