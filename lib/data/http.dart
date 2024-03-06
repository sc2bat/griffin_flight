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

Future<Response> fetchHttpWithParam(
    {required String url, required Map<String, dynamic> paramData}) async {
  try {
    Uri uri = Uri.parse(url);

    Map<String, dynamic> jsonResult = Map.fromEntries(paramData.entries
        .where((entry) => entry.value != null)
        .map((entry) => MapEntry(entry.key, entry.value.toString())));

    // logger.info('$jsonResult');

    final urlWithQuery = uri.replace(queryParameters: jsonResult);
    // logger.info(urlWithQuery);

    final response = await http.get(urlWithQuery);

    if (response.statusCode == 200) {
      return response;
    }
    throw Exception('erorr fetchHttp ${response.statusCode}');
  } catch (e) {
    logger.info('http 통신 에러 => $e');
    throw Exception(e);
  }
}
