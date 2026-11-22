//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/continent_bucket.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'continent_entity.g.dart';

/// ContinentEntity
///
/// Properties:
/// * [bucket] 
/// * [countryCount] 
/// * [flightShare] - Share of flights touching this continent, 0..1
@BuiltValue()
abstract class ContinentEntity implements Built<ContinentEntity, ContinentEntityBuilder> {
  @BuiltValueField(wireName: r'bucket')
  ContinentBucket get bucket;
  // enum bucketEnum {  asia,  europe,  north_america,  middle_east,  oceania,  africa,  central_america,  caribbean,  south_america,  };

  @BuiltValueField(wireName: r'countryCount')
  num get countryCount;

  /// Share of flights touching this continent, 0..1
  @BuiltValueField(wireName: r'flightShare')
  num get flightShare;

  ContinentEntity._();

  factory ContinentEntity([void updates(ContinentEntityBuilder b)]) = _$ContinentEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContinentEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContinentEntity> get serializer => _$ContinentEntitySerializer();
}

class _$ContinentEntitySerializer implements PrimitiveSerializer<ContinentEntity> {
  @override
  final Iterable<Type> types = const [ContinentEntity, _$ContinentEntity];

  @override
  final String wireName = r'ContinentEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContinentEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bucket';
    yield serializers.serialize(
      object.bucket,
      specifiedType: const FullType(ContinentBucket),
    );
    yield r'countryCount';
    yield serializers.serialize(
      object.countryCount,
      specifiedType: const FullType(num),
    );
    yield r'flightShare';
    yield serializers.serialize(
      object.flightShare,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ContinentEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContinentEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bucket':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ContinentBucket),
          ) as ContinentBucket;
          result.bucket = valueDes;
          break;
        case r'countryCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.countryCount = valueDes;
          break;
        case r'flightShare':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.flightShare = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContinentEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContinentEntityBuilder();
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


