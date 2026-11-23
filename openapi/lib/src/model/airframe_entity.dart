//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_flight_summary_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airframe_entity.g.dart';

/// AirframeEntity
///
/// Properties:
/// * [reg] 
/// * [typeCode] 
/// * [typeName] 
/// * [ageYears] 
/// * [image] 
/// * [flight] - Most recent flight on this airframe
@BuiltValue()
abstract class AirframeEntity implements Built<AirframeEntity, AirframeEntityBuilder> {
  @BuiltValueField(wireName: r'reg')
  String get reg;

  @BuiltValueField(wireName: r'typeCode')
  String? get typeCode;

  @BuiltValueField(wireName: r'typeName')
  String? get typeName;

  @BuiltValueField(wireName: r'ageYears')
  num get ageYears;

  @BuiltValueField(wireName: r'image')
  String? get image;

  /// Most recent flight on this airframe
  @BuiltValueField(wireName: r'flight')
  StatsFlightSummaryEntity get flight;

  AirframeEntity._();

  factory AirframeEntity([void updates(AirframeEntityBuilder b)]) = _$AirframeEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AirframeEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AirframeEntity> get serializer => _$AirframeEntitySerializer();
}

class _$AirframeEntitySerializer implements PrimitiveSerializer<AirframeEntity> {
  @override
  final Iterable<Type> types = const [AirframeEntity, _$AirframeEntity];

  @override
  final String wireName = r'AirframeEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AirframeEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reg';
    yield serializers.serialize(
      object.reg,
      specifiedType: const FullType(String),
    );
    if (object.typeCode != null) {
      yield r'typeCode';
      yield serializers.serialize(
        object.typeCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.typeName != null) {
      yield r'typeName';
      yield serializers.serialize(
        object.typeName,
        specifiedType: const FullType(String),
      );
    }
    yield r'ageYears';
    yield serializers.serialize(
      object.ageYears,
      specifiedType: const FullType(num),
    );
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
    yield r'flight';
    yield serializers.serialize(
      object.flight,
      specifiedType: const FullType(StatsFlightSummaryEntity),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AirframeEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AirframeEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reg = valueDes;
          break;
        case r'typeCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typeCode = valueDes;
          break;
        case r'typeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typeName = valueDes;
          break;
        case r'ageYears':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.ageYears = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.image = valueDes;
          break;
        case r'flight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsFlightSummaryEntity),
          ) as StatsFlightSummaryEntity;
          result.flight.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AirframeEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AirframeEntityBuilder();
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


