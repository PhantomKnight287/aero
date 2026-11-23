// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add(AircraftEntity.serializer)
      ..add(AircraftFamilyEntity.serializer)
      ..add(AircraftFlightEntity.serializer)
      ..add(AircraftHistoryEntity.serializer)
      ..add(AircraftLegEntity.serializer)
      ..add(AircraftRegistrationEntity.serializer)
      ..add(AircraftSectionEntity.serializer)
      ..add(AircraftTypeEntity.serializer)
      ..add(AirframeEntity.serializer)
      ..add(AirframesEntity.serializer)
      ..add(AirlineEntity.serializer)
      ..add(AirlineInfo.serializer)
      ..add(AirportConditionsEntity.serializer)
      ..add(AirportDelayReasonEntity.serializer)
      ..add(AirportDelayReasonEntityColorEnum.serializer)
      ..add(AirportDelaysEntity.serializer)
      ..add(AirportDelaysEntityColorEnum.serializer)
      ..add(AirportDetailsEntity.serializer)
      ..add(AirportEntity.serializer)
      ..add(AirportInfo.serializer)
      ..add(AirportType.serializer)
      ..add(AirportWeatherForecastEntity.serializer)
      ..add(AirportWeatherObservationEntity.serializer)
      ..add(AirportWeatherObservationEntityPressureUnitsEnum.serializer)
      ..add(AirportWeatherObservationEntityVisibilityUnitsEnum.serializer)
      ..add(AirportWeatherObservationEntityWindUnitsEnum.serializer)
      ..add(ContinentBucket.serializer)
      ..add(ContinentEntity.serializer)
      ..add(CountryEntity.serializer)
      ..add(CreateFlightBookingDTO.serializer)
      ..add(CreateFlightBookingDTOReasonEnum.serializer)
      ..add(CreateFlightBookingDTOSeatTypeEnum.serializer)
      ..add(CreateFlightBookingDTOSeatingClassEnum.serializer)
      ..add(DecodedWeatherEntity.serializer)
      ..add(DelayAirlineEntity.serializer)
      ..add(DelayAirportEntity.serializer)
      ..add(DelayBucketsEntity.serializer)
      ..add(DelaySummaryEntity.serializer)
      ..add(ExtremesEntity.serializer)
      ..add(FlighType.serializer)
      ..add(FlightAwareDataEntity.serializer)
      ..add(FlightBookingEntity.serializer)
      ..add(FlightBookingEntityReasonEnum.serializer)
      ..add(FlightBookingEntitySeatTypeEnum.serializer)
      ..add(FlightBookingEntitySeatingClassEnum.serializer)
      ..add(FlightCandidateEntity.serializer)
      ..add(FlightControllerDeleteFlightBookingV1200Response.serializer)
      ..add(FlightControllerDeleteFlightV1200Response.serializer)
      ..add(FlightEntity.serializer)
      ..add(FlightHistoryResponseEntity.serializer)
      ..add(FlightPositionEntity.serializer)
      ..add(FlightPositionEntityAltitudeChangeEnum.serializer)
      ..add(FlightPositionEntityUpdateTypeEnum.serializer)
      ..add(FlightResponseEntity.serializer)
      ..add(FlightSearchResponseEntity.serializer)
      ..add(FlightStatus.serializer)
      ..add(FlightSummaryAirlineEntity.serializer)
      ..add(FlightSummaryDestinationEntity.serializer)
      ..add(FlightSummaryEntity.serializer)
      ..add(FlightSummaryOriginEntity.serializer)
      ..add(FlightTrackResponseEntity.serializer)
      ..add(FlightsControllerGetFlightsInBoundsV1200Response.serializer)
      ..add(FlightsControllerGetFlightsInBoundsV1200ResponseBounds.serializer)
      ..add(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner
          .serializer)
      ..add(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInnerOrigin
          .serializer)
      ..add(FlightsPerEntity.serializer)
      ..add(FlightsResponseEntity.serializer)
      ..add(FlightsRouteEntity.serializer)
      ..add(GenericErrorEntity.serializer)
      ..add(GetAirlineDTO.serializer)
      ..add(LocationEntity.serializer)
      ..add(LoginDTO.serializer)
      ..add(LoginEntity.serializer)
      ..add(MapAirportEntity.serializer)
      ..add(MapDataEntity.serializer)
      ..add(MapRouteEntity.serializer)
      ..add(MostFlownTailEntity.serializer)
      ..add(PartialAirlineEntity.serializer)
      ..add(PassportEntity.serializer)
      ..add(ProfileStatsResponseEntity.serializer)
      ..add(RecordsEntity.serializer)
      ..add(RegisterDTO.serializer)
      ..add(RegisterEntity.serializer)
      ..add(RouteAirportEntity.serializer)
      ..add(RouteInfoEntity.serializer)
      ..add(RunwayUseEntity.serializer)
      ..add(RunwaysEntity.serializer)
      ..add(StatsAirlineEntity.serializer)
      ..add(StatsAirportEntity.serializer)
      ..add(StatsFlightSummaryEntity.serializer)
      ..add(StatsRecordEntity.serializer)
      ..add(StringifiedGreatCircleDistanceEntity.serializer)
      ..add(TaxiAirportEntity.serializer)
      ..add(TaxiByAirportEntity.serializer)
      ..add(TimeEntity.serializer)
      ..add(TopAirlineEntity.serializer)
      ..add(TopAirportEntity.serializer)
      ..add(TopRouteEntity.serializer)
      ..add(TrackedFlightsResponseEntity.serializer)
      ..add(UpdateFlightBookingDTO.serializer)
      ..add(UpdateFlightBookingDTOReasonEnum.serializer)
      ..add(UpdateFlightBookingDTOSeatTypeEnum.serializer)
      ..add(UpdateFlightBookingDTOSeatingClassEnum.serializer)
      ..add(UserEntity.serializer)
      ..add(WeatherForecastCloudEntity.serializer)
      ..add(WeatherForecastCloudEntityCoverageEnum.serializer)
      ..add(WeatherForecastDecodedEntity.serializer)
      ..add(WeatherForecastLineEntity.serializer)
      ..add(WeatherForecastVisibilityEntity.serializer)
      ..add(WeatherForecastWindsEntity.serializer)
      ..add(WeatherForecastWindshearEntity.serializer)
      ..add(WeatherObservationCloudEntity.serializer)
      ..add(YearCountEntity.serializer)
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(AircraftRegistrationEntity)]),
          () => ListBuilder<AircraftRegistrationEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AircraftTypeEntity)]),
          () => ListBuilder<AircraftTypeEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(AircraftFamilyEntity)]),
          () => ListBuilder<AircraftFamilyEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(AirportDelayReasonEntity)]),
          () => ListBuilder<AirportDelayReasonEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(DelayAirlineEntity)]),
          () => ListBuilder<DelayAirlineEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(DelayAirportEntity)]),
          () => ListBuilder<DelayAirportEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(StatsRecordEntity)]),
          () => ListBuilder<StatsRecordEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(FlightBookingEntity)]),
          () => ListBuilder<FlightBookingEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(FlightCandidateEntity)]),
          () => ListBuilder<FlightCandidateEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(FlightEntity)]),
          () => ListBuilder<FlightEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(FlightPositionEntity)]),
          () => ListBuilder<FlightPositionEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(FlightResponseEntity)]),
          () => ListBuilder<FlightResponseEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(FlightSummaryEntity)]),
          () => ListBuilder<FlightSummaryEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(
                FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner)
          ]),
          () => ListBuilder<
              FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(MapAirportEntity)]),
          () => ListBuilder<MapAirportEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(MapRouteEntity)]),
          () => ListBuilder<MapRouteEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(RunwayUseEntity)]),
          () => ListBuilder<RunwayUseEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(StatsFlightSummaryEntity)]),
          () => ListBuilder<StatsFlightSummaryEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(StatsFlightSummaryEntity)]),
          () => ListBuilder<StatsFlightSummaryEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(YearCountEntity)]),
          () => ListBuilder<YearCountEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TaxiAirportEntity)]),
          () => ListBuilder<TaxiAirportEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(WeatherForecastCloudEntity)]),
          () => ListBuilder<WeatherForecastCloudEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(WeatherForecastLineEntity)]),
          () => ListBuilder<WeatherForecastLineEntity>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(WeatherObservationCloudEntity)]),
          () => ListBuilder<WeatherObservationCloudEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(YearCountEntity)]),
          () => ListBuilder<YearCountEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(num)]),
          () => ListBuilder<num>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(num)]),
          () => ListBuilder<num>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(num)]),
          () => ListBuilder<num>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TopAirportEntity)]),
          () => ListBuilder<TopAirportEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TopAirlineEntity)]),
          () => ListBuilder<TopAirlineEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TopRouteEntity)]),
          () => ListBuilder<TopRouteEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CountryEntity)]),
          () => ListBuilder<CountryEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ContinentEntity)]),
          () => ListBuilder<ContinentEntity>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
