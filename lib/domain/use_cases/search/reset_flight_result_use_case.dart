import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';

class ResetFlightResultUseCase {
  ResetFlightResultUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;
  Future<Result<void>> execute() async {
    final result = await _flightRepository.resetSearchResult();
    switch (result) {
      case Success<Result<void>>():
        return const Result.success(null);
      case Error<Result<void>>():
        return Result.error(result.message);
    }
    return const Result.error('ResetFlightResultUseCase error');
  }
}
