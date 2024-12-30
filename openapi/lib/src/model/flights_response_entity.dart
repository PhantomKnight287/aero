//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/flights_route_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_response_entity.g.dart';

/// FlightsResponseEntity
///
/// Properties:
/// * [success] 
/// * [date] 
/// * [route] 
/// * [flightCount] 
/// * [flights] 
@BuiltValue()
abstract class FlightsResponseEntity implements Built<FlightsResponseEntity, FlightsResponseEntityBuilder> {
  @BuiltValueField(wireName: r'success')
  bool get success;

  @BuiltValueField(wireName: r'date')
  String get date;

  @BuiltValueField(wireName: r'route')
  FlightsRouteEntity get route;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  @BuiltValueField(wireName: r'flights')
  BuiltList<FlightEntity> get flights;

  FlightsResponseEntity._();

  factory FlightsResponseEntity([void updates(FlightsResponseEntityBuilder b)]) = _$FlightsResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsResponseEntity> get serializer => _$FlightsResponseEntitySerializer();
}

class _$FlightsResponseEntitySerializer implements PrimitiveSerializer<FlightsResponseEntity> {
  @override
  final Iterable<Type> types = const [FlightsResponseEntity, _$FlightsResponseEntity];

  @override
  final String wireName = r'FlightsResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(bool),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(String),
    );
    yield r'route';
    yield serializers.serialize(
      object.route,
      specifiedType: const FullType(FlightsRouteEntity),
    );
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
    yield r'flights';
    yield serializers.serialize(
      object.flights,
      specifiedType: const FullType(BuiltList, [FullType(FlightEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsResponseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.date = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightsRouteEntity),
          ) as FlightsRouteEntity;
          result.route.replace(valueDes);
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
            specifiedType: const FullType(BuiltList, [FullType(FlightEntity)]),
          ) as BuiltList<FlightEntity>;
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
  FlightsResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsResponseEntityBuilder();
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

