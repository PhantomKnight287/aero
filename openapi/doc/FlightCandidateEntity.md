# openapi.model.FlightCandidateEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**faFlightId** | **String** | FlightAware flight ID for fetching full details | 
**ident** | **String** | Flight identifier (e.g., \"AC113\") | 
**origin** | [**FlightSummaryOriginEntity**](FlightSummaryOriginEntity.md) |  | 
**destination** | [**FlightSummaryDestinationEntity**](FlightSummaryDestinationEntity.md) |  | 
**scheduledOut** | [**DateTime**](DateTime.md) |  | [optional] 
**scheduledOff** | [**DateTime**](DateTime.md) |  | [optional] 
**status** | **String** | Flight status description | 
**airline** | [**FlightSummaryAirlineEntity**](FlightSummaryAirlineEntity.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


