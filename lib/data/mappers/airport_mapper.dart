import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/domain/model/airport_model.dart';

class AirportMapper {
  static AirportModel fromDTO(AirportDTO dto) {
    return AirportModel(
      airportId: dto.id,
      airportCode: dto.ident ?? 'none',
      airportName: dto.name ?? 'none',
      latitude: dto.latitudeDeg != null ? double.parse(dto.latitudeDeg!) : 0,
      longitude: dto.longitudeDeg != null ? double.parse(dto.longitudeDeg!) : 0,
      country: dto.isoCountry,
      createdAt: null,
      isDeleted: false,
    );
  }

  static AirportDTO toDTO(AirportModel model) {
    return AirportDTO(
      id: model.airportId,
      ident: model.airportCode,
      name: model.airportName,
      latitudeDeg: model.latitude?.toString(),
      longitudeDeg: model.longitude?.toString(),
      isoCountry: model.country,
    );
  }
}
