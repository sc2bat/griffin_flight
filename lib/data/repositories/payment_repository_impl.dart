import 'dart:convert';

import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:http/http.dart' as http;

import '../../env/env.dart';
import '../../utils/simple_logger.dart';
import '../dtos/books_dto.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<void> postPaymentData(List<BooksDTO> data) async {
    logger.info(Env.griffinPostUrl);

    final url = Uri.parse('${Env.griffinGetUrl}/books/update/');
    logger.info(url);
    for (var item in data) {
      String jsonData = jsonEncode(item);

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
        } else {
          logger.info('response.statusCode => ${response.statusCode}');
          logger.info(response.body);
        }
      } catch (e) {
        logger.info('error => $e');
        throw Exception(e);
      }
    }

  }
}
