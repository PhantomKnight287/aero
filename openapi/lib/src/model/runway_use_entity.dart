//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'runway_use_entity.g.dart';

/// RunwayUseEntity
///
/// Properties:
/// * [airport] 
/// * [runway] 
/// * [departures] 
/// * [arrivals] 
@BuiltValue()
abstract class RunwayUseEntity implements Built<RunwayUseEntity, RunwayUseEntityBuilder> {
  @BuiltValueField(wireName: r'airport')
  StatsAirportEntity get airport;

  @BuiltValueField(wireName: r'runway')
  String get runway;

  @BuiltValueField(wireName: r'departures')
  num get departures;

  @BuiltValueField(wireName: r'arrivals')
  num get arrivals;

  RunwayUseEntity._();

  factory RunwayUseEntity([void updates(RunwayUseEntityBuilder b)]) = _$RunwayUseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RunwayUseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RunwayUseEntity> get serializer => _$RunwayUseEntitySerializer();
}

class _$RunwayUseEntitySerializer implements PrimitiveSerializer<RunwayUseEntity> {
  @override
  final Iterable<Type> types = const [RunwayUseEntity, _$RunwayUseEntity];

  @override
  final String wireName = r'RunwayUseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RunwayUseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport';
    yield serializers.serialize(
      object.airport,
      specifiedType: const FullType(StatsAirportEntity),
    );
    yield r'runway';
    yield serializers.serialize(
      object.runway,
      specifiedType: const FullType(String),
    );
    yield r'departures';
    yield serializers.serialize(
      object.departures,
      specifiedType: const FullType(num),
    );
    yield r'arrivals';
    yield serializers.serialize(
      object.arrivals,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RunwayUseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RunwayUseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirportEntity),
          ) as StatsAirportEntity;
          result.airport.replace(valueDes);
          break;
        case r'runway':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.runway = valueDes;
          break;
        case r'departures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.departures = valueDes;
          break;
        case r'arrivals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.arrivals = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RunwayUseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RunwayUseEntityBuilder();
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


