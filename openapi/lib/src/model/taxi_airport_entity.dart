//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/stats_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'taxi_airport_entity.g.dart';

/// TaxiAirportEntity
///
/// Properties:
/// * [airport] 
/// * [avgTaxiOutMin] 
/// * [taxiOutCount] 
/// * [avgTaxiInMin] 
/// * [taxiInCount] 
@BuiltValue()
abstract class TaxiAirportEntity implements Built<TaxiAirportEntity, TaxiAirportEntityBuilder> {
  @BuiltValueField(wireName: r'airport')
  StatsAirportEntity get airport;

  @BuiltValueField(wireName: r'avgTaxiOutMin')
  num? get avgTaxiOutMin;

  @BuiltValueField(wireName: r'taxiOutCount')
  num get taxiOutCount;

  @BuiltValueField(wireName: r'avgTaxiInMin')
  num? get avgTaxiInMin;

  @BuiltValueField(wireName: r'taxiInCount')
  num get taxiInCount;

  TaxiAirportEntity._();

  factory TaxiAirportEntity([void updates(TaxiAirportEntityBuilder b)]) = _$TaxiAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaxiAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaxiAirportEntity> get serializer => _$TaxiAirportEntitySerializer();
}

class _$TaxiAirportEntitySerializer implements PrimitiveSerializer<TaxiAirportEntity> {
  @override
  final Iterable<Type> types = const [TaxiAirportEntity, _$TaxiAirportEntity];

  @override
  final String wireName = r'TaxiAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaxiAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'airport';
    yield serializers.serialize(
      object.airport,
      specifiedType: const FullType(StatsAirportEntity),
    );
    if (object.avgTaxiOutMin != null) {
      yield r'avgTaxiOutMin';
      yield serializers.serialize(
        object.avgTaxiOutMin,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'taxiOutCount';
    yield serializers.serialize(
      object.taxiOutCount,
      specifiedType: const FullType(num),
    );
    if (object.avgTaxiInMin != null) {
      yield r'avgTaxiInMin';
      yield serializers.serialize(
        object.avgTaxiInMin,
        specifiedType: const FullType.nullable(num),
      );
    }
    yield r'taxiInCount';
    yield serializers.serialize(
      object.taxiInCount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaxiAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaxiAirportEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'airport':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatsAirportEntity),
          ) as StatsAirportEntity;
          result.airport.replace(valueDes);
          break;
        case r'avgTaxiOutMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.avgTaxiOutMin = valueDes;
          break;
        case r'taxiOutCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.taxiOutCount = valueDes;
          break;
        case r'avgTaxiInMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.avgTaxiInMin = valueDes;
          break;
        case r'taxiInCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.taxiInCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaxiAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaxiAirportEntityBuilder();
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


