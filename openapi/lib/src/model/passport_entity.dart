//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'passport_entity.g.dart';

/// PassportEntity
///
/// Properties:
/// * [totalFlights] - Total number of flights taken
/// * [totalDistanceKm] - Total distance in kilometers
/// * [totalDurationMinutes] - Total flight duration in minutes (including delays)
/// * [totalAirports] - Number of unique airports
/// * [totalAirlines] - Number of unique airlines
@BuiltValue()
abstract class PassportEntity implements Built<PassportEntity, PassportEntityBuilder> {
  /// Total number of flights taken
  @BuiltValueField(wireName: r'totalFlights')
  num get totalFlights;

  /// Total distance in kilometers
  @BuiltValueField(wireName: r'totalDistanceKm')
  num get totalDistanceKm;

  /// Total flight duration in minutes (including delays)
  @BuiltValueField(wireName: r'totalDurationMinutes')
  num get totalDurationMinutes;

  /// Number of unique airports
  @BuiltValueField(wireName: r'totalAirports')
  num get totalAirports;

  /// Number of unique airlines
  @BuiltValueField(wireName: r'totalAirlines')
  num get totalAirlines;

  PassportEntity._();

  factory PassportEntity([void updates(PassportEntityBuilder b)]) = _$PassportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PassportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PassportEntity> get serializer => _$PassportEntitySerializer();
}

class _$PassportEntitySerializer implements PrimitiveSerializer<PassportEntity> {
  @override
  final Iterable<Type> types = const [PassportEntity, _$PassportEntity];

  @override
  final String wireName = r'PassportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PassportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'totalFlights';
    yield serializers.serialize(
      object.totalFlights,
      specifiedType: const FullType(num),
    );
    yield r'totalDistanceKm';
    yield serializers.serialize(
      object.totalDistanceKm,
      specifiedType: const FullType(num),
    );
    yield r'totalDurationMinutes';
    yield serializers.serialize(
      object.totalDurationMinutes,
      specifiedType: const FullType(num),
    );
    yield r'totalAirports';
    yield serializers.serialize(
      object.totalAirports,
      specifiedType: const FullType(num),
    );
    yield r'totalAirlines';
    yield serializers.serialize(
      object.totalAirlines,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PassportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PassportEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalFlights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalFlights = valueDes;
          break;
        case r'totalDistanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalDistanceKm = valueDes;
          break;
        case r'totalDurationMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalDurationMinutes = valueDes;
          break;
        case r'totalAirports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalAirports = valueDes;
          break;
        case r'totalAirlines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalAirlines = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PassportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PassportEntityBuilder();
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

