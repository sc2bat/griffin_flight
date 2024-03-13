import '../../data/core/result.dart';
import '../model/payment/payment_model.dart';

abstract interface class MyBooksRepository {
  Future<Result<List<PaymentModel>>> getMyBooksDataApi();
}