import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/presentation/common/common.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('AirportDistanceCalculator test', () {
    double distance = calculateDistance(
        lat1: 63.985, lon1: -22.6056, lat2: 37.4691, lon2: 126.451);

    logger.info(distance); // 8410.032630632031
  });

  test('calculatePrice test', () {
    double price = calculatePrice(
        distance: 8410.032630632031,
        flightDate: '20240301',
        arrivalTime: '11:30');

    logger.info(price);
  });
}
