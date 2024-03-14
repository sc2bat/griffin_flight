import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/utils/simple_logger.dart';

class SaveFlightResultUseCase {
  SaveFlightResultUseCase({
    required FlightRepository flightRepository,
  }) : _flightRepository = flightRepository;
  final FlightRepository _flightRepository;

  Future<void> execute(String key, FlightResultModel flightResultModel) async {
    final result =
        await _flightRepository.saveSearchResult(key, flightResultModel);
    result.when(
      success: (_) => logger.info('SaveFlightResultUseCase execute done'),
      error: (message) => throw Exception(message),
    );
  }
}
