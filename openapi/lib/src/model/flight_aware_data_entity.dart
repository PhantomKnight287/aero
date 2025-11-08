//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_aware_data_entity.g.dart';

/// FlightAwareDataEntity
///
/// Properties:
/// * [id] 
/// * [ident] - Flight identifier
/// * [identIcao] 
/// * [identIata] 
/// * [actualRunwayOff] 
/// * [actualRunwayOn] 
/// * [operator_] 
/// * [operatorIcao] 
/// * [operatorIata] 
/// * [flightNumber] 
/// * [registration] 
/// * [atcIdent] 
/// * [inboundFaFlightId] 
/// * [codesharesIata] 
/// * [codesharesIcao] 
/// * [departureDelay] - Departure delay in seconds (negative = early)
/// * [arrivalDelay] - Arrival delay in seconds (negative = early)
/// * [filedEte] - Estimated time en route in seconds
/// * [progressPercent] - Percent completion (0-100)
/// * [status] - Flight status description
/// * [aircraftType] 
/// * [routeDistance] - Planned flight distance in statute miles
/// * [filedAirspeed] - Filed IFR airspeed in knots
/// * [filedAltitude] - Filed IFR altitude in 100s of feet
/// * [route] 
/// * [baggageClaim] 
/// * [seatsCabinBusiness] - Business class seats
/// * [seatsCabinCoach] - Coach class seats
/// * [seatsCabinFirst] - First class seats
/// * [gateOrigin] 
/// * [gateDestination] 
/// * [terminalOrigin] 
/// * [terminalDestination] 
/// * [scheduledOut] 
/// * [estimatedOut] 
/// * [actualOut] 
/// * [scheduledOff] 
/// * [estimatedOff] 
/// * [actualOff] 
/// * [scheduledOn] 
/// * [estimatedOn] 
/// * [actualOn] 
/// * [scheduledIn] 
/// * [estimatedIn] 
/// * [actualIn] 
/// * [foresightPredictionsAvailable] - Foresight predictions available
/// * [blocked] 
/// * [diverted] 
/// * [cancelled] 
/// * [positionOnly] 
/// * [originCode] 
/// * [originCodeIcao] 
/// * [originCodeIata] 
/// * [originCodeLid] 
/// * [originTimezone] 
/// * [originName] 
/// * [originCity] 
/// * [destinationCode] 
/// * [destinationCodeIcao] 
/// * [destinationCodeIata] 
/// * [destinationCodeLid] 
/// * [destinationTimezone] 
/// * [destinationName] 
/// * [destinationCity] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class FlightAwareDataEntity implements Built<FlightAwareDataEntity, FlightAwareDataEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  /// Flight identifier
  @BuiltValueField(wireName: r'ident')
  String get ident;

  @BuiltValueField(wireName: r'identIcao')
  String? get identIcao;

  @BuiltValueField(wireName: r'identIata')
  String? get identIata;

  @BuiltValueField(wireName: r'actualRunwayOff')
  String? get actualRunwayOff;

  @BuiltValueField(wireName: r'actualRunwayOn')
  String? get actualRunwayOn;

  @BuiltValueField(wireName: r'operator')
  String? get operator_;

  @BuiltValueField(wireName: r'operatorIcao')
  String? get operatorIcao;

  @BuiltValueField(wireName: r'operatorIata')
  String? get operatorIata;

  @BuiltValueField(wireName: r'flightNumber')
  String? get flightNumber;

  @BuiltValueField(wireName: r'registration')
  String? get registration;

  @BuiltValueField(wireName: r'atcIdent')
  String? get atcIdent;

  @BuiltValueField(wireName: r'inboundFaFlightId')
  String? get inboundFaFlightId;

  @BuiltValueField(wireName: r'codesharesIata')
  BuiltList<String>? get codesharesIata;

  @BuiltValueField(wireName: r'codesharesIcao')
  BuiltList<String>? get codesharesIcao;

  /// Departure delay in seconds (negative = early)
  @BuiltValueField(wireName: r'departureDelay')
  num? get departureDelay;

  /// Arrival delay in seconds (negative = early)
  @BuiltValueField(wireName: r'arrivalDelay')
  num? get arrivalDelay;

  /// Estimated time en route in seconds
  @BuiltValueField(wireName: r'filedEte')
  num? get filedEte;

  /// Percent completion (0-100)
  @BuiltValueField(wireName: r'progressPercent')
  num? get progressPercent;

  /// Flight status description
  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'aircraftType')
  String? get aircraftType;

  /// Planned flight distance in statute miles
  @BuiltValueField(wireName: r'routeDistance')
  num? get routeDistance;

  /// Filed IFR airspeed in knots
  @BuiltValueField(wireName: r'filedAirspeed')
  num? get filedAirspeed;

  /// Filed IFR altitude in 100s of feet
  @BuiltValueField(wireName: r'filedAltitude')
  num? get filedAltitude;

  @BuiltValueField(wireName: r'route')
  String? get route;

  @BuiltValueField(wireName: r'baggageClaim')
  String? get baggageClaim;

  /// Business class seats
  @BuiltValueField(wireName: r'seatsCabinBusiness')
  num? get seatsCabinBusiness;

  /// Coach class seats
  @BuiltValueField(wireName: r'seatsCabinCoach')
  num? get seatsCabinCoach;

  /// First class seats
  @BuiltValueField(wireName: r'seatsCabinFirst')
  num? get seatsCabinFirst;

  @BuiltValueField(wireName: r'gateOrigin')
  String? get gateOrigin;

  @BuiltValueField(wireName: r'gateDestination')
  String? get gateDestination;

  @BuiltValueField(wireName: r'terminalOrigin')
  String? get terminalOrigin;

  @BuiltValueField(wireName: r'terminalDestination')
  String? get terminalDestination;

  @BuiltValueField(wireName: r'scheduledOut')
  DateTime? get scheduledOut;

  @BuiltValueField(wireName: r'estimatedOut')
  DateTime? get estimatedOut;

  @BuiltValueField(wireName: r'actualOut')
  DateTime? get actualOut;

  @BuiltValueField(wireName: r'scheduledOff')
  DateTime? get scheduledOff;

  @BuiltValueField(wireName: r'estimatedOff')
  DateTime? get estimatedOff;

  @BuiltValueField(wireName: r'actualOff')
  DateTime? get actualOff;

  @BuiltValueField(wireName: r'scheduledOn')
  DateTime? get scheduledOn;

  @BuiltValueField(wireName: r'estimatedOn')
  DateTime? get estimatedOn;

  @BuiltValueField(wireName: r'actualOn')
  DateTime? get actualOn;

  @BuiltValueField(wireName: r'scheduledIn')
  DateTime? get scheduledIn;

  @BuiltValueField(wireName: r'estimatedIn')
  DateTime? get estimatedIn;

  @BuiltValueField(wireName: r'actualIn')
  DateTime? get actualIn;

  /// Foresight predictions available
  @BuiltValueField(wireName: r'foresightPredictionsAvailable')
  bool get foresightPredictionsAvailable;

  @BuiltValueField(wireName: r'blocked')
  bool get blocked;

  @BuiltValueField(wireName: r'diverted')
  bool get diverted;

  @BuiltValueField(wireName: r'cancelled')
  bool get cancelled;

  @BuiltValueField(wireName: r'positionOnly')
  bool get positionOnly;

  @BuiltValueField(wireName: r'originCode')
  String? get originCode;

  @BuiltValueField(wireName: r'originCodeIcao')
  String? get originCodeIcao;

  @BuiltValueField(wireName: r'originCodeIata')
  String? get originCodeIata;

  @BuiltValueField(wireName: r'originCodeLid')
  String? get originCodeLid;

  @BuiltValueField(wireName: r'originTimezone')
  String? get originTimezone;

  @BuiltValueField(wireName: r'originName')
  String? get originName;

  @BuiltValueField(wireName: r'originCity')
  String? get originCity;

  @BuiltValueField(wireName: r'destinationCode')
  String? get destinationCode;

  @BuiltValueField(wireName: r'destinationCodeIcao')
  String? get destinationCodeIcao;

  @BuiltValueField(wireName: r'destinationCodeIata')
  String? get destinationCodeIata;

  @BuiltValueField(wireName: r'destinationCodeLid')
  String? get destinationCodeLid;

  @BuiltValueField(wireName: r'destinationTimezone')
  String? get destinationTimezone;

  @BuiltValueField(wireName: r'destinationName')
  String? get destinationName;

  @BuiltValueField(wireName: r'destinationCity')
  String? get destinationCity;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  FlightAwareDataEntity._();

  factory FlightAwareDataEntity([void updates(FlightAwareDataEntityBuilder b)]) = _$FlightAwareDataEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightAwareDataEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightAwareDataEntity> get serializer => _$FlightAwareDataEntitySerializer();
}

class _$FlightAwareDataEntitySerializer implements PrimitiveSerializer<FlightAwareDataEntity> {
  @override
  final Iterable<Type> types = const [FlightAwareDataEntity, _$FlightAwareDataEntity];

  @override
  final String wireName = r'FlightAwareDataEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightAwareDataEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'ident';
    yield serializers.serialize(
      object.ident,
      specifiedType: const FullType(String),
    );
    if (object.identIcao != null) {
      yield r'identIcao';
      yield serializers.serialize(
        object.identIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.identIata != null) {
      yield r'identIata';
      yield serializers.serialize(
        object.identIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.actualRunwayOff != null) {
      yield r'actualRunwayOff';
      yield serializers.serialize(
        object.actualRunwayOff,
        specifiedType: const FullType(String),
      );
    }
    if (object.actualRunwayOn != null) {
      yield r'actualRunwayOn';
      yield serializers.serialize(
        object.actualRunwayOn,
        specifiedType: const FullType(String),
      );
    }
    if (object.operator_ != null) {
      yield r'operator';
      yield serializers.serialize(
        object.operator_,
        specifiedType: const FullType(String),
      );
    }
    if (object.operatorIcao != null) {
      yield r'operatorIcao';
      yield serializers.serialize(
        object.operatorIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.operatorIata != null) {
      yield r'operatorIata';
      yield serializers.serialize(
        object.operatorIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.flightNumber != null) {
      yield r'flightNumber';
      yield serializers.serialize(
        object.flightNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.registration != null) {
      yield r'registration';
      yield serializers.serialize(
        object.registration,
        specifiedType: const FullType(String),
      );
    }
    if (object.atcIdent != null) {
      yield r'atcIdent';
      yield serializers.serialize(
        object.atcIdent,
        specifiedType: const FullType(String),
      );
    }
    if (object.inboundFaFlightId != null) {
      yield r'inboundFaFlightId';
      yield serializers.serialize(
        object.inboundFaFlightId,
        specifiedType: const FullType(String),
      );
    }
    if (object.codesharesIata != null) {
      yield r'codesharesIata';
      yield serializers.serialize(
        object.codesharesIata,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.codesharesIcao != null) {
      yield r'codesharesIcao';
      yield serializers.serialize(
        object.codesharesIcao,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.departureDelay != null) {
      yield r'departureDelay';
      yield serializers.serialize(
        object.departureDelay,
        specifiedType: const FullType(num),
      );
    }
    if (object.arrivalDelay != null) {
      yield r'arrivalDelay';
      yield serializers.serialize(
        object.arrivalDelay,
        specifiedType: const FullType(num),
      );
    }
    if (object.filedEte != null) {
      yield r'filedEte';
      yield serializers.serialize(
        object.filedEte,
        specifiedType: const FullType(num),
      );
    }
    if (object.progressPercent != null) {
      yield r'progressPercent';
      yield serializers.serialize(
        object.progressPercent,
        specifiedType: const FullType(num),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    if (object.aircraftType != null) {
      yield r'aircraftType';
      yield serializers.serialize(
        object.aircraftType,
        specifiedType: const FullType(String),
      );
    }
    if (object.routeDistance != null) {
      yield r'routeDistance';
      yield serializers.serialize(
        object.routeDistance,
        specifiedType: const FullType(num),
      );
    }
    if (object.filedAirspeed != null) {
      yield r'filedAirspeed';
      yield serializers.serialize(
        object.filedAirspeed,
        specifiedType: const FullType(num),
      );
    }
    if (object.filedAltitude != null) {
      yield r'filedAltitude';
      yield serializers.serialize(
        object.filedAltitude,
        specifiedType: const FullType(num),
      );
    }
    if (object.route != null) {
      yield r'route';
      yield serializers.serialize(
        object.route,
        specifiedType: const FullType(String),
      );
    }
    if (object.baggageClaim != null) {
      yield r'baggageClaim';
      yield serializers.serialize(
        object.baggageClaim,
        specifiedType: const FullType(String),
      );
    }
    if (object.seatsCabinBusiness != null) {
      yield r'seatsCabinBusiness';
      yield serializers.serialize(
        object.seatsCabinBusiness,
        specifiedType: const FullType(num),
      );
    }
    if (object.seatsCabinCoach != null) {
      yield r'seatsCabinCoach';
      yield serializers.serialize(
        object.seatsCabinCoach,
        specifiedType: const FullType(num),
      );
    }
    if (object.seatsCabinFirst != null) {
      yield r'seatsCabinFirst';
      yield serializers.serialize(
        object.seatsCabinFirst,
        specifiedType: const FullType(num),
      );
    }
    if (object.gateOrigin != null) {
      yield r'gateOrigin';
      yield serializers.serialize(
        object.gateOrigin,
        specifiedType: const FullType(String),
      );
    }
    if (object.gateDestination != null) {
      yield r'gateDestination';
      yield serializers.serialize(
        object.gateDestination,
        specifiedType: const FullType(String),
      );
    }
    if (object.terminalOrigin != null) {
      yield r'terminalOrigin';
      yield serializers.serialize(
        object.terminalOrigin,
        specifiedType: const FullType(String),
      );
    }
    if (object.terminalDestination != null) {
      yield r'terminalDestination';
      yield serializers.serialize(
        object.terminalDestination,
        specifiedType: const FullType(String),
      );
    }
    if (object.scheduledOut != null) {
      yield r'scheduledOut';
      yield serializers.serialize(
        object.scheduledOut,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.estimatedOut != null) {
      yield r'estimatedOut';
      yield serializers.serialize(
        object.estimatedOut,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.actualOut != null) {
      yield r'actualOut';
      yield serializers.serialize(
        object.actualOut,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.scheduledOff != null) {
      yield r'scheduledOff';
      yield serializers.serialize(
        object.scheduledOff,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.estimatedOff != null) {
      yield r'estimatedOff';
      yield serializers.serialize(
        object.estimatedOff,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.actualOff != null) {
      yield r'actualOff';
      yield serializers.serialize(
        object.actualOff,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.scheduledOn != null) {
      yield r'scheduledOn';
      yield serializers.serialize(
        object.scheduledOn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.estimatedOn != null) {
      yield r'estimatedOn';
      yield serializers.serialize(
        object.estimatedOn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.actualOn != null) {
      yield r'actualOn';
      yield serializers.serialize(
        object.actualOn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.scheduledIn != null) {
      yield r'scheduledIn';
      yield serializers.serialize(
        object.scheduledIn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.estimatedIn != null) {
      yield r'estimatedIn';
      yield serializers.serialize(
        object.estimatedIn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.actualIn != null) {
      yield r'actualIn';
      yield serializers.serialize(
        object.actualIn,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'foresightPredictionsAvailable';
    yield serializers.serialize(
      object.foresightPredictionsAvailable,
      specifiedType: const FullType(bool),
    );
    yield r'blocked';
    yield serializers.serialize(
      object.blocked,
      specifiedType: const FullType(bool),
    );
    yield r'diverted';
    yield serializers.serialize(
      object.diverted,
      specifiedType: const FullType(bool),
    );
    yield r'cancelled';
    yield serializers.serialize(
      object.cancelled,
      specifiedType: const FullType(bool),
    );
    yield r'positionOnly';
    yield serializers.serialize(
      object.positionOnly,
      specifiedType: const FullType(bool),
    );
    if (object.originCode != null) {
      yield r'originCode';
      yield serializers.serialize(
        object.originCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.originCodeIcao != null) {
      yield r'originCodeIcao';
      yield serializers.serialize(
        object.originCodeIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.originCodeIata != null) {
      yield r'originCodeIata';
      yield serializers.serialize(
        object.originCodeIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.originCodeLid != null) {
      yield r'originCodeLid';
      yield serializers.serialize(
        object.originCodeLid,
        specifiedType: const FullType(String),
      );
    }
    if (object.originTimezone != null) {
      yield r'originTimezone';
      yield serializers.serialize(
        object.originTimezone,
        specifiedType: const FullType(String),
      );
    }
    if (object.originName != null) {
      yield r'originName';
      yield serializers.serialize(
        object.originName,
        specifiedType: const FullType(String),
      );
    }
    if (object.originCity != null) {
      yield r'originCity';
      yield serializers.serialize(
        object.originCity,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationCode != null) {
      yield r'destinationCode';
      yield serializers.serialize(
        object.destinationCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationCodeIcao != null) {
      yield r'destinationCodeIcao';
      yield serializers.serialize(
        object.destinationCodeIcao,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationCodeIata != null) {
      yield r'destinationCodeIata';
      yield serializers.serialize(
        object.destinationCodeIata,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationCodeLid != null) {
      yield r'destinationCodeLid';
      yield serializers.serialize(
        object.destinationCodeLid,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationTimezone != null) {
      yield r'destinationTimezone';
      yield serializers.serialize(
        object.destinationTimezone,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationName != null) {
      yield r'destinationName';
      yield serializers.serialize(
        object.destinationName,
        specifiedType: const FullType(String),
      );
    }
    if (object.destinationCity != null) {
      yield r'destinationCity';
      yield serializers.serialize(
        object.destinationCity,
        specifiedType: const FullType(String),
      );
    }
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
    FlightAwareDataEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightAwareDataEntityBuilder result,
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
        case r'ident':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ident = valueDes;
          break;
        case r'identIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.identIcao = valueDes;
          break;
        case r'identIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.identIata = valueDes;
          break;
        case r'actualRunwayOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actualRunwayOff = valueDes;
          break;
        case r'actualRunwayOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actualRunwayOn = valueDes;
          break;
        case r'operator':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.operator_ = valueDes;
          break;
        case r'operatorIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.operatorIcao = valueDes;
          break;
        case r'operatorIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.operatorIata = valueDes;
          break;
        case r'flightNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flightNumber = valueDes;
          break;
        case r'registration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.registration = valueDes;
          break;
        case r'atcIdent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.atcIdent = valueDes;
          break;
        case r'inboundFaFlightId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.inboundFaFlightId = valueDes;
          break;
        case r'codesharesIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.codesharesIata.replace(valueDes);
          break;
        case r'codesharesIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.codesharesIcao.replace(valueDes);
          break;
        case r'departureDelay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.departureDelay = valueDes;
          break;
        case r'arrivalDelay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.arrivalDelay = valueDes;
          break;
        case r'filedEte':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.filedEte = valueDes;
          break;
        case r'progressPercent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.progressPercent = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'aircraftType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.aircraftType = valueDes;
          break;
        case r'routeDistance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.routeDistance = valueDes;
          break;
        case r'filedAirspeed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.filedAirspeed = valueDes;
          break;
        case r'filedAltitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.filedAltitude = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.route = valueDes;
          break;
        case r'baggageClaim':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baggageClaim = valueDes;
          break;
        case r'seatsCabinBusiness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.seatsCabinBusiness = valueDes;
          break;
        case r'seatsCabinCoach':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.seatsCabinCoach = valueDes;
          break;
        case r'seatsCabinFirst':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.seatsCabinFirst = valueDes;
          break;
        case r'gateOrigin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gateOrigin = valueDes;
          break;
        case r'gateDestination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gateDestination = valueDes;
          break;
        case r'terminalOrigin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.terminalOrigin = valueDes;
          break;
        case r'terminalDestination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.terminalDestination = valueDes;
          break;
        case r'scheduledOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledOut = valueDes;
          break;
        case r'estimatedOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.estimatedOut = valueDes;
          break;
        case r'actualOut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.actualOut = valueDes;
          break;
        case r'scheduledOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledOff = valueDes;
          break;
        case r'estimatedOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.estimatedOff = valueDes;
          break;
        case r'actualOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.actualOff = valueDes;
          break;
        case r'scheduledOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledOn = valueDes;
          break;
        case r'estimatedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.estimatedOn = valueDes;
          break;
        case r'actualOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.actualOn = valueDes;
          break;
        case r'scheduledIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scheduledIn = valueDes;
          break;
        case r'estimatedIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.estimatedIn = valueDes;
          break;
        case r'actualIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.actualIn = valueDes;
          break;
        case r'foresightPredictionsAvailable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.foresightPredictionsAvailable = valueDes;
          break;
        case r'blocked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.blocked = valueDes;
          break;
        case r'diverted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.diverted = valueDes;
          break;
        case r'cancelled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cancelled = valueDes;
          break;
        case r'positionOnly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.positionOnly = valueDes;
          break;
        case r'originCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originCode = valueDes;
          break;
        case r'originCodeIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originCodeIcao = valueDes;
          break;
        case r'originCodeIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originCodeIata = valueDes;
          break;
        case r'originCodeLid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originCodeLid = valueDes;
          break;
        case r'originTimezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originTimezone = valueDes;
          break;
        case r'originName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originName = valueDes;
          break;
        case r'originCity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originCity = valueDes;
          break;
        case r'destinationCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationCode = valueDes;
          break;
        case r'destinationCodeIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationCodeIcao = valueDes;
          break;
        case r'destinationCodeIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationCodeIata = valueDes;
          break;
        case r'destinationCodeLid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationCodeLid = valueDes;
          break;
        case r'destinationTimezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationTimezone = valueDes;
          break;
        case r'destinationName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationName = valueDes;
          break;
        case r'destinationCity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationCity = valueDes;
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
  FlightAwareDataEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightAwareDataEntityBuilder();
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

