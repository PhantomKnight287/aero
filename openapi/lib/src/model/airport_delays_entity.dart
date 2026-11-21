//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/airport_delay_reason_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_delays_entity.g.dart';

/// AirportDelaysEntity
///
/// Properties:
/// * [airport] 
/// * [category] 
/// * [color] 
/// * [delaySecs] 
/// * [reasons] 
@BuiltValue()
abstract class AirportDelaysEntity implements Built<AirportDelaysEntity, AirportDelaysEntityBuilder> {
  @BuiltValueField(wireName: r'airport')
  String get airport;

  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'color')
  AirportDelaysEntityColorEnum get color;
  // enum colorEnum {  red,  yellow,  green,  };

  @BuiltValueField(wireName: r'delay_secs')
  num get delaySecs;

  @BuiltValueField(wireName: r'reasons')
  BuiltList<AirportDelayReasonEntity> get reasons;

  AirportDelaysEntity._();

  factory AirportDelaysEntity([void updates(AirportDelaysEntityBuilder b)]) = _$AirportDelaysEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportDelaysEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportDelaysEntity> get serializer => _$AirportDelaysEntitySerializer();
}

class _$AirportDelaysEntitySerializer implements PrimitiveSerializer<AirportDelaysEntity> {
  @override
  final Iterable<Type> types = const [AirportDelaysEntity, _$AirportDelaysEntity];

  @override
  final String wireName = r'AirportDelaysEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportDelaysEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport';
    yield serializers.serialize(
      object.airport,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'color';
    yield serializers.serialize(
      object.color,
      specifiedType: const FullType(AirportDelaysEntityColorEnum),
    );
    yield r'delay_secs';
    yield serializers.serialize(
      object.delaySecs,
      specifiedType: const FullType(num),
    );
    yield r'reasons';
    yield serializers.serialize(
      object.reasons,
      specifiedType: const FullType(BuiltList, [FullType(AirportDelayReasonEntity)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportDelaysEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportDelaysEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.airport = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AirportDelaysEntityColorEnum),
          ) as AirportDelaysEntityColorEnum;
          result.color = valueDes;
          break;
        case r'delay_secs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.delaySecs = valueDes;
          break;
        case r'reasons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AirportDelayReasonEntity)]),
          ) as BuiltList<AirportDelayReasonEntity>;
          result.reasons.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportDelaysEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportDelaysEntityBuilder();
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


class AirportDelaysEntityColorEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'red')
  static const AirportDelaysEntityColorEnum red = _$airportDelaysEntityColorEnum_red;
  @BuiltValueEnumConst(wireName: r'yellow')
  static const AirportDelaysEntityColorEnum yellow = _$airportDelaysEntityColorEnum_yellow;
  @BuiltValueEnumConst(wireName: r'green')
  static const AirportDelaysEntityColorEnum green = _$airportDelaysEntityColorEnum_green;

  static Serializer<AirportDelaysEntityColorEnum> get serializer => _$airportDelaysEntityColorEnumSerializer;

  const AirportDelaysEntityColorEnum._(String name): super(name);

  static BuiltSet<AirportDelaysEntityColorEnum> get values => _$airportDelaysEntityColorEnumValues;
  static AirportDelaysEntityColorEnum valueOf(String name) => _$airportDelaysEntityColorEnumValueOf(name);
}

