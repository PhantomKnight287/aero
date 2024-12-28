import 'dart:convert';

String hexToUtf8(String hexAddress) {
  if (hexAddress.length % 2 != 0) {
    throw ArgumentError("Hexadecimal string must have an even number of characters.");
  }

  // Convert the hexadecimal string to bytes
  List<int> bytes = [
    for (int i = 0; i < hexAddress.length; i += 2) int.parse(hexAddress.substring(i, i + 2), radix: 16),
  ];

  // Decode the bytes to a UTF-8 string
  return utf8.decode(bytes);
}
