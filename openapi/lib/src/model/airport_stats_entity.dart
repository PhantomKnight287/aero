//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_stats_entity.g.dart';

/// AirportStatsEntity
///
/// Properties:
/// * [airportCode] 
/// * [airportName] 
/// * [departureCount] - Number of flights departing from this airport
@BuiltValue()
abstract class AirportStatsEntity implements Built<AirportStatsEntity, AirportStatsEntityBuilder> {
  @BuiltValueField(wireName: r'airportCode')
  String get airportCode;

  @BuiltValueField(wireName: r'airportName')
  String get airportName;

  /// Number of flights departing from this airport
  @BuiltValueField(wireName: r'departureCount')
  num get departureCount;

  AirportStatsEntity._();

  factory AirportStatsEntity([void updates(AirportStatsEntityBuilder b)]) = _$AirportStatsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportStatsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportStatsEntity> get serializer => _$AirportStatsEntitySerializer();
}

class _$AirportStatsEntitySerializer implements PrimitiveSerializer<AirportStatsEntity> {
  @override
  final Iterable<Type> types = const [AirportStatsEntity, _$AirportStatsEntity];

  @override
  final String wireName = r'AirportStatsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportStatsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airportCode';
    yield serializers.serialize(
      object.airportCode,
      specifiedType: const FullType(String),
    );
    yield r'airportName';
    yield serializers.serialize(
      object.airportName,
      specifiedType: const FullType(String),
    );
    yield r'departureCount';
    yield serializers.serialize(
      object.departureCount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportStatsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportStatsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airportCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airportCode = valueDes;
          break;
        case r'airportName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airportName = valueDes;
          break;
        case r'departureCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.departureCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportStatsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportStatsEntityBuilder();
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

