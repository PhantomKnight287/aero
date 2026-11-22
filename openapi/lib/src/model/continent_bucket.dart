//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'continent_bucket.g.dart';

class ContinentBucket extends EnumClass {

  @BuiltValueEnumConst(wireName: r'asia')
  static const ContinentBucket asia = _$asia;
  @BuiltValueEnumConst(wireName: r'europe')
  static const ContinentBucket europe = _$europe;
  @BuiltValueEnumConst(wireName: r'north_america')
  static const ContinentBucket northAmerica = _$northAmerica;
  @BuiltValueEnumConst(wireName: r'middle_east')
  static const ContinentBucket middleEast = _$middleEast;
  @BuiltValueEnumConst(wireName: r'oceania')
  static const ContinentBucket oceania = _$oceania;
  @BuiltValueEnumConst(wireName: r'africa')
  static const ContinentBucket africa = _$africa;
  @BuiltValueEnumConst(wireName: r'central_america')
  static const ContinentBucket centralAmerica = _$centralAmerica;
  @BuiltValueEnumConst(wireName: r'caribbean')
  static const ContinentBucket caribbean = _$caribbean;
  @BuiltValueEnumConst(wireName: r'south_america')
  static const ContinentBucket southAmerica = _$southAmerica;

  static Serializer<ContinentBucket> get serializer => _$continentBucketSerializer;

  const ContinentBucket._(String name): super(name);

  static BuiltSet<ContinentBucket> get values => _$values;
  static ContinentBucket valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ContinentBucketMixin = Object with _$ContinentBucketMixin;

