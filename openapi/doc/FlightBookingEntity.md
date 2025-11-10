# openapi.model.FlightBookingEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | Unique booking identifier | 
**bookingCode** | [**JsonObject**](.md) | Booking code/confirmation code (e.g., \"ABC123\") | [optional] 
**seatNumber** | [**JsonObject**](.md) | Seat number (e.g., \"12A\", \"1F\") | [optional] 
**seatType** | **String** | Type of seat position | [optional] 
**seatingClass** | **String** | Class of service | [optional] 
**reason** | **String** | Reason for the flight | [optional] 
**notes** | [**JsonObject**](.md) | Additional notes about the booking | [optional] 
**flightId** | **String** | Flight ID associated with this booking | 
**userId** | **String** | User ID who owns this booking | 
**createdAt** | [**DateTime**](DateTime.md) | Date and time when the booking was created | 
**updatedAt** | [**DateTime**](DateTime.md) | Date and time when the booking was last updated | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


