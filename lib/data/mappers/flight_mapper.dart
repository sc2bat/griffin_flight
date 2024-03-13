import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/domain/model/flight/flight_model.dart';

class FlightMapper {
  static FlightModel fromDTO(FlightDTO dto) {
    return FlightModel(
      flightId: dto.flightId,
      airplaneId: dto.airplaneId ?? 0,
      flightDate: dto.flightDate ?? '',
      departureTime: dto.departureTime ?? '',
      arrivalTime: dto.arrivalTime ?? '',
      departureLoc: dto.departureLoc ?? 0,
      arrivalLoc: dto.arrivalLoc ?? 0,
    );
  }

  static FlightDTO toDTO(FlightModel model) {
    return FlightDTO(
      flightId: model.flightId,
      airplaneId: model.airplaneId,
      flightDate: model.flightDate,
      departureTime: model.departureTime,
      arrivalTime: model.arrivalTime,
      departureLoc: model.departureLoc,
      arrivalLoc: model.arrivalLoc,
    );
  }
}
