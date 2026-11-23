//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airline_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delay_airline_entity.g.dart';

/// DelayAirlineEntity
///
/// Properties:
/// * [airline] 
/// * [late_] 
/// * [total] 
/// * [minutesLate] 
@BuiltValue()
abstract class DelayAirlineEntity implements Built<DelayAirlineEntity, DelayAirlineEntityBuilder> {
  @BuiltValueField(wireName: r'airline')
  StatsAirlineEntity get airline;

  @BuiltValueField(wireName: r'late')
  num get late_;

  @BuiltValueField(wireName: r'total')
  num get total;

  @BuiltValueField(wireName: r'minutesLate')
  num get minutesLate;

  DelayAirlineEntity._();

  factory DelayAirlineEntity([void updates(DelayAirlineEntityBuilder b)]) = _$DelayAirlineEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DelayAirlineEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DelayAirlineEntity> get serializer => _$DelayAirlineEntitySerializer();
}

class _$DelayAirlineEntitySerializer implements PrimitiveSerializer<DelayAirlineEntity> {
  @override
  final Iterable<Type> types = const [DelayAirlineEntity, _$DelayAirlineEntity];

  @override
  final String wireName = r'DelayAirlineEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DelayAirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airline';
    yield serializers.serialize(
      object.airline,
      specifiedType: const FullType(StatsAirlineEntity),
    );
    yield r'late';
    yield serializers.serialize(
      object.late_,
      specifiedType: const FullType(num),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(num),
    );
    yield r'minutesLate';
    yield serializers.serialize(
      object.minutesLate,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DelayAirlineEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DelayAirlineEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirlineEntity),
          ) as StatsAirlineEntity;
          result.airline.replace(valueDes);
          break;
        case r'late':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.late_ = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.total = valueDes;
          break;
        case r'minutesLate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minutesLate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DelayAirlineEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DelayAirlineEntityBuilder();
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


