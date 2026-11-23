import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

String? _json(Object? v) {
  final s = (v is String ? v : (v as dynamic)?.value)?.toString().trim();
  return s == null || s.isEmpty ? null : s;
}

/// 'flight_attendant' / 'flightAttendant' -> 'Flight attendant'.
String _enum(String name) {
  final words = name
      .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
      .replaceAll('_', ' ')
      .toLowerCase();
  return words[0].toUpperCase() + words.substring(1);
}

class _Line extends StatelessWidget {
  final String label;
  final String value;

  const _Line(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs),
        child: Row(children: [
          SizedBox(width: 96, child: Text(label, style: AeroText.caption)),
          Expanded(
            child: Text(value,
                style: AeroText.body.copyWith(
                    color: AeroColors.ink, fontWeight: FontWeight.w600)),
          ),
        ]),
      );
}

/// Code, seat, class and reason from the first booking.
class BookingSection extends StatelessWidget {
  final FlightBookingEntity booking;

  const BookingSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final seat = _json(b.seatNumber);
    final seatType = b.seatType?.name;
    final lines = [
      if (_json(b.bookingCode) != null)
        _Line('Booking code', _json(b.bookingCode)!),
      if (seat != null || seatType != null)
        _Line(
            'Seat',
            [seat, if (seatType != null) _enum(seatType)]
                .whereType<String>()
                .join(' · ')),
      if (b.seatingClass != null) _Line('Class', _enum(b.seatingClass!.name)),
      if (b.reason != null) _Line('Reason', _enum(b.reason!.name)),
    ];
    if (lines.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Booking', style: AeroText.sectionTitle),
        const SizedBox(height: AeroSpace.sm),
        ...lines,
      ],
    );
  }
}
