import 'package:flutter/material.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/use_cases/search/search_flight_use_case.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_state.dart';

class FlightResultViewModel with ChangeNotifier {
  FlightResultViewModel({
    required SearchFlightUseCase searchFlightUseCase,
  }) : _searchFlightUseCase = searchFlightUseCase;
  final SearchFlightUseCase _searchFlightUseCase;

  FlightResultState _flightResultState = FlightResultState();
  FlightResultState get flightResultState => _flightResultState;

  Future<void> init(Map<String, dynamic> searchResult) async {
    _flightResultState = flightResultState.copyWith(isLoading: true);
    notifyListeners();

    // setFligthResult
    _flightResultState = flightResultState.copyWith(
      fromFlight: searchResult['from_flight'] ?? [],
      toFlightList: searchResult['to_flight'] ?? [],
    );

    sortFlight(0, true, false);
    sortFlight(1, true, false);

    // get flight result

    _flightResultState = flightResultState.copyWith(isLoading: false);
    notifyListeners();
  }

  void sortFlight(int index, bool cheeper, bool faster) {
    _flightResultState = flightResultState.copyWith(isLoading: true);
    notifyListeners();

    List<FlightResultModel> sortList = [];
    sortList = List.from(index == 0
        ? flightResultState.fromFlight
        : flightResultState.toFlightList);
    sortList.sort((a, b) => cheeper
        ? a.payAmount.compareTo(b.payAmount)
        : b.payAmount.compareTo(a.payAmount));
    _flightResultState = index == 0
        ? flightResultState.copyWith(fromFlight: sortList)
        : flightResultState.copyWith(toFlightList: sortList);

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
  // double
}
