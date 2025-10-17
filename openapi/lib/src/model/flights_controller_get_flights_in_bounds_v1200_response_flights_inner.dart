//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/flights_controller_get_flights_in_bounds_v1200_response_flights_inner_origin.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flights_controller_get_flights_in_bounds_v1200_response_flights_inner.g.dart';

/// FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner
///
/// Properties:
/// * [identIcao] 
/// * [identIata] 
/// * [callsign] 
/// * [latitude] 
/// * [longitude] 
/// * [altitude] 
/// * [velocity] 
/// * [heading] 
/// * [verticalRate] 
/// * [lastContact] 
/// * [isOnGround] 
/// * [aircraftType] 
/// * [aircraftTypeFaa] 
/// * [aircraftFamily] 
/// * [manufacturer] 
/// * [model] 
/// * [engineType] 
/// * [engineCount] 
/// * [wakeTurbulenceCategory] 
/// * [aircraftId] 
/// * [aircraftRegistration] 
/// * [ownerIcao] 
/// * [ownerIata] 
/// * [ownerName] 
/// * [operator_] 
/// * [operatorIcao] 
/// * [operatorIata] 
/// * [operatorCountry] 
/// * [origin] 
/// * [destination] 
/// * [status] 
/// * [progressPercent] 
/// * [routeDistance] 
/// * [filedAirspeedKts] 
/// * [filedAltitude] 
/// * [scheduledOff] 
/// * [scheduledOn] 
/// * [estimatedOff] 
/// * [estimatedOn] 
/// * [actualOff] 
/// * [actualOn] 
/// * [departureDelay] 
/// * [arrivalDelay] 
/// * [gateOrigin] 
/// * [gateDestination] 
/// * [terminalOrigin] 
/// * [terminalDestination] 
/// * [route] 
/// * [type] 
@BuiltValue()
abstract class FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner implements Built<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner, FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerBuilder> {
  @BuiltValueField(wireName: r'ident_icao')
  String? get identIcao;

  @BuiltValueField(wireName: r'ident_iata')
  String? get identIata;

  @BuiltValueField(wireName: r'callsign')
  String? get callsign;

  @BuiltValueField(wireName: r'latitude')
  num? get latitude;

  @BuiltValueField(wireName: r'longitude')
  num? get longitude;

  @BuiltValueField(wireName: r'altitude')
  num? get altitude;

  @BuiltValueField(wireName: r'velocity')
  num? get velocity;

  @BuiltValueField(wireName: r'heading')
  num? get heading;

  @BuiltValueField(wireName: r'verticalRate')
  num? get verticalRate;

  @BuiltValueField(wireName: r'lastContact')
  DateTime? get lastContact;

  @BuiltValueField(wireName: r'isOnGround')
  bool? get isOnGround;

  @BuiltValueField(wireName: r'aircraftType')
  String? get aircraftType;

  @BuiltValueField(wireName: r'aircraftTypeFaa')
  String? get aircraftTypeFaa;

  @BuiltValueField(wireName: r'aircraftFamily')
  String? get aircraftFamily;

  @BuiltValueField(wireName: r'manufacturer')
  String? get manufacturer;

  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'engineType')
  String? get engineType;

  @BuiltValueField(wireName: r'engineCount')
  String? get engineCount;

  @BuiltValueField(wireName: r'wakeTurbulenceCategory')
  String? get wakeTurbulenceCategory;

  @BuiltValueField(wireName: r'aircraftId')
  String? get aircraftId;

  @BuiltValueField(wireName: r'aircraftRegistration')
  String? get aircraftRegistration;

  @BuiltValueField(wireName: r'ownerIcao')
  String? get ownerIcao;

  @BuiltValueField(wireName: r'ownerIata')
  String? get ownerIata;

  @BuiltValueField(wireName: r'ownerName')
  String? get ownerName;

  @BuiltValueField(wireName: r'operator')
  String? get operator_;

  @BuiltValueField(wireName: r'operatorIcao')
  String? get operatorIcao;

  @BuiltValueField(wireName: r'operatorIata')
  String? get operatorIata;

  @BuiltValueField(wireName: r'operatorCountry')
  String? get operatorCountry;

  @BuiltValueField(wireName: r'origin')
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin? get origin;

  @BuiltValueField(wireName: r'destination')
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin? get destination;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'progressPercent')
  num? get progressPercent;

  @BuiltValueField(wireName: r'routeDistance')
  num? get routeDistance;

  @BuiltValueField(wireName: r'filedAirspeedKts')
  num? get filedAirspeedKts;

  @BuiltValueField(wireName: r'filedAltitude')
  num? get filedAltitude;

  @BuiltValueField(wireName: r'scheduledOff')
  String? get scheduledOff;

  @BuiltValueField(wireName: r'scheduledOn')
  String? get scheduledOn;

  @BuiltValueField(wireName: r'estimatedOff')
  String? get estimatedOff;

  @BuiltValueField(wireName: r'estimatedOn')
  String? get estimatedOn;

  @BuiltValueField(wireName: r'actualOff')
  String? get actualOff;

  @BuiltValueField(wireName: r'actualOn')
  String? get actualOn;

  @BuiltValueField(wireName: r'departureDelay')
  String? get departureDelay;

  @BuiltValueField(wireName: r'arrivalDelay')
  String? get arrivalDelay;

  @BuiltValueField(wireName: r'gateOrigin')
  String? get gateOrigin;

  @BuiltValueField(wireName: r'gateDestination')
  String? get gateDestination;

  @BuiltValueField(wireName: r'terminalOrigin')
  String? get terminalOrigin;

  @BuiltValueField(wireName: r'terminalDestination')
  String? get terminalDestination;

  @BuiltValueField(wireName: r'route')
  String? get route;

  @BuiltValueField(wireName: r'type')
  String? get type;

  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner._();

  factory FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner([void updates(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerBuilder b)]) = _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner> get serializer => _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerSerializer();
}

class _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerSerializer implements PrimitiveSerializer<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner> {
  @override
  final Iterable<Type> types = const [FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner, _$FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner];

  @override
  final String wireName = r'FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.identIcao != null) {
      yield r'ident_icao';
      yield serializers.serialize(
        object.identIcao,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.identIata != null) {
      yield r'ident_iata';
      yield serializers.serialize(
        object.identIata,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.callsign != null) {
      yield r'callsign';
      yield serializers.serialize(
        object.callsign,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.altitude != null) {
      yield r'altitude';
      yield serializers.serialize(
        object.altitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.velocity != null) {
      yield r'velocity';
      yield serializers.serialize(
        object.velocity,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.heading != null) {
      yield r'heading';
      yield serializers.serialize(
        object.heading,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.verticalRate != null) {
      yield r'verticalRate';
      yield serializers.serialize(
        object.verticalRate,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lastContact != null) {
      yield r'lastContact';
      yield serializers.serialize(
        object.lastContact,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.isOnGround != null) {
      yield r'isOnGround';
      yield serializers.serialize(
        object.isOnGround,
        specifiedType: const FullType(bool),
      );
    }
    if (object.aircraftType != null) {
      yield r'aircraftType';
      yield serializers.serialize(
        object.aircraftType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.aircraftTypeFaa != null) {
      yield r'aircraftTypeFaa';
      yield serializers.serialize(
        object.aircraftTypeFaa,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.aircraftFamily != null) {
      yield r'aircraftFamily';
      yield serializers.serialize(
        object.aircraftFamily,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.manufacturer != null) {
      yield r'manufacturer';
      yield serializers.serialize(
        object.manufacturer,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.engineType != null) {
      yield r'engineType';
      yield serializers.serialize(
        object.engineType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.engineCount != null) {
      yield r'engineCount';
      yield serializers.serialize(
        object.engineCount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.wakeTurbulenceCategory != null) {
      yield r'wakeTurbulenceCategory';
      yield serializers.serialize(
        object.wakeTurbulenceCategory,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.aircraftId != null) {
      yield r'aircraftId';
      yield serializers.serialize(
        object.aircraftId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.aircraftRegistration != null) {
      yield r'aircraftRegistration';
      yield serializers.serialize(
        object.aircraftRegistration,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.ownerIcao != null) {
      yield r'ownerIcao';
      yield serializers.serialize(
        object.ownerIcao,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.ownerIata != null) {
      yield r'ownerIata';
      yield serializers.serialize(
        object.ownerIata,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.ownerName != null) {
      yield r'ownerName';
      yield serializers.serialize(
        object.ownerName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.operator_ != null) {
      yield r'operator';
      yield serializers.serialize(
        object.operator_,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.operatorIcao != null) {
      yield r'operatorIcao';
      yield serializers.serialize(
        object.operatorIcao,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.operatorIata != null) {
      yield r'operatorIata';
      yield serializers.serialize(
        object.operatorIata,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.operatorCountry != null) {
      yield r'operatorCountry';
      yield serializers.serialize(
        object.operatorCountry,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.origin != null) {
      yield r'origin';
      yield serializers.serialize(
        object.origin,
        specifiedType: const FullType.nullable(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin),
      );
    }
    if (object.destination != null) {
      yield r'destination';
      yield serializers.serialize(
        object.destination,
        specifiedType: const FullType.nullable(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.progressPercent != null) {
      yield r'progressPercent';
      yield serializers.serialize(
        object.progressPercent,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.routeDistance != null) {
      yield r'routeDistance';
      yield serializers.serialize(
        object.routeDistance,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.filedAirspeedKts != null) {
      yield r'filedAirspeedKts';
      yield serializers.serialize(
        object.filedAirspeedKts,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.filedAltitude != null) {
      yield r'filedAltitude';
      yield serializers.serialize(
        object.filedAltitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.scheduledOff != null) {
      yield r'scheduledOff';
      yield serializers.serialize(
        object.scheduledOff,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.scheduledOn != null) {
      yield r'scheduledOn';
      yield serializers.serialize(
        object.scheduledOn,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.estimatedOff != null) {
      yield r'estimatedOff';
      yield serializers.serialize(
        object.estimatedOff,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.estimatedOn != null) {
      yield r'estimatedOn';
      yield serializers.serialize(
        object.estimatedOn,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.actualOff != null) {
      yield r'actualOff';
      yield serializers.serialize(
        object.actualOff,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.actualOn != null) {
      yield r'actualOn';
      yield serializers.serialize(
        object.actualOn,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.departureDelay != null) {
      yield r'departureDelay';
      yield serializers.serialize(
        object.departureDelay,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.arrivalDelay != null) {
      yield r'arrivalDelay';
      yield serializers.serialize(
        object.arrivalDelay,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.gateOrigin != null) {
      yield r'gateOrigin';
      yield serializers.serialize(
        object.gateOrigin,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.gateDestination != null) {
      yield r'gateDestination';
      yield serializers.serialize(
        object.gateDestination,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.terminalOrigin != null) {
      yield r'terminalOrigin';
      yield serializers.serialize(
        object.terminalOrigin,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.terminalDestination != null) {
      yield r'terminalDestination';
      yield serializers.serialize(
        object.terminalDestination,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.route != null) {
      yield r'route';
      yield serializers.serialize(
        object.route,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ident_icao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.identIcao = valueDes;
          break;
        case r'ident_iata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.identIata = valueDes;
          break;
        case r'callsign':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.callsign = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.longitude = valueDes;
          break;
        case r'altitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.altitude = valueDes;
          break;
        case r'velocity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.velocity = valueDes;
          break;
        case r'heading':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.heading = valueDes;
          break;
        case r'verticalRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.verticalRate = valueDes;
          break;
        case r'lastContact':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastContact = valueDes;
          break;
        case r'isOnGround':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isOnGround = valueDes;
          break;
        case r'aircraftType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.aircraftType = valueDes;
          break;
        case r'aircraftTypeFaa':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.aircraftTypeFaa = valueDes;
          break;
        case r'aircraftFamily':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.aircraftFamily = valueDes;
          break;
        case r'manufacturer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.manufacturer = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.model = valueDes;
          break;
        case r'engineType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.engineType = valueDes;
          break;
        case r'engineCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.engineCount = valueDes;
          break;
        case r'wakeTurbulenceCategory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.wakeTurbulenceCategory = valueDes;
          break;
        case r'aircraftId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.aircraftId = valueDes;
          break;
        case r'aircraftRegistration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.aircraftRegistration = valueDes;
          break;
        case r'ownerIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ownerIcao = valueDes;
          break;
        case r'ownerIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ownerIata = valueDes;
          break;
        case r'ownerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ownerName = valueDes;
          break;
        case r'operator':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.operator_ = valueDes;
          break;
        case r'operatorIcao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.operatorIcao = valueDes;
          break;
        case r'operatorIata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.operatorIata = valueDes;
          break;
        case r'operatorCountry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.operatorCountry = valueDes;
          break;
        case r'origin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin),
          ) as FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin?;
          if (valueDes == null) continue;
          result.origin.replace(valueDes);
          break;
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin),
          ) as FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin?;
          if (valueDes == null) continue;
          result.destination.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'progressPercent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.progressPercent = valueDes;
          break;
        case r'routeDistance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.routeDistance = valueDes;
          break;
        case r'filedAirspeedKts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.filedAirspeedKts = valueDes;
          break;
        case r'filedAltitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.filedAltitude = valueDes;
          break;
        case r'scheduledOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scheduledOff = valueDes;
          break;
        case r'scheduledOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scheduledOn = valueDes;
          break;
        case r'estimatedOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedOff = valueDes;
          break;
        case r'estimatedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedOn = valueDes;
          break;
        case r'actualOff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actualOff = valueDes;
          break;
        case r'actualOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actualOn = valueDes;
          break;
        case r'departureDelay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.departureDelay = valueDes;
          break;
        case r'arrivalDelay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.arrivalDelay = valueDes;
          break;
        case r'gateOrigin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.gateOrigin = valueDes;
          break;
        case r'gateDestination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.gateDestination = valueDes;
          break;
        case r'terminalOrigin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.terminalOrigin = valueDes;
          break;
        case r'terminalDestination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.terminalDestination = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.route = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerBuilder();
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

