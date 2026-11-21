//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_flight_booking_dto.g.dart';

/// CreateFlightBookingDTO
///
/// Properties:
/// * [flightId] - Flight ID to associate the booking with
/// * [bookingCode] - Booking code/confirmation code (e.g., \"ABC123\")
/// * [seatNumber] - Seat number (e.g., \"12A\", \"1F\")
/// * [seatType] - Type of seat position
/// * [seatingClass] - Class of service
/// * [reason] - Reason for the flight
/// * [notes] - Additional notes about the booking
@BuiltValue()
abstract class CreateFlightBookingDTO implements Built<CreateFlightBookingDTO, CreateFlightBookingDTOBuilder> {
  /// Flight ID to associate the booking with
  @BuiltValueField(wireName: r'flightId')
  String get flightId;

  /// Booking code/confirmation code (e.g., \"ABC123\")
  @BuiltValueField(wireName: r'bookingCode')
  String? get bookingCode;

  /// Seat number (e.g., \"12A\", \"1F\")
  @BuiltValueField(wireName: r'seatNumber')
  String? get seatNumber;

  /// Type of seat position
  @BuiltValueField(wireName: r'seatType')
  CreateFlightBookingDTOSeatTypeEnum? get seatType;
  // enum seatTypeEnum {  window,  middle,  aisle,  jumpseat,  captain,  pilot,  copilot,  flight_engineer,  flight_attendant,  observer,  other,  };

  /// Class of service
  @BuiltValueField(wireName: r'seatingClass')
  CreateFlightBookingDTOSeatingClassEnum? get seatingClass;
  // enum seatingClassEnum {  economy,  premium_economy,  business,  first,  private,  other,  };

  /// Reason for the flight
  @BuiltValueField(wireName: r'reason')
  CreateFlightBookingDTOReasonEnum? get reason;
  // enum reasonEnum {  personal,  business,  crew,  training,  repositioning,  other,  };

  /// Additional notes about the booking
  @BuiltValueField(wireName: r'notes')
  String? get notes;

  CreateFlightBookingDTO._();

  factory CreateFlightBookingDTO([void updates(CreateFlightBookingDTOBuilder b)]) = _$CreateFlightBookingDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateFlightBookingDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateFlightBookingDTO> get serializer => _$CreateFlightBookingDTOSerializer();
}

class _$CreateFlightBookingDTOSerializer implements PrimitiveSerializer<CreateFlightBookingDTO> {
  @override
  final Iterable<Type> types = const [CreateFlightBookingDTO, _$CreateFlightBookingDTO];

  @override
  final String wireName = r'CreateFlightBookingDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateFlightBookingDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'flightId';
    yield serializers.serialize(
      object.flightId,
      specifiedType: const FullType(String),
    );
    if (object.bookingCode != null) {
      yield r'bookingCode';
      yield serializers.serialize(
        object.bookingCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.seatNumber != null) {
      yield r'seatNumber';
      yield serializers.serialize(
        object.seatNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.seatType != null) {
      yield r'seatType';
      yield serializers.serialize(
        object.seatType,
        specifiedType: const FullType(CreateFlightBookingDTOSeatTypeEnum),
      );
    }
    if (object.seatingClass != null) {
      yield r'seatingClass';
      yield serializers.serialize(
        object.seatingClass,
        specifiedType: const FullType(CreateFlightBookingDTOSeatingClassEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(CreateFlightBookingDTOReasonEnum),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateFlightBookingDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateFlightBookingDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flightId = valueDes;
          break;
        case r'bookingCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bookingCode = valueDes;
          break;
        case r'seatNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.seatNumber = valueDes;
          break;
        case r'seatType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateFlightBookingDTOSeatTypeEnum),
          ) as CreateFlightBookingDTOSeatTypeEnum?;
          if (valueDes == null) continue;
          result.seatType = valueDes;
          break;
        case r'seatingClass':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateFlightBookingDTOSeatingClassEnum),
          ) as CreateFlightBookingDTOSeatingClassEnum?;
          if (valueDes == null) continue;
          result.seatingClass = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateFlightBookingDTOReasonEnum),
          ) as CreateFlightBookingDTOReasonEnum?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
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
  CreateFlightBookingDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateFlightBookingDTOBuilder();
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


/// Type of seat position
class CreateFlightBookingDTOSeatTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'window')
  static const CreateFlightBookingDTOSeatTypeEnum window = _$createFlightBookingDTOSeatTypeEnum_window;
  @BuiltValueEnumConst(wireName: r'middle')
  static const CreateFlightBookingDTOSeatTypeEnum middle = _$createFlightBookingDTOSeatTypeEnum_middle;
  @BuiltValueEnumConst(wireName: r'aisle')
  static const CreateFlightBookingDTOSeatTypeEnum aisle = _$createFlightBookingDTOSeatTypeEnum_aisle;
  @BuiltValueEnumConst(wireName: r'jumpseat')
  static const CreateFlightBookingDTOSeatTypeEnum jumpseat = _$createFlightBookingDTOSeatTypeEnum_jumpseat;
  @BuiltValueEnumConst(wireName: r'captain')
  static const CreateFlightBookingDTOSeatTypeEnum captain = _$createFlightBookingDTOSeatTypeEnum_captain;
  @BuiltValueEnumConst(wireName: r'pilot')
  static const CreateFlightBookingDTOSeatTypeEnum pilot = _$createFlightBookingDTOSeatTypeEnum_pilot;
  @BuiltValueEnumConst(wireName: r'copilot')
  static const CreateFlightBookingDTOSeatTypeEnum copilot = _$createFlightBookingDTOSeatTypeEnum_copilot;
  @BuiltValueEnumConst(wireName: r'flight_engineer')
  static const CreateFlightBookingDTOSeatTypeEnum flightEngineer = _$createFlightBookingDTOSeatTypeEnum_flightEngineer;
  @BuiltValueEnumConst(wireName: r'flight_attendant')
  static const CreateFlightBookingDTOSeatTypeEnum flightAttendant = _$createFlightBookingDTOSeatTypeEnum_flightAttendant;
  @BuiltValueEnumConst(wireName: r'observer')
  static const CreateFlightBookingDTOSeatTypeEnum observer = _$createFlightBookingDTOSeatTypeEnum_observer;
  @BuiltValueEnumConst(wireName: r'other')
  static const CreateFlightBookingDTOSeatTypeEnum other = _$createFlightBookingDTOSeatTypeEnum_other;

  static Serializer<CreateFlightBookingDTOSeatTypeEnum> get serializer => _$createFlightBookingDTOSeatTypeEnumSerializer;

  const CreateFlightBookingDTOSeatTypeEnum._(String name): super(name);

  static BuiltSet<CreateFlightBookingDTOSeatTypeEnum> get values => _$createFlightBookingDTOSeatTypeEnumValues;
  static CreateFlightBookingDTOSeatTypeEnum valueOf(String name) => _$createFlightBookingDTOSeatTypeEnumValueOf(name);
}

/// Class of service
class CreateFlightBookingDTOSeatingClassEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'economy')
  static const CreateFlightBookingDTOSeatingClassEnum economy = _$createFlightBookingDTOSeatingClassEnum_economy;
  @BuiltValueEnumConst(wireName: r'premium_economy')
  static const CreateFlightBookingDTOSeatingClassEnum premiumEconomy = _$createFlightBookingDTOSeatingClassEnum_premiumEconomy;
  @BuiltValueEnumConst(wireName: r'business')
  static const CreateFlightBookingDTOSeatingClassEnum business = _$createFlightBookingDTOSeatingClassEnum_business;
  @BuiltValueEnumConst(wireName: r'first')
  static const CreateFlightBookingDTOSeatingClassEnum first = _$createFlightBookingDTOSeatingClassEnum_first;
  @BuiltValueEnumConst(wireName: r'private')
  static const CreateFlightBookingDTOSeatingClassEnum private = _$createFlightBookingDTOSeatingClassEnum_private;
  @BuiltValueEnumConst(wireName: r'other')
  static const CreateFlightBookingDTOSeatingClassEnum other = _$createFlightBookingDTOSeatingClassEnum_other;

  static Serializer<CreateFlightBookingDTOSeatingClassEnum> get serializer => _$createFlightBookingDTOSeatingClassEnumSerializer;

  const CreateFlightBookingDTOSeatingClassEnum._(String name): super(name);

  static BuiltSet<CreateFlightBookingDTOSeatingClassEnum> get values => _$createFlightBookingDTOSeatingClassEnumValues;
  static CreateFlightBookingDTOSeatingClassEnum valueOf(String name) => _$createFlightBookingDTOSeatingClassEnumValueOf(name);
}

/// Reason for the flight
class CreateFlightBookingDTOReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'personal')
  static const CreateFlightBookingDTOReasonEnum personal = _$createFlightBookingDTOReasonEnum_personal;
  @BuiltValueEnumConst(wireName: r'business')
  static const CreateFlightBookingDTOReasonEnum business = _$createFlightBookingDTOReasonEnum_business;
  @BuiltValueEnumConst(wireName: r'crew')
  static const CreateFlightBookingDTOReasonEnum crew = _$createFlightBookingDTOReasonEnum_crew;
  @BuiltValueEnumConst(wireName: r'training')
  static const CreateFlightBookingDTOReasonEnum training = _$createFlightBookingDTOReasonEnum_training;
  @BuiltValueEnumConst(wireName: r'repositioning')
  static const CreateFlightBookingDTOReasonEnum repositioning = _$createFlightBookingDTOReasonEnum_repositioning;
  @BuiltValueEnumConst(wireName: r'other')
  static const CreateFlightBookingDTOReasonEnum other = _$createFlightBookingDTOReasonEnum_other;

  static Serializer<CreateFlightBookingDTOReasonEnum> get serializer => _$createFlightBookingDTOReasonEnumSerializer;

  const CreateFlightBookingDTOReasonEnum._(String name): super(name);

  static BuiltSet<CreateFlightBookingDTOReasonEnum> get values => _$createFlightBookingDTOReasonEnumValues;
  static CreateFlightBookingDTOReasonEnum valueOf(String name) => _$createFlightBookingDTOReasonEnumValueOf(name);
}

