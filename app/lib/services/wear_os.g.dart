// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wear_os.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WearOSDevice _$WearOSDeviceFromJson(Map<String, dynamic> json) => WearOSDevice(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      isNearby: json['isNearby'] as bool,
    );

Map<String, dynamic> _$WearOSDeviceToJson(WearOSDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'isNearby': instance.isNearby,
    };
