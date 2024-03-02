import 'package:flutter/cupertino.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:griffin/presentation/mybooks/my_books_state.dart';

import '../../data/core/result.dart';

class MyBooksViewModel extends ChangeNotifier {
  final PaymentRepository paymentRepository;
  final List<PaymentModel> forPaymentList = [];

  MyBooksViewModel({
    required this.paymentRepository,
  }) {
    fetchData();
  }

  MyBooksState _state = const MyBooksState();

  MyBooksState get state => _state;

  Future<void> fetchData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final result = await paymentRepository.getPaymentDataApi();
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
