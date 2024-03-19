import 'package:griffin/domain/repositories/airplanes_repository.dart';
import '../../model/airplanes/airplanes_model.dart';

class AirplanesUseCase {
  AirplanesUseCase({
    required AirplanesRepository airplanesRepository,
  }) : _airplanesRepository = airplanesRepository;

  final AirplanesRepository _airplanesRepository;

  Future<List<AirplanesModel>> execute(int airplaneId) async {
    final result = await _airplanesRepository.getAirplanesData(airplaneId);

    return result.when(
      success: (data) => data,
      error: (message) => throw Exception(message),
    );
  }
}