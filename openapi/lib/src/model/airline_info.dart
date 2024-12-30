//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airline_info.g.dart';

/// AirlineInfo
///
/// Properties:
/// * [name] 
/// * [iataCode] 
/// * [icaoCode] 
@BuiltValue()
abstract class AirlineInfo implements Built<AirlineInfo, AirlineInfoBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'iataCode')
  String get iataCode;

  @BuiltValueField(wireName: r'icaoCode')
  String? get icaoCode;

  AirlineInfo._();

  factory AirlineInfo([void updates(AirlineInfoBuilder b)]) = _$AirlineInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirlineInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirlineInfo> get serializer => _$AirlineInfoSerializer();
}

class _$AirlineInfoSerializer implements PrimitiveSerializer<AirlineInfo> {
  @override
  final Iterable<Type> types = const [AirlineInfo, _$AirlineInfo];

  @override
  final String wireName = r'AirlineInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirlineInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'iataCode';
    yield serializers.serialize(
      object.iataCode,
      specifiedType: const FullType(String),
    );
    if (object.icaoCode != null) {
      yield r'icaoCode';
      yield serializers.serialize(
        object.icaoCode,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AirlineInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirlineInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'iataCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iataCode = valueDes;
          break;
        case r'icaoCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icaoCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirlineInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirlineInfoBuilder();
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

