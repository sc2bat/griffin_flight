import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';

class SearchFlightUseCase {
  SearchFlightUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;

  Future<Result<Map<String, dynamic>>> execute(int fromAirportId,
      int toAirportId, String travelDate, String returnDate) async {
    final searchDTO = SearchDTO(
      fromFlightDate: travelDate,
      toFlightDate: returnDate,
      departureLoc: fromAirportId,
      arrivalLoc: toAirportId,
    );

    final result = await _flightRepository.searchFlightResult(searchDTO);
    switch (result) {
      case Success<Map<String, dynamic>>():
        return Result.success(result.data);
      case Error<Map<String, dynamic>>():
        return Result.error(result.message);
    }
    return const Result.error('SearchFlightUseCase execute error');
  }
}
