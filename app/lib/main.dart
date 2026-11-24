import 'package:aero/constants/main.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/user.dart';
import 'package:aero/routes/main.dart';
import 'package:aero/services/widget_update_service.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/theme.dart';
import 'package:workmanager/workmanager.dart';
import 'package:aero/services/main.dart';
import 'package:aero/services/wear_payload.dart';
import 'package:wear_bridge/wear_bridge.dart';

// Workmanager callback handler
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == 'widgetUpdateTask') {
        await WidgetUpdateService.updateWidget();
      } else if (task == 'wearSyncTask') {
        final units = UnitsNotifier();
        await units.load();
        await WearSync.run(
          fetch: (k) => FlightDataService().getFlightInfoWithNumber(
            k['iata'] as String,
            k['icao'] as String,
            date: DateTime.parse(k['date'] as String),
            forceUpdate: true,
            faFlightId: k['faId'] as String?,
          ),
          send: (p) => WearBridge.send('/register-flight', p),
          distanceUnit: units.distance,
        );
      }
      return Future.value(true);
    } catch (e) {
      print('Error in workmanager task: $e');
      return Future.value(false);
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize OneSignal for flight push alerts. Permission is requested
  // lazily when the user opts into alerts from the flight details menu.
  if (ONESIGNAL_APP_ID.isNotEmpty) {
    OneSignal.initialize(ONESIGNAL_APP_ID);
  }

  // Initialize Workmanager
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Set to true for debugging
  );

  // Register periodic task to update widget every 15 minutes
  await Workmanager().registerPeriodicTask(
    'widget-update',
    'widgetUpdateTask',
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  // Flights sent to the watch follow their changes until they land
  // (see WearSync for the limits).
  await Workmanager().registerPeriodicTask(
    'wear-sync',
    'wearSyncTask',
    frequency: const Duration(minutes: 15),
    constraints: Constraints(networkType: NetworkType.connected),
  );

  // Device locale for numbers and dates; en_US if intl lacks its symbols.
  await initLocale();

  // Loaded before the first frame so non-default units never flash.
  final units = UnitsNotifier();
  await units.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserNotifier();
          },
        ),
        ChangeNotifierProvider.value(value: units),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: AeroRouter.router,
        debugShowCheckedModeBanner: false,
        theme: aeroTheme(),
      ),
    );
  }
}
