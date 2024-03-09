class SearchDTO {
  final String? fromFlightDate;
  final String? toFlightDate;
  final int? departureLoc;
  final int? arrivalLoc;

  SearchDTO({
    this.fromFlightDate,
    this.toFlightDate,
    this.departureLoc,
    this.arrivalLoc,
  });

  factory SearchDTO.fromJson(Map<String, dynamic> json) {
    return SearchDTO(
      fromFlightDate: json['from_flight_date'],
      toFlightDate: json['to_flight_date'],
      departureLoc: json['departure_loc'],
      arrivalLoc: json['arrival_loc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from_flight_date': fromFlightDate,
      'to_flight_date': toFlightDate,
      'departure_loc': departureLoc,
      'arrival_loc': arrivalLoc,
    };
  }
}
