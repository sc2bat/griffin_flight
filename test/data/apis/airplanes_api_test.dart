import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/airplanes_api.dart';
import 'package:griffin/data/dtos/airplanes_dto.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('airplanes api test', () async {
    Result<List<AirplanesDTO>> airplanesDataResult =
    await AirplanesApi().getAirplanesData();

    airplanesDataResult.when(
      success: (data) {
        // logger.info(data.length);
        expect(data.length, 7);
      },
      error: (message) {
        logger.info(message);
      },
    );
  });
}
