import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';

abstract interface class SampleRepository {
  Future<Result<List<AirportModel>>> getSampleDataApi();
}
