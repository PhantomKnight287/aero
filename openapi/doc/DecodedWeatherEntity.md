# openapi.model.DecodedWeatherEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**raw** | **String** | Raw aviation weather string (METAR/TAF) | [optional] 
**decoded** | [**JsonObject**](.md) | Structured/decoded representation of the raw string. Null when decoding failed or no raw string was available. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


