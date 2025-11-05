# openapi.api.FlightApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**flightControllerGetFlightTrackV1**](FlightApi.md#flightcontrollergetflighttrackv1) | **GET** /v1/flight/track | Get flight track/path
[**flightControllerGetFlightV1**](FlightApi.md#flightcontrollergetflightv1) | **GET** /v1/flight | Get flight details


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
final String timezone = timezone_example; // String | The timezone from which the request is being made.
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
> FlightResponseEntity flightControllerGetFlightV1(iata, icao, timezone, date)

Get flight details

Get detailed information about a specific flight including real-time tracking data

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightApi();
final String iata = UA123; // String | IATA flight number
final String icao = UAL123; // String | ICAO flight number
final String timezone = timezone_example; // String | The timezone from which the request is being made.
final String date = 2024-03-20; // String | Flight date (ISO format). Defaults to current date if not provided

try {
    final response = api.flightControllerGetFlightV1(iata, icao, timezone, date);
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

### Return type

[**FlightResponseEntity**](FlightResponseEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

