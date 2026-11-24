import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/notifiers/user.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/ui/components/aero_button.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/aero_segmented.dart';
import 'package:aero/ui/tokens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserNotifier>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AeroText.title),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AeroSpace.xl, vertical: AeroSpace.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'avatar',
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AeroColors.surfaceAlt,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://api.dicebear.com/9.x/initials/png?seed=${user?.name}',
                  ),
                ),
              ),
              const SizedBox(height: AeroSpace.md),
              Text(
                user?.name ?? 'User',
                textAlign: TextAlign.center,
                style: AeroText.display,
              ),
              const SizedBox(height: AeroSpace.xl),
              _ProfileMenuItem(
                icon: Icons.flight_takeoff_outlined,
                title: 'Flight Stats',
                onTap: () async {
                  final r =
                      await context.push<OpenFlightRequest>('/profile/stats');
                  if (r != null && context.mounted) context.pop(r);
                },
              ),
              const SizedBox(height: AeroSpace.sm),
              _ProfileMenuItem(
                icon: Icons.image_outlined,
                title: 'App Icon',
                onTap: () => GoRouter.of(context).push('/profile/app-icon'),
              ),
              const SizedBox(height: AeroSpace.xl),
              const UnitsSection(),
              const SizedBox(height: AeroSpace.xl),
              AeroButton.secondary(
                label: 'Log out',
                onPressed: () {
                  context.read<UserNotifier>().logOut();
                  GoRouter.of(context).go('/auth/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Profile → Units: one segmented control per dimension. Same settings the
/// tap-to-cycle values change.
class UnitsSection extends StatelessWidget {
  const UnitsSection({super.key});

  static String _segmentLabel(Enum unit) => switch (unit) {
        TimeMode.airport => 'Airport',
        TimeMode.device => 'My time',
        TimeMode.utc => 'UTC',
        _ => unitLabel(unit),
      };

  @override
  Widget build(BuildContext context) {
    final units = context.watch<UnitsNotifier>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Units', style: AeroText.heading),
        const SizedBox(height: AeroSpace.xs),
        Text('Tip: tap any value in the app to switch its unit.',
            style: AeroText.caption),
        for (final d in UnitDimension.values) ...[
          const SizedBox(height: AeroSpace.lg),
          Text(dimensionLabel(d), style: AeroText.body),
          const SizedBox(height: AeroSpace.sm),
          AeroSegmented<Enum>(
            values: UnitsNotifier.valuesOf(d),
            selected: units.unitOf(d),
            label: _segmentLabel,
            onChanged: (u) => units.set(d, u),
          ),
        ],
      ],
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AeroPressable(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AeroSpace.lg, vertical: AeroSpace.md + 2),
          decoration: const BoxDecoration(
            color: AeroColors.surfaceAlt,
            borderRadius: AeroRadius.mdAll,
          ),
          child: Row(
            children: [
              Icon(icon, color: AeroColors.ink, size: 22),
              const SizedBox(width: AeroSpace.lg),
              Expanded(
                child: Text(title,
                    style: AeroText.body.copyWith(
                        color: AeroColors.ink, fontWeight: FontWeight.w500)),
              ),
              const Icon(Icons.chevron_right, color: AeroColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
