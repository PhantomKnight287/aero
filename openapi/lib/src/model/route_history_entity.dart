//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/stats_flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_history_entity.g.dart';

/// RouteHistoryEntity
///
/// Properties:
/// * [flightCount] 
/// * [distanceKm] 
/// * [blockMinutes] 
/// * [recent] - Up to 3, newest first
@BuiltValue()
abstract class RouteHistoryEntity implements Built<RouteHistoryEntity, RouteHistoryEntityBuilder> {
  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  @BuiltValueField(wireName: r'blockMinutes')
  num get blockMinutes;

  /// Up to 3, newest first
  @BuiltValueField(wireName: r'recent')
  BuiltList<StatsFlightSummaryEntity> get recent;

  RouteHistoryEntity._();

  factory RouteHistoryEntity([void updates(RouteHistoryEntityBuilder b)]) = _$RouteHistoryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RouteHistoryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RouteHistoryEntity> get serializer => _$RouteHistoryEntitySerializer();
}

class _$RouteHistoryEntitySerializer implements PrimitiveSerializer<RouteHistoryEntity> {
  @override
  final Iterable<Type> types = const [RouteHistoryEntity, _$RouteHistoryEntity];

  @override
  final String wireName = r'RouteHistoryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RouteHistoryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
    yield r'distanceKm';
    yield serializers.serialize(
      object.distanceKm,
      specifiedType: const FullType(num),
    );
    yield r'blockMinutes';
    yield serializers.serialize(
      object.blockMinutes,
      specifiedType: const FullType(num),
    );
    yield r'recent';
    yield serializers.serialize(
      object.recent,
      specifiedType: const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RouteHistoryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RouteHistoryEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flightCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.flightCount = valueDes;
          break;
        case r'distanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.distanceKm = valueDes;
          break;
        case r'blockMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.blockMinutes = valueDes;
          break;
        case r'recent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
          ) as BuiltList<StatsFlightSummaryEntity>;
          result.recent.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RouteHistoryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RouteHistoryEntityBuilder();
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


