import 'package:get/get.dart';
import 'package:griffin/domain/use_cases/get_airport_usecase.dart';

import '../../../domain/model/airport_model.dart';

class AirportProvider extends GetxController {
  final GetAirportUsecase getAirportUsecase;

  AirportProvider({required this.getAirportUsecase});

  final _airports = RxList<AirportModel>([]); // List<AirportModel>
  List<AirportModel> get airports => _airports;

  final _searchResultAirports = RxList<AirportModel>([]);
  List<AirportModel> get searchResultAirports => _searchResultAirports;

  final _isLoading = true.obs; // bool값
  bool get isLoading => _isLoading.value;

  // int
  // double
  // string
  // bool
  // list

  // RxInt a;
  // RxDouble b;
  // RxString c;
  // RxBool d;
  // RxList<AirportModel> e; // == List<AirportModel>

  var f = 0.obs; // RxInt
  var g = 0.0.obs;
  var h = ''.obs;

  temp() {
    f.value = 1;
  }

  // 선택지 FLYINGFROMAIRPORT
  AirportModel? selectFlyingFrom;
  AirportModel? selectFlyingTo;

  // Airport data 받아오기.(usecase에서 받아오기)
  Future<void> fetchAirports() async {
    _isLoading.value = true;

    try {
      _airports.value = await getAirportUsecase.call();
      _searchResultAirports.value = _airports;
    } finally {
      _isLoading.value = false;
    }
  }

  // 검색하기.
  Future<void> searchAirports(String airportName) async {
    _searchResultAirports.value = airports
        .where((airport) => airport.airportName
            .toLowerCase()
            .contains(airportName.toLowerCase()))
        .toList();
  }
}
