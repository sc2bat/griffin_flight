import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/flight_api.dart';
import 'package:griffin/data/mappers/flight_mapper.dart';
import 'package:griffin/domain/model/flights_model.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';

class FlightRepositoryImpl implements FlightRepository {
  @override
  Future<Result<List<FlightsModel>>> getFlightDataApi() async {
    final result = await FlightApi().getFlightData();

    return result.when(
      success: (data) {
        try {
          List<FlightsModel> flightModelList =
              data.map((e) => FlightMapper.fromDTO(e)).toList();
          return Result.success(flightModelList);
        } catch (e) {
          return Result.error('FlightRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
