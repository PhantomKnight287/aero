// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continent_bucket.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ContinentBucket _$asia = const ContinentBucket._('asia');
const ContinentBucket _$europe = const ContinentBucket._('europe');
const ContinentBucket _$northAmerica = const ContinentBucket._('northAmerica');
const ContinentBucket _$middleEast = const ContinentBucket._('middleEast');
const ContinentBucket _$oceania = const ContinentBucket._('oceania');
const ContinentBucket _$africa = const ContinentBucket._('africa');
const ContinentBucket _$centralAmerica =
    const ContinentBucket._('centralAmerica');
const ContinentBucket _$caribbean = const ContinentBucket._('caribbean');
const ContinentBucket _$southAmerica = const ContinentBucket._('southAmerica');

ContinentBucket _$valueOf(String name) {
  switch (name) {
    case 'asia':
      return _$asia;
    case 'europe':
      return _$europe;
    case 'northAmerica':
      return _$northAmerica;
    case 'middleEast':
      return _$middleEast;
    case 'oceania':
      return _$oceania;
    case 'africa':
      return _$africa;
    case 'centralAmerica':
      return _$centralAmerica;
    case 'caribbean':
      return _$caribbean;
    case 'southAmerica':
      return _$southAmerica;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ContinentBucket> _$values =
    BuiltSet<ContinentBucket>(const <ContinentBucket>[
  _$asia,
  _$europe,
  _$northAmerica,
  _$middleEast,
  _$oceania,
  _$africa,
  _$centralAmerica,
  _$caribbean,
  _$southAmerica,
]);

class _$ContinentBucketMeta {
  const _$ContinentBucketMeta();
  ContinentBucket get asia => _$asia;
  ContinentBucket get europe => _$europe;
  ContinentBucket get northAmerica => _$northAmerica;
  ContinentBucket get middleEast => _$middleEast;
  ContinentBucket get oceania => _$oceania;
  ContinentBucket get africa => _$africa;
  ContinentBucket get centralAmerica => _$centralAmerica;
  ContinentBucket get caribbean => _$caribbean;
  ContinentBucket get southAmerica => _$southAmerica;
  ContinentBucket valueOf(String name) => _$valueOf(name);
  BuiltSet<ContinentBucket> get values => _$values;
}

abstract class _$ContinentBucketMixin {
  // ignore: non_constant_identifier_names
  _$ContinentBucketMeta get ContinentBucket => const _$ContinentBucketMeta();
}

Serializer<ContinentBucket> _$continentBucketSerializer =
    _$ContinentBucketSerializer();

class _$ContinentBucketSerializer
    implements PrimitiveSerializer<ContinentBucket> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'asia': 'asia',
    'europe': 'europe',
    'northAmerica': 'north_america',
    'middleEast': 'middle_east',
    'oceania': 'oceania',
    'africa': 'africa',
    'centralAmerica': 'central_america',
    'caribbean': 'caribbean',
    'southAmerica': 'south_america',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'asia': 'asia',
    'europe': 'europe',
    'north_america': 'northAmerica',
    'middle_east': 'middleEast',
    'oceania': 'oceania',
    'africa': 'africa',
    'central_america': 'centralAmerica',
    'caribbean': 'caribbean',
    'south_america': 'southAmerica',
  };

  @override
  final Iterable<Type> types = const <Type>[ContinentBucket];
  @override
  final String wireName = 'ContinentBucket';

  @override
  Object serialize(Serializers serializers, ContinentBucket object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ContinentBucket deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ContinentBucket.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
