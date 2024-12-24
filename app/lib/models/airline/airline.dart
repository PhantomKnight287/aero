import 'package:json_annotation/json_annotation.dart';

part 'airline.g.dart';

@JsonSerializable()
class Airline {
  final String id;
  final String name;
  final String iata;
  final String icao;
  final String? image;

  Airline({
    required this.id,
    required this.name,
    required this.iata,
    required this.icao,
    this.image,
  });

  factory Airline.fromJson(Map<String, dynamic> json) => _$AirlineFromJson(json);

  toJson() => _$AirlineToJson(this);
}
