import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/data/mappers/flight_mapper.dart';
import 'package:griffin/data/repositories/flight_repository_impl.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  final FlightRepositoryImpl flightRepository = FlightRepositoryImpl();
  test('flight search result testing', () async {
    SearchDTO searchDTO = SearchDTO(
      fromFlightDate: '20240304',
      toFlightDate: '20240412',
      departureLoc: 5653,
      arrivalLoc: 3873,
    );

    final result = await flightRepository.searchFlightResult(searchDTO);
    result.when(
      success: (data) {
        logger.info(data);
        if (data.containsKey('from_flight_result')) {
          final flights = (data['from_flight_result'] as List<dynamic>)
              .map((e) => FlightMapper.fromDTO(e))
              .toList();
          logger.info(flights);
        }
        if (data.containsKey('to_flight_result')) {
          final flights = (data['to_flight_result'] as List<dynamic>)
              .map((e) => FlightMapper.fromDTO(e))
              .toList();
          logger.info(flights);
        }
      },
      error: (error) => logger.info(error),
    );
  });
}
