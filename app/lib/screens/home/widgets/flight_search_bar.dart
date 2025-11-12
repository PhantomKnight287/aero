import 'package:aero/widgets/input.dart';
import 'package:flutter/material.dart';

class FlightSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final bool isSearchEnabled;
  final String hintText;
  final Function(String) onSearchChanged;

  const FlightSearchBar({
    super.key,
    required this.searchController,
    required this.isSearchEnabled,
    required this.hintText,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      enabled: isSearchEnabled,
      hintText: hintText,
      keyboardType: TextInputType.text,
      prefixIcon: Icon(Icons.search),
      controller: searchController,
      onChanged: onSearchChanged,
      hideKeyboardOnClickOutside: false,
    );
  }
}
