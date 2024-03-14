import 'package:flutter/cupertino.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/domain/use_cases/books/get_from_flight_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_number_of_people_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_seat_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_to_flight_use_case.dart';
import 'package:griffin/presentation/book/books/books_state.dart';

import '../../../data/core/result.dart';
import '../../../domain/model/flight_result/flight_result_model.dart';
import '../../../domain/model/user/user_account_model.dart';
import '../../../domain/use_cases/books/books_use_case.dart';
import '../../../domain/use_cases/splash/get_session_use_case.dart';
import '../../../utils/simple_logger.dart';

class BooksViewModel with ChangeNotifier {
  BooksViewModel({
    required GetSessionUseCase getSessionUseCase,
    required BooksUseCase booksUseCase,
    required GetFromFlightUseCase getFromFlightUseCase,
    required GetToFlightUseCase getToFlightUseCase,
    required GetNumberOfPeopleUseCase getNumberOfPeopleUseCase,
    required GetSeatUseCase getSeatUseCase,
  })  : _getSessionUseCase = getSessionUseCase,
        _booksUseCase = booksUseCase,
        _getFromFlightUseCase = getFromFlightUseCase,
        _getToFlightUseCase = getToFlightUseCase,
        _getNumberOfPeopleUseCase = getNumberOfPeopleUseCase,
        _getSeatUseCase = getSeatUseCase;

  final GetSessionUseCase _getSessionUseCase;
  final BooksUseCase _booksUseCase;
  final GetFromFlightUseCase _getFromFlightUseCase;
  final GetToFlightUseCase _getToFlightUseCase;
  final GetNumberOfPeopleUseCase _getNumberOfPeopleUseCase;
  final GetSeatUseCase _getSeatUseCase;

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

  Future<void> getFligthResultDate() async {}

  //Post
  Future<List<BooksModel>> postBookData(
      List<FlightResultModel> flightResultModelList) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    List<BooksModel> bookIdList = [];
    if (state.userAccountModel != null && flightResultModelList.isNotEmpty) {
      for (var item in flightResultModelList) {
        final result = await _booksUseCase.execute(
            userId: state.userAccountModel!.userId,
            flightId: item.flightId,
            payAmount: item.payAmount);
        switch (result) {
          case Success<BooksModel>():
            bookIdList.add(result.data);
          case Error<BooksModel>():
            throw Exception(result.message);
        }
      }
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
    return bookIdList;
  }
}
