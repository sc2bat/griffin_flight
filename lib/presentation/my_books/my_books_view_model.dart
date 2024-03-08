import 'package:flutter/cupertino.dart';
import 'package:griffin/domain/model/payment/payment_model.dart';

import '../../data/core/result.dart';
import '../../domain/use_cases/my_books/my_books_use_case.dart';
import 'my_books_state.dart';

class MyBooksViewModel extends ChangeNotifier {
  final MyBooksUseCase _myBooksUseCase;
  final List<PaymentModel> forPaymentList = [];

  MyBooksViewModel({
    required MyBooksUseCase myBooksUseCase,
  }) : _myBooksUseCase = myBooksUseCase {
    fetchData();
  }

  MyBooksState _state = const MyBooksState();

  MyBooksState get state => _state;

  Future<void> fetchData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final result = await _myBooksUseCase.execute();
      switch (result) {
        case Success<List<PaymentModel>>():
          _state = state.copyWith(
            isLoading: false,
            myBooksList: result.data,
          );
        case Error<List<PaymentModel>>():
          _state = state.copyWith(
            isLoading: false,
          );
      }
      notifyListeners();
    } catch (error) {
      // 에러 처리
      debugPrint('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void forPaymentCheckBoxTap(PaymentModel targetBookItem) {
    if (forPaymentList.contains(targetBookItem)) {
      forPaymentList.remove(targetBookItem);
      notifyListeners();
    } else {
      forPaymentList.add(targetBookItem);
    }
    notifyListeners();
  }
}
