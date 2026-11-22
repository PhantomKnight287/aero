//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/stats_flight_summary_entity.dart';
import 'package:openapi/src/model/year_count_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_history_response_entity.g.dart';

/// FlightHistoryResponseEntity
///
/// Properties:
/// * [items] 
/// * [nextCursor] 
/// * [yearCounts] - All years, desc
@BuiltValue()
abstract class FlightHistoryResponseEntity implements Built<FlightHistoryResponseEntity, FlightHistoryResponseEntityBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<StatsFlightSummaryEntity> get items;

  @BuiltValueField(wireName: r'nextCursor')
  String? get nextCursor;

  /// All years, desc
  @BuiltValueField(wireName: r'yearCounts')
  BuiltList<YearCountEntity> get yearCounts;

  FlightHistoryResponseEntity._();

  factory FlightHistoryResponseEntity([void updates(FlightHistoryResponseEntityBuilder b)]) = _$FlightHistoryResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightHistoryResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightHistoryResponseEntity> get serializer => _$FlightHistoryResponseEntitySerializer();
}

class _$FlightHistoryResponseEntitySerializer implements PrimitiveSerializer<FlightHistoryResponseEntity> {
  @override
  final Iterable<Type> types = const [FlightHistoryResponseEntity, _$FlightHistoryResponseEntity];

  @override
  final String wireName = r'FlightHistoryResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightHistoryResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
    );
    yield r'nextCursor';
    yield object.nextCursor == null ? null : serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType.nullable(String),
    );
    yield r'yearCounts';
    yield serializers.serialize(
      object.yearCounts,
      specifiedType: const FullType(BuiltList, [FullType(YearCountEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightHistoryResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightHistoryResponseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StatsFlightSummaryEntity)]),
          ) as BuiltList<StatsFlightSummaryEntity>;
          result.items.replace(valueDes);
          break;
        case r'nextCursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'yearCounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(YearCountEntity)]),
          ) as BuiltList<YearCountEntity>;
          result.yearCounts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightHistoryResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightHistoryResponseEntityBuilder();
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


