import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/services/main.dart';
import 'package:aero/extensions/datetime.dart';

class WidgetUpdateService {
  static final FlightDataService _flightService = FlightDataService();

  /// Updates the home widget with updated flight status from backend
  /// Only updates if widget already has flight data
  static Future<void> updateWidget() async {
    try {
      // Check if widget has flight data
      final flightId = await HomeWidget.getWidgetData<String>('flight_id');
      final flightIata = await HomeWidget.getWidgetData<String>('flight_iata');
      final flightIcao = await HomeWidget.getWidgetData<String>('flight_icao');
      final flightDateStr =
          await HomeWidget.getWidgetData<String>('flight_date');

      // If no flight is setup in widget, do nothing
      if (flightId == null ||
          flightIata == null ||
          flightIcao == null ||
          flightDateStr == null) {
        print('No flight setup in widget, skipping update');
        return;
      }

      // Parse the date
      DateTime flightDate;
      try {
        flightDate = DateTime.parse(flightDateStr);
      } catch (e) {
        print('Invalid flight date in widget: $flightDateStr');
        await _clearWidgetData();
        await HomeWidget.updateWidget(
            androidName: 'CurrentActiveFlightReceiver',
            qualifiedAndroidName:
                "fyi.procrastinator.aero.widgets.current_active_flight.CurrentActiveFlightReceiver");
        return;
      }

      // Check if flight has concluded (arrival time has passed)
      final arrivalTimeStr =
          await HomeWidget.getWidgetData<String>('arrival_time_scheduled');
      if (arrivalTimeStr != null) {
        try {
          final arrivalTime = DateTime.parse(arrivalTimeStr);
          final now = DateTime.now();

          // If arrival time has passed by more than 1 hour, clear widget
          if (now.difference(arrivalTime).inHours > 1) {
            print('Flight has concluded, clearing widget');
            await _clearWidgetData();
            await HomeWidget.updateWidget(
              androidName: 'CurrentActiveFlightReceiver',
              qualifiedAndroidName:
                  "fyi.procrastinator.aero.widgets.current_active_flight.CurrentActiveFlightReceiver",
            );
            return;
          }
        } catch (e) {
          print('Error parsing arrival time: $e');
        }
      }

      // Fetch updated flight status with forceUpdate=true
      final updatedFlight = await _flightService.getFlightInfoWithNumber(
        flightIata,
        flightIcao,
        date: flightDate,
        forceUpdate: true,
        faFlightId: flightId,
      );

      if (updatedFlight == null) {
        print('Failed to fetch updated flight info');
        return;
      }

      // Extract flight information and update widget
      await _updateWidgetWithFlightData(updatedFlight);

      // Trigger widget update
      await HomeWidget.updateWidget(
          androidName: 'CurrentActiveFlightReceiver',
          qualifiedAndroidName:
              "fyi.procrastinator.aero.widgets.current_active_flight.CurrentActiveFlightReceiver");
    } catch (e) {
      print('Error updating widget: $e');
      // Don't clear on error, keep existing data
    }
  }

  /// Updates the widget with specific flight data
  static Future<void> _updateWidgetWithFlightData(
      FlightResponseEntity flight) async {
    try {
      // Extract required data from flight entity
      final airline = flight.airline;
      final airlineLogo = airline.image ??
          "https://www.flightaware.com/images/airline_logos/180px/${airline.icao}.png";
      final flightNumberIata =
          flight.flightAwareData?.identIata ?? flight.flightNo ?? '';
      final flightNumberIcao =
          flight.flightAwareData?.identIcao ?? flight.flightNo ?? '';

      final departure = flight.departure;
      final arrival = flight.arrival;

      final destinationName = arrival.airport.name ?? '';
      final arrivalAirportCode =
          arrival.airport.iata ?? arrival.airport.icao ?? '';
      final departureAirportCode =
          departure.airport.iata ?? departure.airport.icao ?? '';

      // Format times using airport timezones
      final departureTimeLocal = _formatTime(
        departure.predictedTime?.utc ??
            departure.revisedTime?.utc ??
            departure.scheduledTime?.utc,
        timezone: departure.airport.timeZone,
      );
      final arrivalTimeLocal = _formatTime(
        arrival.predictedTime?.utc ??
            arrival.revisedTime?.utc ??
            arrival.scheduledTime?.utc,
        timezone: arrival.airport.timeZone,
      );

      // Determine delay/expedite status
      final isDelayInDeparture = _isDelayed(
        departure.scheduledTime?.utc,
        departure.predictedTime?.utc ?? departure.revisedTime?.utc,
      );
      final isDelayInArrival = _isDelayed(
        arrival.scheduledTime?.utc,
        arrival.predictedTime?.utc ?? arrival.revisedTime?.utc,
      );
      final isExpediteInDeparture = _isExpedited(
        departure.scheduledTime?.utc,
        departure.predictedTime?.utc ?? departure.revisedTime?.utc,
      );
      final isExpediteInArrival = _isExpedited(
        arrival.scheduledTime?.utc,
        arrival.predictedTime?.utc ?? arrival.revisedTime?.utc,
      );

      // Save data to home_widget storage
      await HomeWidget.saveWidgetData('airline_logo', airlineLogo);
      await HomeWidget.saveWidgetData('flight_number_iata', flightNumberIata);
      await HomeWidget.saveWidgetData('flight_number_icao', flightNumberIcao);
      await HomeWidget.saveWidgetData('destination', destinationName);
      await HomeWidget.saveWidgetData(
          'arrival_airport_code', arrivalAirportCode);
      await HomeWidget.saveWidgetData(
          'departure_airport_code', departureAirportCode);
      await HomeWidget.saveWidgetData(
          'departure_time_local', departureTimeLocal);
      await HomeWidget.saveWidgetData('arrival_time_local', arrivalTimeLocal);
      await HomeWidget.saveWidgetData(
          'is_delay_in_departure', isDelayInDeparture);
      await HomeWidget.saveWidgetData('is_delay_in_arrival', isDelayInArrival);
      await HomeWidget.saveWidgetData(
          'is_expedite_in_departure', isExpediteInDeparture);
      await HomeWidget.saveWidgetData(
          'is_expedite_in_arrival', isExpediteInArrival);

      // Store flight metadata for polling updates
      await HomeWidget.saveWidgetData(
          'flight_id', flight.flightAwareData?.id ?? flight.id);
      await HomeWidget.saveWidgetData('flight_iata', flightNumberIata);
      await HomeWidget.saveWidgetData('flight_icao', flightNumberIcao);
      await HomeWidget.saveWidgetData(
          'flight_date', flight.date.toIso8601String());

      // Store scheduled arrival time for checking if flight has concluded
      final arrivalScheduled = arrival.scheduledTime?.utc ??
          arrival.predictedTime?.utc ??
          arrival.revisedTime?.utc;
      if (arrivalScheduled != null) {
        await HomeWidget.saveWidgetData(
          'arrival_time_scheduled',
          arrivalScheduled,
        );
      }
    } catch (e) {
      print('Error updating widget with flight data: $e');
      throw e;
    }
  }

  /// Clears all widget data
  static Future<void> _clearWidgetData() async {
    await HomeWidget.saveWidgetData('airline_logo', null);
    await HomeWidget.saveWidgetData('flight_number_iata', null);
    await HomeWidget.saveWidgetData('flight_number_icao', null);
    await HomeWidget.saveWidgetData('destination', null);
    await HomeWidget.saveWidgetData('arrival_airport_code', null);
    await HomeWidget.saveWidgetData('departure_airport_code', null);
    await HomeWidget.saveWidgetData('departure_time_local', null);
    await HomeWidget.saveWidgetData('arrival_time_local', null);
    await HomeWidget.saveWidgetData('is_delay_in_departure', false);
    await HomeWidget.saveWidgetData('is_delay_in_arrival', false);
    await HomeWidget.saveWidgetData('is_expedite_in_departure', false);
    await HomeWidget.saveWidgetData('is_expedite_in_arrival', false);

    // Clear flight metadata
    await HomeWidget.saveWidgetData('flight_id', null);
    await HomeWidget.saveWidgetData('flight_iata', null);
    await HomeWidget.saveWidgetData('flight_icao', null);
    await HomeWidget.saveWidgetData('flight_date', null);
    await HomeWidget.saveWidgetData('arrival_time_scheduled', null);
  }

  /// Formats a time string to HH:mm format in the specified timezone
  /// If timezone is not provided or invalid, falls back to UTC
  static String _formatTime(String? timeString, {String? timezone}) {
    if (timeString == null || timeString.isEmpty) return '--:--';

    try {
      final dateTime = DateTime.parse(timeString);

      // If timezone is provided and valid, convert to that timezone
      if (timezone != null && timezone.isNotEmpty) {
        try {
          return dateTime.toTimezoneString(timezone, use24Hrs: true);
        } catch (e) {
          // If timezone conversion fails, fall back to UTC formatting
          print('Error converting time to timezone $timezone: $e');
          return DateFormat('HH:mm').format(dateTime);
        }
      }

      // Fall back to UTC formatting if no timezone provided
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return '--:--';
    }
  }

  /// Checks if a flight is delayed (estimated > scheduled by more than 5 minutes)
  static bool _isDelayed(String? scheduledTime, String? estimatedTime) {
    if (scheduledTime == null || estimatedTime == null) return false;

    try {
      final scheduled = DateTime.parse(scheduledTime);
      final estimated = DateTime.parse(estimatedTime);
      final diff = estimated.difference(scheduled);
      return diff.inMinutes > 5;
    } catch (e) {
      return false;
    }
  }

  /// Checks if a flight is expedited (estimated < scheduled by more than 5 minutes)
  static bool _isExpedited(String? scheduledTime, String? estimatedTime) {
    if (scheduledTime == null || estimatedTime == null) return false;

    try {
      final scheduled = DateTime.parse(scheduledTime);
      final estimated = DateTime.parse(estimatedTime);
      final diff = scheduled.difference(estimated);
      return diff.inMinutes > 5;
    } catch (e) {
      return false;
    }
  }

  /// Updates widget immediately when a flight is fetched in the app
  static Future<void> updateWidgetWithFlight(
      FlightResponseEntity flight) async {
    try {
      await _updateWidgetWithFlightData(flight);
      await HomeWidget.updateWidget(
          androidName: 'CurrentActiveFlightReceiver',
          qualifiedAndroidName:
              "fyi.procrastinator.aero.widgets.current_active_flight.CurrentActiveFlightReceiver");
    } catch (e) {
      print('Error updating widget with flight: $e');
    }
  }

  /// Clears widget data (public method for external use)
  static Future<void> clearWidget() async {
    try {
      await _clearWidgetData();
      await HomeWidget.updateWidget(
          androidName: 'CurrentActiveFlightReceiver',
          qualifiedAndroidName:
              "fyi.procrastinator.aero.widgets.current_active_flight.CurrentActiveFlightReceiver");
    } catch (e) {
      print('Error clearing widget: $e');
    }
  }
}
