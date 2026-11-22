/// ISO 3166-1 alpha-2 code to flag emoji ('IN' -> 🇮🇳).
String flagEmoji(String iso2) => String.fromCharCodes(
    iso2.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 0x41));
