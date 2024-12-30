import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/riverpod/user/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    final user = ref.read(userNotifierProvider);
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push("/profile");
                      },
                      child: Hero(
                        tag: "avatar",
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: CachedNetworkImageProvider(
                            "https://api.dicebear.com/9.x/initials/png?seed=${user?.name}",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Connected Wear Os Devices",
                ),
                onTap: () async {
                  GoRouter.of(context).push(
                    "/wearables",
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ListTile(
                    title: Text(
                      "Log Out",
                    ),
                    onTap: () async {
                      ref.read(userNotifierProvider.notifier).logout();
                      if (context.mounted) {
                        GoRouter.of(context).go(
                          "/auth/register",
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
