import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/env/env.dart';

void main() {
  test('env test url testing', () {
    expect(Env.testApiUrl, 'https://www.naver.com/');
  });
}
