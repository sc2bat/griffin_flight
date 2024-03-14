import 'package:griffin/domain/repositories/flight_repository.dart';

class SaveNumberOfPeopleUseCase {
  SaveNumberOfPeopleUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;

  Future<void> execute(int numberOfPeople) async {
    await _flightRepository.saveNumberOfPeople(numberOfPeople);
  }
}
