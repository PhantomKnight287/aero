//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flight_candidate_entity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_search_response_entity.g.dart';

/// FlightSearchResponseEntity
///
/// Properties:
/// * [flights] - Array of flight candidates
/// * [count] - Number of flights found
@BuiltValue()
abstract class FlightSearchResponseEntity implements Built<FlightSearchResponseEntity, FlightSearchResponseEntityBuilder> {
  /// Array of flight candidates
  @BuiltValueField(wireName: r'flights')
  BuiltList<FlightCandidateEntity> get flights;

  /// Number of flights found
  @BuiltValueField(wireName: r'count')
  num get count;

  FlightSearchResponseEntity._();

  factory FlightSearchResponseEntity([void updates(FlightSearchResponseEntityBuilder b)]) = _$FlightSearchResponseEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightSearchResponseEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightSearchResponseEntity> get serializer => _$FlightSearchResponseEntitySerializer();
}

class _$FlightSearchResponseEntitySerializer implements PrimitiveSerializer<FlightSearchResponseEntity> {
  @override
  final Iterable<Type> types = const [FlightSearchResponseEntity, _$FlightSearchResponseEntity];

  @override
  final String wireName = r'FlightSearchResponseEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightSearchResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flights';
    yield serializers.serialize(
      object.flights,
      specifiedType: const FullType(BuiltList, [FullType(FlightCandidateEntity)]),
    );
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightSearchResponseEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightSearchResponseEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FlightCandidateEntity)]),
          ) as BuiltList<FlightCandidateEntity>;
          result.flights.replace(valueDes);
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightSearchResponseEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightSearchResponseEntityBuilder();
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

