//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delay_airport_entity.g.dart';

/// DelayAirportEntity
///
/// Properties:
/// * [airport] 
/// * [lateDepartures] 
/// * [total] 
@BuiltValue()
abstract class DelayAirportEntity implements Built<DelayAirportEntity, DelayAirportEntityBuilder> {
  @BuiltValueField(wireName: r'airport')
  StatsAirportEntity get airport;

  @BuiltValueField(wireName: r'lateDepartures')
  num get lateDepartures;

  @BuiltValueField(wireName: r'total')
  num get total;

  DelayAirportEntity._();

  factory DelayAirportEntity([void updates(DelayAirportEntityBuilder b)]) = _$DelayAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DelayAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DelayAirportEntity> get serializer => _$DelayAirportEntitySerializer();
}

class _$DelayAirportEntitySerializer implements PrimitiveSerializer<DelayAirportEntity> {
  @override
  final Iterable<Type> types = const [DelayAirportEntity, _$DelayAirportEntity];

  @override
  final String wireName = r'DelayAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DelayAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport';
    yield serializers.serialize(
      object.airport,
      specifiedType: const FullType(StatsAirportEntity),
    );
    yield r'lateDepartures';
    yield serializers.serialize(
      object.lateDepartures,
      specifiedType: const FullType(num),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DelayAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DelayAirportEntityBuilder result,
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
        case r'lateDepartures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.lateDepartures = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DelayAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DelayAirportEntityBuilder();
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


