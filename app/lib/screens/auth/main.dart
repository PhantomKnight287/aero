import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/riverpod/user/user.dart';
import 'package:plane_pal/screens/loading/loading.dart';

class AuthShell extends ConsumerStatefulWidget {
  final Widget child;
  const AuthShell({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends ConsumerState<AuthShell> {
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

      ref.read(userNotifierProvider.notifier).login(
            data.id,
            data.name,
          );
      if (mounted) {
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
