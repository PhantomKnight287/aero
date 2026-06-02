# openapi.api.AlertsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**alertsControllerSubscribeV1**](AlertsApi.md#alertscontrollersubscribev1) | **POST** /v1/alerts | Subscribe to flight alerts


# **alertsControllerSubscribeV1**
> alertsControllerSubscribeV1(createAlertDto)

Subscribe to flight alerts

Register a OneSignal player for push notifications about a flight. Seeds the initial flight + airport state in Redis and wakes the alerts worker.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAlertsApi();
final CreateAlertDto createAlertDto = ; // CreateAlertDto | 

try {
    api.alertsControllerSubscribeV1(createAlertDto);
} on DioException catch (e) {
    print('Exception when calling AlertsApi->alertsControllerSubscribeV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAlertDto** | [**CreateAlertDto**](CreateAlertDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

