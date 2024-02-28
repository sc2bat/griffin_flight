import 'package:flutter/foundation.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/presentation/search/search_screen_state.dart';

import '../../data/core/result.dart';
import '../../data/dtos/airport_dto.dart';
import '../../data/repositories/sample_repository_impl.dart';

class SearchViewModel extends ChangeNotifier {
  final AirportRepository _repository;

  SearchViewModel({
    required AirportRepository repository,
  }) : _repository = repository;

  SearchScreenState _state = const SearchScreenState();

  SearchScreenState get state => _state;

  Future<void> searchAirport (String airportName) async {

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getAirportDataApi(airportName);
    switch (result) {
      case Success<List<AirportModel>>():
        _state = state.copyWith(
          isLoading: false,
          airportData: result.data,
        );

      case Error<List<AirportModel>>():
        _state = state.copyWith(
          isLoading: false,
        );

    }
    notifyListeners();

  }
}