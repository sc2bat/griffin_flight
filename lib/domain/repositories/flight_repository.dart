import 'package:griffin/data/dtos/search_dto.dart';

import '../../data/core/result.dart';
import '../model/flights/flights_model.dart';

abstract interface class FlightRepository {
  Future<Result<List<FlightsModel>>> getFlightDataApi();
  Future<Result<Map<String, dynamic>>> searchFlightResult(SearchDTO searchDTO);
}
