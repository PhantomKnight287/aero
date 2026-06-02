# openapi.api.AirportsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**airportsControllerGetAirportDetailsV1**](AirportsApi.md#airportscontrollergetairportdetailsv1) | **GET** /v1/airports/{ident}/details | Get detailed live information for an airport
[**airportsControllerGetAirportsInBoundsV1**](AirportsApi.md#airportscontrollergetairportsinboundsv1) | **GET** /v1/airports/bounds | Get airports within geographic bounds
[**airportsControllerGetAirportsV1**](AirportsApi.md#airportscontrollergetairportsv1) | **GET** /v1/airports | Get all airports


# **airportsControllerGetAirportDetailsV1**
> AirportDetailsEntity airportsControllerGetAirportDetailsV1(ident)

Get detailed live information for an airport

Aggregates current delays plus the latest METAR observation and TAF forecast (raw + decoded) for the given airport identifier (ICAO/IATA). Each source is best-effort; missing data is returned as null.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAirportsApi();
final String ident = VIDP; // String | Airport identifier (ICAO preferred, IATA accepted)

try {
    final response = api.airportsControllerGetAirportDetailsV1(ident);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AirportsApi->airportsControllerGetAirportDetailsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ident** | **String**| Airport identifier (ICAO preferred, IATA accepted) | 

### Return type

[**AirportDetailsEntity**](AirportDetailsEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **airportsControllerGetAirportsInBoundsV1**
> BuiltList<AirportEntity> airportsControllerGetAirportsInBoundsV1(minLat, maxLat, minLng, maxLng)

Get airports within geographic bounds

Returns airports whose coordinates fall inside the given bounding box. Restricted to non-closed airports with an IATA code, prioritized by size and capped at 200 results. Intended for plotting airports on a map as the user pans at a sufficient zoom level.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAirportsApi();
final num minLat = 28; // num | Minimum latitude of the bounding box
final num maxLat = 29; // num | Maximum latitude of the bounding box
final num minLng = 76; // num | Minimum longitude of the bounding box
final num maxLng = 77; // num | Maximum longitude of the bounding box

try {
    final response = api.airportsControllerGetAirportsInBoundsV1(minLat, maxLat, minLng, maxLng);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AirportsApi->airportsControllerGetAirportsInBoundsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **minLat** | **num**| Minimum latitude of the bounding box | 
 **maxLat** | **num**| Maximum latitude of the bounding box | 
 **minLng** | **num**| Minimum longitude of the bounding box | 
 **maxLng** | **num**| Maximum longitude of the bounding box | 

### Return type

[**BuiltList&lt;AirportEntity&gt;**](AirportEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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
} on DioException catch (e) {
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

