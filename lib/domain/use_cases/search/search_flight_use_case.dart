import 'package:griffin/domain/repositories/flight_repository.dart';

class SearchFlightUseCase {
  SearchFlightUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;
}
