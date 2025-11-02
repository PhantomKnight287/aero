//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/airline_info.dart';
import 'package:openapi/src/model/fligh_type.dart';
import 'package:openapi/src/model/airport_info.dart';
import 'package:openapi/src/model/flight_status.dart';
import 'package:openapi/src/model/aircraft_flight_entity.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_entity.g.dart';

/// FlightEntity
///
/// Properties:
/// * [airline] 
/// * [flight] 
/// * [departure] 
/// * [arrival] 
/// * [status] 
/// * [type] 
/// * [codeshared] 
@BuiltValue()
abstract class FlightEntity implements Built<FlightEntity, FlightEntityBuilder> {
  @BuiltValueField(wireName: r'airline')
  AirlineInfo get airline;

  @BuiltValueField(wireName: r'flight')
  AircraftFlightEntity get flight;

  @BuiltValueField(wireName: r'departure')
  AirportInfo get departure;

  @BuiltValueField(wireName: r'arrival')
  AirportInfo get arrival;

  @BuiltValueField(wireName: r'status')
  FlightStatus get status;
  // enum statusEnum {  scheduled,  active,  landed,  cancelled,  incident,  diverted,  unknown,  };

  @BuiltValueField(wireName: r'type')
  FlighType get type;
  // enum typeEnum {  arrival,  departure,  };

  @BuiltValueField(wireName: r'codeshared')
  JsonObject? get codeshared;

  FlightEntity._();

  factory FlightEntity([void updates(FlightEntityBuilder b)]) = _$FlightEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightEntity> get serializer => _$FlightEntitySerializer();
}

class _$FlightEntitySerializer implements PrimitiveSerializer<FlightEntity> {
  @override
  final Iterable<Type> types = const [FlightEntity, _$FlightEntity];

  @override
  final String wireName = r'FlightEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(AirlineInfo),
    );
    yield r'flight';
    yield serializers.serialize(
      object.flight,
      specifiedType: const FullType(AircraftFlightEntity),
    );
    yield r'departure';
    yield serializers.serialize(
      object.departure,
      specifiedType: const FullType(AirportInfo),
    );
    yield r'arrival';
    yield serializers.serialize(
      object.arrival,
      specifiedType: const FullType(AirportInfo),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FlightStatus),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(FlighType),
    );
    if (object.codeshared != null) {
      yield r'codeshared';
      yield serializers.serialize(
        object.codeshared,
        specifiedType: const FullType(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirlineInfo),
          ) as AirlineInfo;
          result.airline.replace(valueDes);
          break;
        case r'flight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AircraftFlightEntity),
          ) as AircraftFlightEntity;
          result.flight.replace(valueDes);
          break;
        case r'departure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirportInfo),
          ) as AirportInfo;
          result.departure.replace(valueDes);
          break;
        case r'arrival':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirportInfo),
          ) as AirportInfo;
          result.arrival.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightStatus),
          ) as FlightStatus;
          result.status = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlighType),
          ) as FlighType;
          result.type = valueDes;
          break;
        case r'codeshared':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.codeshared = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightEntityBuilder();
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

