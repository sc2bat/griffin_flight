import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/repositories/airport_repository_impl.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('airport repository get airport dto test', () async {
    AirportRepositoryImpl airportRepository = AirportRepositoryImpl();
    final result = await airportRepository.getAirportListData();
    List<AirportDTO> airportList = [];
    switch (result) {
      case Success<List<AirportDTO>>():
        airportList = result.data;
        break;
      case Error<List<AirportDTO>>():
        logger.info(result.message);
        break;
    }
    logger.info(airportList[0].airportId);
  });
}
