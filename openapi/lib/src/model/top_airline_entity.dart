//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airline_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'top_airline_entity.g.dart';

/// TopAirlineEntity
///
/// Properties:
/// * [airline] 
/// * [flightCount] 
/// * [distanceKm] 
@BuiltValue()
abstract class TopAirlineEntity implements Built<TopAirlineEntity, TopAirlineEntityBuilder> {
  @BuiltValueField(wireName: r'airline')
  StatsAirlineEntity get airline;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  @BuiltValueField(wireName: r'distanceKm')
  num get distanceKm;

  TopAirlineEntity._();

  factory TopAirlineEntity([void updates(TopAirlineEntityBuilder b)]) = _$TopAirlineEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TopAirlineEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TopAirlineEntity> get serializer => _$TopAirlineEntitySerializer();
}

class _$TopAirlineEntitySerializer implements PrimitiveSerializer<TopAirlineEntity> {
  @override
  final Iterable<Type> types = const [TopAirlineEntity, _$TopAirlineEntity];

  @override
  final String wireName = r'TopAirlineEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TopAirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(StatsAirlineEntity),
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
    TopAirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TopAirlineEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirlineEntity),
          ) as StatsAirlineEntity;
          result.airline.replace(valueDes);
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
  TopAirlineEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TopAirlineEntityBuilder();
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


