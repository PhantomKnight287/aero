//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fligh_type.g.dart';

class FlighType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'arrival')
  static const FlighType arrival = _$arrival;
  @BuiltValueEnumConst(wireName: r'departure')
  static const FlighType departure = _$departure;

  static Serializer<FlighType> get serializer => _$flighTypeSerializer;

  const FlighType._(String name): super(name);

  static BuiltSet<FlighType> get values => _$values;
  static FlighType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FlighTypeMixin = Object with _$FlighTypeMixin;

