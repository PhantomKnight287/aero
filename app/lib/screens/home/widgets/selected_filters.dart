import 'package:plane_pal/models/airline/airline.dart';
import 'package:plane_pal/screens/home/service.dart';
import 'package:flutter/material.dart';

class SelectedFilters extends StatelessWidget {
  final Airline? selectedAirline;
  final String? selectedFlightNumber;
  final Airport? arrivalAirport;
  final Airport? departureAirport;
  final VoidCallback onAirlineClear;
  final VoidCallback onFlightNumberClear;
  final VoidCallback onAirportsClear;
  final VoidCallback onDepartureAirportClear;

  const SelectedFilters({
    super.key,
    this.selectedAirline,
    this.departureAirport,
    this.arrivalAirport,
    this.selectedFlightNumber,
    required this.onAirlineClear,
    required this.onFlightNumberClear,
    required this.onAirportsClear,
    required this.onDepartureAirportClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (selectedAirline != null)
          GestureDetector(
            onTap: onAirlineClear,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(0xffe7e0e8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedAirline!.iata,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        if (selectedFlightNumber != null)
          GestureDetector(
            onTap: onFlightNumberClear,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(0xffe7e0e8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedFlightNumber!.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        if (arrivalAirport != null)
          GestureDetector(
            onTap: onAirlineClear,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(0xffe7e0e8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                arrivalAirport!.iata_code ?? arrivalAirport!.ident,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        if (departureAirport != null)
          GestureDetector(
            onTap: onDepartureAirportClear,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(0xffe7e0e8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                departureAirport!.iata_code ?? departureAirport!.ident,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
      ],
    );
  }
}
