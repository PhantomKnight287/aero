import 'package:plane_pal/screens/auth/login/main.dart';
import 'package:plane_pal/screens/auth/main.dart';
import 'package:plane_pal/screens/auth/register/main.dart';
import 'package:plane_pal/screens/home/main.dart';
import 'package:plane_pal/screens/loading/loading.dart';
import 'package:plane_pal/screens/profile/main.dart';
import 'package:plane_pal/screens/profile/stats/main.dart';
import 'package:plane_pal/screens/wearables/list/main.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/screens/wearables/login/main.dart';

class AeroRouter {
  static GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        routes: [
          GoRoute(
            path: "/auth/register",
            builder: (context, state) => RegisterScreen(),
          ),
          GoRoute(
            path: "/auth/login",
            builder: (context, state) => LoginScreen(),
          )
        ],
        builder: (context, state, child) {
          return AuthShell(
            child: child,
          );
        },
      ),
      GoRoute(
        path: "/",
        builder: (context, state) {
          final name = state.uri.queryParameters["wearable_name"];
          if (name != null && name.isNotEmpty) {
            return WearablesLoginScreen(wearableName: name);
          }
          return HomeScreen();
        },
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) {
          return ProfileScreen();
        },
      ),
      GoRoute(
        path: "/profile/stats",
        builder: (context, state) {
          return FlightStatsScreen();
        },
      ),
      GoRoute(
        path: "/wearables",
        builder: (context, state) {
          return WearablesScreen();
        },
      ),
      GoRoute(
        path: "/loading",
        builder: (context, state) {
          return LoadingScreen();
        },
      )
    ],
    debugLogDiagnostics: true,
    initialLocation: "/auth/login",
  );
}
