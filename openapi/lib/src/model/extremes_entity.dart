//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'extremes_entity.g.dart';

/// ExtremesEntity
///
/// Properties:
/// * [north] 
/// * [south] 
/// * [east] 
/// * [west] 
/// * [highest] 
@BuiltValue()
abstract class ExtremesEntity implements Built<ExtremesEntity, ExtremesEntityBuilder> {
  @BuiltValueField(wireName: r'north')
  StatsAirportEntity? get north;

  @BuiltValueField(wireName: r'south')
  StatsAirportEntity? get south;

  @BuiltValueField(wireName: r'east')
  StatsAirportEntity? get east;

  @BuiltValueField(wireName: r'west')
  StatsAirportEntity? get west;

  @BuiltValueField(wireName: r'highest')
  StatsAirportEntity? get highest;

  ExtremesEntity._();

  factory ExtremesEntity([void updates(ExtremesEntityBuilder b)]) = _$ExtremesEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExtremesEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExtremesEntity> get serializer => _$ExtremesEntitySerializer();
}

class _$ExtremesEntitySerializer implements PrimitiveSerializer<ExtremesEntity> {
  @override
  final Iterable<Type> types = const [ExtremesEntity, _$ExtremesEntity];

  @override
  final String wireName = r'ExtremesEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExtremesEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.north != null) {
      yield r'north';
      yield serializers.serialize(
        object.north,
        specifiedType: const FullType.nullable(StatsAirportEntity),
      );
    }
    if (object.south != null) {
      yield r'south';
      yield serializers.serialize(
        object.south,
        specifiedType: const FullType.nullable(StatsAirportEntity),
      );
    }
    if (object.east != null) {
      yield r'east';
      yield serializers.serialize(
        object.east,
        specifiedType: const FullType.nullable(StatsAirportEntity),
      );
    }
    if (object.west != null) {
      yield r'west';
      yield serializers.serialize(
        object.west,
        specifiedType: const FullType.nullable(StatsAirportEntity),
      );
    }
    if (object.highest != null) {
      yield r'highest';
      yield serializers.serialize(
        object.highest,
        specifiedType: const FullType.nullable(StatsAirportEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExtremesEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExtremesEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'north':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsAirportEntity),
          ) as StatsAirportEntity?;
          if (valueDes == null) continue;
          result.north.replace(valueDes);
          break;
        case r'south':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsAirportEntity),
          ) as StatsAirportEntity?;
          if (valueDes == null) continue;
          result.south.replace(valueDes);
          break;
        case r'east':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsAirportEntity),
          ) as StatsAirportEntity?;
          if (valueDes == null) continue;
          result.east.replace(valueDes);
          break;
        case r'west':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsAirportEntity),
          ) as StatsAirportEntity?;
          if (valueDes == null) continue;
          result.west.replace(valueDes);
          break;
        case r'highest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsAirportEntity),
          ) as StatsAirportEntity?;
          if (valueDes == null) continue;
          result.highest.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExtremesEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExtremesEntityBuilder();
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


