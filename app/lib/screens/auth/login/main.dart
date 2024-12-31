import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/notifiers/user.dart';
import 'package:plane_pal/screens/auth/service.dart';
import 'package:plane_pal/utils/error.dart';
import 'package:plane_pal/widgets/input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate() || _loading) return;
    setState(() {
      _loading = true;
    });

    final data = await authService.login(
      LoginDTO(
        (b) {
          b
            ..email = _emailController.text.trim()
            ..password = _passwordController.text.trim()
            ..build();
        },
      ),
    );
    setState(() {
      _loading = false;
    });
    if (data.hasError) {
      showErrorToast(data.error);
      return;
    }
    final body = data.value!.data;
    TextInput.finishAutofillContext();
    await const FlutterSecureStorage().write(
      key: AUTH_TOKEN_KEY,
      value: body!.token,
    );
    if (mounted) {
      final ref = Provider.of<UserNotifier>(context, listen: false);
      ref.login(body.user.id, body.user.name);
    }
    showSuccessToast(
      description: "Welcome back ${body.user.name}",
    );
    if (mounted) {
      GoRouter.of(context).go("/");
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
            child: AutofillGroup(
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
                  InputField(
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [
                      AutofillHints.email,
                    ],
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your email'
                        : null,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: [
                      AutofillHints.password,
                    ],
                    validator: (value) => (value?.length ?? 0) < 8
                        ? 'Password must be at least 8 characters'
                        : null,
                    obscureText: !_isPasswordVisible,
                    controller: _passwordController,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer(
                    builder: (context, ref, child) {
                      return ElevatedButton(
                        onPressed: _login,
                        child: _loading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text(
                                "Login",
                              ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          context.go("/auth/register");
                        },
                        child: Text("Register"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
