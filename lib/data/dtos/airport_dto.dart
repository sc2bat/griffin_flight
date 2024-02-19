class AirportDTO {
  final String id;
  final String? ident;
  final String? type;
  final String? name;
  final String? latitudeDeg;
  final String? longitudeDeg;
  final String? elevationFt;
  final String? continent;
  final String? isoCountry;
  final String? isoRegion;
  final String? municipality;
  final String? scheduledService;
  final String? gpsCode;
  final String? iataCode;
  final String? localCode;
  final String? homeLink;
  final String? wikipediaLink;
  final String? keywords;

  AirportDTO({
    required this.id,
    this.ident,
    this.type,
    this.name,
    this.latitudeDeg,
    this.longitudeDeg,
    this.elevationFt,
    this.continent,
    this.isoCountry,
    this.isoRegion,
    this.municipality,
    this.scheduledService,
    this.gpsCode,
    this.iataCode,
    this.localCode,
    this.homeLink,
    this.wikipediaLink,
    this.keywords,
  });

  factory AirportDTO.fromJson(Map<String, dynamic> json) {
    return AirportDTO(
      id: json['id'] ?? '',
      ident: json['ident'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      latitudeDeg: json['latitude_deg'] ?? '',
      longitudeDeg: json['longitude_deg'] ?? '',
      elevationFt: json['elevation_ft'] ?? '',
      continent: json['continent'] ?? '',
      isoCountry: json['iso_country'] ?? '',
      isoRegion: json['iso_region'] ?? '',
      municipality: json['municipality'] ?? '',
      scheduledService: json['scheduled_service'] ?? '',
      gpsCode: json['gps_code'] ?? '',
      iataCode: json['iata_code'] ?? '',
      localCode: json['local_code'] ?? '',
      homeLink: json['home_link'] ?? '',
      wikipediaLink: json['wikipedia_link'] ?? '',
      keywords: json['keywords'] ?? '',
    );
  }
}
