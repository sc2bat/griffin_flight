import '../../../data/core/result.dart';
import '../../model/payment/payment_model.dart';
import '../../repositories/my_books_repository.dart';

class MyBooksUseCase {
  MyBooksUseCase({
    required MyBooksRepository myBooksRepository,
  }) : _myBooksRepository = myBooksRepository;

  final MyBooksRepository _myBooksRepository;

  Future<Result<List<PaymentModel>>> execute() async {
    final result = await _myBooksRepository.getMyBooksDataApi();

    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }



}