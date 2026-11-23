# openapi.model.DelaySummaryEntity

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**basedOn** | **num** |  | 
**arrivedCount** | **num** |  | 
**delayedCount** | **num** |  | 
**minutesLost** | **num** |  | 
**avgDelayMinutes** | **num** |  | 
**netMinutes** | **num** | Signed sum of arrival delays (negative = early) | 
**buckets** | [**DelayBucketsEntity**](DelayBucketsEntity.md) |  | 
**worst** | [**StatsRecordEntity**](StatsRecordEntity.md) |  | [optional] 
**airlines** | [**BuiltList&lt;DelayAirlineEntity&gt;**](DelayAirlineEntity.md) |  | 
**airports** | [**BuiltList&lt;DelayAirportEntity&gt;**](DelayAirportEntity.md) |  | 
**flights** | [**BuiltList&lt;StatsRecordEntity&gt;**](StatsRecordEntity.md) | Delayed flights, worst first | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


