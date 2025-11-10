# openapi.api.FlightApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**flightControllerCreateFlightBookingV1**](FlightApi.md#flightcontrollercreateflightbookingv1) | **POST** /v1/flight/booking | Create a flight booking
[**flightControllerDeleteFlightBookingV1**](FlightApi.md#flightcontrollerdeleteflightbookingv1) | **DELETE** /v1/flight/booking/{bookingId} | Delete a flight booking
[**flightControllerGetFlightBookingV1**](FlightApi.md#flightcontrollergetflightbookingv1) | **GET** /v1/flight/booking/{bookingId} | Get a flight booking
[**flightControllerGetFlightBookingsByFlightIdV1**](FlightApi.md#flightcontrollergetflightbookingsbyflightidv1) | **GET** /v1/flight/booking/flight/{flightId} | Get all bookings for a flight
[**flightControllerGetFlightTrackV1**](FlightApi.md#flightcontrollergetflighttrackv1) | **GET** /v1/flight/track | Get flight track/path
[**flightControllerGetFlightV1**](FlightApi.md#flightcontrollergetflightv1) | **GET** /v1/flight | Get flight details
[**flightControllerSearchFlightsV1**](FlightApi.md#flightcontrollersearchflightsv1) | **GET** /v1/flight/search | Search flights
[**flightControllerUpdateFlightBookingV1**](FlightApi.md#flightcontrollerupdateflightbookingv1) | **PUT** /v1/flight/booking/{bookingId} | Update a flight booking


# **flightControllerCreateFlightBookingV1**
> FlightBookingEntity flightControllerCreateFlightBookingV1(createFlightBookingDTO)

Create a flight booking

Create a new booking for a flight with booking details

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final CreateFlightBookingDTO createFlightBookingDTO = ; // CreateFlightBookingDTO | 

try {
    final response = api.flightControllerCreateFlightBookingV1(createFlightBookingDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerCreateFlightBookingV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createFlightBookingDTO** | [**CreateFlightBookingDTO**](CreateFlightBookingDTO.md)|  | 

### Return type

[**FlightBookingEntity**](FlightBookingEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerDeleteFlightBookingV1**
> FlightControllerDeleteFlightBookingV1200Response flightControllerDeleteFlightBookingV1(bookingId)

Delete a flight booking

Delete a flight booking

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String bookingId = booking_abc123; // String | ID of the booking to delete

try {
    final response = api.flightControllerDeleteFlightBookingV1(bookingId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerDeleteFlightBookingV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingId** | **String**| ID of the booking to delete | 

### Return type

[**FlightControllerDeleteFlightBookingV1200Response**](FlightControllerDeleteFlightBookingV1200Response.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerGetFlightBookingV1**
> FlightBookingEntity flightControllerGetFlightBookingV1(bookingId)

Get a flight booking

Get details of a specific flight booking

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String bookingId = booking_abc123; // String | ID of the booking to retrieve

try {
    final response = api.flightControllerGetFlightBookingV1(bookingId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerGetFlightBookingV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingId** | **String**| ID of the booking to retrieve | 

### Return type

[**FlightBookingEntity**](FlightBookingEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerGetFlightBookingsByFlightIdV1**
> BuiltList<FlightBookingEntity> flightControllerGetFlightBookingsByFlightIdV1(flightId)

Get all bookings for a flight

Get all bookings associated with a specific flight

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String flightId = flight_abc123; // String | ID of the flight

try {
    final response = api.flightControllerGetFlightBookingsByFlightIdV1(flightId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerGetFlightBookingsByFlightIdV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **flightId** | **String**| ID of the flight | 

### Return type

[**BuiltList&lt;FlightBookingEntity&gt;**](FlightBookingEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerGetFlightTrackV1**
> FlightTrackResponseEntity flightControllerGetFlightTrackV1(iata, icao, timezone, date)

Get flight track/path

Get the flight path with all position data points for a specific flight

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String iata = UA123; // String | IATA flight number
final String icao = UAL123; // String | ICAO flight number
final String timezone = IST; // String | The timezone from which the request is being made.
final String date = 2024-03-20; // String | Flight date (ISO format). Defaults to current date if not provided

try {
    final response = api.flightControllerGetFlightTrackV1(iata, icao, timezone, date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerGetFlightTrackV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **iata** | **String**| IATA flight number | 
 **icao** | **String**| ICAO flight number | 
 **timezone** | **String**| The timezone from which the request is being made. | 
 **date** | **String**| Flight date (ISO format). Defaults to current date if not provided | [optional] 

### Return type

[**FlightTrackResponseEntity**](FlightTrackResponseEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerGetFlightV1**
> FlightResponseEntity flightControllerGetFlightV1(iata, icao, timezone, date, forceUpdate, faFlightId)

Get flight details

Get detailed information about a specific flight including real-time tracking data. Use faFlightId to fetch a specific flight after searching.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String iata = UA123; // String | IATA flight number
final String icao = UAL123; // String | ICAO flight number
final String timezone = timezone_example; // String | The timezone from which the request is being made.
final String date = 2024-03-20; // String | Flight date (ISO format). Defaults to current date if not provided
final bool forceUpdate = true; // bool | Force update the flight data(used to refresh the flight data)
final String faFlightId = faFlightId_example; // String | FlightAware flight ID to fetch a specific flight. Use this after searching for flights to get details of a selected flight.

try {
    final response = api.flightControllerGetFlightV1(iata, icao, timezone, date, forceUpdate, faFlightId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerGetFlightV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **iata** | **String**| IATA flight number | 
 **icao** | **String**| ICAO flight number | 
 **timezone** | **String**| The timezone from which the request is being made. | 
 **date** | **String**| Flight date (ISO format). Defaults to current date if not provided | [optional] 
 **forceUpdate** | **bool**| Force update the flight data(used to refresh the flight data) | [optional] [default to false]
 **faFlightId** | **String**| FlightAware flight ID to fetch a specific flight. Use this after searching for flights to get details of a selected flight. | [optional] 

### Return type

[**FlightResponseEntity**](FlightResponseEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerSearchFlightsV1**
> FlightSearchResponseEntity flightControllerSearchFlightsV1(iata, icao, timezone, date)

Search flights

Search for flights by identifier and optional date. Returns lightweight flight summaries for selection.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String iata = UA123; // String | IATA flight number
final String icao = UAL123; // String | ICAO flight number
final String timezone = timezone_example; // String | The timezone from which the request is being made.
final String date = 2024-03-20; // String | Flight date (ISO format). Filters flights by date if provided

try {
    final response = api.flightControllerSearchFlightsV1(iata, icao, timezone, date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerSearchFlightsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **iata** | **String**| IATA flight number | 
 **icao** | **String**| ICAO flight number | 
 **timezone** | **String**| The timezone from which the request is being made. | 
 **date** | **String**| Flight date (ISO format). Filters flights by date if provided | [optional] 

### Return type

[**FlightSearchResponseEntity**](FlightSearchResponseEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightControllerUpdateFlightBookingV1**
> FlightBookingEntity flightControllerUpdateFlightBookingV1(bookingId, updateFlightBookingDTO)

Update a flight booking

Update an existing flight booking

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String bookingId = booking_abc123; // String | ID of the booking to update
final UpdateFlightBookingDTO updateFlightBookingDTO = ; // UpdateFlightBookingDTO | 

try {
    final response = api.flightControllerUpdateFlightBookingV1(bookingId, updateFlightBookingDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightApi->flightControllerUpdateFlightBookingV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bookingId** | **String**| ID of the booking to update | 
 **updateFlightBookingDTO** | [**UpdateFlightBookingDTO**](UpdateFlightBookingDTO.md)|  | 

### Return type

[**FlightBookingEntity**](FlightBookingEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

