import 'package:flutter/foundation.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/presentation/search/search_screen_state.dart';

import '../../data/core/result.dart';
import '../../data/dtos/airport_dto.dart';
import '../../data/repositories/airport_repository_impl.dart';
import '../../data/repositories/sample_repository_impl.dart';
import '../../utils/simple_logger.dart';

class SearchViewModel extends ChangeNotifier {
  final AirportRepository _repository;



  SearchViewModel({
    required AirportRepository repository,
  }) : _repository = repository;

  SearchScreenState _state = const SearchScreenState();

  SearchScreenState get state => _state;

  Future<void> init() async {
    getAirportList();
  }

  Future<void> getAirportList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getAirportDataApi();
    result.when(
      success: (data) => _state = state.copyWith(
        isLoading: false,
        airportData: data,
      ),
      error: (error) => logger.info(error),
    );
    notifyListeners();
  }

  void searchAirport(String airportName) {

      List<AirportModel> searchedAirport = state.airportData
          .where((e) =>
          e.airportName.toLowerCase().contains(airportName.toLowerCase()))
          .toList();


      notifyListeners();
    //state.airportData는 List<AirportModel> 형식인데, searchAirport 함수에서
    // 이를 사용하려고 하고 있습니다.
    // 그러나 map 함수는 새로운 List를 생성하므로,
    // searchedAirport는 List<bool>이 되고, 이로 인해 state.airportData
    // 뒤에 사용할 때 타입 불일치 오류가 발생합니다.
    //
    // 해결 방법으로는 where 함수를 사용하여 조건에 맞는 AirportModel만 필터링하는 것입니다.
  }



}
