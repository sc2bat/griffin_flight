import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';


class SeatUseCase {
  SeatUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  Future<void> execute({
    required int bookId,
    required String classSeat,
    required int status,
    required double payAmount,
    required int payStatus,
    required int isDeleted,
  }) async {
    BooksDTO booksDTO = BooksDTO(
      bookId: bookId,
      classSeat: classSeat,
      status: status,
      payAmount: payAmount,
      payStatus: payStatus,
      isDeleted: 0,
    );

    await _paymentRepository.postPaymentData([booksDTO]);
  }
}
