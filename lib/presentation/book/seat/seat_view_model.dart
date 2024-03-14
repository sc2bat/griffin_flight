import 'dart:async';

import 'package:flutter/material.dart';
import 'package:griffin/presentation/book/seat/seat_state.dart';

import '../../../data/core/result.dart';
import '../../../data/dtos/books_dto.dart';
import '../../../domain/model/books/books_model.dart';
import '../../../domain/model/flight_result/flight_result_model.dart';
import '../../../domain/model/user/user_account_model.dart';
import '../../../domain/use_cases/payment/post_pay_data_use_case.dart';
import '../../../domain/use_cases/seat/seat_use_case.dart';
import '../../../domain/use_cases/splash/get_session_use_case.dart';
import '../../../utils/simple_logger.dart';

class SeatViewModel extends ChangeNotifier {
  final GetSessionUseCase _getSessionUseCase;
  final SeatUseCase _seatUseCase;
  int? selectedSeatIndex;

  SeatViewModel({required GetSessionUseCase getSessionUseCase,
    required SeatUseCase seatUseCase})
      : _getSessionUseCase = getSessionUseCase,
        _seatUseCase = seatUseCase;

  SeatState _state = SeatState();

  SeatState get state => _state;

  void init() async {
    await getSession();
  }

  //Get user ID
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

  //Post
  Future<void> updateBookData(List<BooksModel> booksModelList) async {
    if (state.userAccountModel != null && booksModelList.isNotEmpty) {
      for (var item in booksModelList) {
        await _seatUseCase.execute(
            payAmount: item.payAmount ?? 0.0,
            bookId: item.bookId,
            classSeat: item.classSeat ?? '',
            status: 1,
            payStatus: 0,
            isDeleted: 0
        );
      }
    }
  }

}

