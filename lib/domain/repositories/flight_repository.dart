import '../../data/core/result.dart';
import '../model/flights/flights_model.dart';

abstract interface class FlightRepository {
  Future<Result<List<FlightsModel>>> getFlightDataApi();
}