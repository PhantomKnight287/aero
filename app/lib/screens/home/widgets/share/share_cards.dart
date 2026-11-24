import 'package:aero/constants/map.dart';
import 'package:aero/screens/profile/stats/passport_header.dart'
    show fitLongitudes, splitAtAntimeridian;
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/great_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../flight_detail/flight_status.dart';
import '../flight_detail/progress_bar.dart';
import 'share_data.dart';

/// The share styles, each a fixed logical size so exports are stable.
enum ShareStyle {
  card('Card', Size(400, 500)),
  pass('Pass', Size(440, 230)),
  board('Board', Size(440, 136)),
  story('Story', Size(360, 640));

  final String label;
  final Size size;

  const ShareStyle(this.label, this.size);
}

/// [tiles] off for goldens: map tiles need the network.
Widget buildShareCard(ShareStyle style, ShareData d, {bool tiles = true}) =>
    SizedBox.fromSize(
      size: style.size,
      child: switch (style) {
        ShareStyle.card => ShareCard(d: d),
        ShareStyle.pass => SharePass(d: d),
        ShareStyle.board => ShareBoard(d: d),
        ShareStyle.story => ShareStory(d: d, tiles: tiles),
      },
    );

// ---------------------------------------------------------------------------
// Card: the app's flight detail, condensed
// ---------------------------------------------------------------------------

class ShareCard extends StatelessWidget {
  final ShareData d;

  const ShareCard({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final facts = <(String, String)>[
      if (d.aircraft != null || d.registration != null)
        (
          'Aircraft',
          [d.aircraft, d.registration].whereType<String>().join(' · ')
        ),
      if (_gates(d) != null) ('Gates', _gates(d)!),
      ('Distance', d.distance),
      if (d.seat != null || d.cabin != null)
        ('Seat', [d.seat, d.cabin].whereType<String>().join(' · ')),
    ];
    return ClipRRect(
      borderRadius: AeroRadius.mdAll,
      child: ColoredBox(
        color: AeroColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(AeroSpace.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(d: d),
              const SizedBox(height: AeroSpace.lg),
              if (d.photo != null)
                Expanded(
                  child: ClipRRect(
                    borderRadius: AeroRadius.mdAll,
                    child: Image(image: d.photo!, fit: BoxFit.cover),
                  ),
                )
              else
                const Spacer(),
              const SizedBox(height: AeroSpace.lg),
              _Route(d: d),
              if (d.photo == null) const Spacer(),
              const SizedBox(height: AeroSpace.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AeroSpace.md, vertical: AeroSpace.sm),
                decoration: const BoxDecoration(
                    color: AeroColors.surfaceAlt,
                    borderRadius: AeroRadius.mdAll),
                child: Column(children: [
                  for (final (k, v) in facts)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AeroSpace.xs / 2),
                      child: Row(children: [
                        SizedBox(
                            width: 72, child: Text(k, style: AeroText.caption)),
                        Expanded(
                            child: Text(v,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AeroText.body.copyWith(
                                    color: AeroColors.ink,
                                    fontFeatures: AeroText.tabular))),
                      ]),
                    ),
                ]),
              ),
              const SizedBox(height: AeroSpace.md),
              Row(children: [
                const _AeroMark(),
                const Spacer(),
                Text('aero.procrastinator.fyi', style: AeroText.micro),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final ShareData d;

  const _Title({required this.d});

  @override
  Widget build(BuildContext context) => Row(children: [
        AirlineLogo(svgUrl: d.airlineSvg, icao: d.airlineIcao, size: 32),
        const SizedBox(width: AeroSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${d.idents} · ${d.date}'.toUpperCase(),
                  style:
                      AeroText.label.copyWith(fontFeatures: AeroText.tabular)),
              Text('${d.dep.city} to ${d.arr.city}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AeroText.title),
            ],
          ),
        ),
      ]);
}

/// Codes, the progress bar, then times coloured by punctuality.
class _Route extends StatelessWidget {
  final ShareData d;

  const _Route({required this.d});

  @override
  Widget build(BuildContext context) {
    final (word, colour) = d.remark;
    final cancelled = d.phase == FlightPhase.cancelled;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Expanded(child: _End(side: d.dep)),
          Expanded(child: _End(side: d.arr, end: true)),
        ]),
        const SizedBox(height: AeroSpace.xs),
        if (d.progress != null)
          RouteProgressBar(
              from: d.dep.code, to: d.arr.code, progress: d.progress!)
        else
          Text(word, style: AeroText.heading.copyWith(color: colour)),
        const SizedBox(height: AeroSpace.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Clock(side: d.dep, cancelled: cancelled),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: AeroSpace.sm),
                child: Text(d.duration,
                    textAlign: TextAlign.center,
                    style: AeroText.caption
                        .copyWith(fontFeatures: AeroText.tabular)),
              ),
            ),
            _Clock(side: d.arr, end: true, cancelled: cancelled),
          ],
        ),
      ],
    );
  }
}

class _End extends StatelessWidget {
  final ShareSide side;
  final bool end;

  const _End({required this.side, this.end = false});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment:
            end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(side.code, style: AeroText.display),
          Text([side.icao, side.city].whereType<String>().join(' · '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AeroText.caption),
        ],
      );
}

class _Clock extends StatelessWidget {
  final ShareSide side;
  final bool end;
  final bool cancelled;

  const _Clock({required this.side, this.end = false, this.cancelled = false});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment:
            end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(side.clock,
              style: AeroText.figure.copyWith(
                  color: side.color ?? AeroColors.ink,
                  decoration: cancelled ? TextDecoration.lineThrough : null)),
          Text(side.delay,
              style: AeroText.caption.copyWith(
                  color: side.color ?? AeroColors.muted,
                  fontWeight: side.color == null ? null : FontWeight.w600,
                  fontFeatures: AeroText.tabular)),
        ],
      );
}

String? _gates(ShareData d) {
  String? one(ShareSide s) {
    final bits = [
      if (s.terminal != null) 'T${s.terminal}',
      if (s.gate != null) s.gate!,
    ];
    return bits.isEmpty ? null : bits.join(' · ');
  }

  final a = one(d.dep), b = one(d.arr);
  if (a == null && b == null) return null;
  return '${a ?? '—'} → ${b ?? '—'}';
}

// ---------------------------------------------------------------------------
// Pass: boarding-pass layout
// ---------------------------------------------------------------------------

class SharePass extends StatelessWidget {
  final ShareData d;

  const SharePass({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final label = AeroText.label.copyWith(color: AeroColors.ink);
    return ClipPath(
      clipper: const _PassClip(),
      child: ColoredBox(
        color: AeroColors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AeroColors.surfaceAlt,
              padding: const EdgeInsets.fromLTRB(
                  AeroSpace.lg, AeroSpace.md, AeroSpace.lg, AeroSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    const _AeroMark(),
                    Expanded(
                      child: Text(d.airline.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: label),
                    ),
                    Text('BOARDING PASS', style: label),
                  ]),
                  const SizedBox(height: AeroSpace.sm),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${d.dep.city} → ${d.arr.city}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AeroText.title),
                          Text('${d.idents} · ${d.date}',
                              style: AeroText.label
                                  .copyWith(fontFeatures: AeroText.tabular)),
                        ],
                      ),
                    ),
                    AirlineLogo(
                        svgUrl: d.airlineSvg, icao: d.airlineIcao, size: 36),
                  ]),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 180,
                    color: AeroColors.ink,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AeroSpace.lg, vertical: AeroSpace.md),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.dep.code, style: AeroText.passCode),
                          Text('→${d.arr.code}', style: AeroText.passCode),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomPaint(
                      painter: const _Hatch(),
                      child: Padding(
                        padding: const EdgeInsets.all(AeroSpace.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DEPARTS', style: AeroText.label),
                            Text(d.dep.clock,
                                style: AeroText.figure.copyWith(
                                    color: d.dep.color ?? AeroColors.ink)),
                            const Spacer(),
                            Row(children: [
                              _Mini('GATE', d.dep.gate ?? '—'),
                              _Mini('ARRIVES', d.arr.clock,
                                  colour: d.arr.color),
                              _Mini('SEAT', d.seat ?? '—'),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Mini extends StatelessWidget {
  final String label;
  final String value;
  final Color? colour;

  const _Mini(this.label, this.value, {this.colour});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AeroText.label),
            Text(value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AeroText.body.copyWith(
                    color: colour ?? AeroColors.ink,
                    fontWeight: FontWeight.w600,
                    fontFeatures: AeroText.tabular)),
          ],
        ),
      );
}

/// Rounded corners, the bottom-right one cut like a torn stub.
class _PassClip extends CustomClipper<Path> {
  const _PassClip();

  @override
  Path getClip(Size s) {
    const r = AeroRadius.md, cut = 22.0;
    return Path()
      ..moveTo(r, 0)
      ..lineTo(s.width - r, 0)
      ..arcToPoint(Offset(s.width, r), radius: const Radius.circular(r))
      ..lineTo(s.width, s.height - cut)
      ..lineTo(s.width - cut, s.height)
      ..lineTo(r, s.height)
      ..arcToPoint(Offset(0, s.height - r), radius: const Radius.circular(r))
      ..lineTo(0, r)
      ..arcToPoint(const Offset(r, 0), radius: const Radius.circular(r))
      ..close();
  }

  @override
  bool shouldReclip(_PassClip old) => false;
}

class _Hatch extends CustomPainter {
  const _Hatch();

  @override
  void paint(Canvas canvas, Size size) {
    // Lines start left of the box; clip so they don't cross the code block.
    canvas.clipRect(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, Paint()..color = AeroColors.surface);
    final p = Paint()
      ..color = AeroColors.line
      ..strokeWidth = 1;
    for (var x = -size.height; x < size.width; x += 10) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), p);
    }
  }

  @override
  bool shouldRepaint(_Hatch old) => false;
}

// ---------------------------------------------------------------------------
// Board: one row of a departures (or arrivals) board
// ---------------------------------------------------------------------------

class ShareBoard extends StatelessWidget {
  final ShareData d;

  const ShareBoard({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final here = d.arriving ? d.arr : d.dep;
    final there = d.arriving ? d.dep : d.arr;
    final (word, colour) = d.remark;
    final head = AeroText.label.copyWith(color: AeroColors.boardMuted);
    final cell = AeroText.heading
        .copyWith(color: AeroColors.onInk, fontFeatures: AeroText.tabular);
    final ident = d.ident.replaceFirstMapped(
        RegExp(r'^([A-Z0-9]{2})(\d+)$'), (m) => '${m[1]} ${m[2]}');
    const time = 96.0, flight = 84.0, remarks = 128.0;

    return Container(
      padding: const EdgeInsets.all(AeroSpace.lg),
      decoration: const BoxDecoration(
          color: AeroColors.boardPanel, borderRadius: AeroRadius.mdAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Icon(d.arriving ? Icons.flight_land : Icons.flight_takeoff,
                color: AeroColors.board, size: 26),
            const SizedBox(width: AeroSpace.sm),
            Text('${here.code} ${d.arriving ? 'Arrivals' : 'Departures'}',
                style: AeroText.title.copyWith(color: AeroColors.board)),
            const Spacer(),
            Text('Aero',
                style: AeroText.caption.copyWith(color: AeroColors.boardMuted)),
          ]),
          const SizedBox(height: AeroSpace.lg),
          // Same left inset as the data row so the columns line up.
          Padding(
            padding: const EdgeInsets.only(left: AeroSpace.sm),
            child: Row(children: [
              SizedBox(width: time, child: Text('TIME', style: head)),
              Expanded(child: Text(d.arriving ? 'FROM' : 'TO', style: head)),
              SizedBox(width: flight, child: Text('FLIGHT', style: head)),
              SizedBox(
                width: remarks,
                child: Padding(
                  padding: const EdgeInsets.only(left: AeroSpace.sm),
                  child: Text('REMARKS', style: head),
                ),
              ),
            ]),
          ),
          const SizedBox(height: AeroSpace.xs),
          Container(
            color: AeroColors.boardRow,
            padding: const EdgeInsets.only(left: AeroSpace.sm),
            child: Row(children: [
              SizedBox(width: time, child: Text(here.clock, style: cell)),
              Expanded(
                  child: Text(there.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: cell)),
              SizedBox(width: flight, child: Text(ident, style: cell)),
              Container(
                width: remarks,
                color: colour,
                padding: const EdgeInsets.symmetric(
                    horizontal: AeroSpace.sm, vertical: AeroSpace.sm),
                child: Row(children: [
                  for (final o in [1.0, 0.55])
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                          color: AeroColors.onInk.withValues(alpha: o),
                          shape: BoxShape.circle),
                    ),
                  const SizedBox(width: AeroSpace.xs),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(word,
                          style: AeroText.body.copyWith(
                              color: AeroColors.onInk,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Story: 9:16, route on the map with the pass on top
// ---------------------------------------------------------------------------

class ShareStory extends StatelessWidget {
  final ShareData d;
  final bool tiles;

  const ShareStory({super.key, required this.d, this.tiles = true});

  @override
  Widget build(BuildContext context) {
    final lons = fitLongitudes([d.dep.at.longitude, d.arr.at.longitude]);
    final a = LatLng(d.dep.at.latitude, lons[0]);
    final b = LatLng(d.arr.at.latitude, lons[1]);
    final arc = greatCirclePoints(a, b);
    final flying = d.phase == FlightPhase.inFlight && d.progress != null;
    final i =
        ((d.progress ?? 0) * (arc.length - 1)).round().clamp(0, arc.length - 2);
    final bearing = const Distance().bearing(arc[i], arc[i + 1]);

    return ClipRRect(
      borderRadius: AeroRadius.mdAll,
      child: Stack(children: [
        Positioned.fill(
          child: FlutterMap(
            options: MapOptions(
              backgroundColor: AeroColors.surfaceAlt,
              initialCameraFit: CameraFit.coordinates(
                coordinates: [a, b],
                padding: const EdgeInsets.fromLTRB(120, 120, 120, 280),
                maxZoom: 7,
              ),
              interactionOptions:
                  const InteractionOptions(flags: InteractiveFlag.none),
            ),
            children: [
              if (tiles) lightMapTileLayer,
              PolylineLayer(polylines: [
                for (final part in splitAtAntimeridian(arc))
                  Polyline(
                      points: part, color: AeroColors.ink, strokeWidth: 2.5),
              ]),
              CircleLayer(circles: [
                for (final p in [a, b])
                  CircleMarker(
                      point: p,
                      radius: 5,
                      color: AeroColors.ink,
                      borderColor: AeroColors.surface,
                      borderStrokeWidth: 2),
              ]),
              MarkerLayer(markers: [
                for (final (p, s) in [(a, d.dep), (b, d.arr)])
                  Marker(
                    point: p,
                    width: 180,
                    height: 64,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _MapTag(side: s),
                    ),
                  ),
                if (flying)
                  Marker(
                    point: arc[i],
                    width: 32,
                    height: 32,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AeroColors.ink, shape: BoxShape.circle),
                      child: Transform.rotate(
                        angle: bearing * pi / 180,
                        child: const Icon(Icons.flight,
                            size: 20, color: AeroColors.onInk),
                      ),
                    ),
                  ),
              ]),
            ],
          ),
        ),
        Positioned(
          left: AeroSpace.lg,
          right: AeroSpace.lg,
          bottom: AeroSpace.xl,
          child: FittedBox(
            // Shadow cast by the pass's own outline (rounded, cut corner).
            child: PhysicalShape(
              clipper: const _PassClip(),
              color: AeroColors.surface,
              shadowColor: AeroColors.shadow,
              elevation: 12,
              child: SizedBox.fromSize(
                  size: ShareStyle.pass.size, child: SharePass(d: d)),
            ),
          ),
        ),
      ]),
    );
  }
}

/// 'Los Angeles │ LAX' chip under an airport dot.
class _MapTag extends StatelessWidget {
  final ShareSide side;

  const _MapTag({required this.side});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: AeroRadius.smAll,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            color: AeroColors.surface,
            padding: const EdgeInsets.symmetric(
                horizontal: AeroSpace.sm, vertical: AeroSpace.xs),
            child: Text(side.city,
                style: AeroText.body.copyWith(color: AeroColors.ink)),
          ),
          Container(
            color: AeroColors.ink,
            padding: const EdgeInsets.symmetric(
                horizontal: AeroSpace.sm, vertical: AeroSpace.xs),
            child: Text(side.code,
                style: AeroText.body.copyWith(
                    color: AeroColors.onInk, fontWeight: FontWeight.w600)),
          ),
        ]),
      );
}

/// App icon and wordmark, the cards' signature.
class _AeroMark extends StatelessWidget {
  const _AeroMark();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: AeroRadius.smAll,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset('assets/logos/0-1.png', width: 14),
            ),
          ),
          const SizedBox(width: AeroSpace.xs),
          Text('Made with Aero', style: AeroText.micro),
        ],
      );
}
