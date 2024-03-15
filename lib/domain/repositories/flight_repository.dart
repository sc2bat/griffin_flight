import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/domain/model/flight/flight_model.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';

import '../../data/core/result.dart';

abstract interface class FlightRepository {
  Future<Result<List<FlightModel>>> getFlightDataApi();
  Future<Result<Map<String, List<FlightDTO>>>> searchFlightResult(
      SearchDTO searchDTO);

  Future<Result<void>> resetSearchResult();
  Future<Result<void>> saveSearchResult(
      String key, FlightResultModel flightResultModel);
  Future<Result<FlightResultModel>> getSearchFlightResult(String key);
  Future<Result<void>> saveSeatClass(String seatClass);
  Future<Result<void>> saveNumberOfPeople(int numberOfPeople);
  Future<Result<String>> getSearchResultData(String key);
}
