# openapi.model.AircraftHistoryEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**registration** | **String** |  | 
**inbound** | [**AircraftLegEntity**](AircraftLegEntity.md) | This airframe's previous leg (inbound to this flight) | 
**ownFlights** | [**BuiltList&lt;FlightSummaryEntity&gt;**](FlightSummaryEntity.md) | The user's other logged flights on the same registration | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


