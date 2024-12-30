//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/time_entity.dart';
import 'package:openapi/src/model/route_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_info_entity.g.dart';

/// RouteInfoEntity
///
/// Properties:
/// * [airport] 
/// * [terminal] 
/// * [gate] 
/// * [scheduledTime] 
/// * [revisedTime] 
/// * [predictedTime] 
@BuiltValue()
abstract class RouteInfoEntity implements Built<RouteInfoEntity, RouteInfoEntityBuilder> {
  @BuiltValueField(wireName: r'airport')
  RouteAirportEntity get airport;

  @BuiltValueField(wireName: r'terminal')
  String? get terminal;

  @BuiltValueField(wireName: r'gate')
  String? get gate;

  @BuiltValueField(wireName: r'scheduledTime')
  TimeEntity get scheduledTime;

  @BuiltValueField(wireName: r'revisedTime')
  TimeEntity? get revisedTime;

  @BuiltValueField(wireName: r'predictedTime')
  TimeEntity? get predictedTime;

  RouteInfoEntity._();

  factory RouteInfoEntity([void updates(RouteInfoEntityBuilder b)]) = _$RouteInfoEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RouteInfoEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RouteInfoEntity> get serializer => _$RouteInfoEntitySerializer();
}

class _$RouteInfoEntitySerializer implements PrimitiveSerializer<RouteInfoEntity> {
  @override
  final Iterable<Type> types = const [RouteInfoEntity, _$RouteInfoEntity];

  @override
  final String wireName = r'RouteInfoEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RouteInfoEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport';
    yield serializers.serialize(
      object.airport,
      specifiedType: const FullType(RouteAirportEntity),
    );
    if (object.terminal != null) {
      yield r'terminal';
      yield serializers.serialize(
        object.terminal,
        specifiedType: const FullType(String),
      );
    }
    if (object.gate != null) {
      yield r'gate';
      yield serializers.serialize(
        object.gate,
        specifiedType: const FullType(String),
      );
    }
    yield r'scheduledTime';
    yield serializers.serialize(
      object.scheduledTime,
      specifiedType: const FullType(TimeEntity),
    );
    if (object.revisedTime != null) {
      yield r'revisedTime';
      yield serializers.serialize(
        object.revisedTime,
        specifiedType: const FullType(TimeEntity),
      );
    }
    if (object.predictedTime != null) {
      yield r'predictedTime';
      yield serializers.serialize(
        object.predictedTime,
        specifiedType: const FullType(TimeEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RouteInfoEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RouteInfoEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RouteAirportEntity),
          ) as RouteAirportEntity;
          result.airport.replace(valueDes);
          break;
        case r'terminal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.terminal = valueDes;
          break;
        case r'gate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gate = valueDes;
          break;
        case r'scheduledTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TimeEntity),
          ) as TimeEntity;
          result.scheduledTime.replace(valueDes);
          break;
        case r'revisedTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TimeEntity),
          ) as TimeEntity;
          result.revisedTime.replace(valueDes);
          break;
        case r'predictedTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TimeEntity),
          ) as TimeEntity;
          result.predictedTime.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RouteInfoEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RouteInfoEntityBuilder();
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

