import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/domain/model/flights/flights_model.dart';

class FlightMapper {
  static FlightsModel fromDTO(FlightDTO dto) {
    return FlightsModel(
      flightId: dto.flightId,
      airplaneId: dto.airplaneId ?? 0,
      flightDate: dto.flightDate,
      departureTime: dto.departureTime,
      arrivalTime: dto.arrivalTime,
      departureLoc: dto.departureLoc,
      departureName: dto.departureName,
      arrivalLoc: dto.arrivalLoc,
      arrivalName: dto.arrivalName,
    );
  }

  static FlightsModel toDTO(FlightDTO model) {
    return FlightsModel(
      flightId: model.flightId,
      airplaneId: model.airplaneId ?? 0,
      flightDate: model.flightDate,
      departureTime: model.departureTime,
      arrivalTime: model.arrivalTime,
      departureLoc: model.departureLoc,
      departureName: model.departureName,
      arrivalLoc: model.arrivalLoc,
      arrivalName: model.arrivalName,
    );
  }


}