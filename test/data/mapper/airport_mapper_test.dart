import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/mappers/airport_mapper.dart';
import 'package:griffin/domain/model/airport_model.dart';

void main() {
  test('airport dto to model mapper test', () {
    AirportModel airportModel = AirportMapper.fromDTO(airportDTO);

    expect(airportModel.airportId, '3');
  });
}

AirportDTO airportDTO = AirportDTO.fromJson({
  "id": "3",
  "ident": "AGGH",
  "type": "large_airport",
  "name": "Honiara International Airport",
  "latitude_deg": "-9.428",
  "longitude_deg": "160.054993",
  "elevation_ft": "28",
  "continent": "OC",
  "iso_country": "SB",
  "iso_region": "SB-CT",
  "municipality": "Honiara",
  "scheduled_service": "yes",
  "gps_code": "AGGH",
  "iata_code": "HIR",
  "local_code": "",
  "home_link": "",
  "wikipedia_link":
      "https://en.wikipedia.org/wiki/Honiara_International_Airport",
  "keywords": "Henderson Field"
});
