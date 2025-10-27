# openapi.model.FlightPositionEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**faFlightId** | **String** | FlightAware flight ID for this position | [optional] 
**altitude** | **num** | Aircraft altitude in hundreds of feet | 
**altitudeChange** | **String** | Altitude change indicator | 
**groundspeed** | **num** | Groundspeed in knots | 
**heading** | **num** | Aircraft heading in degrees (0-360) | [optional] 
**latitude** | **num** | Latitude position | 
**longitude** | **num** | Longitude position | 
**timestamp** | **String** | Time that position was received | 
**updateType** | **String** | Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


