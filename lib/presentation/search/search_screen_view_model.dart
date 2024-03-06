import 'package:flutter/material.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/presentation/search/search_state.dart';

import '../../data/repositories/airport_repository_impl.dart';

class SearchScreenViewModel with ChangeNotifier {
  final AirportRepository airportRepository;
   List<String> selectedClassList = [
    'Economy', 'Business', 'First'
  ];//좌석 등급 리스트


  SearchScreenViewModel({
    required this.airportRepository,
});
  // Future<void> loadAirportData() async {
  //   await AirportRepositoryImpl().getAirportDataApi();
  //   notifyListeners();
  //}
  final SearchState _state = SearchState();

  SearchState get state => _state;

  String _selectClass = 'Economy';

  String get selectClass => _selectClass;

  set selectedClass(String value) {
    _selectClass = value.toString();

  }

  // List<Air>
  //
  // Future<void>

}
