import 'package:griffin/domain/repositories/flight_repository.dart';

class GetSeatUseCase {
  GetSeatUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;

  Future<String> execute(List<String> seatNumberOfPeople) async {
    final seatResult =
        await _flightRepository.getSearchResultData('seat_class');

    return seatResult.when(
      success: (data) => data,
      error: (message) => throw Exception(message),
    );
  }
}
