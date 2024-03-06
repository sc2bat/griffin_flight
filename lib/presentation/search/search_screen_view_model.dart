import 'package:flutter/material.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/presentation/search/search_state.dart';

import '../../data/repositories/airport_repository_impl.dart';

class SearchScreenViewModel with ChangeNotifier {
  final AirportRepository airportRepository;

  SearchScreenViewModel({
    required this.airportRepository,
});
  // Future<void> loadAirportData() async {
  //   await AirportRepositoryImpl().getAirportDataApi();
  //   notifyListeners();
  //}
  SearchState _state = SearchState();

  SearchState get state => _state;

  // List<Air>
  //
  // Future<void>

}
