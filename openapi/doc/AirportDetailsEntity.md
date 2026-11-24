# openapi.model.AirportDetailsEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**ident** | **String** | Airport identifier (ICAO) | 
**airport** | [**AirportEntity**](AirportEntity.md) | Airport record from the airports table (country, region, elevation, type). Null when the ident is not in the table. | [optional] 
**delays** | [**JsonObject**](.md) | FlightAware airport delay information, if any | [optional] 
**metar** | [**DecodedWeatherEntity**](DecodedWeatherEntity.md) | Latest METAR observation (raw + decoded) | [optional] 
**taf** | [**DecodedWeatherEntity**](DecodedWeatherEntity.md) | TAF forecast (raw + decoded) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


