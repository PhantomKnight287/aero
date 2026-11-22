/// Request to open a flight detail from the stats screen.
class OpenFlightRequest {
  final String flightNo;
  final DateTime date;
  final String? faFlightId;

  const OpenFlightRequest({
    required this.flightNo,
    required this.date,
    this.faFlightId,
  });
}
