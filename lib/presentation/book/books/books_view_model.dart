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
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    await getSession();

    await getFligthResultDate();

    _state = state.copyWith(isLoading: false);
    notifyListeners();
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

  Future<void> getFligthResultDate() async {
    FlightResultModel departureFlightResultModel =
        await _getFromFlightUseCase.execute();
    FlightResultModel arrivalFlightResultModel =
        await _getToFlightUseCase.execute();
    String numberOfPeople = await _getNumberOfPeopleUseCase.execute();
    String seatClass = await _getSeatUseCase.execute();
    _state = state.copyWith(
        departureFlightResultModel: departureFlightResultModel,
        arrivalFlightResultModel: arrivalFlightResultModel,
        numberOfPeople: int.parse(numberOfPeople),
        seatClass: seatClass);
    notifyListeners();
  }

  //Post
  Future<void> postBookData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    List<BooksModel> departureBookList = [];
    List<BooksModel> arrivalBookList = [];
    if (state.userAccountModel != null &&
        state.departureFlightResultModel != null &&
        state.arrivalFlightResultModel != null) {
      for (var i = 0; i < state.numberOfPeople; i++) {
        final departureResult = await _booksUseCase.execute(
            userId: state.userAccountModel!.userId,
            flightId: state.departureFlightResultModel!.flightId,
            payAmount: state.departureFlightResultModel!.payAmount);
        switch (departureResult) {
          case Success<BooksModel>():
            departureBookList.add(departureResult.data);
          case Error<BooksModel>():
            throw Exception(departureResult.message);
        }
        final arrivalResult = await _booksUseCase.execute(
            userId: state.userAccountModel!.userId,
            flightId: state.arrivalFlightResultModel!.flightId,
            payAmount: state.arrivalFlightResultModel!.payAmount);
        switch (arrivalResult) {
          case Success<BooksModel>():
            arrivalBookList.add(arrivalResult.data);
          case Error<BooksModel>():
            throw Exception(arrivalResult.message);
        }
      }
    }
    _state = state.copyWith(
      departureBookList: departureBookList,
      arrivalBookList: arrivalBookList,
    );
    notifyListeners();
  }
}
