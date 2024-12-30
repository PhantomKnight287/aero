import 'package:plane_pal/screens/auth/login/main.dart';
import 'package:plane_pal/screens/auth/main.dart';
import 'package:plane_pal/screens/auth/register/main.dart';
import 'package:plane_pal/screens/home/main.dart';
import 'package:plane_pal/screens/loading/loading.dart';
import 'package:plane_pal/screens/profile/main.dart';
import 'package:plane_pal/screens/wearables/main.dart';
import 'package:go_router/go_router.dart';

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
