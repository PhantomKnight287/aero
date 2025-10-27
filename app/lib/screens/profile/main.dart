import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plane_pal/notifiers/user.dart';
import 'package:provider/provider.dart';

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
                child: Builder(
                  builder: (
                    context,
                  ) {
                    final user = Provider.of<UserNotifier>(
                      context,
                    ).user;
                    return Hero(
                      tag: "avatar",
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: CachedNetworkImageProvider(
                          "https://api.dicebear.com/9.x/initials/png?seed=${user?.name}",
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
                    onTap: () {
                      final user = Provider.of<UserNotifier>(
                        context,
                        listen: false,
                      );
                      user.logOut();
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
