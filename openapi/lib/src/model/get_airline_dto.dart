//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_airline_dto.g.dart';

/// GetAirlineDTO
///
/// Properties:
/// * [search] - The search query, like 6E9920
@BuiltValue()
abstract class GetAirlineDTO implements Built<GetAirlineDTO, GetAirlineDTOBuilder> {
  /// The search query, like 6E9920
  @BuiltValueField(wireName: r'search')
  String get search;

  GetAirlineDTO._();

  factory GetAirlineDTO([void updates(GetAirlineDTOBuilder b)]) = _$GetAirlineDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAirlineDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAirlineDTO> get serializer => _$GetAirlineDTOSerializer();
}

class _$GetAirlineDTOSerializer implements PrimitiveSerializer<GetAirlineDTO> {
  @override
  final Iterable<Type> types = const [GetAirlineDTO, _$GetAirlineDTO];

  @override
  final String wireName = r'GetAirlineDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAirlineDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'search';
    yield serializers.serialize(
      object.search,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAirlineDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetAirlineDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'search':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.search = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetAirlineDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAirlineDTOBuilder();
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

