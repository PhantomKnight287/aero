// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      arrival: Map<String, String?>.from(json['arrival'] as Map),
      airline: Map<String, String>.from(json['airline'] as Map),
      codeshared: json['codeshared'],
      departure: Map<String, String?>.from(json['departure'] as Map),
      flight: Map<String, String>.from(json['flight'] as Map),
      type: $enumDecode(_$FlightTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'airline': instance.airline,
      'arrival': instance.arrival,
      'codeshared': instance.codeshared,
      'departure': instance.departure,
      'flight': instance.flight,
      'type': _$FlightTypeEnumMap[instance.type]!,
    };

const _$FlightTypeEnumMap = {
  FlightType.arrival: 'arrival',
  FlightType.departure: 'departure',
};
