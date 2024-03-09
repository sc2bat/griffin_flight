class FlightDTO {
  final int flightId;
  final int? airplaneId;
  final String? flightDate;
  final String? departureTime;
  final String? arrivalTime;
  final int? departureLoc;
  final String? departureName;
  final int? arrivalLoc;
  final String? arrivalName;

  FlightDTO(
      {required this.flightId,
      this.airplaneId,
      this.flightDate,
      this.departureTime,
      this.arrivalTime,
      this.departureLoc,
      this.departureName,
      this.arrivalLoc,
      this.arrivalName});

  factory FlightDTO.fromJson(Map<String, dynamic> json) {
    return FlightDTO(
      flightId: json['flight_id'] ?? '',
      airplaneId: json['airplane_id'] ?? '',
      flightDate: json['flight_date'] ?? '',
      departureTime: json['departure_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      departureLoc: json['departure_loc'] ?? '',
      departureName: json['departure_name'] ?? '',
      arrivalLoc: json['arrival_loc'] ?? '',
      arrivalName: json['arrival_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flight_id': flightId,
      'airplane_id': airplaneId,
      'flight_date': flightDate,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'departure_loc': departureLoc,
      'departure_name': departureName,
      'arrival_loc': arrivalLoc,
      'arrival_name': arrivalName,
    };
  }
}
