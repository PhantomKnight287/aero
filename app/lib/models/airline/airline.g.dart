// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airline _$AirlineFromJson(Map<String, dynamic> json) => Airline(
      id: json['id'] as String,
      name: json['name'] as String,
      iata: json['iata'] as String,
      icao: json['icao'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$AirlineToJson(Airline instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iata': instance.iata,
      'icao': instance.icao,
      'image': instance.image,
    };
