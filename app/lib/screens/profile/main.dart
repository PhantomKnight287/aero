import 'package:plane_pal/client/pocketbase.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                child: Hero(
                  tag: "avatar",
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      (pb.authStore.record!.data['avatar'] == null || pb.authStore.record!.data['avatar'].isEmpty)
                          ? "https://api.dicebear.com/9.x/initials/png?seed=${pb.authStore.record!.data['name']}"
                          : "$POCKETBASE_URL/api/files/users/${pb.authStore.record!.id}/${pb.authStore.record!.data['avatar']}",
                    ),
                  ),
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
              ListTile(
                title: Text(
                  "Log Out",
                ),
                onTap: () async {
                  pb.authStore.clear();
                  GoRouter.of(context).go(
                    "/auth/register",
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
