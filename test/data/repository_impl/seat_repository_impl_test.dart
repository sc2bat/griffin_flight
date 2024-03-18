import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/data/repositories/payment_repository_impl.dart';

void main() {
  test('seat repository impl post book dto test', () async {
    PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl();
    BooksDTO booksDTO = BooksDTO(
      bookId: 90,
      classSeat: 'A2',
      status: 1,
      payAmount: 20,
      payStatus: 0,
      isDeleted: 0,
    );

    await paymentRepositoryImpl.postPaymentData([booksDTO]);
  });
}
