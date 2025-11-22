import 'package:aero/constants/main.dart';
import 'package:aero/notifiers/user.dart';
import 'package:aero/routes/main.dart';
import 'package:aero/services/widget_update_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserNotifier();
          },
        )
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
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Geist",
          brightness: Brightness.light,
          primaryColor: Colors.black,
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: const WidgetStatePropertyAll(
              TextStyle(
                fontSize: 14,
              ),
            ),
            backgroundColor: const Color(0xfffafafa),
            indicatorColor: Colors.black.withValues(
              alpha: .4,
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            titleTextStyle: TextStyle(
              fontFamily: "CalSans",
              fontSize: 20,
              color: Colors.black,
            ),
            toolbarHeight: 50,
            backgroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            labelMedium: TextStyle(
              fontSize: 20,
            ),
            titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              color: SECONDARY_TEXT_COLOR,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Baby pink buttons
              foregroundColor: Colors.black, // White text
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(
                color: Colors.blueAccent,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
