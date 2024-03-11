import 'package:griffin/data/dtos/books_dto.dart';

import '../../data/core/result.dart';
import '../model/payment/payment_model.dart';

abstract interface class PaymentRepository {
  Future<Result<List<PaymentModel>>> getPaymentData(List<int> bookId);

  Future<void> postPaymentData(List<BooksDTO> data);
}
