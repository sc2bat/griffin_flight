import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/search/search_flight_use_case.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_state.dart';

class FlightResultViewModel with ChangeNotifier {
  FlightResultViewModel({
    required SearchFlightUseCase searchFlightUseCase,
  }) : _searchFlightUseCase = searchFlightUseCase;
  final SearchFlightUseCase _searchFlightUseCase;

  final FlightResultState _flightResultState = FlightResultState();
  FlightResultState get flightResultState => _flightResultState;

  Future<void> init() async {
    // loading
    notifyListeners();

    // get user info

    // get flight result

    // loading
    notifyListeners();
  }

  // flight result
  Future<void> searchFlightResult() async {
    //
  }
}
