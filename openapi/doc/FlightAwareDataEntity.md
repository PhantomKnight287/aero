# openapi.model.FlightAwareDataEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**ident** | **String** | Flight identifier | 
**identIcao** | **String** |  | [optional] 
**identIata** | **String** |  | [optional] 
**actualRunwayOff** | **String** |  | [optional] 
**actualRunwayOn** | **String** |  | [optional] 
**operator_** | **String** |  | [optional] 
**operatorIcao** | **String** |  | [optional] 
**operatorIata** | **String** |  | [optional] 
**flightNumber** | **String** |  | [optional] 
**registration** | **String** |  | [optional] 
**atcIdent** | **String** |  | [optional] 
**inboundFaFlightId** | **String** |  | [optional] 
**codesharesIata** | **BuiltList&lt;String&gt;** |  | [optional] 
**codesharesIcao** | **BuiltList&lt;String&gt;** |  | [optional] 
**departureDelay** | **num** | Departure delay in seconds (negative = early) | [optional] 
**arrivalDelay** | **num** | Arrival delay in seconds (negative = early) | [optional] 
**filedEte** | **num** | Estimated time en route in seconds | [optional] 
**progressPercent** | **num** | Percent completion (0-100) | [optional] 
**status** | **String** | Flight status description | 
**aircraftType** | **String** |  | [optional] 
**routeDistance** | **num** | Planned flight distance in statute miles | [optional] 
**filedAirspeed** | **num** | Filed IFR airspeed in knots | [optional] 
**filedAltitude** | **num** | Filed IFR altitude in 100s of feet | [optional] 
**route** | **String** |  | [optional] 
**baggageClaim** | **String** |  | [optional] 
**seatsCabinBusiness** | **num** | Business class seats | [optional] 
**seatsCabinCoach** | **num** | Coach class seats | [optional] 
**seatsCabinFirst** | **num** | First class seats | [optional] 
**gateOrigin** | **String** |  | [optional] 
**gateDestination** | **String** |  | [optional] 
**terminalOrigin** | **String** |  | [optional] 
**terminalDestination** | **String** |  | [optional] 
**scheduledOut** | [**DateTime**](DateTime.md) |  | [optional] 
**estimatedOut** | [**DateTime**](DateTime.md) |  | [optional] 
**actualOut** | [**DateTime**](DateTime.md) |  | [optional] 
**scheduledOff** | [**DateTime**](DateTime.md) |  | [optional] 
**estimatedOff** | [**DateTime**](DateTime.md) |  | [optional] 
**actualOff** | [**DateTime**](DateTime.md) |  | [optional] 
**scheduledOn** | [**DateTime**](DateTime.md) |  | [optional] 
**estimatedOn** | [**DateTime**](DateTime.md) |  | [optional] 
**actualOn** | [**DateTime**](DateTime.md) |  | [optional] 
**scheduledIn** | [**DateTime**](DateTime.md) |  | [optional] 
**estimatedIn** | [**DateTime**](DateTime.md) |  | [optional] 
**actualIn** | [**DateTime**](DateTime.md) |  | [optional] 
**foresightPredictionsAvailable** | **bool** | Foresight predictions available | 
**blocked** | **bool** |  | 
**diverted** | **bool** |  | 
**cancelled** | **bool** |  | 
**positionOnly** | **bool** |  | 
**originCode** | **String** |  | [optional] 
**originCodeIcao** | **String** |  | [optional] 
**originCodeIata** | **String** |  | [optional] 
**originCodeLid** | **String** |  | [optional] 
**originTimezone** | **String** |  | [optional] 
**originName** | **String** |  | [optional] 
**originCity** | **String** |  | [optional] 
**destinationCode** | **String** |  | [optional] 
**destinationCodeIcao** | **String** |  | [optional] 
**destinationCodeIata** | **String** |  | [optional] 
**destinationCodeLid** | **String** |  | [optional] 
**destinationTimezone** | **String** |  | [optional] 
**destinationName** | **String** |  | [optional] 
**destinationCity** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


