import 'package:griffin/domain/model/airport_model.dart';

import '../../data/core/result.dart';

abstract interface class AirportRepository {
  Future<Result<List<AirportModel>>> getAirportDataApi();
}