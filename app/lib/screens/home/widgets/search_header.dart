import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:aero/notifiers/user.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/ui/tokens.dart';

class SearchHeader extends StatelessWidget {
  /// Receives a flight picked in Profile → Passport.
  final ValueChanged<OpenFlightRequest>? onOpenFlight;

  const SearchHeader({super.key, this.onOpenFlight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Search",
            style: AeroText.title,
          ),
          Spacer(),
          Builder(
            builder: (context) {
              final user = Provider.of<UserNotifier>(context);
              return GestureDetector(
                onTap: () async {
                  final r = await context.push<OpenFlightRequest>('/profile');
                  if (r != null) onOpenFlight?.call(r);
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
