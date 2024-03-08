import '../../../data/core/result.dart';
import '../../model/payment_model.dart';
import '../../repositories/my_books_for_pay_repository.dart';

class MyBooksForPayUseCase {
  MyBooksForPayUseCase({
    required MyBooksForPayRepository myBooksForPayRepository,
  }) : _myBooksForPayRepository = myBooksForPayRepository;

  final MyBooksForPayRepository _myBooksForPayRepository;

  Future<Result<List<PaymentModel>>> execute() async {
    final result = await _myBooksForPayRepository.getMyBooksForPayDataApi();

    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }



}