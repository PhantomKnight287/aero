import 'package:json_annotation/json_annotation.dart';

part 'flight.g.dart';

enum FlightType {
  arrival,
  departure,
}

enum FlightStatus {
  scheduled,
  active,
  landed,
  cancelled,
  incident,
  diverted,
}

@JsonSerializable()
class Flight {
  final String id;
  final DateTime date;
  final Map<String, String> airline;
  final Map<String, String?> arrival;
  final dynamic codeshared;
  final Map<String, String?> departure;
  final Map<String, String> flight;
  final FlightType type;
  // final FlightStatus? status;

  Flight({
    required this.id,
    required this.date,
    required this.arrival,
    required this.airline,
    required this.codeshared,
    required this.departure,
    required this.flight,
    required this.type,
    // required this.status,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}
