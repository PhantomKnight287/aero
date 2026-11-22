//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/year_count_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_per_entity.g.dart';

/// FlightsPerEntity
///
/// Properties:
/// * [year] 
/// * [month] - Jan..Dec
/// * [weekday] - Sun..Sat
@BuiltValue()
abstract class FlightsPerEntity implements Built<FlightsPerEntity, FlightsPerEntityBuilder> {
  @BuiltValueField(wireName: r'year')
  BuiltList<YearCountEntity> get year;

  /// Jan..Dec
  @BuiltValueField(wireName: r'month')
  BuiltList<num> get month;

  /// Sun..Sat
  @BuiltValueField(wireName: r'weekday')
  BuiltList<num> get weekday;

  FlightsPerEntity._();

  factory FlightsPerEntity([void updates(FlightsPerEntityBuilder b)]) = _$FlightsPerEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsPerEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsPerEntity> get serializer => _$FlightsPerEntitySerializer();
}

class _$FlightsPerEntitySerializer implements PrimitiveSerializer<FlightsPerEntity> {
  @override
  final Iterable<Type> types = const [FlightsPerEntity, _$FlightsPerEntity];

  @override
  final String wireName = r'FlightsPerEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsPerEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'year';
    yield serializers.serialize(
      object.year,
      specifiedType: const FullType(BuiltList, [FullType(YearCountEntity)]),
    );
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
    yield r'weekday';
    yield serializers.serialize(
      object.weekday,
      specifiedType: const FullType(BuiltList, [FullType(num)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsPerEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsPerEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(YearCountEntity)]),
          ) as BuiltList<YearCountEntity>;
          result.year.replace(valueDes);
          break;
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.month.replace(valueDes);
          break;
        case r'weekday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(num)]),
          ) as BuiltList<num>;
          result.weekday.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightsPerEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsPerEntityBuilder();
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


