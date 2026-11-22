//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'top_airport_entity.g.dart';

/// TopAirportEntity
///
/// Properties:
/// * [airport] 
/// * [departures] 
/// * [arrivals] 
/// * [flightCount] 
/// * [distanceKm] 
@BuiltValue()
abstract class TopAirportEntity implements Built<TopAirportEntity, TopAirportEntityBuilder> {
  @BuiltValueField(wireName: r'airport')
  StatsAirportEntity get airport;

  @BuiltValueField(wireName: r'departures')
  num get departures;

  @BuiltValueField(wireName: r'arrivals')
  num get arrivals;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  TopAirportEntity._();

  factory TopAirportEntity([void updates(TopAirportEntityBuilder b)]) = _$TopAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TopAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TopAirportEntity> get serializer => _$TopAirportEntitySerializer();
}

class _$TopAirportEntitySerializer implements PrimitiveSerializer<TopAirportEntity> {
  @override
  final Iterable<Type> types = const [TopAirportEntity, _$TopAirportEntity];

  @override
  final String wireName = r'TopAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TopAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport';
    yield serializers.serialize(
      object.airport,
      specifiedType: const FullType(StatsAirportEntity),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    TopAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TopAirportEntityBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TopAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TopAirportEntityBuilder();
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


