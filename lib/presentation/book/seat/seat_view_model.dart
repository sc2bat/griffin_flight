import 'dart:async';

import 'package:flutter/material.dart';
import 'package:griffin/presentation/book/seat/seat_state.dart';

import '../../../data/core/result.dart';
import '../../../domain/model/books/books_model.dart';
import '../../../domain/model/user/user_account_model.dart';
import '../../../domain/use_cases/seat/seat_use_case.dart';
import '../../../domain/use_cases/splash/get_session_use_case.dart';
import '../../../utils/simple_logger.dart';

class SeatViewModel extends ChangeNotifier {
  final GetSessionUseCase _getSessionUseCase;
  final SeatUseCase _seatUseCase;
  int? selectedSeatIndex;

  SeatViewModel(
      {required GetSessionUseCase getSessionUseCase,
      required SeatUseCase seatUseCase})
      : _getSessionUseCase = getSessionUseCase,
        _seatUseCase = seatUseCase;

  SeatState _state = SeatState();

  SeatState get state => _state;

  void init() async {
    // _state = _state.copyWith(totalFare: totalFare);
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
            isDeleted: 0);
      }
    }
  }

  //좌석 선택
  void selectSeat(String seat, int bookIdListLength, bool isDeparture) {
    List<String> selectedSeats = isDeparture
        ? _state.departureSelectedSeats
        : _state.returnSelectedSeats;
    if (!selectedSeats.contains(seat) &&
        selectedSeats.length < bookIdListLength ~/ 2) {
      _state = isDeparture
          ? _state.copyWith(
              departureSelectedSeats: List.from(selectedSeats)..add(seat),
            )
          : _state.copyWith(
              returnSelectedSeats: List.from(selectedSeats)..add(seat),
            );
      notifyListeners();
    }
  }

  //좌석 선택 해제
  void removeSeat(String seat, bool isDeparture) {
    if (isDeparture) {
      if (_state.departureSelectedSeats.contains(seat)) {
        _state = _state.copyWith(
          departureSelectedSeats: List.from(_state.departureSelectedSeats)
            ..remove(seat),
        );
      }
    } else {
      if (_state.returnSelectedSeats.contains(seat)) {
        _state = _state.copyWith(
          returnSelectedSeats: List.from(_state.returnSelectedSeats)
            ..remove(seat),
        );
      }
    }
    notifyListeners();
  }

  //좌석 선택 여부 확인
  bool isSeatSelected(String seat, bool isDeparture) {
    List<String> selectedSeats = isDeparture
        ? _state.departureSelectedSeats
        : _state.returnSelectedSeats;
    return selectedSeats.contains(seat);
  }

  //좌석 추가 금액
  void updateFare(int index, bool isSelected) {
    int fareChange = 0;
    int rowNumber = (index / 7).floor() + 1;
    if (rowNumber < 3) {
      fareChange = 100;
    } else if (rowNumber < 5) {
      fareChange = 50;
    }

    int updatedTotalFare = state.totalFare;
    if (isSelected) {
      updatedTotalFare += fareChange;
    } else {
      updatedTotalFare -= fareChange;
    }

    _state = _state.copyWith(totalFare: updatedTotalFare);
    notifyListeners();
  }
}
