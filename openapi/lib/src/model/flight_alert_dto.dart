//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_alert_dto.g.dart';

/// FlightAlertDTO
///
/// Properties:
/// * [playerId] - OneSignal subscription (player) ID for the device to notify
@BuiltValue()
abstract class FlightAlertDTO implements Built<FlightAlertDTO, FlightAlertDTOBuilder> {
  /// OneSignal subscription (player) ID for the device to notify
  @BuiltValueField(wireName: r'playerId')
  String get playerId;

  FlightAlertDTO._();

  factory FlightAlertDTO([void updates(FlightAlertDTOBuilder b)]) = _$FlightAlertDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightAlertDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightAlertDTO> get serializer => _$FlightAlertDTOSerializer();
}

class _$FlightAlertDTOSerializer implements PrimitiveSerializer<FlightAlertDTO> {
  @override
  final Iterable<Type> types = const [FlightAlertDTO, _$FlightAlertDTO];

  @override
  final String wireName = r'FlightAlertDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightAlertDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'playerId';
    yield serializers.serialize(
      object.playerId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightAlertDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightAlertDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  FlightAlertDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightAlertDTOBuilder();
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

