import 'package:aero/constants/main.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/user.dart';
import 'package:aero/routes/main.dart';
import 'package:aero/services/widget_update_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/theme.dart';
import 'package:workmanager/workmanager.dart';

// Workmanager callback handler
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == 'widgetUpdateTask') {
        await WidgetUpdateService.updateWidget();
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

  // Device locale for number grouping; fall back if intl lacks its symbols.
  Intl.defaultLocale = resolveLocale(await findSystemLocale());

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
