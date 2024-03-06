import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/domain/model/airport_model.dart';

class AirportMapper {
  static AirportDTO toDTO(AirportModel model) {
    return AirportDTO(
      airportId: model.airportId,
      airportCode: model.airportCode,
      airportName: model.airportName,
      latitude: model.latitude,
      longitude: model.longitude,
      country: model.country,
      isDeleted: model.isDeleted,
    );
  }

  static AirportModel fromDTO(AirportDTO dto) {
    return AirportModel(
      airportId: dto.airportId ?? 0,
      airportCode: dto.airportCode ?? '',
      airportName: dto.airportName ?? '',
      latitude: dto.latitude ?? 0.0,
      longitude: dto.longitude ?? 0.0,
      country: dto.country ?? '',
      isDeleted: dto.isDeleted ?? 0,
    );
  }
}
