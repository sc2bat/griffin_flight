import 'package:griffin/data/core/result.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Result<Response>> fetchHttp(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Result.success(response);
    } else {
      return Result.error('response.statusCode => ${response.statusCode}');
    }
  } catch (e) {
    logger.info('http 통신 에러 => $e');
    throw Exception(e);
  }
}
