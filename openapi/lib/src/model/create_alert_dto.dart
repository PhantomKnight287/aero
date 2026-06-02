//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_alert_dto.g.dart';

/// CreateAlertDto
///
/// Properties:
/// * [flightId] - Flight identifier. Accepts the internal flight id, the FlightAware fa_flight_id, or the flightAwareData id — resolved the same way as flight.service resolveFaFlight.
/// * [playerId] - OneSignal subscription (player) id to push notifications to.
@BuiltValue()
abstract class CreateAlertDto implements Built<CreateAlertDto, CreateAlertDtoBuilder> {
  /// Flight identifier. Accepts the internal flight id, the FlightAware fa_flight_id, or the flightAwareData id — resolved the same way as flight.service resolveFaFlight.
  @BuiltValueField(wireName: r'flightId')
  String get flightId;

  /// OneSignal subscription (player) id to push notifications to.
  @BuiltValueField(wireName: r'playerId')
  String get playerId;

  CreateAlertDto._();

  factory CreateAlertDto([void updates(CreateAlertDtoBuilder b)]) = _$CreateAlertDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAlertDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAlertDto> get serializer => _$CreateAlertDtoSerializer();
}

class _$CreateAlertDtoSerializer implements PrimitiveSerializer<CreateAlertDto> {
  @override
  final Iterable<Type> types = const [CreateAlertDto, _$CreateAlertDto];

  @override
  final String wireName = r'CreateAlertDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAlertDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flightId';
    yield serializers.serialize(
      object.flightId,
      specifiedType: const FullType(String),
    );
    yield r'playerId';
    yield serializers.serialize(
      object.playerId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAlertDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateAlertDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flightId = valueDes;
          break;
        case r'playerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.playerId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAlertDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAlertDtoBuilder();
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

