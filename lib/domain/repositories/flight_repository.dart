import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/domain/model/flight/flight_model.dart';

import '../../data/core/result.dart';

abstract interface class FlightRepository {
  Future<Result<List<FlightModel>>> getFlightDataApi();
  Future<Result<Map<String, List<FlightDTO>>>> searchFlightResult(
      SearchDTO searchDTO);
}
