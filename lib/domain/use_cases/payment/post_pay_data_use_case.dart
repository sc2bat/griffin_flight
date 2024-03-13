import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/data/mappers/books_mapper.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';

class PostPayDataUseCase {
  PostPayDataUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  Future<void> execute({
    required List<BooksModel> data,
  }) async {
    List<BooksDTO> result = data.map((e) => BooksMapper.toDTO(e)).toList();
    _paymentRepository.postPaymentData(result);
  }
}
