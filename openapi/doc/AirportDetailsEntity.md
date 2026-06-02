# openapi.model.AirportDetailsEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**ident** | **String** | Airport identifier (ICAO) | 
**delays** | [**JsonObject**](.md) | FlightAware airport delay information, if any | [optional] 
**metar** | [**DecodedWeatherEntity**](DecodedWeatherEntity.md) | Latest METAR observation (raw + decoded) | [optional] 
**taf** | [**DecodedWeatherEntity**](DecodedWeatherEntity.md) | TAF forecast (raw + decoded) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


