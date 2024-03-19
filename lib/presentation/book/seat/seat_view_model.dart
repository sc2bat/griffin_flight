import 'dart:async';
import 'package:flutter/material.dart';
import 'package:griffin/domain/model/airplanes/airplanes_model.dart';
import 'package:griffin/domain/use_cases/airplanes/airplanes_use_case.dart';
import 'package:griffin/presentation/book/seat/seat_state.dart';
import '../../../data/core/result.dart';
import '../../../data/dtos/books_dto.dart';
import '../../../domain/model/books/books_model.dart';
import '../../../domain/model/flight_result/flight_result_model.dart';
import '../../../domain/model/user/user_account_model.dart';
import '../../../domain/use_cases/seat/seat_use_case.dart';
import '../../../domain/use_cases/splash/get_session_use_case.dart';
import '../../../utils/simple_logger.dart';

class SeatViewModel extends ChangeNotifier {
  final GetSessionUseCase _getSessionUseCase;
  final SeatUseCase _seatUseCase;
  final AirplanesUseCase _airplanesUseCase;
  int? selectedSeatIndex;

  SeatViewModel({
    required GetSessionUseCase getSessionUseCase,
    required SeatUseCase seatUseCase,
    required AirplanesUseCase airplanesUseCase,
  })  : _getSessionUseCase = getSessionUseCase,
        _seatUseCase = seatUseCase,
        _airplanesUseCase = airplanesUseCase;

  SeatState _state = SeatState();

  SeatState get state => _state;

  void init(List<BooksModel> departureBookList,
      List<BooksModel> arrivalBookList) async {
    await getSession();

    setBookList(departureBookList, arrivalBookList);

    setTotalFare();

    setNumberOfPeople();

    // getAirplaneData(fligtsModel);
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

  //Get Airplane data
  Future<void> getAirplaneData(FlightResultModel flightsModel) async {
    int airplaneId = flightsModel.airplaneId;
    List<AirplanesModel> airplanesModel =
        await _airplanesUseCase.execute(airplaneId);
    _state = state.copyWith(airplanesModel: airplanesModel);
    notifyListeners();
  }

  //Update book data
  Future<List<BooksModel>> updateBookData() async {
    if (state.userAccountModel != null && state.booksDTOList.isNotEmpty) {
      logger.info(state.booksDTOList.length);
      final result = await _seatUseCase.execute(state.booksDTOList);
      switch (result) {
        case Success<List<BooksModel>>():
          logger.info(result.data);
          return result.data;
        case Error<List<BooksModel>>():
          throw Exception(result.message);
      }
    }

    return [];
  }

//save seat
  void saveSeat(BooksDTO booksDTO) {
    List<BooksDTO> booksDTOList = List.from(state.booksDTOList);
    booksDTOList.add(booksDTO);
    _state = state.copyWith(booksDTOList: booksDTOList);
    notifyListeners();
  }

  // total fare 계산
  void setTotalFare() {
    double totalFare = 0.0;
    for (var item in state.departureBookList) {
      totalFare += item.payAmount ?? 0.0;
    }
    for (var item in state.arrivalBookList) {
      totalFare += item.payAmount ?? 0.0;
    }
    _state = state.copyWith(totalFare: totalFare);
    notifyListeners();
  }

  void setBookList(
      List<BooksModel> departureBookList, List<BooksModel> arrivalBookList) {
    _state = state.copyWith(
      departureBookList: departureBookList,
      arrivalBookList: arrivalBookList,
    );
    notifyListeners();
  }

  //인원
  void setNumberOfPeople() {
    _state = state.copyWith(numberOfPeople: state.departureBookList.length);
    notifyListeners();
  }

  //좌석 선택
  void selectSeat(String seat, bool isDeparture) {
    List<String> selectedSeats = isDeparture
        ? _state.departureSelectedSeats
        : _state.arrivalSelectedSeats;
    if (!selectedSeats.contains(seat) &&
        selectedSeats.length < state.departureBookList.length) {
      _state = isDeparture
          ? _state.copyWith(
              departureSelectedSeats: List.from(selectedSeats)..add(seat),
            )
          : _state.copyWith(
              arrivalSelectedSeats: List.from(selectedSeats)..add(seat),
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
      if (_state.arrivalSelectedSeats.contains(seat)) {
        _state = _state.copyWith(
          arrivalSelectedSeats: List.from(_state.arrivalSelectedSeats)
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
        : _state.arrivalSelectedSeats;
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

    double updatedTotalFare = state.totalFare;
    if (isSelected) {
      updatedTotalFare += fareChange;
    } else {
      updatedTotalFare -= fareChange;
    }

    _state = _state.copyWith(totalFare: updatedTotalFare);
    notifyListeners();
  }
}
