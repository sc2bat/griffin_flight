import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/env/env.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:http/http.dart' as http;

void main() {
  test('get user Info by userId test', () async {
    int userId = int.parse(Env.sampleAccountUserid);
    const url = '${Env.griffinGetUrl}/users/';

    try {
      final response = await fetchHttpWithParam(url: url, paramData: {
        'user_id': userId,
      });
      logger.info('${response.statusCode}');
      logger.info(response.body);
    } catch (e) {
      logger.info('$e');
    }
  });
  test('user login test', () async {
    const url = '${Env.griffinAccountUrl}/login/';
    final formData = {
      'username': Env.sampleAccountUsername,
      'password': Env.sampleAccountPassword,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );
      logger.info('${response.statusCode}');
      logger.info(response.body);
    } catch (e) {
      logger.info('$e');
    }
  });
}
