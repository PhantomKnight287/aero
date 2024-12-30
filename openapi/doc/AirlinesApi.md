# openapi.api.AirlinesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**airlinesControllerGetAirlinesV1**](AirlinesApi.md#airlinescontrollergetairlinesv1) | **GET** /v1/airlines | Get airlines


# **airlinesControllerGetAirlinesV1**
> BuiltList<AirlineEntity> airlinesControllerGetAirlinesV1(search)

Get airlines

Get airlines.  Has over 800 records, only has commerical airlines.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAirlinesApi();
final String search = search_example; // String | The full(or a part of) name, ident or icao. Case Insensitive.

try {
    final response = api.airlinesControllerGetAirlinesV1(search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AirlinesApi->airlinesControllerGetAirlinesV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **search** | **String**| The full(or a part of) name, ident or icao. Case Insensitive. | [optional] 

### Return type

[**BuiltList&lt;AirlineEntity&gt;**](AirlineEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

