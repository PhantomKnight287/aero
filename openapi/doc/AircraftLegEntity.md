# openapi.model.AircraftLegEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**faFlightId** | **String** |  | 
**ident** | **String** |  | 
**identIata** | **String** |  | [optional] 
**identIcao** | **String** |  | [optional] 
**status** | **String** | FlightAware status text | 
**originIata** | **String** |  | [optional] 
**originIcao** | **String** |  | [optional] 
**originCity** | **String** |  | [optional] 
**originTimezone** | **String** |  | [optional] 
**destinationIata** | **String** |  | [optional] 
**destinationIcao** | **String** |  | [optional] 
**destinationCity** | **String** |  | [optional] 
**destinationTimezone** | **String** |  | [optional] 
**scheduledOut** | **String** | ISO time | [optional] 
**estimatedOut** | **String** | ISO time | [optional] 
**actualOut** | **String** | ISO time | [optional] 
**scheduledIn** | **String** | ISO time | [optional] 
**estimatedIn** | **String** | ISO time | [optional] 
**actualIn** | **String** | ISO time | [optional] 
**arrivalDelay** | **num** | Seconds, negative = early | [optional] 
**progressPercent** | **num** | 0-100 | [optional] 
**cancelled** | **bool** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


