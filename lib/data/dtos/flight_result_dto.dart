class FlightResultDTO{
   int? flightId;
   int? airplaneId;
   String? flightDate;
   int? departureLoc;
   String? departureAirportCode;
   String? departureAirportName;
   int? arrivalLoc;
   String? arrivalAirportCode;
   String? arrivalAirportName;
   String? departureTime;
   String? arrivalTime;
   String? classLevel;
   double? payAmount;

  FlightResultDTO({
    this.flightId,
    this.airplaneId,
    this.flightDate,
    this.departureLoc,
    this.departureAirportCode,
    this.departureAirportName,
    this.arrivalLoc,
    this.arrivalAirportCode,
    this.arrivalAirportName,
    this.departureTime,
    this.arrivalTime,
    this.classLevel,
    this.payAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'flightId': flightId,
      'airplaneId': airplaneId,
      'flightDate': flightDate,
      'departureLoc': departureLoc,
      'departureAirportCode': departureAirportCode,
      'departureAirportName': departureAirportName,
      'arrivalLoc': arrivalLoc,
      'arrivalAirportCode': arrivalAirportCode,
      'arrivalAirportName': arrivalAirportName,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'classLevel': classLevel,
      'payAmount': payAmount,
    };
  }

  factory FlightResultDTO.fromMap(Map<String, dynamic> json) {
    return FlightResultDTO(
      flightId: json['flightId'] ?? '',
      airplaneId: json['airplaneId'] ?? '',
      flightDate: json['flightDate'] ?? '',
      departureLoc: json['departureLoc'] ?? '',
      departureAirportCode: json['departureAirportCode'] ?? '',
      departureAirportName: json['departureAirportName'] ?? '',
      arrivalLoc: json['arrivalLoc'] ?? '',
      arrivalAirportCode: json['arrivalAirportCode'] ?? '',
      arrivalAirportName: json['arrivalAirportName'] ?? '',
      departureTime: json['departureTime'] ?? '',
      arrivalTime: json['arrivalTime'] ?? '',
      classLevel: json['classLevel'] ?? '',
      payAmount: json['payAmount'] ?? '',
    );
  }
}