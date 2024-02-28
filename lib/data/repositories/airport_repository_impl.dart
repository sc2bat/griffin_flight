import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/airport_api.dart';
import 'package:griffin/data/data_sources/apis/sample_api.dart';
import 'package:griffin/data/mappers/airport_mapper.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';

class AirportRepositoryImpl implements AirportRepository {
  @override
  Future<Result<List<AirportModel>>> getAirportDataApi(String airportName) async {
    final result = await AirportApi().getAirportApi();

    return result.when(
      success: (data) {
        try {
          List<AirportModel> airportModelList =
              data.map((e) => AirportMapper.fromDTO(e)).toList();

          return Result.success(airportModelList);
        } catch (e) {
          return Result.error('airportRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
