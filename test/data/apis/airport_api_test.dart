import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/sample_api.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('sample airport api testt', () async {
    Result<List<AirportDTO>> airportListResult =
        await SampleApi().getSampleAirportFromGit();

    airportListResult.when(
      success: (data) {
        // logger.info(data.length);
        expect(data.length, 401);
      },
      error: (message) {
        logger.info(message);
      },
    );
  });
}
