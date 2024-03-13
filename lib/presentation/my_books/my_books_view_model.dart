import 'package:flutter/cupertino.dart';
import 'package:griffin/domain/model/payment/payment_model.dart';

import '../../data/core/result.dart';
import '../../domain/model/books/books_model.dart';
import '../../domain/model/user/user_account_model.dart';
import '../../domain/use_cases/my_books/my_books_for_pay_use_case.dart';
import '../../domain/use_cases/payment/post_pay_data_use_case.dart';
import '../../domain/use_cases/splash/get_session_use_case.dart';
import '../../utils/simple_logger.dart';
import 'my_books_state.dart';

class MyBooksViewModel extends ChangeNotifier {
  final MyBooksForPayUseCase _myBooksUseCase;
  final GetSessionUseCase _getSessionUseCase;
  final PostPayDataUseCase _postPayDataUseCase;
  final List<PaymentModel> forPaymentList = [];
  final List<PaymentModel> forRefundList = [];

  MyBooksViewModel({
    required MyBooksForPayUseCase myBooksUseCase,
    required GetSessionUseCase getSessionUseCase,
    required PostPayDataUseCase postPayDataUseCase,
  })  : _myBooksUseCase = myBooksUseCase,
        _postPayDataUseCase = postPayDataUseCase,
        _getSessionUseCase = getSessionUseCase {
    fetchData();
  }

  MyBooksState _state = const MyBooksState();

  MyBooksState get state => _state;

  Future<void> getSession() async {
    final result = await _getSessionUseCase.execute();
    switch (result) {
      case Success<UserAccountModel>():
        _state = state.copyWith(userAccountModel: result.data);
        notifyListeners();
        break;
      case Error<UserAccountModel>():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }

  Future<void> fetchData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await getSession();
      if (_state.userAccountModel != null) {
        final userId = _state.userAccountModel!.userId;
        final result = await _myBooksUseCase.execute(userId);
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
      }
    } catch (error) {
      // 에러 처리
      logger.info('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> postRefundedItems(List<PaymentModel> forRefundList) async {
    List<BooksModel> refundedList = [];
    for (var bookItem in forRefundList) {
      BooksModel postItem = BooksModel(
          bookId: bookItem.bookId,
          payStatus: 0,
);
      refundedList.add(postItem);
    }
    logger.info(refundedList);
    await _postPayDataUseCase.execute(data: refundedList);
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

  void forRefundCheckBoxTap(PaymentModel targetBookItem) {
    if (forRefundList.contains(targetBookItem)) {
      forRefundList.remove(targetBookItem);
      notifyListeners();
    } else {
      forRefundList.add(targetBookItem);
    }
    notifyListeners();
  }
}
