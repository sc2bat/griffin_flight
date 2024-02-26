import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/flight_api.dart';
import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/data/repositories/flight_repository_impl.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('flight api test', () async {
    Result<List<FlightDTO>> flightListResult =
    await FlightApi().getFlightData();

    flightListResult.when(success: (data) {
      // logger.info('length: ${data.length}');
      expect(data.length, 108);
    },
      error: (message) {
        logger.info('error: $message');
      },
    );
  });

  test('get flight data api test', () async {
   Result<List> dataListResult =
    await FlightRepositoryImpl().getFlightDataApi();

    dataListResult.when(success: (data) {
      logger.info('length: ${data.length}');
      expect(data.length, 108);
    },
      error: (message) {
        logger.info('error: $message');
      },
    );
  });
}

