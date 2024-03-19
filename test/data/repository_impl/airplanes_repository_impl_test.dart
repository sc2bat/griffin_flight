import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/repositories/airplanes_repository_impl.dart';
import 'package:griffin/domain/model/airplanes/airplanes_model.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('airplanes repository impl get airplanes dto test', () async {
    AirplanesRepositoryImpl airplanesRepositoryImpl = AirplanesRepositoryImpl();

    final Result<List<AirplanesModel>> result = await airplanesRepositoryImpl.getAirplanesData(12);

    if (result is Success<List<AirplanesModel>>) {
      for (var airplaneModel in result.data) {
        logger.info('Success: $airplaneModel');
      }
    } else if (result is Error<List<AirplanesModel>>) {
      logger.info('Error: ${result.message}');
    }
  });
}
