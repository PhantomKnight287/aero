//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_position_entity.g.dart';

/// FlightPositionEntity
///
/// Properties:
/// * [faFlightId] - FlightAware flight ID for this position
/// * [altitude] - Aircraft altitude in hundreds of feet
/// * [altitudeChange] - Altitude change indicator
/// * [groundspeed] - Groundspeed in knots
/// * [heading] - Aircraft heading in degrees (0-360)
/// * [latitude] - Latitude position
/// * [longitude] - Longitude position
/// * [timestamp] - Time that position was received
/// * [updateType] - Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
@BuiltValue()
abstract class FlightPositionEntity implements Built<FlightPositionEntity, FlightPositionEntityBuilder> {
  /// FlightAware flight ID for this position
  @BuiltValueField(wireName: r'fa_flight_id')
  String? get faFlightId;

  /// Aircraft altitude in hundreds of feet
  @BuiltValueField(wireName: r'altitude')
  num get altitude;

  /// Altitude change indicator
  @BuiltValueField(wireName: r'altitude_change')
  FlightPositionEntityAltitudeChangeEnum get altitudeChange;
  // enum altitudeChangeEnum {  C,  D,  -,  };

  /// Groundspeed in knots
  @BuiltValueField(wireName: r'groundspeed')
  num get groundspeed;

  /// Aircraft heading in degrees (0-360)
  @BuiltValueField(wireName: r'heading')
  num? get heading;

  /// Latitude position
  @BuiltValueField(wireName: r'latitude')
  num get latitude;

  /// Longitude position
  @BuiltValueField(wireName: r'longitude')
  num get longitude;

  /// Time that position was received
  @BuiltValueField(wireName: r'timestamp')
  String get timestamp;

  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueField(wireName: r'update_type')
  FlightPositionEntityUpdateTypeEnum? get updateType;
  // enum updateTypeEnum {  P,  O,  Z,  A,  M,  D,  X,  S,  V,  };

  FlightPositionEntity._();

  factory FlightPositionEntity([void updates(FlightPositionEntityBuilder b)]) = _$FlightPositionEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightPositionEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightPositionEntity> get serializer => _$FlightPositionEntitySerializer();
}

class _$FlightPositionEntitySerializer implements PrimitiveSerializer<FlightPositionEntity> {
  @override
  final Iterable<Type> types = const [FlightPositionEntity, _$FlightPositionEntity];

  @override
  final String wireName = r'FlightPositionEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightPositionEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.faFlightId != null) {
      yield r'fa_flight_id';
      yield serializers.serialize(
        object.faFlightId,
        specifiedType: const FullType(String),
      );
    }
    yield r'altitude';
    yield serializers.serialize(
      object.altitude,
      specifiedType: const FullType(num),
    );
    yield r'altitude_change';
    yield serializers.serialize(
      object.altitudeChange,
      specifiedType: const FullType(FlightPositionEntityAltitudeChangeEnum),
    );
    yield r'groundspeed';
    yield serializers.serialize(
      object.groundspeed,
      specifiedType: const FullType(num),
    );
    if (object.heading != null) {
      yield r'heading';
      yield serializers.serialize(
        object.heading,
        specifiedType: const FullType(num),
      );
    }
    yield r'latitude';
    yield serializers.serialize(
      object.latitude,
      specifiedType: const FullType(num),
    );
    yield r'longitude';
    yield serializers.serialize(
      object.longitude,
      specifiedType: const FullType(num),
    );
    yield r'timestamp';
    yield serializers.serialize(
      object.timestamp,
      specifiedType: const FullType(String),
    );
    if (object.updateType != null) {
      yield r'update_type';
      yield serializers.serialize(
        object.updateType,
        specifiedType: const FullType(FlightPositionEntityUpdateTypeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightPositionEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightPositionEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fa_flight_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.faFlightId = valueDes;
          break;
        case r'altitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.altitude = valueDes;
          break;
        case r'altitude_change':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightPositionEntityAltitudeChangeEnum),
          ) as FlightPositionEntityAltitudeChangeEnum;
          result.altitudeChange = valueDes;
          break;
        case r'groundspeed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.groundspeed = valueDes;
          break;
        case r'heading':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.heading = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.longitude = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.timestamp = valueDes;
          break;
        case r'update_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FlightPositionEntityUpdateTypeEnum),
          ) as FlightPositionEntityUpdateTypeEnum;
          result.updateType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightPositionEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightPositionEntityBuilder();
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

class FlightPositionEntityAltitudeChangeEnum extends EnumClass {

  /// Altitude change indicator
  @BuiltValueEnumConst(wireName: r'C')
  static const FlightPositionEntityAltitudeChangeEnum C = _$flightPositionEntityAltitudeChangeEnum_C;
  /// Altitude change indicator
  @BuiltValueEnumConst(wireName: r'D')
  static const FlightPositionEntityAltitudeChangeEnum D = _$flightPositionEntityAltitudeChangeEnum_D;
  /// Altitude change indicator
  @BuiltValueEnumConst(wireName: r'-')
  static const FlightPositionEntityAltitudeChangeEnum underscore = _$flightPositionEntityAltitudeChangeEnum_underscore;

  static Serializer<FlightPositionEntityAltitudeChangeEnum> get serializer => _$flightPositionEntityAltitudeChangeEnumSerializer;

  const FlightPositionEntityAltitudeChangeEnum._(String name): super(name);

  static BuiltSet<FlightPositionEntityAltitudeChangeEnum> get values => _$flightPositionEntityAltitudeChangeEnumValues;
  static FlightPositionEntityAltitudeChangeEnum valueOf(String name) => _$flightPositionEntityAltitudeChangeEnumValueOf(name);
}

class FlightPositionEntityUpdateTypeEnum extends EnumClass {

  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'P')
  static const FlightPositionEntityUpdateTypeEnum P = _$flightPositionEntityUpdateTypeEnum_P;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'O')
  static const FlightPositionEntityUpdateTypeEnum O = _$flightPositionEntityUpdateTypeEnum_O;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'Z')
  static const FlightPositionEntityUpdateTypeEnum Z = _$flightPositionEntityUpdateTypeEnum_Z;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'A')
  static const FlightPositionEntityUpdateTypeEnum A = _$flightPositionEntityUpdateTypeEnum_A;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'M')
  static const FlightPositionEntityUpdateTypeEnum M = _$flightPositionEntityUpdateTypeEnum_M;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'D')
  static const FlightPositionEntityUpdateTypeEnum D = _$flightPositionEntityUpdateTypeEnum_D;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'X')
  static const FlightPositionEntityUpdateTypeEnum X = _$flightPositionEntityUpdateTypeEnum_X;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'S')
  static const FlightPositionEntityUpdateTypeEnum S = _$flightPositionEntityUpdateTypeEnum_S;
  /// Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event
  @BuiltValueEnumConst(wireName: r'V')
  static const FlightPositionEntityUpdateTypeEnum V = _$flightPositionEntityUpdateTypeEnum_V;

  static Serializer<FlightPositionEntityUpdateTypeEnum> get serializer => _$flightPositionEntityUpdateTypeEnumSerializer;

  const FlightPositionEntityUpdateTypeEnum._(String name): super(name);

  static BuiltSet<FlightPositionEntityUpdateTypeEnum> get values => _$flightPositionEntityUpdateTypeEnumValues;
  static FlightPositionEntityUpdateTypeEnum valueOf(String name) => _$flightPositionEntityUpdateTypeEnumValueOf(name);
}

