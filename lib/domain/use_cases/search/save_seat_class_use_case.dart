import 'package:griffin/domain/repositories/flight_repository.dart';

class SaveSeatClassUseCase {
  SaveSeatClassUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;

  Future<void> execute(String seatClass) async {
    await _flightRepository.saveSeatClass(seatClass);
  }
}
