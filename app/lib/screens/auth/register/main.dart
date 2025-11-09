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
import 'package:plane_pal/widgets/input.dart';
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
  bool _isPasswordVisible = false;

  @override
  void dispose() {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  // App Logo
                  Center(
                    child: Image.asset(
                      'assets/logos/0-1.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Welcome Text
                  const Text(
                    'Join Aero',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CalSans",
                      color: Colors.black,
                      letterSpacing: -1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Create an account to start tracking flights',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontFamily: "Geist",
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 56),
                  // Name Field
                  InputField(
                    hintText: "Name",
                    keyboardType: TextInputType.name,
                    fillColor: Colors.white,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter your name' : null,
                    controller: _nameController,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      size: 20,
                    ),
                    autofillHints: [AutofillHints.name],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  InputField(
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [
                      AutofillHints.email,
                    ],
                    fillColor: Colors.white,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter your email' : null,
                    controller: _emailController,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  InputField(
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: [
                      AutofillHints.password,
                    ],
                    fillColor: Colors.white,
                    validator: (value) => (value?.length ?? 0) < 8
                        ? 'Password must be at least 8 characters'
                        : null,
                    obscureText: !_isPasswordVisible,
                    controller: _passwordController,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Register Button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "CalSans",
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontFamily: "Geist",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go("/auth/login");
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "CalSans",
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
