import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/mappers/payment_data_mapper.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/domain/repositories/my_books_repository.dart';

import '../data_sources/apis/payment_api.dart';

class MyBooksRepositoryImpl implements MyBooksRepository{
  @override
  Future<Result<List<PaymentModel>>> getMyBooksDataApi() async {
    final result = await PaymentApi().getMyBooksDataFromGit();

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
