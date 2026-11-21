//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_delay_reason_entity.g.dart';

/// AirportDelayReasonEntity
///
/// Properties:
/// * [category] 
/// * [color] 
/// * [delaySecs] 
/// * [reason] 
@BuiltValue()
abstract class AirportDelayReasonEntity implements Built<AirportDelayReasonEntity, AirportDelayReasonEntityBuilder> {
  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'color')
  AirportDelayReasonEntityColorEnum get color;
  // enum colorEnum {  red,  yellow,  green,  };

  @BuiltValueField(wireName: r'delay_secs')
  num get delaySecs;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  AirportDelayReasonEntity._();

  factory AirportDelayReasonEntity([void updates(AirportDelayReasonEntityBuilder b)]) = _$AirportDelayReasonEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportDelayReasonEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportDelayReasonEntity> get serializer => _$AirportDelayReasonEntitySerializer();
}

class _$AirportDelayReasonEntitySerializer implements PrimitiveSerializer<AirportDelayReasonEntity> {
  @override
  final Iterable<Type> types = const [AirportDelayReasonEntity, _$AirportDelayReasonEntity];

  @override
  final String wireName = r'AirportDelayReasonEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportDelayReasonEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'color';
    yield serializers.serialize(
      object.color,
      specifiedType: const FullType(AirportDelayReasonEntityColorEnum),
    );
    yield r'delay_secs';
    yield serializers.serialize(
      object.delaySecs,
      specifiedType: const FullType(num),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportDelayReasonEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportDelayReasonEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(AirportDelayReasonEntityColorEnum),
          ) as AirportDelayReasonEntityColorEnum;
          result.color = valueDes;
          break;
        case r'delay_secs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.delaySecs = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportDelayReasonEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportDelayReasonEntityBuilder();
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


class AirportDelayReasonEntityColorEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'red')
  static const AirportDelayReasonEntityColorEnum red = _$airportDelayReasonEntityColorEnum_red;
  @BuiltValueEnumConst(wireName: r'yellow')
  static const AirportDelayReasonEntityColorEnum yellow = _$airportDelayReasonEntityColorEnum_yellow;
  @BuiltValueEnumConst(wireName: r'green')
  static const AirportDelayReasonEntityColorEnum green = _$airportDelayReasonEntityColorEnum_green;

  static Serializer<AirportDelayReasonEntityColorEnum> get serializer => _$airportDelayReasonEntityColorEnumSerializer;

  const AirportDelayReasonEntityColorEnum._(String name): super(name);

  static BuiltSet<AirportDelayReasonEntityColorEnum> get values => _$airportDelayReasonEntityColorEnumValues;
  static AirportDelayReasonEntityColorEnum valueOf(String name) => _$airportDelayReasonEntityColorEnumValueOf(name);
}

