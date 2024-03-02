import '../../data/core/result.dart';
import '../model/payment_model.dart';

abstract interface class PaymentRepository {
  Future<Result<List<PaymentModel>>> getPaymentDataApi();
}