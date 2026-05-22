# openapi.api.FlightAlertsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**flightAlertsControllerSubscribeV1**](FlightAlertsApi.md#flightalertscontrollersubscribev1) | **POST** /v1/flight/{id}/alerts | Subscribe to push alerts for a flight
[**flightAlertsControllerUnsubscribeV1**](FlightAlertsApi.md#flightalertscontrollerunsubscribev1) | **DELETE** /v1/flight/{id}/alerts | Unsubscribe from push alerts for a flight


# **flightAlertsControllerSubscribeV1**
> flightAlertsControllerSubscribeV1(id, flightAlertDTO)

Subscribe to push alerts for a flight

Registers a OneSignal subscription (player) ID to receive push notifications when this flight changes (status, gate, terminal, delays, baggage claim, airport delays).

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightAlertsApi();
final String id = id_example; // String | Flight ID or FlightAware flight ID
final FlightAlertDTO flightAlertDTO = ; // FlightAlertDTO | 

try {
    api.flightAlertsControllerSubscribeV1(id, flightAlertDTO);
} on DioException catch (e) {
    print('Exception when calling FlightAlertsApi->flightAlertsControllerSubscribeV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Flight ID or FlightAware flight ID | 
 **flightAlertDTO** | [**FlightAlertDTO**](FlightAlertDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **flightAlertsControllerUnsubscribeV1**
> flightAlertsControllerUnsubscribeV1(id, flightAlertDTO)

Unsubscribe from push alerts for a flight

Removes a OneSignal subscription (player) ID from a flight’s alert list. Tracking stops once no devices remain.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFlightAlertsApi();
final String id = id_example; // String | Flight ID or FlightAware flight ID
final FlightAlertDTO flightAlertDTO = ; // FlightAlertDTO | 

try {
    api.flightAlertsControllerUnsubscribeV1(id, flightAlertDTO);
} on DioException catch (e) {
    print('Exception when calling FlightAlertsApi->flightAlertsControllerUnsubscribeV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Flight ID or FlightAware flight ID | 
 **flightAlertDTO** | [**FlightAlertDTO**](FlightAlertDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[JWT-auth](../README.md#JWT-auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

