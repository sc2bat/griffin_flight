class AirportDTO {
  final int? airportId;
  final String? airportCode;
  final String? airportName;
  final double? latitude;
  final double? longitude;
  final String? country;
  final DateTime? createdAt;
  final int? isDeleted;

  AirportDTO({
    this.airportId,
    this.airportCode,
    this.airportName,
    this.latitude,
    this.longitude,
    this.country,
    this.createdAt,
    this.isDeleted,
  });

  factory AirportDTO.fromJson(Map<String, dynamic> json) {
    return AirportDTO(
      airportId: json['airport_id'],
      airportCode: json['airport_code'],
      airportName: json['airport_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: json['country'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isDeleted: json['is_deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airport_id': airportId,
      'airport_code': airportCode,
      'airport_name': airportName,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'created_at': createdAt?.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }
}
