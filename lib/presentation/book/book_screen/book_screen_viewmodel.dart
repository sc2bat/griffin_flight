import 'package:flutter/foundation.dart';
import 'package:griffin/data/repositories/flight_repository_impl.dart';

class BookScreenViewModel with ChangeNotifier {

  //flight data를 screen에서 load -> 삭제 예정
  Future<void> loadFlightData() async {
    await FlightRepositoryImpl().getFlightDataApi();
    notifyListeners();
  }
}