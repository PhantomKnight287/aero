//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'top_route_entity.g.dart';

/// TopRouteEntity
///
/// Properties:
/// * [origin] 
/// * [destination] 
/// * [flightCount] 
@BuiltValue()
abstract class TopRouteEntity implements Built<TopRouteEntity, TopRouteEntityBuilder> {
  @BuiltValueField(wireName: r'origin')
  String get origin;

  @BuiltValueField(wireName: r'destination')
  String get destination;

  @BuiltValueField(wireName: r'flightCount')
  num get flightCount;

  TopRouteEntity._();

  factory TopRouteEntity([void updates(TopRouteEntityBuilder b)]) = _$TopRouteEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TopRouteEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TopRouteEntity> get serializer => _$TopRouteEntitySerializer();
}

class _$TopRouteEntitySerializer implements PrimitiveSerializer<TopRouteEntity> {
  @override
  final Iterable<Type> types = const [TopRouteEntity, _$TopRouteEntity];

  @override
  final String wireName = r'TopRouteEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TopRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'origin';
    yield serializers.serialize(
      object.origin,
      specifiedType: const FullType(String),
    );
    yield r'destination';
    yield serializers.serialize(
      object.destination,
      specifiedType: const FullType(String),
    );
    yield r'flightCount';
    yield serializers.serialize(
      object.flightCount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TopRouteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TopRouteEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'origin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.origin = valueDes;
          break;
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destination = valueDes;
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
  TopRouteEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TopRouteEntityBuilder();
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

