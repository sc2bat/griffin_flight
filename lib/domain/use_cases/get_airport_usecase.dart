// 데이터를 가지고오는것.
// 직접 data의 api에 접근을 하면 안됩니다.

import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';

class GetAirportUsecase {
  final AirportRepository repository;
  GetAirportUsecase({required this.repository});

  Future<List<AirportModel>> call() async {
    // repository를 통해서 AirportDataApi에 접근하여 데이터를 다운로드한다.
    var result = await repository.getAirportData();
    List<AirportModel> airports = [];
    result.when(
        success: (data) {
          airports = data;
        }, error: (message) {
          airports = [];
        },
    );
    return airports;
  }
}