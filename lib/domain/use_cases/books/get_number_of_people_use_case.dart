import 'package:griffin/domain/repositories/flight_repository.dart';

class GetNumberOfPeopleUseCase {
  GetNumberOfPeopleUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;

  Future<String> execute(List<String> seatNumberOfPeople) async {
    final numberOfPeopleResult =
        await _flightRepository.getSearchResultData('number_of_people');

    return numberOfPeopleResult.when(
      success: (data) => data,
      error: (message) => throw Exception(message),
    );
  }
}
