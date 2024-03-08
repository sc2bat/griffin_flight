import 'package:griffin/domain/model/payment/payment_model.dart';

import '../../data/core/result.dart';

abstract interface class MyBooksForPayRepository {
  Future<Result<List<PaymentModel>>> getMyBooksForPayDataApi(int userId);
}
