# openapi.api.AppApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**appControllerGetHelloV1**](AppApi.md#appcontrollergethellov1) | **GET** /v1 | 


# **appControllerGetHelloV1**
> appControllerGetHelloV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAppApi();

try {
    api.appControllerGetHelloV1();
} catch on DioException (e) {
    print('Exception when calling AppApi->appControllerGetHelloV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

