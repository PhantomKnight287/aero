import 'dart:convert';

import 'package:flutter/services.dart';

/// Messages to every connected Wear OS node. Works from the UI isolate and
/// from background isolates alike.
class WearBridge {
  static const _channel = MethodChannel('fyi.procrastinator.wear_bridge');

  /// Sends [payload] as UTF-8 JSON on [path]. Returns how many watches got
  /// it; 0 when none is connected (not an error).
  static Future<int> send(String path, Map<String, Object?> payload) async =>
      await _channel.invokeMethod<int>(
          'send', {'path': path, 'json': jsonEncode(payload)}) ??
      0;
}
