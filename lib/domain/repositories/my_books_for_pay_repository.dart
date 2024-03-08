import '../../data/core/result.dart';
import '../model/payment_model.dart';

abstract interface class MyBooksForPayRepository {
  Future<Result<List<PaymentModel>>> getMyBooksForPayDataApi();
}