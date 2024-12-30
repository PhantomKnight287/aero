# openapi.api.FlightsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**flightsControllerGetAirlineV1**](FlightsApi.md#flightscontrollergetairlinev1) | **POST** /v1/flights/airline | Get airline
[**flightsControllerGetFlightsV1**](FlightsApi.md#flightscontrollergetflightsv1) | **GET** /v1/flights | Get flights between two airports


# **flightsControllerGetAirlineV1**
> AirlineEntity flightsControllerGetAirlineV1(getAirlineDTO)

Get airline

Get airline with search query. This doesn't check if the number is correct

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightsApi();
final GetAirlineDTO getAirlineDTO = ; // GetAirlineDTO | 

try {
    final response = api.flightsControllerGetAirlineV1(getAirlineDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightsApi->flightsControllerGetAirlineV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getAirlineDTO** | [**GetAirlineDTO**](GetAirlineDTO.md)|  | 

### Return type

[**AirlineEntity**](AirlineEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightsControllerGetFlightsV1**
> FlightsResponseEntity flightsControllerGetFlightsV1(from, to, date)

Get flights between two airports

Get all flights between two airports for a specific date

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightsApi();
final String from = LAX; // String | Departure airport IATA code
final String to = JFK; // String | Arrival airport IATA code
final String date = 2024-03-20; // String | Flight date in ISO format

try {
    final response = api.flightsControllerGetFlightsV1(from, to, date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FlightsApi->flightsControllerGetFlightsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**| Departure airport IATA code | 
 **to** | **String**| Arrival airport IATA code | 
 **date** | **String**| Flight date in ISO format | 

### Return type

[**FlightsResponseEntity**](FlightsResponseEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

