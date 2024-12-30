# openapi.api.AirportsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**airportsControllerGetAirportsV1**](AirportsApi.md#airportscontrollergetairportsv1) | **GET** /v1/airports | Get all airports


# **airportsControllerGetAirportsV1**
> BuiltList<AirportEntity> airportsControllerGetAirportsV1(search)

Get all airports

Get all airports. We do not recommend using this route without any search query. This route has over 20k records

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAirportsApi();
final String search = VIDP; // String | Search query for airport. Can be iata, ident(icao), name or a part of any these. Searching is case insensitive

try {
    final response = api.airportsControllerGetAirportsV1(search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AirportsApi->airportsControllerGetAirportsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **search** | **String**| Search query for airport. Can be iata, ident(icao), name or a part of any these. Searching is case insensitive | [optional] 

### Return type

[**BuiltList&lt;AirportEntity&gt;**](AirportEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

