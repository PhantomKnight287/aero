//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_summary_origin_entity.dart';
import 'package:openapi/src/model/flight_summary_destination_entity.dart';
import 'package:openapi/src/model/flight_summary_airline_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_candidate_entity.g.dart';

/// FlightCandidateEntity
///
/// Properties:
/// * [faFlightId] - FlightAware flight ID for fetching full details
/// * [ident] - Flight identifier (e.g., \"AC113\")
/// * [origin] 
/// * [destination] 
/// * [scheduledOut] 
/// * [scheduledOff] 
/// * [status] - Flight status description
/// * [airline] 
@BuiltValue()
abstract class FlightCandidateEntity implements Built<FlightCandidateEntity, FlightCandidateEntityBuilder> {
  /// FlightAware flight ID for fetching full details
  @BuiltValueField(wireName: r'faFlightId')
  String get faFlightId;

  /// Flight identifier (e.g., \"AC113\")
  @BuiltValueField(wireName: r'ident')
  String get ident;

  @BuiltValueField(wireName: r'origin')
  FlightSummaryOriginEntity get origin;

  @BuiltValueField(wireName: r'destination')
  FlightSummaryDestinationEntity get destination;

  @BuiltValueField(wireName: r'scheduledOut')
  DateTime? get scheduledOut;

  @BuiltValueField(wireName: r'scheduledOff')
  DateTime? get scheduledOff;

  /// Flight status description
  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'airline')
  FlightSummaryAirlineEntity get airline;

  FlightCandidateEntity._();

  factory FlightCandidateEntity([void updates(FlightCandidateEntityBuilder b)]) = _$FlightCandidateEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightCandidateEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightCandidateEntity> get serializer => _$FlightCandidateEntitySerializer();
}

class _$FlightCandidateEntitySerializer implements PrimitiveSerializer<FlightCandidateEntity> {
  @override
  final Iterable<Type> types = const [FlightCandidateEntity, _$FlightCandidateEntity];

  @override
  final String wireName = r'FlightCandidateEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightCandidateEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'faFlightId';
    yield serializers.serialize(
      object.faFlightId,
      specifiedType: const FullType(String),
    );
    yield r'ident';
    yield serializers.serialize(
      object.ident,
      specifiedType: const FullType(String),
    );
    yield r'origin';
    yield serializers.serialize(
      object.origin,
      specifiedType: const FullType(FlightSummaryOriginEntity),
    );
    yield r'destination';
    yield serializers.serialize(
      object.destination,
      specifiedType: const FullType(FlightSummaryDestinationEntity),
    );
    if (object.scheduledOut != null) {
      yield r'scheduledOut';
      yield serializers.serialize(
        object.scheduledOut,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.scheduledOff != null) {
      yield r'scheduledOff';
      yield serializers.serialize(
        object.scheduledOff,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(FlightSummaryAirlineEntity),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightCandidateEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightCandidateEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'faFlightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.faFlightId = valueDes;
          break;
        case r'ident':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ident = valueDes;
          break;
        case r'origin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightSummaryOriginEntity),
          ) as FlightSummaryOriginEntity;
          result.origin.replace(valueDes);
          break;
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightSummaryDestinationEntity),
          ) as FlightSummaryDestinationEntity;
          result.destination.replace(valueDes);
          break;
        case r'scheduledOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledOut = valueDes;
          break;
        case r'scheduledOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledOff = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightSummaryAirlineEntity),
          ) as FlightSummaryAirlineEntity;
          result.airline.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightCandidateEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightCandidateEntityBuilder();
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

