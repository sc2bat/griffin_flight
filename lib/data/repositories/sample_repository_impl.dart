import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/sample_api.dart';
import 'package:griffin/data/mappers/airport_mapper.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';

class SampleRepositoryImpl implements SampleRepository {
  @override
  Future<Result<List<AirportModel>>> getSampleDataApi() async {
    final result = await SampleApi().getSampleAirportFromGit();

    return result.when(
      success: (data) {
        try {
          List<AirportModel> airportModelList =
              data.map((e) => AirportMapper.fromDTO(e)).toList();

          return Result.success(airportModelList);
        } catch (e) {
          return Result.error('SampleRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
