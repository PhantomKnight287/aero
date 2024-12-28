import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wear_os.g.dart';

@JsonSerializable()
class WearOSDevice {
  final String id;
  final String displayName;
  final bool isNearby;

  WearOSDevice({
    required this.id,
    required this.displayName,
    required this.isNearby,
  });

  factory WearOSDevice.fromJson(Map<Object, Object> json) => WearOSDevice(id: json['id'] as String, displayName: json['displayName'] as String, isNearby: json['isNearby'] as bool);
  toJson() => _$WearOSDeviceToJson(this);
}

class WearOSService {
  static const MethodChannel _channel = MethodChannel('com.phantomknight287.planepal/planepal');

  /// Get list of connected Wear OS devices
  Future<List<WearOSDevice>> getConnectedDevices() async {
    try {
      final List<Object?> rawResult = await _channel.invokeMethod(
        'getConnectedWearables',
      );
      final List<Map<Object?, Object?>> result = List<Map<Object?, Object?>>.from(rawResult);
      return result.map((json) => WearOSDevice(id: json['id'] as String, displayName: json['displayName'] as String, isNearby: json['isNearby'] as bool)).toList();
    } on PlatformException catch (e) {
      print('Error getting connected devices: ${e.message}');
      return [];
    }
  }
}
