import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/data/mappers/airport_mapper.dart';
import 'package:griffin/data/mappers/flight_result_mapper.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/presentation/common/common.dart';

class SearchFlightUseCase {
  SearchFlightUseCase({
    required FlightRepository flightRepository,
    required AirportRepository airportRepository,
  })  : _flightRepository = flightRepository,
        _airportRepository = airportRepository;
  final FlightRepository _flightRepository;
  final AirportRepository _airportRepository;

  Future<Result<Map<String, dynamic>>> execute(int fromAirportId,
      int toAirportId, String travelDate, String returnDate) async {
    final searchDTO = SearchDTO(
      fromFlightDate: travelDate,
      toFlightDate: returnDate,
      departureLoc: fromAirportId,
      arrivalLoc: toAirportId,
    );
    AirportModel? fromAirportModel;
    AirportModel? toAirportModel;
    final fromAirportResult =
        await _airportRepository.getAirportOne(fromAirportId);
    final toAirportResult = await _airportRepository.getAirportOne(toAirportId);
    switch (fromAirportResult) {
      case Success<AirportDTO>():
        fromAirportModel = AirportMapper.fromDTO(fromAirportResult.data);
      case Error<AirportDTO>():
        return const Result.error('fromFlight getAirportOne error');
    }
    switch (toAirportResult) {
      case Success<AirportDTO>():
        toAirportModel = AirportMapper.fromDTO(toAirportResult.data);
      case Error<AirportDTO>():
        return const Result.error('toFlight getAirportOne error');
    }
    if (fromAirportModel != null && toAirportModel != null) {
      double distance = calculateDistance(
          lat1: fromAirportModel.latitude,
          lon1: fromAirportModel.longitude,
          lat2: toAirportModel.latitude,
          lon2: toAirportModel.longitude);
      final result = await _flightRepository.searchFlightResult(searchDTO);
      switch (result) {
        case Success<Map<String, List<FlightDTO>>>():
          if (result.data.containsKey('from_flight') &&
              result.data.containsKey('to_flight')) {
            final List<FlightResultModel> fromFlight = result
                .data['from_flight']!
                .map((e) => FlightResultMapper.fromDTO(e))
                .toList();
            final List<FlightResultModel> toFlight = result.data['to_flight']!
                .map((e) => FlightResultMapper.fromDTO(e))
                .toList();

            final fromFlightResult = fromFlight
                .map((e) => e.copyWith(
                      departureAirportCode: fromAirportModel!.airportCode,
                      departureAirportName: fromAirportModel.airportName,
                      arrivalAirportCode: toAirportModel!.airportCode,
                      arrivalAirportName: toAirportModel.airportName,
                      payAmount: calculatePrice(
                          distance: distance,
                          flightDate: e.flightDate,
                          arrivalTime: e.arrivalTime),
                    ))
                .toList();

            final toFlightResult = toFlight
                .map((e) => e.copyWith(
                      departureAirportCode: toAirportModel!.airportCode,
                      departureAirportName: toAirportModel.airportName,
                      arrivalAirportCode: fromAirportModel!.airportCode,
                      arrivalAirportName: fromAirportModel.airportName,
                      payAmount: calculatePrice(
                          distance: distance,
                          flightDate: e.flightDate,
                          arrivalTime: e.arrivalTime),
                    ))
                .toList();
            final Map<String, dynamic> flightResult = {
              'from_flight': fromFlightResult,
              'to_flight': toFlightResult,
            };
            return Result.success(flightResult);
          } else {
            return const Result.error('result.data.containsKey error');
          }
        case Error<Map<String, List<FlightDTO>>>():
          return Result.error(result.message);
      }
    } else {
      return const Result.error('SearchFlightUseCase getAirport null error');
    }

    return const Result.error('SearchFlightUseCase execute error');
  }
}
