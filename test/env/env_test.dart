import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/env/env.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('env test url testing', () {
    logger.info(Env.griffinAccountUrl);
  });
  test('env test url testing', () {
    expect(Env.testApiUrl, 'https://www.naver.com/');
  });
}
