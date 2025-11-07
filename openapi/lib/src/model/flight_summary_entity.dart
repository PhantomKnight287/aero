//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_summary_airline_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_summary_entity.g.dart';

/// FlightSummaryEntity
///
/// Properties:
/// * [id] 
/// * [flightNo] 
/// * [callSign] 
/// * [airline] 
/// * [departureAirportCode] - Departure airport code (IATA or ICAO)
/// * [departureAirportName] - Departure airport name
/// * [arrivalAirportCode] - Arrival airport code (IATA or ICAO)
/// * [arrivalAirportName] - Arrival airport name
/// * [date] - Flight date (ISO string)
@BuiltValue()
abstract class FlightSummaryEntity implements Built<FlightSummaryEntity, FlightSummaryEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'flightNo')
  String get flightNo;

  @BuiltValueField(wireName: r'callSign')
  String get callSign;

  @BuiltValueField(wireName: r'airline')
  FlightSummaryAirlineEntity get airline;

  /// Departure airport code (IATA or ICAO)
  @BuiltValueField(wireName: r'departureAirportCode')
  String get departureAirportCode;

  /// Departure airport name
  @BuiltValueField(wireName: r'departureAirportName')
  String get departureAirportName;

  /// Arrival airport code (IATA or ICAO)
  @BuiltValueField(wireName: r'arrivalAirportCode')
  String get arrivalAirportCode;

  /// Arrival airport name
  @BuiltValueField(wireName: r'arrivalAirportName')
  String get arrivalAirportName;

  /// Flight date (ISO string)
  @BuiltValueField(wireName: r'date')
  String get date;

  FlightSummaryEntity._();

  factory FlightSummaryEntity([void updates(FlightSummaryEntityBuilder b)]) = _$FlightSummaryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightSummaryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightSummaryEntity> get serializer => _$FlightSummaryEntitySerializer();
}

class _$FlightSummaryEntitySerializer implements PrimitiveSerializer<FlightSummaryEntity> {
  @override
  final Iterable<Type> types = const [FlightSummaryEntity, _$FlightSummaryEntity];

  @override
  final String wireName = r'FlightSummaryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightSummaryEntity object, {
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
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(FlightSummaryAirlineEntity),
    );
    yield r'departureAirportCode';
    yield serializers.serialize(
      object.departureAirportCode,
      specifiedType: const FullType(String),
    );
    yield r'departureAirportName';
    yield serializers.serialize(
      object.departureAirportName,
      specifiedType: const FullType(String),
    );
    yield r'arrivalAirportCode';
    yield serializers.serialize(
      object.arrivalAirportCode,
      specifiedType: const FullType(String),
    );
    yield r'arrivalAirportName';
    yield serializers.serialize(
      object.arrivalAirportName,
      specifiedType: const FullType(String),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightSummaryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightSummaryEntityBuilder result,
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
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightSummaryAirlineEntity),
          ) as FlightSummaryAirlineEntity;
          result.airline.replace(valueDes);
          break;
        case r'departureAirportCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.departureAirportCode = valueDes;
          break;
        case r'departureAirportName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.departureAirportName = valueDes;
          break;
        case r'arrivalAirportCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.arrivalAirportCode = valueDes;
          break;
        case r'arrivalAirportName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.arrivalAirportName = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.date = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightSummaryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightSummaryEntityBuilder();
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

