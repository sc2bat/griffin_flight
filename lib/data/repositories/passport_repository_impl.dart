import 'dart:convert';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/passport_dto.dart';
import 'package:griffin/domain/repositories/passport_repository.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../../utils/simple_logger.dart';

class PassportRepositoryImpl implements PassportRepository {
  @override
  Future<Result<PassportDTO>> insertPassport(PassportDTO passport) async {
    logger.info(Env.griffinPostUrl);

    final url = Uri.parse('${Env.griffinGetUrl}/passports/');
    logger.info(url);
    String jsonData = jsonEncode(passport);

    logger.info(jsonData);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        logger.info('statusCode == 201');
        logger.info(response.body);
        final jsonString = jsonDecode(response.body);
        return Result.success(PassportDTO.fromJson(jsonString));
      } else {
        logger.info('response.statusCode => ${response.statusCode}');
        logger.info(response.body);
        return Result.error('response.statusCode => ${response.statusCode}');
      }
    } catch (e) {
      logger.info('error => $e');
      return Result.error('error => $e');
    }
  }
}
