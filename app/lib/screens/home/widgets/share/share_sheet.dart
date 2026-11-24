import 'dart:io';

import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/aero_button.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/error.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'share_cards.dart';
import 'share_data.dart';

/// Pick a style, see it, share it. The export is captured from the preview
/// itself, so the photo and logo are already loaded when it's taken.
class ShareSheet extends StatefulWidget {
  final FlightResponseEntity info;

  const ShareSheet({super.key, required this.info});

  @override
  State<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<ShareSheet> {
  final _shot = ScreenshotController();
  var _style = ShareStyle.card;
  var _busy = false;

  Future<void> _share() async {
    setState(() => _busy = true);
    try {
      // 1080 px wide whatever the style.
      final bytes = await _shot.capture(pixelRatio: 1080 / _style.size.width);
      if (bytes == null) throw 'Could not render the card';
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/aero_${_style.name}_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } catch (e) {
      showErrorToast(e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final units = context.watch<UnitsNotifier>();
    final photo = widget.info.aircraft?.image;
    final data = ShareData.from(
      widget.info,
      DateTime.now(),
      distanceUnit: units.distance,
      timeMode: units.time,
      use24: MediaQuery.of(context).alwaysUse24HourFormat,
      photo: photo == null || photo.isEmpty
          ? null
          : CachedNetworkImageProvider(photo),
    );
    return AeroSheet(
      title: 'Share flight',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 340,
            padding: const EdgeInsets.all(AeroSpace.lg),
            decoration: const BoxDecoration(
                color: AeroColors.surfaceAlt, borderRadius: AeroRadius.mdAll),
            child: FittedBox(
              child: Screenshot(
                controller: _shot,
                child: buildShareCard(_style, data),
              ),
            ),
          ),
          const SizedBox(height: AeroSpace.md),
          Row(children: [
            for (final s in ShareStyle.values) ...[
              if (s != ShareStyle.values.first)
                const SizedBox(width: AeroSpace.sm),
              Expanded(
                child: _Thumb(
                  style: s,
                  data: data,
                  selected: s == _style,
                  onTap: () => setState(() => _style = s),
                ),
              ),
            ],
          ]),
          const SizedBox(height: AeroSpace.lg),
          AeroButton(
            label: 'Share image',
            loading: _busy,
            onPressed: _busy ? null : _share,
          ),
        ],
      ),
    );
  }
}

/// A live miniature of one style; the ink ring marks the chosen one.
class _Thumb extends StatelessWidget {
  final ShareStyle style;
  final ShareData data;
  final bool selected;
  final VoidCallback onTap;

  const _Thumb({
    required this.style,
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: '${style.label} style',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(
          child: Column(children: [
            Container(
              height: 88,
              padding: const EdgeInsets.all(AeroSpace.xs),
              decoration: BoxDecoration(
                color: AeroColors.surfaceAlt,
                borderRadius: AeroRadius.smAll,
                border: Border.all(
                    width: 2,
                    color: selected ? AeroColors.ink : AeroColors.surfaceAlt),
              ),
              child: IgnorePointer(
                child: FittedBox(child: buildShareCard(style, data)),
              ),
            ),
            const SizedBox(height: AeroSpace.xs),
            Text(style.label,
                style: AeroText.caption.copyWith(
                    color: selected ? AeroColors.ink : AeroColors.muted,
                    fontWeight: selected ? FontWeight.w600 : null)),
          ]),
        ),
      ),
    );
  }
}
