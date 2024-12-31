//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/partial_airline_entity.dart';
import 'package:openapi/src/model/stringified_great_circle_distance_entity.dart';
import 'package:openapi/src/model/aircraft_entity.dart';
import 'package:openapi/src/model/route_info_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_response_entity.g.dart';

/// FlightResponseEntity
///
/// Properties:
/// * [id] 
/// * [flightNo] 
/// * [callSign] 
/// * [aircraft] 
/// * [airline] 
/// * [arrival] 
/// * [departure] 
/// * [cargo] 
/// * [greatCircleDistance] 
/// * [date] 
/// * [image] 
@BuiltValue()
abstract class FlightResponseEntity implements Built<FlightResponseEntity, FlightResponseEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'flightNo')
  String get flightNo;

  @BuiltValueField(wireName: r'callSign')
  String get callSign;

  @BuiltValueField(wireName: r'aircraft')
  AircraftEntity? get aircraft;

  @BuiltValueField(wireName: r'airline')
  PartialAirlineEntity get airline;

  @BuiltValueField(wireName: r'arrival')
  RouteInfoEntity get arrival;

  @BuiltValueField(wireName: r'departure')
  RouteInfoEntity get departure;

  @BuiltValueField(wireName: r'cargo')
  bool get cargo;

  @BuiltValueField(wireName: r'greatCircleDistance')
  StringifiedGreatCircleDistanceEntity get greatCircleDistance;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'image')
  String? get image;

  FlightResponseEntity._();

  factory FlightResponseEntity([void updates(FlightResponseEntityBuilder b)]) = _$FlightResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightResponseEntity> get serializer => _$FlightResponseEntitySerializer();
}

class _$FlightResponseEntitySerializer implements PrimitiveSerializer<FlightResponseEntity> {
  @override
  final Iterable<Type> types = const [FlightResponseEntity, _$FlightResponseEntity];

  @override
  final String wireName = r'FlightResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'flightNo';
    yield serializers.serialize(
      object.flightNo,
      specifiedType: const FullType(String),
    );
    yield r'callSign';
    yield serializers.serialize(
      object.callSign,
      specifiedType: const FullType(String),
    );
    if (object.aircraft != null) {
      yield r'aircraft';
      yield serializers.serialize(
        object.aircraft,
        specifiedType: const FullType(AircraftEntity),
      );
    }
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(PartialAirlineEntity),
    );
    yield r'arrival';
    yield serializers.serialize(
      object.arrival,
      specifiedType: const FullType(RouteInfoEntity),
    );
    yield r'departure';
    yield serializers.serialize(
      object.departure,
      specifiedType: const FullType(RouteInfoEntity),
    );
    yield r'cargo';
    yield serializers.serialize(
      object.cargo,
      specifiedType: const FullType(bool),
    );
    yield r'greatCircleDistance';
    yield serializers.serialize(
      object.greatCircleDistance,
      specifiedType: const FullType(StringifiedGreatCircleDistanceEntity),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(DateTime),
    );
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightResponseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'flightNo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flightNo = valueDes;
          break;
        case r'callSign':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.callSign = valueDes;
          break;
        case r'aircraft':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AircraftEntity),
          ) as AircraftEntity;
          result.aircraft.replace(valueDes);
          break;
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PartialAirlineEntity),
          ) as PartialAirlineEntity;
          result.airline.replace(valueDes);
          break;
        case r'arrival':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RouteInfoEntity),
          ) as RouteInfoEntity;
          result.arrival.replace(valueDes);
          break;
        case r'departure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RouteInfoEntity),
          ) as RouteInfoEntity;
          result.departure.replace(valueDes);
          break;
        case r'cargo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cargo = valueDes;
          break;
        case r'greatCircleDistance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StringifiedGreatCircleDistanceEntity),
          ) as StringifiedGreatCircleDistanceEntity;
          result.greatCircleDistance.replace(valueDes);
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightResponseEntityBuilder();
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

