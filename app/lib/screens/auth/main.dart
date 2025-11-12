import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aero/constants/main.dart';
import 'package:aero/notifiers/user.dart';
import 'package:aero/screens/loading/loading.dart';
import 'package:provider/provider.dart';

class AuthShell extends StatefulWidget {
  final Widget child;
  const AuthShell({
    super.key,
    required this.child,
  });

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  bool _loading = true;

  final _authApi = openapi.getAuthenticationApi();
  Future<void> _hyrate() async {
    try {
      setState(() {
        _loading = true;
      });
      const storage = FlutterSecureStorage();
      final key = await storage.read(
        key: AUTH_TOKEN_KEY,
      );

      if (key == null) return;

      // dio interceptor will add auth token if present, big brain move
      final req = await _authApi.authControllerGetCurrentUserV1();
      final data = req.data!;

      if (mounted) {
        final ref = Provider.of<UserNotifier>(context, listen: false);
        ref.login(data.id, data.name);
        GoRouter.of(context).go("/");
      }
    } catch (e, stack) {
      print(e);
      print(stack);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _hyrate();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        appBar: null,
        body: SafeArea(
          child: Center(
            child: LoadingScreen(),
          ),
        ),
      );
    }
    return widget.child;
  }
}
