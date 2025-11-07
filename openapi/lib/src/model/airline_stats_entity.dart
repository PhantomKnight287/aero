//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airline_stats_entity.g.dart';

/// AirlineStatsEntity
///
/// Properties:
/// * [airlineName] 
/// * [airlineIata] 
/// * [airlineIcao] 
/// * [image] - Airline image URL from DB, when available
/// * [flightCount] 
@BuiltValue()
abstract class AirlineStatsEntity implements Built<AirlineStatsEntity, AirlineStatsEntityBuilder> {
  @BuiltValueField(wireName: r'airlineName')
  String get airlineName;

  @BuiltValueField(wireName: r'airlineIata')
  String get airlineIata;

  @BuiltValueField(wireName: r'airlineIcao')
  String? get airlineIcao;

  /// Airline image URL from DB, when available
  @BuiltValueField(wireName: r'image')
  String? get image;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  AirlineStatsEntity._();

  factory AirlineStatsEntity([void updates(AirlineStatsEntityBuilder b)]) = _$AirlineStatsEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirlineStatsEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirlineStatsEntity> get serializer => _$AirlineStatsEntitySerializer();
}

class _$AirlineStatsEntitySerializer implements PrimitiveSerializer<AirlineStatsEntity> {
  @override
  final Iterable<Type> types = const [AirlineStatsEntity, _$AirlineStatsEntity];

  @override
  final String wireName = r'AirlineStatsEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirlineStatsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airlineName';
    yield serializers.serialize(
      object.airlineName,
      specifiedType: const FullType(String),
    );
    yield r'airlineIata';
    yield serializers.serialize(
      object.airlineIata,
      specifiedType: const FullType(String),
    );
    if (object.airlineIcao != null) {
      yield r'airlineIcao';
      yield serializers.serialize(
        object.airlineIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirlineStatsEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirlineStatsEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airlineName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airlineName = valueDes;
          break;
        case r'airlineIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airlineIata = valueDes;
          break;
        case r'airlineIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airlineIcao = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        case r'flightCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.flightCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirlineStatsEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirlineStatsEntityBuilder();
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

