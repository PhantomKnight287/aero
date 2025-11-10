# openapi.model.CreateFlightBookingDTO

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**flightId** | **String** | Flight ID to associate the booking with | 
**bookingCode** | **String** | Booking code/confirmation code (e.g., \"ABC123\") | [optional] 
**seatNumber** | **String** | Seat number (e.g., \"12A\", \"1F\") | [optional] 
**seatType** | **String** | Type of seat position | [optional] 
**seatingClass** | **String** | Class of service | [optional] 
**reason** | **String** | Reason for the flight | [optional] [default to 'personal']
**notes** | **String** | Additional notes about the booking | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


