//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_flight_booking_dto.g.dart';

/// UpdateFlightBookingDTO
///
/// Properties:
/// * [bookingCode] - Booking code/confirmation code (e.g., \"ABC123\"). Set to null to clear.
/// * [seatNumber] - Seat number (e.g., \"12A\", \"1F\"). Set to null to clear.
/// * [seatType] - Type of seat position. Set to null to clear.
/// * [seatingClass] - Class of service. Set to null to clear.
/// * [reason] - Reason for the flight. Set to null to clear.
/// * [notes] - Additional notes about the booking. Set to null to clear.
@BuiltValue()
abstract class UpdateFlightBookingDTO implements Built<UpdateFlightBookingDTO, UpdateFlightBookingDTOBuilder> {
  /// Booking code/confirmation code (e.g., \"ABC123\"). Set to null to clear.
  @BuiltValueField(wireName: r'bookingCode')
  JsonObject? get bookingCode;

  /// Seat number (e.g., \"12A\", \"1F\"). Set to null to clear.
  @BuiltValueField(wireName: r'seatNumber')
  JsonObject? get seatNumber;

  /// Type of seat position. Set to null to clear.
  @BuiltValueField(wireName: r'seatType')
  UpdateFlightBookingDTOSeatTypeEnum? get seatType;
  // enum seatTypeEnum {  window,  middle,  aisle,  jumpseat,  captain,  pilot,  copilot,  flight_engineer,  flight_attendant,  observer,  other,  };

  /// Class of service. Set to null to clear.
  @BuiltValueField(wireName: r'seatingClass')
  UpdateFlightBookingDTOSeatingClassEnum? get seatingClass;
  // enum seatingClassEnum {  economy,  premium_economy,  business,  first,  private,  other,  };

  /// Reason for the flight. Set to null to clear.
  @BuiltValueField(wireName: r'reason')
  UpdateFlightBookingDTOReasonEnum? get reason;
  // enum reasonEnum {  personal,  business,  crew,  training,  repositioning,  other,  };

  /// Additional notes about the booking. Set to null to clear.
  @BuiltValueField(wireName: r'notes')
  JsonObject? get notes;

  UpdateFlightBookingDTO._();

  factory UpdateFlightBookingDTO([void updates(UpdateFlightBookingDTOBuilder b)]) = _$UpdateFlightBookingDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateFlightBookingDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateFlightBookingDTO> get serializer => _$UpdateFlightBookingDTOSerializer();
}

class _$UpdateFlightBookingDTOSerializer implements PrimitiveSerializer<UpdateFlightBookingDTO> {
  @override
  final Iterable<Type> types = const [UpdateFlightBookingDTO, _$UpdateFlightBookingDTO];

  @override
  final String wireName = r'UpdateFlightBookingDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateFlightBookingDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.bookingCode != null) {
      yield r'bookingCode';
      yield serializers.serialize(
        object.bookingCode,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.seatNumber != null) {
      yield r'seatNumber';
      yield serializers.serialize(
        object.seatNumber,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.seatType != null) {
      yield r'seatType';
      yield serializers.serialize(
        object.seatType,
        specifiedType: const FullType.nullable(UpdateFlightBookingDTOSeatTypeEnum),
      );
    }
    if (object.seatingClass != null) {
      yield r'seatingClass';
      yield serializers.serialize(
        object.seatingClass,
        specifiedType: const FullType.nullable(UpdateFlightBookingDTOSeatingClassEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(UpdateFlightBookingDTOReasonEnum),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateFlightBookingDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateFlightBookingDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bookingCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.bookingCode = valueDes;
          break;
        case r'seatNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.seatNumber = valueDes;
          break;
        case r'seatType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateFlightBookingDTOSeatTypeEnum),
          ) as UpdateFlightBookingDTOSeatTypeEnum?;
          if (valueDes == null) continue;
          result.seatType = valueDes;
          break;
        case r'seatingClass':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateFlightBookingDTOSeatingClassEnum),
          ) as UpdateFlightBookingDTOSeatingClassEnum?;
          if (valueDes == null) continue;
          result.seatingClass = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateFlightBookingDTOReasonEnum),
          ) as UpdateFlightBookingDTOReasonEnum?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateFlightBookingDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateFlightBookingDTOBuilder();
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

class UpdateFlightBookingDTOSeatTypeEnum extends EnumClass {

  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'window')
  static const UpdateFlightBookingDTOSeatTypeEnum window = _$updateFlightBookingDTOSeatTypeEnum_window;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'middle')
  static const UpdateFlightBookingDTOSeatTypeEnum middle = _$updateFlightBookingDTOSeatTypeEnum_middle;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'aisle')
  static const UpdateFlightBookingDTOSeatTypeEnum aisle = _$updateFlightBookingDTOSeatTypeEnum_aisle;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'jumpseat')
  static const UpdateFlightBookingDTOSeatTypeEnum jumpseat = _$updateFlightBookingDTOSeatTypeEnum_jumpseat;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'captain')
  static const UpdateFlightBookingDTOSeatTypeEnum captain = _$updateFlightBookingDTOSeatTypeEnum_captain;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'pilot')
  static const UpdateFlightBookingDTOSeatTypeEnum pilot = _$updateFlightBookingDTOSeatTypeEnum_pilot;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'copilot')
  static const UpdateFlightBookingDTOSeatTypeEnum copilot = _$updateFlightBookingDTOSeatTypeEnum_copilot;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'flight_engineer')
  static const UpdateFlightBookingDTOSeatTypeEnum flightEngineer = _$updateFlightBookingDTOSeatTypeEnum_flightEngineer;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'flight_attendant')
  static const UpdateFlightBookingDTOSeatTypeEnum flightAttendant = _$updateFlightBookingDTOSeatTypeEnum_flightAttendant;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'observer')
  static const UpdateFlightBookingDTOSeatTypeEnum observer = _$updateFlightBookingDTOSeatTypeEnum_observer;
  /// Type of seat position. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'other')
  static const UpdateFlightBookingDTOSeatTypeEnum other = _$updateFlightBookingDTOSeatTypeEnum_other;

  static Serializer<UpdateFlightBookingDTOSeatTypeEnum> get serializer => _$updateFlightBookingDTOSeatTypeEnumSerializer;

  const UpdateFlightBookingDTOSeatTypeEnum._(String name): super(name);

  static BuiltSet<UpdateFlightBookingDTOSeatTypeEnum> get values => _$updateFlightBookingDTOSeatTypeEnumValues;
  static UpdateFlightBookingDTOSeatTypeEnum valueOf(String name) => _$updateFlightBookingDTOSeatTypeEnumValueOf(name);
}

class UpdateFlightBookingDTOSeatingClassEnum extends EnumClass {

  /// Class of service. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'economy')
  static const UpdateFlightBookingDTOSeatingClassEnum economy = _$updateFlightBookingDTOSeatingClassEnum_economy;
  /// Class of service. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'premium_economy')
  static const UpdateFlightBookingDTOSeatingClassEnum premiumEconomy = _$updateFlightBookingDTOSeatingClassEnum_premiumEconomy;
  /// Class of service. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'business')
  static const UpdateFlightBookingDTOSeatingClassEnum business = _$updateFlightBookingDTOSeatingClassEnum_business;
  /// Class of service. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'first')
  static const UpdateFlightBookingDTOSeatingClassEnum first = _$updateFlightBookingDTOSeatingClassEnum_first;
  /// Class of service. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'private')
  static const UpdateFlightBookingDTOSeatingClassEnum private = _$updateFlightBookingDTOSeatingClassEnum_private;
  /// Class of service. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'other')
  static const UpdateFlightBookingDTOSeatingClassEnum other = _$updateFlightBookingDTOSeatingClassEnum_other;

  static Serializer<UpdateFlightBookingDTOSeatingClassEnum> get serializer => _$updateFlightBookingDTOSeatingClassEnumSerializer;

  const UpdateFlightBookingDTOSeatingClassEnum._(String name): super(name);

  static BuiltSet<UpdateFlightBookingDTOSeatingClassEnum> get values => _$updateFlightBookingDTOSeatingClassEnumValues;
  static UpdateFlightBookingDTOSeatingClassEnum valueOf(String name) => _$updateFlightBookingDTOSeatingClassEnumValueOf(name);
}

class UpdateFlightBookingDTOReasonEnum extends EnumClass {

  /// Reason for the flight. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'personal')
  static const UpdateFlightBookingDTOReasonEnum personal = _$updateFlightBookingDTOReasonEnum_personal;
  /// Reason for the flight. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'business')
  static const UpdateFlightBookingDTOReasonEnum business = _$updateFlightBookingDTOReasonEnum_business;
  /// Reason for the flight. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'crew')
  static const UpdateFlightBookingDTOReasonEnum crew = _$updateFlightBookingDTOReasonEnum_crew;
  /// Reason for the flight. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'training')
  static const UpdateFlightBookingDTOReasonEnum training = _$updateFlightBookingDTOReasonEnum_training;
  /// Reason for the flight. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'repositioning')
  static const UpdateFlightBookingDTOReasonEnum repositioning = _$updateFlightBookingDTOReasonEnum_repositioning;
  /// Reason for the flight. Set to null to clear.
  @BuiltValueEnumConst(wireName: r'other')
  static const UpdateFlightBookingDTOReasonEnum other = _$updateFlightBookingDTOReasonEnum_other;

  static Serializer<UpdateFlightBookingDTOReasonEnum> get serializer => _$updateFlightBookingDTOReasonEnumSerializer;

  const UpdateFlightBookingDTOReasonEnum._(String name): super(name);

  static BuiltSet<UpdateFlightBookingDTOReasonEnum> get values => _$updateFlightBookingDTOReasonEnumValues;
  static UpdateFlightBookingDTOReasonEnum valueOf(String name) => _$updateFlightBookingDTOReasonEnumValueOf(name);
}

