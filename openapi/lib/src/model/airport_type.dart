//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport_type.g.dart';

class AirportType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'small_airport')
  static const AirportType smallAirport = _$smallAirport;
  @BuiltValueEnumConst(wireName: r'seaplane_base')
  static const AirportType seaplaneBase = _$seaplaneBase;
  @BuiltValueEnumConst(wireName: r'medium_airport')
  static const AirportType mediumAirport = _$mediumAirport;
  @BuiltValueEnumConst(wireName: r'large_airport')
  static const AirportType largeAirport = _$largeAirport;
  @BuiltValueEnumConst(wireName: r'heliport')
  static const AirportType heliport = _$heliport;
  @BuiltValueEnumConst(wireName: r'closed')
  static const AirportType closed = _$closed;
  @BuiltValueEnumConst(wireName: r'balloonport')
  static const AirportType balloonport = _$balloonport;

  static Serializer<AirportType> get serializer => _$airportTypeSerializer;

  const AirportType._(String name): super(name);

  static BuiltSet<AirportType> get values => _$values;
  static AirportType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AirportTypeMixin = Object with _$AirportTypeMixin;

