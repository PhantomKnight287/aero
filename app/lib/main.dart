import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/notifiers/user.dart';
import 'package:plane_pal/routes/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:variable_app_icon/variable_app_icon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  VariableAppIcon.androidAppIconIds = [
    "appIcon.DEFAULT",
    "appIcon.ZERO_TWO",
    "appIcon.ZERO_THREE",
    "appIcon.ZERO_FOUR",
    "appIcon.ZERO_FIVE",
    "appIcon.ZERO_SIX",
    "appIcon.ONE_ONE",
    "appIcon.ONE_TWO",
    "appIcon.ONE_THREE",
    "appIcon.ONE_FOUR",
    "appIcon.ONE_FIVE",
    "appIcon.ONE_SIX",
  ];
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
