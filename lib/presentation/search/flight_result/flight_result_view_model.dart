import 'dart:async';

import 'package:flutter/material.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/use_cases/search/search_flight_use_case.dart';
import 'package:griffin/presentation/common/common.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_state.dart';
import 'package:griffin/presentation/search/search_ui_event.dart';

class FlightResultViewModel with ChangeNotifier {
  FlightResultViewModel({
    required SearchFlightUseCase searchFlightUseCase,
  }) : _searchFlightUseCase = searchFlightUseCase;
  final SearchFlightUseCase _searchFlightUseCase;

  FlightResultState _flightResultState = FlightResultState();
  FlightResultState get flightResultState => _flightResultState;

  final _searchUiEventStreamController = StreamController<SearchUiEvent>();
  Stream<SearchUiEvent> get searchUiEventStreamController =>
      _searchUiEventStreamController.stream;

  Future<void> init(Map<String, dynamic> searchResult) async {
    _flightResultState = flightResultState.copyWith(isLoading: true);
    notifyListeners();

    // setFligthResult
    _flightResultState = flightResultState.copyWith(
      fromFlightResultList: searchResult['from_flight'] ?? [],
      toFlightResultList: searchResult['to_flight'] ?? [],
    );

    sortFlight(0, true, false);
    sortFlight(1, true, false);

    // get flight result

    _flightResultState = flightResultState.copyWith(isLoading: false);
    notifyListeners();
  }

  StreamSubscription? setStream(BuildContext context) {
    return searchUiEventStreamController.listen((event) {
      switch (event) {
        case ShowSnackBar():
          showSnackBar(context, event.message);
        case ViewAirportMap():
          break;
      }
    });
  }

  void sortFlight(int index, bool cheeper, bool faster) {
    _flightResultState = flightResultState.copyWith(isLoading: true);
    notifyListeners();

    List<FlightResultModel> sortList = [];
    sortList = List.from(index == 0
        ? flightResultState.fromFlightResultList
        : flightResultState.toFlightResultList);
    sortList.sort((a, b) => cheeper
        ? a.payAmount.compareTo(b.payAmount)
        : b.payAmount.compareTo(a.payAmount));
    _flightResultState = index == 0
        ? flightResultState.copyWith(fromFlightResultList: sortList)
        : flightResultState.copyWith(toFlightResultList: sortList);

    _flightResultState = flightResultState.copyWith(isLoading: false);
    notifyListeners();
  }

  void updateToggle(int index) {
    List<bool> selectedPage = List.from(flightResultState.selectedPage);
    for (int i = 0; i < selectedPage.length; i++) {
      selectedPage[i] = i == index;
    }
    _flightResultState = flightResultState.copyWith(selectedPage: selectedPage);
    notifyListeners();
  }

  bool flightSelectValid() {
    String message = '비행편을 모두 선택해주세요.';
    if (flightResultState.selectFromFlight != null &&
        flightResultState.selectToFlight != null) {
      return true;
    } else if (flightResultState.selectFromFlight == null) {
      message = '출발 비행편을 선택해주세요.';
    } else {
      message = '도착 비행편을 선택해주세요.';
    }
    _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
    return false;
  }

  void selectFromFlight(FlightResultModel flightResultModel) {
    _flightResultState =
        flightResultState.copyWith(selectFromFlight: flightResultModel);
    notifyListeners();
  }

  void selectToFlight(FlightResultModel flightResultModel) {
    _flightResultState =
        flightResultState.copyWith(selectToFlight: flightResultModel);
    notifyListeners();
  }
}
