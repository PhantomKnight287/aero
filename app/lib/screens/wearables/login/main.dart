import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/constants/main.dart';

class WearablesLoginScreen extends StatefulWidget {
  final String wearableName;
  const WearablesLoginScreen({
    super.key,
    required this.wearableName,
  });

  @override
  State<WearablesLoginScreen> createState() => _WearablesLoginScreenState();
}

class _WearablesLoginScreenState extends State<WearablesLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go("/");
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Login Request",
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Would you like to sign in to your watch (${widget.wearableName})?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      final storage = const FlutterSecureStorage();
                      final token = await storage.read(
                        key: AUTH_TOKEN_KEY,
                      );
                      if (token == null || (token.isEmpty)) {
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Login Required"),
                                content: Text(
                                    "Please login in the app first before connecting your watch."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.go("/auth/login");
                                    },
                                    child: Text("Login"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        final channel = MethodChannel(METHOD_CHANNEL);
                        channel.invokeMethod(
                          "loginInWearable",
                          token,
                        );
                      }
                    },
                    child: Text(
                      "Sign In",
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
