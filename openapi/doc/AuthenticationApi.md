# openapi.api.AuthenticationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerGetCurrentUserV1**](AuthenticationApi.md#authcontrollergetcurrentuserv1) | **GET** /v1/auth/@me | Get current user
[**authControllerLoginV1**](AuthenticationApi.md#authcontrollerloginv1) | **POST** /v1/auth/login | Login
[**authControllerRegisterV1**](AuthenticationApi.md#authcontrollerregisterv1) | **POST** /v1/auth/register | Register


# **authControllerGetCurrentUserV1**
> UserEntity authControllerGetCurrentUserV1()

Get current user

Get current user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticationApi();

try {
    final response = api.authControllerGetCurrentUserV1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->authControllerGetCurrentUserV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerLoginV1**
> LoginEntity authControllerLoginV1(loginDTO)

Login

Login

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticationApi();
final LoginDTO loginDTO = ; // LoginDTO | 

try {
    final response = api.authControllerLoginV1(loginDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->authControllerLoginV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginDTO** | [**LoginDTO**](LoginDTO.md)|  | 

### Return type

[**LoginEntity**](LoginEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerRegisterV1**
> RegisterEntity authControllerRegisterV1(registerDTO)

Register

Create a new user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthenticationApi();
final RegisterDTO registerDTO = ; // RegisterDTO | 

try {
    final response = api.authControllerRegisterV1(registerDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->authControllerRegisterV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDTO** | [**RegisterDTO**](RegisterDTO.md)|  | 

### Return type

[**RegisterEntity**](RegisterEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

