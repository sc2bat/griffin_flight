import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/airport_model.dart';

abstract interface class SampleRepository {
  Future<Result<List<AirportModel>>> getSampleDataApi();
}
