import 'package:flutter/material.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/use_cases/airport/airport_list_use_case.dart';
import 'package:griffin/domain/use_cases/splash/get_session_use_case.dart';
import 'package:griffin/presentation/search/search_state.dart';
import 'package:griffin/utils/simple_logger.dart';

class SearchViewModel with ChangeNotifier {
  SearchViewModel({
    required GetSessionUseCase getSessionUseCase,
    required AirportListUseCase airportListUseCase,
  })  : _getSessionUseCase = getSessionUseCase,
        _airportListUseCase = airportListUseCase;
  final GetSessionUseCase _getSessionUseCase;
  final AirportListUseCase _airportListUseCase;

  SearchState _state = SearchState();
  SearchState get state => _state;
//좌석 등급 리스트

  void init() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    // session 가져오기
    await getSession();

    // airport 가져오기
    await getAirportList();

    setClassList();

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

  Future<void> getAirportList() async {
    final result = await _airportListUseCase.execute();
    switch (result) {
      case Success<List<AirportModel>>():
        _state = state.copyWith(airportList: result.data);
        break;
      case Error<List<AirportModel>>():
        logger.info('error => ${result.message}');
        break;
    }
  }

  // currentPersonValue decreasePerson
  void decreasePerson() {
    int currentPersonValue = state.currentPersonValue;
    if (currentPersonValue > 1) {
      _state = state.copyWith(currentPersonValue: currentPersonValue - 1);
      notifyListeners();
    }
  }

  // currentPersonValue increasePerson
  void increasePerson() {
    int currentPersonValue = state.currentPersonValue;
    if (currentPersonValue < 8) {
      _state = state.copyWith(currentPersonValue: currentPersonValue + 1);
      notifyListeners();
    }
  }

  void setClassList() {
    _state =
        state.copyWith(selectedClassList: ['Economy', 'Business', 'First']);
    notifyListeners();
  }

  void onChangeClass(String selectClass) {
    _state = state.copyWith(selectClass: selectClass);
    notifyListeners();
  }

  void onTapDirect() {
    _state = state.copyWith(isSelected: !state.isSelected);
    notifyListeners();
  }

  void saveTravelDate(DateTime dateTime) {
    _state = state.copyWith(travelDate: formatDate(dateTime));
    notifyListeners();
  }

  void saveReturnDate(DateTime dateTime) {
    _state = state.copyWith(returnDate: formatDate(dateTime));
    notifyListeners();
  }

  String formatDate(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return '$year$month$day';
  }

  void saveFromAirport(int airportId) {
    _state = state.copyWith(fromAirportId: airportId);
    notifyListeners();
  }

  void saveToAirport(int airportId) {
    _state = state.copyWith(toAirportId: airportId);
    notifyListeners();
  }
}
