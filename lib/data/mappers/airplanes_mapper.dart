import 'package:griffin/data/dtos/airplanes_dto.dart';
import 'package:griffin/domain/model/airplanes/airplanes_model.dart';

class AirplanesMapper {
  static AirplanesModel fromDTO(AirplanesDTO dto) {
    return AirplanesModel(
      airplaneId: dto.airplaneId ?? 0,
      firstClassSeat: dto.firstClassSeat ?? 0,
      businessClassSeat: dto.businessClassSeat ?? 0,
      economyClassSeat: dto.economyClassSeat ?? 0,
      isDeleted: dto.isDeleted ?? 0,
    );
  }

  static AirplanesDTO toDTO(AirplanesModel model) {
    return AirplanesDTO(
      airplaneId: model.airplaneId,
      firstClassSeat: model.firstClassSeat,
      businessClassSeat: model.businessClassSeat,
      economyClassSeat: model.economyClassSeat,
      isDeleted: model.isDeleted,
    );
  }
}
