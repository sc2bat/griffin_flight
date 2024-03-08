import 'package:griffin/domain/model/payment/payment_model.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

import '../../../data/core/result.dart';
import '../../repositories/my_books_for_pay_repository.dart';

class MyBooksForPayUseCase {
  MyBooksForPayUseCase({
    required MyBooksForPayRepository myBooksForPayRepository,
  }) : _myBooksForPayRepository = myBooksForPayRepository;

  final MyBooksForPayRepository _myBooksForPayRepository;

  Future<Result<List<PaymentModel>>> execute(int userId) async {
    final result = await _myBooksForPayRepository.getMyBooksForPayDataApi(userId);

    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
