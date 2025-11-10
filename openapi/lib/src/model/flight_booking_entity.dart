//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_booking_entity.g.dart';

/// FlightBookingEntity
///
/// Properties:
/// * [id] - Unique booking identifier
/// * [bookingCode] - Booking code/confirmation code (e.g., \"ABC123\")
/// * [seatNumber] - Seat number (e.g., \"12A\", \"1F\")
/// * [seatType] - Type of seat position
/// * [seatingClass] - Class of service
/// * [reason] - Reason for the flight
/// * [notes] - Additional notes about the booking
/// * [flightId] - Flight ID associated with this booking
/// * [userId] - User ID who owns this booking
/// * [createdAt] - Date and time when the booking was created
/// * [updatedAt] - Date and time when the booking was last updated
@BuiltValue()
abstract class FlightBookingEntity implements Built<FlightBookingEntity, FlightBookingEntityBuilder> {
  /// Unique booking identifier
  @BuiltValueField(wireName: r'id')
  String get id;

  /// Booking code/confirmation code (e.g., \"ABC123\")
  @BuiltValueField(wireName: r'bookingCode')
  JsonObject? get bookingCode;

  /// Seat number (e.g., \"12A\", \"1F\")
  @BuiltValueField(wireName: r'seatNumber')
  JsonObject? get seatNumber;

  /// Type of seat position
  @BuiltValueField(wireName: r'seatType')
  FlightBookingEntitySeatTypeEnum? get seatType;
  // enum seatTypeEnum {  window,  middle,  aisle,  jumpseat,  captain,  pilot,  copilot,  flight_engineer,  flight_attendant,  observer,  other,  };

  /// Class of service
  @BuiltValueField(wireName: r'seatingClass')
  FlightBookingEntitySeatingClassEnum? get seatingClass;
  // enum seatingClassEnum {  economy,  premium_economy,  business,  first,  private,  other,  };

  /// Reason for the flight
  @BuiltValueField(wireName: r'reason')
  FlightBookingEntityReasonEnum? get reason;
  // enum reasonEnum {  personal,  business,  crew,  training,  repositioning,  other,  };

  /// Additional notes about the booking
  @BuiltValueField(wireName: r'notes')
  JsonObject? get notes;

  /// Flight ID associated with this booking
  @BuiltValueField(wireName: r'flightId')
  String get flightId;

  /// User ID who owns this booking
  @BuiltValueField(wireName: r'userId')
  String get userId;

  /// Date and time when the booking was created
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  /// Date and time when the booking was last updated
  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  FlightBookingEntity._();

  factory FlightBookingEntity([void updates(FlightBookingEntityBuilder b)]) = _$FlightBookingEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightBookingEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightBookingEntity> get serializer => _$FlightBookingEntitySerializer();
}

class _$FlightBookingEntitySerializer implements PrimitiveSerializer<FlightBookingEntity> {
  @override
  final Iterable<Type> types = const [FlightBookingEntity, _$FlightBookingEntity];

  @override
  final String wireName = r'FlightBookingEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightBookingEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    if (object.bookingCode != null) {
      yield r'bookingCode';
      yield serializers.serialize(
        object.bookingCode,
        specifiedType: const FullType(JsonObject),
      );
    }
    if (object.seatNumber != null) {
      yield r'seatNumber';
      yield serializers.serialize(
        object.seatNumber,
        specifiedType: const FullType(JsonObject),
      );
    }
    if (object.seatType != null) {
      yield r'seatType';
      yield serializers.serialize(
        object.seatType,
        specifiedType: const FullType(FlightBookingEntitySeatTypeEnum),
      );
    }
    if (object.seatingClass != null) {
      yield r'seatingClass';
      yield serializers.serialize(
        object.seatingClass,
        specifiedType: const FullType(FlightBookingEntitySeatingClassEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(FlightBookingEntityReasonEnum),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(JsonObject),
      );
    }
    yield r'flightId';
    yield serializers.serialize(
      object.flightId,
      specifiedType: const FullType(String),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightBookingEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightBookingEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'bookingCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.bookingCode = valueDes;
          break;
        case r'seatNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.seatNumber = valueDes;
          break;
        case r'seatType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightBookingEntitySeatTypeEnum),
          ) as FlightBookingEntitySeatTypeEnum;
          result.seatType = valueDes;
          break;
        case r'seatingClass':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightBookingEntitySeatingClassEnum),
          ) as FlightBookingEntitySeatingClassEnum;
          result.seatingClass = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightBookingEntityReasonEnum),
          ) as FlightBookingEntityReasonEnum;
          result.reason = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.notes = valueDes;
          break;
        case r'flightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flightId = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightBookingEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightBookingEntityBuilder();
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

class FlightBookingEntitySeatTypeEnum extends EnumClass {

  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'window')
  static const FlightBookingEntitySeatTypeEnum window = _$flightBookingEntitySeatTypeEnum_window;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'middle')
  static const FlightBookingEntitySeatTypeEnum middle = _$flightBookingEntitySeatTypeEnum_middle;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'aisle')
  static const FlightBookingEntitySeatTypeEnum aisle = _$flightBookingEntitySeatTypeEnum_aisle;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'jumpseat')
  static const FlightBookingEntitySeatTypeEnum jumpseat = _$flightBookingEntitySeatTypeEnum_jumpseat;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'captain')
  static const FlightBookingEntitySeatTypeEnum captain = _$flightBookingEntitySeatTypeEnum_captain;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'pilot')
  static const FlightBookingEntitySeatTypeEnum pilot = _$flightBookingEntitySeatTypeEnum_pilot;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'copilot')
  static const FlightBookingEntitySeatTypeEnum copilot = _$flightBookingEntitySeatTypeEnum_copilot;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'flight_engineer')
  static const FlightBookingEntitySeatTypeEnum flightEngineer = _$flightBookingEntitySeatTypeEnum_flightEngineer;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'flight_attendant')
  static const FlightBookingEntitySeatTypeEnum flightAttendant = _$flightBookingEntitySeatTypeEnum_flightAttendant;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'observer')
  static const FlightBookingEntitySeatTypeEnum observer = _$flightBookingEntitySeatTypeEnum_observer;
  /// Type of seat position
  @BuiltValueEnumConst(wireName: r'other')
  static const FlightBookingEntitySeatTypeEnum other = _$flightBookingEntitySeatTypeEnum_other;

  static Serializer<FlightBookingEntitySeatTypeEnum> get serializer => _$flightBookingEntitySeatTypeEnumSerializer;

  const FlightBookingEntitySeatTypeEnum._(String name): super(name);

  static BuiltSet<FlightBookingEntitySeatTypeEnum> get values => _$flightBookingEntitySeatTypeEnumValues;
  static FlightBookingEntitySeatTypeEnum valueOf(String name) => _$flightBookingEntitySeatTypeEnumValueOf(name);
}

class FlightBookingEntitySeatingClassEnum extends EnumClass {

  /// Class of service
  @BuiltValueEnumConst(wireName: r'economy')
  static const FlightBookingEntitySeatingClassEnum economy = _$flightBookingEntitySeatingClassEnum_economy;
  /// Class of service
  @BuiltValueEnumConst(wireName: r'premium_economy')
  static const FlightBookingEntitySeatingClassEnum premiumEconomy = _$flightBookingEntitySeatingClassEnum_premiumEconomy;
  /// Class of service
  @BuiltValueEnumConst(wireName: r'business')
  static const FlightBookingEntitySeatingClassEnum business = _$flightBookingEntitySeatingClassEnum_business;
  /// Class of service
  @BuiltValueEnumConst(wireName: r'first')
  static const FlightBookingEntitySeatingClassEnum first = _$flightBookingEntitySeatingClassEnum_first;
  /// Class of service
  @BuiltValueEnumConst(wireName: r'private')
  static const FlightBookingEntitySeatingClassEnum private = _$flightBookingEntitySeatingClassEnum_private;
  /// Class of service
  @BuiltValueEnumConst(wireName: r'other')
  static const FlightBookingEntitySeatingClassEnum other = _$flightBookingEntitySeatingClassEnum_other;

  static Serializer<FlightBookingEntitySeatingClassEnum> get serializer => _$flightBookingEntitySeatingClassEnumSerializer;

  const FlightBookingEntitySeatingClassEnum._(String name): super(name);

  static BuiltSet<FlightBookingEntitySeatingClassEnum> get values => _$flightBookingEntitySeatingClassEnumValues;
  static FlightBookingEntitySeatingClassEnum valueOf(String name) => _$flightBookingEntitySeatingClassEnumValueOf(name);
}

class FlightBookingEntityReasonEnum extends EnumClass {

  /// Reason for the flight
  @BuiltValueEnumConst(wireName: r'personal')
  static const FlightBookingEntityReasonEnum personal = _$flightBookingEntityReasonEnum_personal;
  /// Reason for the flight
  @BuiltValueEnumConst(wireName: r'business')
  static const FlightBookingEntityReasonEnum business = _$flightBookingEntityReasonEnum_business;
  /// Reason for the flight
  @BuiltValueEnumConst(wireName: r'crew')
  static const FlightBookingEntityReasonEnum crew = _$flightBookingEntityReasonEnum_crew;
  /// Reason for the flight
  @BuiltValueEnumConst(wireName: r'training')
  static const FlightBookingEntityReasonEnum training = _$flightBookingEntityReasonEnum_training;
  /// Reason for the flight
  @BuiltValueEnumConst(wireName: r'repositioning')
  static const FlightBookingEntityReasonEnum repositioning = _$flightBookingEntityReasonEnum_repositioning;
  /// Reason for the flight
  @BuiltValueEnumConst(wireName: r'other')
  static const FlightBookingEntityReasonEnum other = _$flightBookingEntityReasonEnum_other;

  static Serializer<FlightBookingEntityReasonEnum> get serializer => _$flightBookingEntityReasonEnumSerializer;

  const FlightBookingEntityReasonEnum._(String name): super(name);

  static BuiltSet<FlightBookingEntityReasonEnum> get values => _$flightBookingEntityReasonEnumValues;
  static FlightBookingEntityReasonEnum valueOf(String name) => _$flightBookingEntityReasonEnumValueOf(name);
}

