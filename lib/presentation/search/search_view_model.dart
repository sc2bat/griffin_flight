import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/use_cases/airport/airport_list_use_case.dart';
import 'package:griffin/domain/use_cases/search/reset_flight_result_use_case.dart';
import 'package:griffin/domain/use_cases/search/save_number_of_people_use_case.dart';
import 'package:griffin/domain/use_cases/search/save_seat_class_use_case.dart';
import 'package:griffin/domain/use_cases/search/search_flight_use_case.dart';
import 'package:griffin/domain/use_cases/splash/get_session_use_case.dart';
import 'package:griffin/presentation/common/common.dart';
import 'package:griffin/presentation/search/search_state.dart';
import 'package:griffin/presentation/search/search_ui_event.dart';
import 'package:griffin/presentation/search/widget/airport_map_widget.dart';
import 'package:griffin/utils/simple_logger.dart';

class SearchViewModel with ChangeNotifier {
  SearchViewModel({
    required GetSessionUseCase getSessionUseCase,
    required AirportListUseCase airportListUseCase,
    required SearchFlightUseCase searchFlightUseCase,
    required ResetFlightResultUseCase resetFlightResultUseCase,
    required SaveSeatClassUseCase saveSeatClassUseCase,
    required SaveNumberOfPeopleUseCase saveNumberOfPeopleUseCase,
  })  : _getSessionUseCase = getSessionUseCase,
        _airportListUseCase = airportListUseCase,
        _searchFlightUseCase = searchFlightUseCase,
        _resetFlightResultUseCase = resetFlightResultUseCase,
        _saveSeatClassUseCase = saveSeatClassUseCase,
        _saveNumberOfPeopleUseCase = saveNumberOfPeopleUseCase;
  final GetSessionUseCase _getSessionUseCase;
  final AirportListUseCase _airportListUseCase;
  final SearchFlightUseCase _searchFlightUseCase;
  final ResetFlightResultUseCase _resetFlightResultUseCase;
  final SaveSeatClassUseCase _saveSeatClassUseCase;
  final SaveNumberOfPeopleUseCase _saveNumberOfPeopleUseCase;

  SearchState _state = SearchState();
  SearchState get state => _state;

  final _searchUiEventStreamController = StreamController<SearchUiEvent>();
  Stream<SearchUiEvent> get searchUiEventStreamController =>
      _searchUiEventStreamController.stream;

//좌석 등급 리스트

  void init() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    // session 가져오기
    await getSession();

    // airport 가져오기
    await getAirportList();

    // reset result
    await resetResult();

    setClassList();

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  StreamSubscription? setStream(BuildContext context) {
    return searchUiEventStreamController.listen((event) {
      switch (event) {
        case ShowSnackBar():
          showSnackBar(context, event.message);
        case ViewAirportMap():
          if (state.fromAirport != null && state.toAirport != null) {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog.fullscreen(
                  child: AirportMapWidget(
                    goResultFunction: (context) {
                      context.pop();
                      context.push(
                        '/search/result',
                        extra: {
                          'search_result': state.searchResult,
                        },
                      );
                    },
                    fromAirport: state.fromAirport!,
                    toAirport: state.toAirport!,
                    isFlightAvailable: isFlightAvailableValid(),
                  ),
                );
              },
            );
          } else {
            _searchUiEventStreamController.add(const SearchUiEvent.showSnackBar(
                'fromAirport || toAirport is Null!'));
          }
      }
    });
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

  void onChangeClass(String selectClass) async {
    _state = state.copyWith(selectClass: selectClass);
    notifyListeners();
    await _saveSeatClassUseCase.execute(selectClass);
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

  void saveFromAirport(AirportModel airportModel) {
    _state = state.copyWith(
        fromAirportId: airportModel.airportId, fromAirport: airportModel);
    notifyListeners();
  }

  void saveToAirport(AirportModel airportModel) {
    _state = state.copyWith(
        toAirportId: airportModel.airportId, toAirport: airportModel);
    notifyListeners();
  }

  Future<void> searchFilght() async {
    if (stateValid()) {
      _state = state.copyWith(isLoading: true);
      notifyListeners();

      final result = await _searchFlightUseCase.execute(state.fromAirportId,
          state.toAirportId, state.travelDate, state.returnDate);
      switch (result) {
        case Success<Map<String, dynamic>>():
          _state = state.copyWith(searchResult: result.data, isLoading: false);
          notifyListeners();
          _searchUiEventStreamController
              .add(const SearchUiEvent.viewAirportMap());
        case Error<Map<String, dynamic>>():
          _state = state.copyWith(isLoading: false);
          notifyListeners();
          _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(
              'result.message => ${result.message}'));
      }
    } else {
      String message = '관리자에게 문의바랍니다.';
      if (state.fromAirportId == 0) {
        message = '출발지를 선택해주세요.';
      } else if (state.fromAirportId == 0) {
        message = '도착지를 선택해주세요.';
      } else if (state.travelDate.isEmpty) {
        message = '가는날을 선택해주세요.';
      } else if (state.returnDate.isEmpty) {
        message = '오는날을 선택해주세요.';
      }
      _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
    }
  }

  bool stateValid() {
    return state.fromAirportId != 0 &&
        state.toAirportId != 0 &&
        state.travelDate.isNotEmpty &&
        state.returnDate.isNotEmpty;
  }

  bool isFlightAvailableValid() {
    List<FlightResultModel> fromFlightList =
        state.searchResult['from_flight'] ?? [];
    List<FlightResultModel> toFlightList =
        state.searchResult['from_flight'] ?? [];
    return fromFlightList.isNotEmpty && toFlightList.isNotEmpty;
  }

  Future<void> resetResult() async {
    final result = await _resetFlightResultUseCase.execute();
    logger.info('reset result => $result');
  }
}
