//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'top_route_entity.g.dart';

/// TopRouteEntity
///
/// Properties:
/// * [from] 
/// * [to] 
/// * [flightCount] 
/// * [distanceKm] 
@BuiltValue()
abstract class TopRouteEntity implements Built<TopRouteEntity, TopRouteEntityBuilder> {
  @BuiltValueField(wireName: r'from')
  StatsAirportEntity get from;

  @BuiltValueField(wireName: r'to')
  StatsAirportEntity get to;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  TopRouteEntity._();

  factory TopRouteEntity([void updates(TopRouteEntityBuilder b)]) = _$TopRouteEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TopRouteEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TopRouteEntity> get serializer => _$TopRouteEntitySerializer();
}

class _$TopRouteEntitySerializer implements PrimitiveSerializer<TopRouteEntity> {
  @override
  final Iterable<Type> types = const [TopRouteEntity, _$TopRouteEntity];

  @override
  final String wireName = r'TopRouteEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TopRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(StatsAirportEntity),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(StatsAirportEntity),
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
    TopRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TopRouteEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirportEntity),
          ) as StatsAirportEntity;
          result.from.replace(valueDes);
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirportEntity),
          ) as StatsAirportEntity;
          result.to.replace(valueDes);
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
  TopRouteEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TopRouteEntityBuilder();
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


