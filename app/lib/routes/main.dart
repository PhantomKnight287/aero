import 'package:aero/screens/auth/login/main.dart';
import 'package:aero/screens/auth/main.dart';
import 'package:aero/screens/auth/register/main.dart';
import 'package:aero/screens/home/main.dart';
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
    ],
    debugLogDiagnostics: true,
    initialLocation: "/auth/register",
  );
}
