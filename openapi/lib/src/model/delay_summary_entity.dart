//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/delay_airline_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/delay_buckets_entity.dart';
import 'package:openapi/src/model/stats_record_entity.dart';
import 'package:openapi/src/model/delay_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delay_summary_entity.g.dart';

/// DelaySummaryEntity
///
/// Properties:
/// * [basedOn] 
/// * [arrivedCount] 
/// * [delayedCount] 
/// * [minutesLost] 
/// * [avgDelayMinutes] 
/// * [netMinutes] - Signed sum of arrival delays (negative = early)
/// * [buckets] 
/// * [worst] 
/// * [airlines] 
/// * [airports] 
/// * [flights] - Delayed flights, worst first
@BuiltValue()
abstract class DelaySummaryEntity implements Built<DelaySummaryEntity, DelaySummaryEntityBuilder> {
  @BuiltValueField(wireName: r'basedOn')
  num get basedOn;

  @BuiltValueField(wireName: r'arrivedCount')
  num get arrivedCount;

  @BuiltValueField(wireName: r'delayedCount')
  num get delayedCount;

  @BuiltValueField(wireName: r'minutesLost')
  num get minutesLost;

  @BuiltValueField(wireName: r'avgDelayMinutes')
  num get avgDelayMinutes;

  /// Signed sum of arrival delays (negative = early)
  @BuiltValueField(wireName: r'netMinutes')
  num get netMinutes;

  @BuiltValueField(wireName: r'buckets')
  DelayBucketsEntity get buckets;

  @BuiltValueField(wireName: r'worst')
  StatsRecordEntity? get worst;

  @BuiltValueField(wireName: r'airlines')
  BuiltList<DelayAirlineEntity> get airlines;

  @BuiltValueField(wireName: r'airports')
  BuiltList<DelayAirportEntity> get airports;

  /// Delayed flights, worst first
  @BuiltValueField(wireName: r'flights')
  BuiltList<StatsRecordEntity> get flights;

  DelaySummaryEntity._();

  factory DelaySummaryEntity([void updates(DelaySummaryEntityBuilder b)]) = _$DelaySummaryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DelaySummaryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DelaySummaryEntity> get serializer => _$DelaySummaryEntitySerializer();
}

class _$DelaySummaryEntitySerializer implements PrimitiveSerializer<DelaySummaryEntity> {
  @override
  final Iterable<Type> types = const [DelaySummaryEntity, _$DelaySummaryEntity];

  @override
  final String wireName = r'DelaySummaryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DelaySummaryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'basedOn';
    yield serializers.serialize(
      object.basedOn,
      specifiedType: const FullType(num),
    );
    yield r'arrivedCount';
    yield serializers.serialize(
      object.arrivedCount,
      specifiedType: const FullType(num),
    );
    yield r'delayedCount';
    yield serializers.serialize(
      object.delayedCount,
      specifiedType: const FullType(num),
    );
    yield r'minutesLost';
    yield serializers.serialize(
      object.minutesLost,
      specifiedType: const FullType(num),
    );
    yield r'avgDelayMinutes';
    yield serializers.serialize(
      object.avgDelayMinutes,
      specifiedType: const FullType(num),
    );
    yield r'netMinutes';
    yield serializers.serialize(
      object.netMinutes,
      specifiedType: const FullType(num),
    );
    yield r'buckets';
    yield serializers.serialize(
      object.buckets,
      specifiedType: const FullType(DelayBucketsEntity),
    );
    if (object.worst != null) {
      yield r'worst';
      yield serializers.serialize(
        object.worst,
        specifiedType: const FullType.nullable(StatsRecordEntity),
      );
    }
    yield r'airlines';
    yield serializers.serialize(
      object.airlines,
      specifiedType: const FullType(BuiltList, [FullType(DelayAirlineEntity)]),
    );
    yield r'airports';
    yield serializers.serialize(
      object.airports,
      specifiedType: const FullType(BuiltList, [FullType(DelayAirportEntity)]),
    );
    yield r'flights';
    yield serializers.serialize(
      object.flights,
      specifiedType: const FullType(BuiltList, [FullType(StatsRecordEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DelaySummaryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DelaySummaryEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'basedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.basedOn = valueDes;
          break;
        case r'arrivedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.arrivedCount = valueDes;
          break;
        case r'delayedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.delayedCount = valueDes;
          break;
        case r'minutesLost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minutesLost = valueDes;
          break;
        case r'avgDelayMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.avgDelayMinutes = valueDes;
          break;
        case r'netMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.netMinutes = valueDes;
          break;
        case r'buckets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DelayBucketsEntity),
          ) as DelayBucketsEntity;
          result.buckets.replace(valueDes);
          break;
        case r'worst':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsRecordEntity),
          ) as StatsRecordEntity?;
          if (valueDes == null) continue;
          result.worst.replace(valueDes);
          break;
        case r'airlines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DelayAirlineEntity)]),
          ) as BuiltList<DelayAirlineEntity>;
          result.airlines.replace(valueDes);
          break;
        case r'airports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DelayAirportEntity)]),
          ) as BuiltList<DelayAirportEntity>;
          result.airports.replace(valueDes);
          break;
        case r'flights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StatsRecordEntity)]),
          ) as BuiltList<StatsRecordEntity>;
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
  DelaySummaryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DelaySummaryEntityBuilder();
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


