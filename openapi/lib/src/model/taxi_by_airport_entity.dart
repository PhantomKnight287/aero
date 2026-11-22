//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/stats_record_entity.dart';
import 'package:openapi/src/model/taxi_airport_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'taxi_by_airport_entity.g.dart';

/// TaxiByAirportEntity
///
/// Properties:
/// * [basedOn] 
/// * [items] 
/// * [longest] 
@BuiltValue()
abstract class TaxiByAirportEntity implements Built<TaxiByAirportEntity, TaxiByAirportEntityBuilder> {
  @BuiltValueField(wireName: r'basedOn')
  num get basedOn;

  @BuiltValueField(wireName: r'items')
  BuiltList<TaxiAirportEntity> get items;

  @BuiltValueField(wireName: r'longest')
  StatsRecordEntity? get longest;

  TaxiByAirportEntity._();

  factory TaxiByAirportEntity([void updates(TaxiByAirportEntityBuilder b)]) = _$TaxiByAirportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaxiByAirportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaxiByAirportEntity> get serializer => _$TaxiByAirportEntitySerializer();
}

class _$TaxiByAirportEntitySerializer implements PrimitiveSerializer<TaxiByAirportEntity> {
  @override
  final Iterable<Type> types = const [TaxiByAirportEntity, _$TaxiByAirportEntity];

  @override
  final String wireName = r'TaxiByAirportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaxiByAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'basedOn';
    yield serializers.serialize(
      object.basedOn,
      specifiedType: const FullType(num),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(TaxiAirportEntity)]),
    );
    if (object.longest != null) {
      yield r'longest';
      yield serializers.serialize(
        object.longest,
        specifiedType: const FullType.nullable(StatsRecordEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TaxiByAirportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaxiByAirportEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'basedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.basedOn = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TaxiAirportEntity)]),
          ) as BuiltList<TaxiAirportEntity>;
          result.items.replace(valueDes);
          break;
        case r'longest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(StatsRecordEntity),
          ) as StatsRecordEntity?;
          if (valueDes == null) continue;
          result.longest.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaxiByAirportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaxiByAirportEntityBuilder();
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


