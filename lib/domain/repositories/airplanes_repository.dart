import '../../data/core/result.dart';
import '../model/airplanes/airplanes_model.dart';

abstract interface class AirplanesRepository {
  Future<Result<List<AirplanesModel>>> getAirplanesData(int airplaneId);
}
