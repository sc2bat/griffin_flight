import 'package:griffin/data/data_sources/apis/airplanes_api.dart';
import 'package:griffin/data/mappers/airplanes_mapper.dart';
import 'package:griffin/domain/repositories/airplanes_repository.dart';

import '../../domain/model/airplanes/airplanes_model.dart';
import '../core/result.dart';

class AirplanesRepositoryImpl implements AirplanesRepository {
  @override
  Future<Result<List<AirplanesModel>>> getAirplanesData(int airplaneId) async {
    final result = await AirplanesApi().getAirplanesData();

    return result.when(
      success: (data) {
        try {
          List<AirplanesModel> airplanesModelList =
              data.map((e) => AirplanesMapper.fromDTO(e)).toList();
          return Result.success(airplanesModelList);
        } catch (e) {
          return Result.error('AirplanesRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
