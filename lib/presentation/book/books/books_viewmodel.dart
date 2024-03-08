import 'package:flutter/foundation.dart';
import 'package:griffin/presentation/book/books/books_state.dart';
import '../../../data/core/result.dart';
import '../../../domain/model/user/user_account_model.dart';
import '../../../domain/use_cases/books/books_use_case.dart';
import '../../../domain/use_cases/splash/get_session_use_case.dart';
import '../../../utils/simple_logger.dart';

class BooksViewModel with ChangeNotifier {
  BooksViewModel(
      {required GetSessionUseCase getSessionUseCase,
      required BooksUseCase booksUseCase})
      : _getSessionUseCase = getSessionUseCase,
        _booksUseCase = booksUseCase;

  final GetSessionUseCase _getSessionUseCase;
  final BooksUseCase _booksUseCase;

  BooksState _state = BooksState();
  BooksState get state => _state;


  void init() async {
    await getSession();
  }



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
}
