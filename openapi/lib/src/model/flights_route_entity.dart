//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_route_entity.g.dart';

/// FlightsRouteEntity
///
/// Properties:
/// * [from] 
/// * [to] 
@BuiltValue()
abstract class FlightsRouteEntity implements Built<FlightsRouteEntity, FlightsRouteEntityBuilder> {
  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  FlightsRouteEntity._();

  factory FlightsRouteEntity([void updates(FlightsRouteEntityBuilder b)]) = _$FlightsRouteEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsRouteEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsRouteEntity> get serializer => _$FlightsRouteEntitySerializer();
}

class _$FlightsRouteEntitySerializer implements PrimitiveSerializer<FlightsRouteEntity> {
  @override
  final Iterable<Type> types = const [FlightsRouteEntity, _$FlightsRouteEntity];

  @override
  final String wireName = r'FlightsRouteEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsRouteEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightsRouteEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsRouteEntityBuilder();
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

