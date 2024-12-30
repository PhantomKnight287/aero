//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_status.g.dart';

class FlightStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'scheduled')
  static const FlightStatus scheduled = _$scheduled;
  @BuiltValueEnumConst(wireName: r'active')
  static const FlightStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'landed')
  static const FlightStatus landed = _$landed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const FlightStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'incident')
  static const FlightStatus incident = _$incident;
  @BuiltValueEnumConst(wireName: r'diverted')
  static const FlightStatus diverted = _$diverted;
  @BuiltValueEnumConst(wireName: r'unknown')
  static const FlightStatus unknown = _$unknown;

  static Serializer<FlightStatus> get serializer => _$flightStatusSerializer;

  const FlightStatus._(String name): super(name);

  static BuiltSet<FlightStatus> get values => _$values;
  static FlightStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FlightStatusMixin = Object with _$FlightStatusMixin;

