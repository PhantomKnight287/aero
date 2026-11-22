//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'passport_entity.g.dart';

/// PassportEntity
///
/// Properties:
/// * [totalFlights] 
/// * [totalDistanceKm] 
/// * [blockMinutes] 
/// * [airMinutes] 
/// * [airBasedOn] 
/// * [taxiMinutes] 
/// * [taxiBasedOn] 
/// * [totalAirports] 
/// * [totalAirlines] 
/// * [totalCountries] 
/// * [domestic] 
/// * [international] 
/// * [longHaul] 
@BuiltValue()
abstract class PassportEntity implements Built<PassportEntity, PassportEntityBuilder> {
  @BuiltValueField(wireName: r'totalFlights')
  num get totalFlights;

  @BuiltValueField(wireName: r'totalDistanceKm')
  num get totalDistanceKm;

  @BuiltValueField(wireName: r'blockMinutes')
  num get blockMinutes;

  @BuiltValueField(wireName: r'airMinutes')
  num get airMinutes;

  @BuiltValueField(wireName: r'airBasedOn')
  num get airBasedOn;

  @BuiltValueField(wireName: r'taxiMinutes')
  num get taxiMinutes;

  @BuiltValueField(wireName: r'taxiBasedOn')
  num get taxiBasedOn;

  @BuiltValueField(wireName: r'totalAirports')
  num get totalAirports;

  @BuiltValueField(wireName: r'totalAirlines')
  num get totalAirlines;

  @BuiltValueField(wireName: r'totalCountries')
  num get totalCountries;

  @BuiltValueField(wireName: r'domestic')
  num get domestic;

  @BuiltValueField(wireName: r'international')
  num get international;

  @BuiltValueField(wireName: r'longHaul')
  num get longHaul;

  PassportEntity._();

  factory PassportEntity([void updates(PassportEntityBuilder b)]) = _$PassportEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PassportEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PassportEntity> get serializer => _$PassportEntitySerializer();
}

class _$PassportEntitySerializer implements PrimitiveSerializer<PassportEntity> {
  @override
  final Iterable<Type> types = const [PassportEntity, _$PassportEntity];

  @override
  final String wireName = r'PassportEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PassportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'totalFlights';
    yield serializers.serialize(
      object.totalFlights,
      specifiedType: const FullType(num),
    );
    yield r'totalDistanceKm';
    yield serializers.serialize(
      object.totalDistanceKm,
      specifiedType: const FullType(num),
    );
    yield r'blockMinutes';
    yield serializers.serialize(
      object.blockMinutes,
      specifiedType: const FullType(num),
    );
    yield r'airMinutes';
    yield serializers.serialize(
      object.airMinutes,
      specifiedType: const FullType(num),
    );
    yield r'airBasedOn';
    yield serializers.serialize(
      object.airBasedOn,
      specifiedType: const FullType(num),
    );
    yield r'taxiMinutes';
    yield serializers.serialize(
      object.taxiMinutes,
      specifiedType: const FullType(num),
    );
    yield r'taxiBasedOn';
    yield serializers.serialize(
      object.taxiBasedOn,
      specifiedType: const FullType(num),
    );
    yield r'totalAirports';
    yield serializers.serialize(
      object.totalAirports,
      specifiedType: const FullType(num),
    );
    yield r'totalAirlines';
    yield serializers.serialize(
      object.totalAirlines,
      specifiedType: const FullType(num),
    );
    yield r'totalCountries';
    yield serializers.serialize(
      object.totalCountries,
      specifiedType: const FullType(num),
    );
    yield r'domestic';
    yield serializers.serialize(
      object.domestic,
      specifiedType: const FullType(num),
    );
    yield r'international';
    yield serializers.serialize(
      object.international,
      specifiedType: const FullType(num),
    );
    yield r'longHaul';
    yield serializers.serialize(
      object.longHaul,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PassportEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PassportEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalFlights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalFlights = valueDes;
          break;
        case r'totalDistanceKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalDistanceKm = valueDes;
          break;
        case r'blockMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.blockMinutes = valueDes;
          break;
        case r'airMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.airMinutes = valueDes;
          break;
        case r'airBasedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.airBasedOn = valueDes;
          break;
        case r'taxiMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.taxiMinutes = valueDes;
          break;
        case r'taxiBasedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.taxiBasedOn = valueDes;
          break;
        case r'totalAirports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalAirports = valueDes;
          break;
        case r'totalAirlines':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalAirlines = valueDes;
          break;
        case r'totalCountries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalCountries = valueDes;
          break;
        case r'domestic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.domestic = valueDes;
          break;
        case r'international':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.international = valueDes;
          break;
        case r'longHaul':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.longHaul = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PassportEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PassportEntityBuilder();
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


