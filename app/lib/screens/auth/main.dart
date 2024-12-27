import 'package:plane_pal/client/pocketbase.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthShell extends StatefulWidget {
  final Widget child;
  const AuthShell({
    super.key,
    required this.child,
  });

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _redirect();
      },
    );
  }

  void _redirect() {
    if (pb.authStore.record != null) {
      context.go("/");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
