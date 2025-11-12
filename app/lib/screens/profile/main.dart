import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aero/notifiers/user.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: "CalSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Avatar Section
              Builder(
                builder: (context) {
                  final user = Provider.of<UserNotifier>(context).user;
                  return Column(
                    children: [
                      Hero(
                        tag: "avatar",
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: CachedNetworkImageProvider(
                            "https://api.dicebear.com/9.x/initials/png?seed=${user?.name}",
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user?.name ?? 'User',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: "CalSans",
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              // Menu Items
              _ProfileMenuItem(
                icon: Icons.flight_takeoff_outlined,
                title: 'Flight Stats',
                onTap: () {
                  GoRouter.of(context).push("/profile/stats");
                },
              ),
              const SizedBox(height: 8),
              _ProfileMenuItem(
                icon: Icons.watch_outlined,
                title: 'Connected Wear OS Devices',
                onTap: () {
                  GoRouter.of(context).push("/wearables");
                },
              ),
              const SizedBox(height: 8),
              _ProfileMenuItem(
                icon: Icons.image_outlined,
                title: 'App Icon',
                onTap: () {
                  GoRouter.of(context).push("/profile/app-icon");
                },
              ),
              const SizedBox(height: 24),
              // Log Out Button
              Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        final user = Provider.of<UserNotifier>(
                          context,
                          listen: false,
                        );
                        user.logOut();
                        if (context.mounted) {
                          GoRouter.of(context).go("/auth/login");
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CalSans",
                          letterSpacing: 0.5,
                        ),
                      ),
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

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Geist",
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
