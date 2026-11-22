//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:openapi/src/model/stats_airline_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stats_flight_summary_entity.g.dart';

/// StatsFlightSummaryEntity
///
/// Properties:
/// * [id] 
/// * [flightNo] 
/// * [identIata] 
/// * [identIcao] 
/// * [faFlightId] 
/// * [airline] 
/// * [departure] 
/// * [arrival] 
/// * [date] - Flight date (ISO string)
/// * [localDate] - Departure-local date (YYYY-MM-DD)
@BuiltValue()
abstract class StatsFlightSummaryEntity implements Built<StatsFlightSummaryEntity, StatsFlightSummaryEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'flightNo')
  String get flightNo;

  @BuiltValueField(wireName: r'identIata')
  String? get identIata;

  @BuiltValueField(wireName: r'identIcao')
  String? get identIcao;

  @BuiltValueField(wireName: r'faFlightId')
  String? get faFlightId;

  @BuiltValueField(wireName: r'airline')
  StatsAirlineEntity get airline;

  @BuiltValueField(wireName: r'departure')
  StatsAirportEntity get departure;

  @BuiltValueField(wireName: r'arrival')
  StatsAirportEntity get arrival;

  /// Flight date (ISO string)
  @BuiltValueField(wireName: r'date')
  String get date;

  /// Departure-local date (YYYY-MM-DD)
  @BuiltValueField(wireName: r'localDate')
  String get localDate;

  StatsFlightSummaryEntity._();

  factory StatsFlightSummaryEntity([void updates(StatsFlightSummaryEntityBuilder b)]) = _$StatsFlightSummaryEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatsFlightSummaryEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatsFlightSummaryEntity> get serializer => _$StatsFlightSummaryEntitySerializer();
}

class _$StatsFlightSummaryEntitySerializer implements PrimitiveSerializer<StatsFlightSummaryEntity> {
  @override
  final Iterable<Type> types = const [StatsFlightSummaryEntity, _$StatsFlightSummaryEntity];

  @override
  final String wireName = r'StatsFlightSummaryEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatsFlightSummaryEntity object, {
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
    if (object.identIata != null) {
      yield r'identIata';
      yield serializers.serialize(
        object.identIata,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.identIcao != null) {
      yield r'identIcao';
      yield serializers.serialize(
        object.identIcao,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.faFlightId != null) {
      yield r'faFlightId';
      yield serializers.serialize(
        object.faFlightId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(StatsAirlineEntity),
    );
    yield r'departure';
    yield serializers.serialize(
      object.departure,
      specifiedType: const FullType(StatsAirportEntity),
    );
    yield r'arrival';
    yield serializers.serialize(
      object.arrival,
      specifiedType: const FullType(StatsAirportEntity),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(String),
    );
    yield r'localDate';
    yield serializers.serialize(
      object.localDate,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StatsFlightSummaryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatsFlightSummaryEntityBuilder result,
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
        case r'identIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.identIata = valueDes;
          break;
        case r'identIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.identIcao = valueDes;
          break;
        case r'faFlightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.faFlightId = valueDes;
          break;
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirlineEntity),
          ) as StatsAirlineEntity;
          result.airline.replace(valueDes);
          break;
        case r'departure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirportEntity),
          ) as StatsAirportEntity;
          result.departure.replace(valueDes);
          break;
        case r'arrival':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirportEntity),
          ) as StatsAirportEntity;
          result.arrival.replace(valueDes);
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.date = valueDes;
          break;
        case r'localDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.localDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatsFlightSummaryEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatsFlightSummaryEntityBuilder();
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


