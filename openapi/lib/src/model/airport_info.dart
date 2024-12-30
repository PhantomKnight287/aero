//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_info.g.dart';

/// AirportInfo
///
/// Properties:
/// * [actualRunway] 
/// * [actualTime] 
/// * [baggage] 
/// * [delay] - in mins
/// * [estimatedRunway] 
/// * [estimatedTime] 
/// * [gate] 
/// * [iataCode] 
/// * [icaoCode] 
/// * [scheduledTime] 
/// * [terminal] 
@BuiltValue()
abstract class AirportInfo implements Built<AirportInfo, AirportInfoBuilder> {
  @BuiltValueField(wireName: r'actualRunway')
  String? get actualRunway;

  @BuiltValueField(wireName: r'actualTime')
  String? get actualTime;

  @BuiltValueField(wireName: r'baggage')
  String? get baggage;

  /// in mins
  @BuiltValueField(wireName: r'delay')
  String? get delay;

  @BuiltValueField(wireName: r'estimatedRunway')
  String? get estimatedRunway;

  @BuiltValueField(wireName: r'estimatedTime')
  String? get estimatedTime;

  @BuiltValueField(wireName: r'gate')
  String? get gate;

  @BuiltValueField(wireName: r'iataCode')
  String? get iataCode;

  @BuiltValueField(wireName: r'icaoCode')
  String? get icaoCode;

  @BuiltValueField(wireName: r'scheduledTime')
  String? get scheduledTime;

  @BuiltValueField(wireName: r'terminal')
  String? get terminal;

  AirportInfo._();

  factory AirportInfo([void updates(AirportInfoBuilder b)]) = _$AirportInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirportInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirportInfo> get serializer => _$AirportInfoSerializer();
}

class _$AirportInfoSerializer implements PrimitiveSerializer<AirportInfo> {
  @override
  final Iterable<Type> types = const [AirportInfo, _$AirportInfo];

  @override
  final String wireName = r'AirportInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirportInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.actualRunway != null) {
      yield r'actualRunway';
      yield serializers.serialize(
        object.actualRunway,
        specifiedType: const FullType(String),
      );
    }
    if (object.actualTime != null) {
      yield r'actualTime';
      yield serializers.serialize(
        object.actualTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.baggage != null) {
      yield r'baggage';
      yield serializers.serialize(
        object.baggage,
        specifiedType: const FullType(String),
      );
    }
    if (object.delay != null) {
      yield r'delay';
      yield serializers.serialize(
        object.delay,
        specifiedType: const FullType(String),
      );
    }
    if (object.estimatedRunway != null) {
      yield r'estimatedRunway';
      yield serializers.serialize(
        object.estimatedRunway,
        specifiedType: const FullType(String),
      );
    }
    if (object.estimatedTime != null) {
      yield r'estimatedTime';
      yield serializers.serialize(
        object.estimatedTime,
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
    if (object.iataCode != null) {
      yield r'iataCode';
      yield serializers.serialize(
        object.iataCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.icaoCode != null) {
      yield r'icaoCode';
      yield serializers.serialize(
        object.icaoCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.scheduledTime != null) {
      yield r'scheduledTime';
      yield serializers.serialize(
        object.scheduledTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.terminal != null) {
      yield r'terminal';
      yield serializers.serialize(
        object.terminal,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AirportInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirportInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'actualRunway':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actualRunway = valueDes;
          break;
        case r'actualTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actualTime = valueDes;
          break;
        case r'baggage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baggage = valueDes;
          break;
        case r'delay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.delay = valueDes;
          break;
        case r'estimatedRunway':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedRunway = valueDes;
          break;
        case r'estimatedTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedTime = valueDes;
          break;
        case r'gate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gate = valueDes;
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
        case r'scheduledTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scheduledTime = valueDes;
          break;
        case r'terminal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.terminal = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirportInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirportInfoBuilder();
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

