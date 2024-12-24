// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airport _$AirportFromJson(Map<String, dynamic> json) => Airport(
      id: json['id'] as String,
      ident: json['ident'] as String,
      type: $enumDecode(_$AirportTypeEnumMap, json['type']),
      name: json['name'] as String,
      elevation: json['elevation'] as String?,
      continent: json['continent'] as String?,
      iso_country: json['iso_country'] as String,
      iso_region: json['iso_region'] as String?,
      municipality: json['municipality'] as String?,
      gps_code: json['gps_code'] as String?,
      iata_code: json['iata_code'] as String?,
      local_code: json['local_code'] as String?,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$AirportToJson(Airport instance) => <String, dynamic>{
      'id': instance.id,
      'ident': instance.ident,
      'type': _$AirportTypeEnumMap[instance.type]!,
      'name': instance.name,
      'elevation': instance.elevation,
      'continent': instance.continent,
      'iso_country': instance.iso_country,
      'iso_region': instance.iso_region,
      'municipality': instance.municipality,
      'gps_code': instance.gps_code,
      'iata_code': instance.iata_code,
      'local_code': instance.local_code,
      'lat': instance.lat,
      'long': instance.long,
    };

const _$AirportTypeEnumMap = {
  AirportType.small_airport: 'small_airport',
  AirportType.seaplane_base: 'seaplane_base',
  AirportType.medium_airport: 'medium_airport',
  AirportType.large_airport: 'large_airport',
  AirportType.heliport: 'heliport',
  AirportType.closed: 'closed',
  AirportType.balloonport: 'balloonport',
};
