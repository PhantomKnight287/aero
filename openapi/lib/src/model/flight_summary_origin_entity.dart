//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_summary_origin_entity.g.dart';

/// FlightSummaryOriginEntity
///
/// Properties:
/// * [code] 
/// * [codeIata] 
/// * [codeIcao] 
/// * [name] 
/// * [city] 
@BuiltValue()
abstract class FlightSummaryOriginEntity implements Built<FlightSummaryOriginEntity, FlightSummaryOriginEntityBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'codeIata')
  String? get codeIata;

  @BuiltValueField(wireName: r'codeIcao')
  String? get codeIcao;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'city')
  String? get city;

  FlightSummaryOriginEntity._();

  factory FlightSummaryOriginEntity([void updates(FlightSummaryOriginEntityBuilder b)]) = _$FlightSummaryOriginEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightSummaryOriginEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightSummaryOriginEntity> get serializer => _$FlightSummaryOriginEntitySerializer();
}

class _$FlightSummaryOriginEntitySerializer implements PrimitiveSerializer<FlightSummaryOriginEntity> {
  @override
  final Iterable<Type> types = const [FlightSummaryOriginEntity, _$FlightSummaryOriginEntity];

  @override
  final String wireName = r'FlightSummaryOriginEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightSummaryOriginEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    if (object.codeIata != null) {
      yield r'codeIata';
      yield serializers.serialize(
        object.codeIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.codeIcao != null) {
      yield r'codeIcao';
      yield serializers.serialize(
        object.codeIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightSummaryOriginEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightSummaryOriginEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'codeIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.codeIata = valueDes;
          break;
        case r'codeIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.codeIcao = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.city = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightSummaryOriginEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightSummaryOriginEntityBuilder();
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

