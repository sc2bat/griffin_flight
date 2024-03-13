import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/payment/payment_model.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:http/http.dart' as http;

import '../../env/env.dart';
import '../../utils/simple_logger.dart';
import '../data_sources/apis/payment_api.dart';
import '../dtos/books_dto.dart';
import '../mappers/payment_data_mapper.dart';

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

  @override
  Future<Result<List<PaymentModel>>> getPaymentData(List<int> bookId) async{
    final result = await PaymentApi().getForDirectPayDataFromGit(bookId);

    return result.when(
      success: (data) {
        try {
          List<PaymentModel> paymentModelList =
          data.map((e) => PaymentDataMapper.fromDTO(e)).toList();

          return Result.success(paymentModelList);
        } catch (e) {
          return Result.error('paymentRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

}
