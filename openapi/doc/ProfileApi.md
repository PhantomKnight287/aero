# openapi.api.ProfileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**profileControllerGetProfileStatsV1**](ProfileApi.md#profilecontrollergetprofilestatsv1) | **GET** /v1/profile/@me | Get profile stats


# **profileControllerGetProfileStatsV1**
> ProfileStatsResponseEntity profileControllerGetProfileStatsV1(year)

Get profile stats

Returns comprehensive statistics about tracked flights including passport data, aircraft stats, airlines, airports, and routes

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();
final num year = 8.14; // num | 

try {
    final response = api.profileControllerGetProfileStatsV1(year);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProfileApi->profileControllerGetProfileStatsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **year** | **num**|  | [optional] 

### Return type

[**ProfileStatsResponseEntity**](ProfileStatsResponseEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

