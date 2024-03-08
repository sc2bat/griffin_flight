import 'package:griffin/data/dtos/books_dto.dart';

abstract interface class PaymentRepository {
  Future<void> postPaymentData(List<BooksDTO> data);
}
