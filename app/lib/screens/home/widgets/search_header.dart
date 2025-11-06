import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:plane_pal/notifiers/user.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Search",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Builder(
            builder: (context) {
              final user = Provider.of<UserNotifier>(context);
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).push("/profile");
                },
                child: Hero(
                  tag: "avatar",
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      "https://api.dicebear.com/9.x/initials/png?seed=${user.user?.name}",
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

