import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/notifiers/user.dart';
import 'package:plane_pal/screens/auth/service.dart';
import 'package:plane_pal/utils/error.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate() || _loading) return;

    setState(() {
      _loading = true;
    });
    try {
      final data = await authService.register(
        RegisterDTO(
          (b) {
            b
              ..password = _passwordController.text.trim()
              ..name = _nameController.text.trim()
              ..email = _emailController.text.trim()
              ..build();
          },
        ),
      );
      TextInput.finishAutofillContext();
      await const FlutterSecureStorage().write(
        key: AUTH_TOKEN_KEY,
        value: data!.token,
      );
      if (mounted) {
        final ref = Provider.of<UserNotifier>(context, listen: false);
        ref.login(data.user.id, data.user.name);
      }
      showSuccessToast(
        description: "Welcome ${data.user.name}",
      );
      if (mounted) {
        GoRouter.of(context).go("/");
      }
    } on DioException catch (e) {
      showErrorToast(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome to Aero',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CalSans",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => (value?.length ?? 0) < 8
                      ? 'Password must be at least 8 characters'
                      : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _register,
                  child: _loading
                      ? const CircularProgressIndicator.adaptive()
                      : const Text(
                          "Register",
                        ),
                ),
                Row(
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        context.go("/auth/login");
                      },
                      child: Text("Login"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
